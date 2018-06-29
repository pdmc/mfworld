pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond is MirailaDataAccess{
    
    MirailaEnergyBase mirailaEnergyBase;
    MirailaDiamondBase mirailaDiamondBase;
    MirailaCoreBase mirailaCoreBase;
    uint256 public _userDiamond;
    // uint256 public _loadDiamond;

    function MirailaDiamond(address energy_add, address user_add, address diamond_add){
        mirailaEnergyBase = MirailaEnergyBase(energy_add);
        mirailaCoreBase = MirailaCoreBase(user_add);
        mirailaDiamondBase = MirailaDiamondBase(diamond_add);
    }
    
    // load Diamond
    function loadDiamond(address _useradd) onlyOperator returns (uint256){
        uint lastDiamond = mirailaDiamondBase.lastDiamondOf(_useradd);
        if (lastDiamond == 0){
            mirailaDiamondBase.setLastTime(_useradd, now);
            uint256 _userDiamond = 10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
            mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
            // _loadDiamond = 0;
            mirailaDiamondBase.setLoadDiamond(_useradd, 0);
            return 0;
        }
        uint lastTime = mirailaDiamondBase.lastTimeOf(_useradd);
        uint  timediff = now - lastTime;
        uint count = timediff/ 120;
        if (count > 24){
            // _loadDiamond = lastDiamond*24;
            mirailaDiamondBase.setLoadDiamond(_useradd, lastDiamond*24);
            //mirailaDiamondBase.setLastDiamond(_useradd, _loadDiamond); 
            return mirailaDiamondBase.loadDiamondOf(_useradd);
            // return _loadDiamond;
        }
        if (count == 0){
            // _loadDiamond = 0;
            mirailaDiamondBase.setLoadDiamond(_useradd, 0);
            return mirailaDiamondBase.loadDiamondOf(_useradd);
            // return 0;
        }
        // _loadDiamond = lastDiamond*(now - lastTime)/ 120;
        mirailaDiamondBase.setLoadDiamond(_useradd, lastDiamond*timediff/ 120);
        //mirailaDiamondBase.setLastDiamond(_useradd, _loadDiamond);
        return mirailaDiamondBase.loadDiamondOf(_useradd);
        // return _loadDiamond;
    }
    
    // process user diamond
    function inDiamond(address _useradd, uint256 _value) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
            _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _value);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       else {
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _value);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
    }
    
    // process user diamond
    function iinDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + mirailaDiamondBase.loadDiamondOf(_useradd));
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       else {
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + mirailaDiamondBase.loadDiamondOf(_useradd));
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
    }

}
