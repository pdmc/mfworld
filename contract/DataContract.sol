pragma solidity ^0.4.18;

contract DataContract {
    mapping (address => uint256) public balanceOf;

    function setBlance(address _address,uint256 v) public {
        balanceOf[_address] = v;
    }
}