pragma solidity ^0.4.11;

import './MirailaCoreBase.sol';


contract MirailaCore is MirailaDataAccess {
    
    // parameter init
    MirailaCoreBase mirailaCoreBase;
    
    // constructor
    function MirailaCore(address add) {
        mirailaCoreBase = MirailaCoreBase(add);
    }
    
    // user add one, when first login 
    function addUser() onlyOperator {
        mirailaCoreBase.addUser();
    }
    
}
