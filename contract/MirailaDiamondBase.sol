pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';

contract MirailaDiamondBase {
    
    mapping (address => uint256) public diamondOf; 
    mapping (address => bool) accessAllowed;
    mapping (address => uint256) public lastTimeOf;
    mapping (address => uint256) public lastDiamondOf;
    

    uint256 private allDiamond = 1800000000*10*18;
    uint256 private currentDiamond = 90000000*10**18;
    uint256 private teamDiamond = 360000000*10**18;
    uint256 private foundationDiamond = 540000000*10**18;
    uint256 private _leaveDiamond;
    uint256 private poolDiamond;
    uint256 private _start;
    uint256 private _mouth = 1;
    bool public _transfer = false;
    
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // function init
    function MirailaDiamondBase() {
        diamondOf[0x66Cad0CC2Ed3Df2989a8642b29fa31Ee3e433DE1] = teamDiamond;
        diamondOf[0x2697493f56426EE55aA9a4A3a86D871D31Ee212E] = foundationDiamond;
        // diamondOf[miraila] = mirailaDiamond;
        accessAllowed[msg.sender] = true;
        _start = now;
    }
 
    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }  
    
    function allowAccess(address _addr) platform public {
        accessAllowed[_addr] = true;
    }
    
    function getlook(address _addr) returns (bool){
        return accessAllowed[_addr];
    }
    
    function denyAccess(address _addr) platform public {
        accessAllowed[_addr] = false;
    }
    

    function setdiamond(address _address, uint256 _value) platform public {
        if (now >= _start + 30 * 1 days && _mouth <=10) { 
            currentDiamond = 90000000*10**18;
            _start = now;
            poolDiamond += _leaveDiamond;
            _mouth += 1;
        }
        if (now >= _start + 30 * 1 days && _mouth > 10){
            currentDiamond = 2400000*10**18;
            _start = now;
            poolDiamond += _leaveDiamond;
            _mouth += 1;
        }
        require(currentDiamond >= _value);
        diamondOf[_address] = _value;
        currentDiamond -= _value;
        _leaveDiamond = currentDiamond;
    }

    
    function setLastTime(address _address, uint256 v) platform public {
        lastTimeOf[_address] = v;
    }

    function setLastDiamond(address _address, uint256 v) platform public {
        lastDiamondOf[_address] = v;
    }


    function transfer(address _from, address _to, uint256 _amount) returns (bool success) {
          if (diamondOf[_from] >= _amount 
              && _amount > 0
              && diamondOf[_to] + _amount > diamondOf[_to]) {
              diamondOf[_from] -= _amount;
              diamondOf[_to] += _amount;
              Transfer(_from, _to, _amount);
              _transfer = true;
              return true;
          } else {
              _transfer = false;
              return false;
          }
      }

}
