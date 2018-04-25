pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';

contract MirailaDiamond {
    
    MirailaEnergyBase mirailaEnergyBase;
    
    function MirailaDiamond(address add){
        mirailaEnergyBase = MirailaEnergyBase(add);
    }
    
    // 查看总能量
    function lookEnergy() public returns (uint256) {
      return mirailaEnergyBase.getEnergy();
    }
    
}