pragma solidity ^0.4.11;

/// @title Transparante Productie Keten
contract Zaagsel {
    mapping (address => uint) public balances;
    
    event Sent(address from, address to, uint amount);
    event Added(address from, address to, uint amount);
    
    // Constructor
    function Zaagsel(){
        balances[msg.sender] = 0;
    }

    // Stuur zaagsel op transport, in eigendom van de transporteur, of lever af bij zaagselverwerking
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

    // functie om zaagsel aan te maken vanuit bomen
    function addZaagsel(address receiver, uint amount) returns(bool received) {
        balances[receiver] += amount;
        Added(msg.sender, receiver, amount);
        return true;
    }
}
