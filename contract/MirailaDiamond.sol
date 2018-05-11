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
    
    // get new_diamond 
    function newDiamond(address _useradd) public returns (uint256){
        uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
        return _userDiamond;
    }
    
    // process user diamond
    function userDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
           uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
       }
       if (mirailaCoreBase.getUser() >= 66666){
           uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
       }
       
       
    //   return userDiamond; 
    }

}