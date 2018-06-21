pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond is MirailaDataAccess{
    
    MirailaEnergyBase mirailaEnergyBase;
    MirailaDiamondBase mirailaDiamondBase;
    MirailaCoreBase mirailaCoreBase;
    uint256 public _userDiamond;
    uint256 public _loadDiamond;

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
            _loadDiamond = 0;
            return 0;
        }
        uint lastTime = mirailaDiamondBase.lastTimeOf(_useradd);
        uint count = (now - lastTime)/ 120;
        if (count > 24){
            _loadDiamond = lastDiamond*24;
            //mirailaDiamondBase.setLastDiamond(_useradd, _loadDiamond); 
            return _loadDiamond;
        }
        if (count == 0){
            _loadDiamond = 0;
            return 0;
        }
        _loadDiamond = lastDiamond*(now - lastTime)/ 120;
        //mirailaDiamondBase.setLastDiamond(_useradd, _loadDiamond);
        return _loadDiamond;
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
<<<<<<< HEAD
    function userDiamond(address _useradd) onlyOperator {
       uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
       mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
=======
    function iinDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
            _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _loadDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       else {
           _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _loadDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
>>>>>>> c9677f376788d6b9b90cbd00f4496b5de27eca61
    }

}
