var Zaagsel = artifacts.require("./Zaagsel.sol");

contract('Zaagsel', function(accounts) {
  it("should put 0 Zaagsel in the first account", function() {
    return Zaagsel.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 0, "0 wasn't in the first account");
    });
  });
  it("should add zaagsel correctly", function() {
    var meta;

    // Get initial balances of account.
    var account = accounts[0];

    var account_starting_balance;
    var account_ending_balance;

    var amount = 10;

    return Zaagsel.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(account);
    }).then(function(balance) {
      account_starting_balance = balance.toNumber();
      return meta.addZaagsel(account, amount);
    }).then(function() {
      return meta.getBalance.call(account);
    }).then(function(balance) {
      account_ending_balance = balance.toNumber();
      assert.equal(account_ending_balance, account_starting_balance + amount, "Amount wasn't correctly added");
    });
  });
  it("should send zaagsel correctly", function() {
    var meta;

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return Zaagsel.deployed().then(function(instance) {
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
});
