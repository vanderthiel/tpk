var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var Bomen = artifacts.require("./Bomen.sol");
var Planken = artifacts.require("./Planken.sol");
var Zaagsel = artifacts.require("./Zaagsel.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(Bomen);
  deployer.link(Bomen, Planken);
  deployer.deploy(Planken);
  deployer.link(Bomen, Zaagsel);
  deployer.deploy(Zaagsel);
};
