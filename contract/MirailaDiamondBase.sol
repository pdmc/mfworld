pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';

contract MirailaDiamondBase {
    
    uint256 public leaveDiamond = 1200000000*10**18;
    uint256 public allDiamond = 1200000000;
    
    mapping (address => uint256) public diamondOf;  
    
    function getAlldiamond() returns (uint256){
        return allDiamond;
    }
    
    function getLeavediamond() returns (uint256){
        return leaveDiamond;
    }
    
    function countLeavediamond(uint256 value) returns (uint256) {
        
        return leaveDiamond -= value;
    }
    
    function setdiamond(address _address, uint256 v)  public {
        diamondOf[_address] = v;
    }
    
}