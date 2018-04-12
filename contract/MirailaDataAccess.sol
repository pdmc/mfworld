pragma solidity ^0.4.11;

import './Ownership.sol';

contract MirailaDataAccess is Ownership{
	// This facet controls access control for Miraila. There are two roles managed here;
	//
	//		- The admin
	//
	//		- The operator
	//
	/// @dev Emited when contract is upgraded - See README.md for updgrade plan
    event ContractUpgrade(address newContract);

    // The addresses of the accounts (or contracts) that can execute actions within each roles.
    address public adminAddress;
    address public operatorAddress;

    // @dev Keeps track whether the contract is paused. When that is true, most actions are blocked
    bool public paused = false;

    /// Access modifier for admin-only functionality
    
    modifier onlyAdmin() {
    	require(msg.sender == adminAddress);
    	_;
    }

    /// Access modifier for operator-only functionality
    modifier onlyOperator() {
    	require(msg.sender == operatorAddress);
    	_;
    }

    modifier onlyCLevel() {
    	require(
    		msg.sender == adminAddress ||
    		msg.sender == operatorAddress
    	);
    	_;
    }

    /// Assigns a new address to act as the admin. Only available to the current admin.
    ///	_newAdmin The address of the new admin
    function setAdmin(address _newAdmin) external onlyAdmin {
    	require(_newAdmin != address(0));
    	adminAddress = _newAdmin;
    }

    /// Assigns a new address to act as the operator. Only available to the current operator.
    ///	_newOperator The address of the new operator
    function setOperator(address _newOperator) external onlyAdmin {
    	require(_newOperator != address(0));
    	operatorAddress = _newOperator;
    }  

    /// @dev Modifier to allow actions only when the contract IS NOT paused
    modifier whenNotPaused() {
    	require(!paused);
    	_;
    }

    /// @dev Modifier to allow actions only when the contract IS paused
    modifier whenPaused() {
        require(paused);
        _;
    }

    /// @dev Called by any "C-level" role to pause the contract. Used only when
    /// a bug or exploit is detected and we need to limit damage.
    function pause() external onlyCLevel whenNotPaused {
    	paused = true;
    }

    //	@notice This is public rather than external so it can be called by
    //	derived contracts.
    function unpause() public onlyAdmin whenPaused{
    	// can't unpause if contract was upgraded
    	paused = false;
    }
}