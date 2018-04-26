pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond {
    
    MirailaEnergyBase mirailaEnergyBase;
    MirailaDiamondBase mirailaDiamondBase;
    MirailaCoreBase mirailaCoreBase;
    
    
    function MirailaDiamond(address energy_add, address user_add, address diamond_add){
        mirailaEnergyBase = MirailaEnergyBase(energy_add);
        mirailaCoreBase = MirailaCoreBase(user_add);
        mirailaDiamondBase = MirailaDiamondBase(diamond_add);
    }
    
  
    // get all user
    function lookUser() public returns (uint256) {
      return mirailaCoreBase.getUser();
    }
    
    // get all energy
    function lookEnergy() public returns (uint256) {
      return mirailaEnergyBase.getEnergy();
    }
    
    // get Leavediamond
    function lookLeaveDiamond() public returns (uint256){
        return mirailaDiamondBase.getLeavediamond();
    }
    
    // process Leavediamond
    function processDiamond() public returns (uint256){
        return mirailaDiamondBase.countLeavediamond(10);
    }
    
    // proess diamond 
    function diamondAdd(address _address) public {
      mirailaDiamondBase.setdiamond(_address, mirailaDiamondBase.diamondOf(_address) + 10);
    }
    
    
    
    
    
}