pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/GoldShop.sol";
import "../contracts/Lighthouse.sol";

// testing hooks, refactor and comments, new folder copy files, make into a box, submit to truffle
//work with oracle and eth price
// what node modules do I need

contract TestLighthouse{

/* Create a new instance of Lighthouse, so this contract can be the deployer and be authorized
   to write values into the lighthouse. */

  Lighthouse newlighthouse = new Lighthouse();

/* Each instance of GoldShop must be created with a parameter, which is the address of an already deployed lighthouse
   it will obtain data from, interpreted as an ILighthouse interface.

   We must create a new goldshop, one that obtains data from our new lighthouse. Take the address of 'newlighthouse',
   interpret it as an ILighthouse interface, and this will be the new goldshop constructor parameter. */

  GoldShop newgoldshop = new GoldShop(ILighthouse(address(newlighthouse)));

// Create the value and nonce we will be writing into the lighthouse
  uint dataValue = 40;
  uint nonce = 1234;

// Tests if I can write a value into the lighthouse
  function testWrite() public {

    newlighthouse.write(dataValue, nonce);

    uint goldval = 0;
    bool ok = false;

    (goldval, ok) = newlighthouse.peekData();

    Assert.equal(goldval, dataValue, "write failed");
  }

// Tests if goldshop can read an actual value from lighthouse (default lighthouse value is 0)
  function testLighthouseReturns() public {

    uint goldPrice = newgoldshop.goldPrice();

    Assert.isNotZero(goldPrice, "Goldshop returned zero");
  }

// Tests if the value placed into the lighthouse is correct (whether or not it is worth buying jewlery)
  function testJewlery1() public {

    uint ounces = 5;      //5*40 = 200, should be worth to buy
    uint dollars = 100;

    bool isWorth = newgoldshop.worthBuying(ounces, dollars);

    Assert.isTrue(isWorth, "Not worth buying.");
  }

  function testBarelyWorth() public {

    uint ounces = 5;      //5*40 = 200, should be worth to buy
    uint dollars = 199;

    bool isWorth = newgoldshop.worthBuying(ounces, dollars);

    Assert.isTrue(isWorth, "Not worth buying.");
  }

  function testNotWorth() public {

    uint ounces = 5;      //5*40 = 200, should not be worth to buy
    uint dollars = 201;

    bool isWorth = newgoldshop.worthBuying(ounces, dollars);

    Assert.isFalse(isWorth, "Worth buying.");
  }

}
