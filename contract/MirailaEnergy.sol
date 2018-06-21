pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import "./MirailaCoreBase.sol";

contract MirailaEnergy is MirailaDataAccess{

    MirailaEnergyBase dataContract;

    function MirailaEnergy(address _dataContractAddr) public {
        dataContract = MirailaEnergyBase(_dataContractAddr);
    }
    
<<<<<<< HEAD
    // 登录能量增加
    function loginAdd(address _address) onlyOperator {
      dataContract.setBlance(_address, dataContract.balanceOf(_address) + login);
      dataContract.addEnergy(login);
    }

  // 邀请好友能量增加
  function friendsAdd(address _address) onlyOperator {
      dataContract.setBlance(_address, dataContract.balanceOf(_address) + friends);
      dataContract.addEnergy(friends);
  }

    // 问题能量增加
    function questionAdd(address _address) onlyOperator {
        dataContract.setBlance(_address, dataContract.balanceOf(_address) + question);
        dataContract.addEnergy(question);
    }
}
=======
    // 能量增加
    function energyAdd(address _address, uint256 _value) onlyOperator returns(uint256) {
        dataContract.setBlance(_address, dataContract.balanceOf(_address) + _value);
        dataContract.addEnergy(_value);
        return 200;
    }

}
>>>>>>> c9677f376788d6b9b90cbd00f4496b5de27eca61
