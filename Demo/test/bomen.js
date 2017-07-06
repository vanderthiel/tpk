var Bomen = artifacts.require("./Bomen.sol");
var Planken = artifacts.require("./Planken.sol");
var Zaagsel = artifacts.require("./Zaagsel.sol");

contract('Bomen', function(accounts) {
  it("should put 0 Bomen in the first account", function() {
    return Bomen.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 0, "0 wasn't in the first account");
    });
  });
  it("should add bomen correctly", function() {
    var meta;

    // Get initial balances of account.
    var account = accounts[0];

    var account_starting_balance;
    var account_ending_balance;

    var amount = 1000;

    return Bomen.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(account);
    }).then(function(balance) {
      account_starting_balance = balance.toNumber();
      return meta.quota(account, amount);
    }).then(function() {
      return meta.getBalance.call(account);
    }).then(function(balance) {
      account_ending_balance = balance.toNumber();
      assert.equal(account_ending_balance, account_starting_balance + amount, "Amount wasn't correctly added");
    });
  });
  it("should send bomen correctly", function() {
    var meta;
    let plankAddress = Planken.deployed();
    let zaagselAddress = Zaagsel.deployed();

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;
    
    return Bomen.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return meta.transfer(account_two, amount, {from: account_one});
    }).then(function() {
      return meta.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();
      
      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });
  it("should transform bomen to planken and zaagsel correctly", function() {
    var meta;
    let plankAddress = Planken.deployed();
    let zaagselAddress = Zaagsel.deployed();

    // Get initial balances of first and second account.
    var account = accounts[0];

    var account_start_boom;
    var account_start_plank;
    var account_start_zaagsel;
    var account_end_boom;
    var account_end_plank;
    var account_end_zaagsel;

    var amount = 10;
    var plankamount = 6;
    
    return Bomen.deployed().then(function(instance) {
      boom = instance;
      return Planken.deployed();
    }).then(function(instance) {
      plank = instance;
      return Zaagsel.deployed();
    }).then(function(instance) {
      zaagsel = instance;
      return boom.getBalance.call(account);
    }).then(function(balance) {
      account_start_boom = balance.toNumber();
      return plank.getBalance.call(account);
    }).then(function(balance) {
      account_start_plank = balance.toNumber();
      return zaagsel.getBalance.call(account);
    }).then(function(balance) {
      account_start_zaagsel = balance.toNumber();
      return boom.verzagen.call(plank.address, zaagsel.address, amount, plankamount, {from: account});
    }).then(function(balance) {
      account_end_boom = balance.toNumber();
      return plank.getBalance.call(account);
    }).then(function(balance) {
      account_end_plank = balance.toNumber();
      return zaagsel.getBalance.call(account);
    }).then(function(balance) {
      account_end_zaagsel = balance.toNumber();

      assert.equal(account_start_boom, account_end_boom + amount, "Boom amount wasn't correctly taken from the sender");
    });
  });
});
