pragma solidity ^0.4.11;

import './MirailaCoreBase.sol';


contract MirailaCore {
    
    // parameter init
    MirailaCoreBase mirailaCoreBase;
    
    // constructor
    function MirailaCore(address add) {
        mirailaCoreBase = MirailaCoreBase(add);
    }
    
    // user add one, when first login 
    function addUser() public {
        mirailaCoreBase.addUser();
    }
    
}
