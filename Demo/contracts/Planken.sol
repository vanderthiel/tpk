pragma solidity ^0.4.11;

/// @title Transparante Productie Keten
contract Planken {
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);
    event Added(address from, address to, uint amount);
    
    // Constructor
    function Planken(){
        balances[msg.sender] = 0;
    }

    // Stuur planken op transport, in eigendom van de transporteur, of lever af bij meubelmakerij
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

    // todo: functie om planken aan te maken vanuit bomen
    function addPlanken(address receiver, uint amount) returns(bool received) {
        balances[receiver] += amount;
        Added(msg.sender, receiver, amount);
        return true;
    }
}
