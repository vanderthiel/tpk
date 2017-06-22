pragma solidity ^0.4.11;

/// @title Transparante Productie Keten
contract Bomen {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    // Constructor
    function Bomen() {
        minter = msg.sender;
    }

    // Geef quota uit aan de ontvanger, zodat hij een quota aan bomen kan genereren
    function quota(address receiver, uint amount) {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    // Stuur bomen op transport, in eigendom van de transporteur, of lever af bij zagerij
    function transfer(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }

    // Verzaag bomen in individuele planken en restmateriaal. Dit vertaalt zich in nieuwe contracten
    function verzagen(address receiver, uint boomamount, uint plankamount) {
        if (balances[msg.sender] < amount) return;
        // todo: vertaling naar andere contracten
    }
}



contract Planken {
    mapping (address => uint) public balances;

    // Constructor
    function Planken(){}

    // Stuur planken op transport, in eigendom van de transporteur, of lever af bij meubelmakerij
    function transfer(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }

    // todo: functie om planken aan te maken vanuit bomen
}



contract Zaagsel {
    mapping (address => uint) public balances;
    
    // Constructor
    function Zaagsel(){}

    // Stuur zaagsel op transport, in eigendom van de transporteur, of lever af bij zaagselverwerking
    function transfer(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }

    // todo: functie om zaagsel aan te maken vanuit bomen
}
