pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Bomen.sol";

contract TestBomen {

  function testInitialBalanceUsingDeployedContract() {
    Bomen meta = Bomen(DeployedAddresses.Bomen());

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Bomen initially");
  }

  function testInitialBalanceWithNewBomen() {
    Bomen meta = new Bomen();

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Bomen initially");
  }

}
