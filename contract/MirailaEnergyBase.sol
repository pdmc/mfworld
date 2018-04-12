pragma solidity ^0.4.11;

import "./MirailaCoreBase.sol";
// import "./MirailaDataAccess.sol";

contract MirailaEnergyBase is MirailaCoreBase{

  	mapping (address => uint256) public balanceOf;
  	mapping (address => bool) accessAllowed;
  	
  	
  	function MirailaEnergyBase() public {
        accessAllowed[msg.sender] = true;
    }

  	function setBlance(address _address, uint256 v) platform public {
        balanceOf[_address] = v;
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
    
    
    function getAccess(address _addr) public returns (bool) {
       return accessAllowed[_addr];
    }
  
}