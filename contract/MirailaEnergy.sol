pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import "./MirailaCoreBase.sol";

contract MirailaEnergy is MirailaCoreBase{

  MirailaEnergyBase dataContract;
  uint256 internal login = 2;
  uint256 internal friends = 10;
  uint256 internal question = 1;
  uint256 internal register = 10;

  function MirailaEnergy(address _dataContractAddr) public {
        dataContract = MirailaEnergyBase(_dataContractAddr);
    }
    
    // // 查看查看账户
    // function look(address addr) public returns (uint) {
    //     return dataContract.balanceOf(addr);
    // }
    
    // 查看总能量
    // function getEnergy() public returns (uint256){
    //     return dataContract.look1();
    // }

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

    // 能量增加
    function registerAdd(address _address) onlyOperator {
        dataContract.setBlance(_address, dataContract.balanceOf(_address) + register);
        dataContract.addEnergy(register);
    }
}