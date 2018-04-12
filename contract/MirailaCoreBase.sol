pragma solidity ^0.4.11;

import './MirailaDataAccess.sol';

contract MirailaCoreBase is MirailaDataAccess {

	/// @dev Emited when contract is upgraded - See README.md for updgrade plan
	address public newContractAddress;
	
    event ContractUpgrade(address newContract);

	mapping (address => bool) accessAllowed;

	function MirailaCoreBase() public {
        accessAllowed[msg.sender] = true;
    }

    function upgrade(address _v2Address) external onlyAdmin {
    	newContractAddress = _v2Address;
    	ContractUpgrade(_v2Address);
    }	

    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }
    
    function allowAccess(address _addr) platform public {
        accessAllowed[_addr] = true;
    }
    
    function denyAccess(address _addr) platform public {
        accessAllowed[_addr] = false;
    }
}