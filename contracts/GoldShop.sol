/* -------------------------------------------- Scenario -----------------------------------
You are a second hand jewlery buyer, people come to you with unwanted accessories and make you an offer. For gold
jewlery, you typically melt it and sell the gold. This smart contract determines whether a piece of old gold jewlery
is worth buying and melting or not.
*/

//To do: Take some packages out of node modules (which ones?), make a README

pragma solidity ^0.5.0;

import "../contracts/Ilighthouse.sol";

contract GoldShop {

// Create GoldShop with an ILighthouse interface, a lighthouse address where the GoldShop will read data from
    ILighthouse  public myLighthouse;

    constructor(ILighthouse _myLighthouse) public {
        myLighthouse = _myLighthouse;
    }

// Returns the current price of one troy ounce of gold in USD
    function goldPrice() public returns (uint) {

      uint troyOunceOfGold;
      bool ok;

// Obtain gold price from lighthosue
      (troyOunceOfGold,ok) = myLighthouse.peekData();

      return troyOunceOfGold;
    }

// Returns whether or not a piece of jewlery is worth buying to melt
    function worthBuying(uint troyOunces, uint dollars) public returns (bool){
      uint oneOz = goldPrice();
      uint goldVal = oneOz * troyOunces;

      bool isWorth;

      if(goldVal < dollars){      //raw gold worth less than what you are paying
        isWorth = false;
      }
      else{
        isWorth = true;
      }
      return isWorth;
    }


}
