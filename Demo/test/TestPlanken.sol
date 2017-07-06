pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Planken.sol";

contract TestPlanken {

  function testInitialBalanceUsingDeployedContract() {
    Planken meta = Planken(DeployedAddresses.Planken());

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Planken initially");
  }

  function testInitialBalanceWithNewPlanken() {
    Planken meta = new Planken();

    uint expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 Planken initially");
  }

}
