pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond is MirailaDataAccess{
    
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
    // function processDiamond() public returns (uint256){
    //     return mirailaDiamondBase.countLeavediamond(10);
    // }
    
    // proess diamond 
    // function diamondAdd(address _address, uint256 diamondValue) public {
    //   mirailaDiamondBase.setdiamond(_address, mirailaDiamondBase.diamondOf(_address) + diamondValue);
    //   mirailaDiamondBase.countLeavediamond(diamondValue);
    // }
    
    // process user diamond
    function userDiamond(address _useradd) onlyOperator {
       uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
       mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
    //   return userDiamond; 
    }

}