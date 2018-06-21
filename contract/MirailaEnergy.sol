pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import "./MirailaCoreBase.sol";

contract MirailaEnergy is MirailaDataAccess{

    MirailaEnergyBase dataContract;

    function MirailaEnergy(address _dataContractAddr) public {
        dataContract = MirailaEnergyBase(_dataContractAddr);
    }
    
    // 能量增加
    function energyAdd(address _address, uint256 _value) onlyOperator returns(uint256) {
        dataContract.setBlance(_address, dataContract.balanceOf(_address) + _value);
        dataContract.addEnergy(_value);
        return 200;
    }

}