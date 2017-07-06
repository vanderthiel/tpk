pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Zaagsel.sol";

contract TestZaagsel {

  function testInitialBalanceUsingDeployedContract() {
    Zaagsel meta = Zaagsel(DeployedAddresses.Zaagsel());

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Zaagsel initially");
  }

  function testInitialBalanceWithNewZaagsel() {
    Zaagsel meta = new Zaagsel();

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Zaagsel initially");
  }

}
