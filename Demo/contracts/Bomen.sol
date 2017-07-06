pragma solidity ^0.4.11;

import "./Planken.sol";
import "./Zaagsel.sol";

/// @title Transparante Productie Keten
contract Bomen {
    address public minter;
    mapping (address => uint) public balances;

    event AccessDenied(address a);
    event Sent(address from, address to, uint amount);
    event QuotaAdded(address to, uint amount);
    event Transformed(address to, uint boomamount, uint plankamount, uint zaagselamount);

    // Constructor
    function Bomen() {
        minter = msg.sender;
        balances[msg.sender] = 0;
    }

    // Geef quota uit aan de ontvanger, zodat hij een quota aan bomen kan genereren
    function quota(address receiver, uint amount) returns(uint total) {
        //if (msg.sender != minter) {
        //    AccessDenied(msg.sender);
        //    return balances[receiver];
        //}
        balances[receiver] += amount;
        QuotaAdded(receiver, amount);
        return balances[receiver];
    }

    // Stuur bomen op transport, in eigendom van de transporteur, of lever af bij zagerij
    function transfer(address receiver, uint amount) returns(bool sufficient) {
        if (balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
        return true;
    }

    function getBalance(address addr) returns(uint) {
		return balances[addr];
	}

    // Verzaag bomen in individuele planken en restmateriaal. Dit vertaalt zich in nieuwe contracten
    function verzagen(address plankAddress, address zaagselAddress, uint boomamount, uint plankamount) returns(uint result) {
        if (balances[msg.sender] < boomamount) return balances[msg.sender];
        // todo: vertaling naar andere contracten
        balances[msg.sender] -= boomamount;
        Planken(plankAddress).addPlanken(msg.sender, plankamount);
        Zaagsel(zaagselAddress).addZaagsel(msg.sender, boomamount - plankamount);
        Transformed(msg.sender, boomamount, plankamount, boomamount - plankamount);
        return balances[msg.sender];
    }
}
