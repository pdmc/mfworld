pragma solidity ^0.4.0;
import "./DataContract.sol";

contract ControlContract {

    DataContract dataContract;
    
    // mapping (address => uint256) public balanceOf;
    
    function aaa(address _dataContractAddr) public {
        dataContract = DataContract(_dataContractAddr);
    }


    function addTen(address addr) public {
        dataContract.setBlance(addr, dataContract.balanceOf(addr) + 22);
    }
    
    
    function look(address addr) public returns (uint) {
        return dataContract.balanceOf(addr);
    }
    
    
}