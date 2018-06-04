pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond is MirailaDataAccess{
    
    MirailaEnergyBase mirailaEnergyBase;
    MirailaDiamondBase mirailaDiamondBase;
    MirailaCoreBase mirailaCoreBase;
    uint256 public _userDiamond;
    uint256 public _allDiamond;

    function MirailaDiamond(address energy_add, address user_add, address diamond_add){
        mirailaEnergyBase = MirailaEnergyBase(energy_add);
        mirailaCoreBase = MirailaCoreBase(user_add);
        mirailaDiamondBase = MirailaDiamondBase(diamond_add);
    }
    
    // get all user
    // function lookUser() public returns (uint256) {
    //   return mirailaCoreBase.getUser();
    // }
    
    // // get all energy
    // function lookEnergy() public returns (uint256) {
    //   return mirailaEnergyBase.getEnergy();
    // }
    

    // user first login
    function firstLogin(address _useradd) onlyOperator {
       mirailaDiamondBase.setLastTime(_useradd, now);
    }

    // load Diamond
    function loadDiamond(address _useradd) onlyOperator returns (uint256){
        uint lastDiamond = mirailaDiamondBase.lastDiamondOf(_useradd);
        if (lastDiamond == 0){
            uint256 _userDiamond = 10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
            mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
            _allDiamond = _userDiamond;
            return _userDiamond;
        }
        uint lastTime = mirailaDiamondBase.lastTimeOf(_useradd);
        uint count = (now - lastTime)/ 7200;
        if (count > 24){
            _allDiamond = lastDiamond*24;
            mirailaDiamondBase.setLastDiamond(_useradd, _allDiamond); 
            return _allDiamond;
        }
        _allDiamond = lastDiamond*count;
        mirailaDiamondBase.setLastDiamond(_useradd, _allDiamond);
        return _allDiamond;
    }
    
    // process user diamond
    function inDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
            _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       else {
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
    }
    
    // process user diamond
    function iinDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
            _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _allDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       else {
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _allDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
    }

}