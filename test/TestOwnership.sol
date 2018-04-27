pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ownership.sol";

contract TestOwnership {
  Ownership ownership = Ownership();

  // Testing ownership
  function testOwnership() public {
    Assert.equal(ownership, msg.sender, "Ownership should be msg sender.");
  }

  // Testing transfer ownership
  function testTransferOwnership() public {
  }

}