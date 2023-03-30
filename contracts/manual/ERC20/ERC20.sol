// SPDX-License-Identifier: MIT

///@notice most function are defined as public to allow integration by child contracts

pragma solidity 0.8.19;

import "../../interfaces/IERC20.sol";

contract ERC20 is IERC20 {
    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) _allowance;
    string private _name;
    string private _symbol;
    uint256 public decimals;
    uint256 private _totalSupply;

    constructor(string memory name_, string memory symbol_, uint _initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = _initialSupply;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){
        return balances[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return _allowance[_owner][ _spender];
    }

    function transfer(address _to, uint256 _amount) public returns (bool success){
        uint senderBalance = balances[msg.sender];
        require(senderBalance - _amount >= 0, "ERC20: amount exceeds balance"); ///WHY: to allow uncheck refactor
        require(_to != address(0), "ERC20: transfer to address 0");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        success = true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success){
        uint senderBalance = balances[_from];
        uint allowed = _allowance[_from][msg.sender];
        require(senderBalance - _amount >= 0, "ERC20: amount exceeds balance");
        require (allowed - _amount >= 0, "ERC20: amount exceeds allowance");  ///WHY: to allow uncheck refactor
        require(_to != address(0), "ERC20: transfer to address 0");
        balances[_from] -= _amount;
        balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        _allowance[msg.sender][ _spender] = _value;
        success = true;
    }

    function _mint(address _account, uint _amount) internal {
        require(_account != address(0), "ERC20: mint to address 0");
        balances[_account] += _amount;
        emit Transfer(address(0), _account, _amount);
    }

    function _burn(address _account, uint _amount) internal {
        require(_account != address(0), "ERC20: mint to address 0");
        balances[_account] -= _amount;
        emit Transfer(address(0), _account, _amount);
    }

    ///TODO: add hook _beforeTokenTransfer + hook _afterTokenTransfer for child contracts' inheritance
    ///TODO: refactor with internal _transfer to use in transfer & transferFrom
}