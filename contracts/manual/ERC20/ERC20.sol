// SPDX-License-Identifier: MIT

///@notice most function are defined as public to allow integration by child contracts

pragma solidity ^0.8.19;

import "../../interfaces/IERC20.sol";
import "../../interfaces/IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
    mapping(address => uint) balance;
    mapping(address => mapping (address => uint)) _allowance;
    string private _name;
    string private _symbol;
    uint256 public _decimals;
    uint256 private _totalSupply;

    constructor(string memory name_, string memory symbol_,uint decimals_, uint _initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _totalSupply = _initialSupply;
    }

    function name() external view returns(string memory){
        return _name;
    }

    function symbol() external view returns(string memory){
        return _symbol;
    }

    function decimals() external view returns(uint256){
        return _decimals;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256){
        return balance[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint256){
        return _allowance[_owner][ _spender];
    }

    function transfer(address _to, uint256 _amount) public returns (bool success){
        _transfer(msg.sender, _to, _amount);
        success = true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success){
        uint allowed = _allowance[_from][msg.sender];
        require (allowed - _amount >= 0, "ERC20: amount exceeds allowance");  ///WHY: to allow uncheck refactor

        _allowance[_from][msg.sender] -= _amount;
        _transfer(_from, _to, _amount);

        success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        require(_spender != address(0), "ERC20: approve to address 0");

        _allowance[msg.sender][ _spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        success = true;
    }

    function _transfer(address _from, address _to, uint _amount) internal {
        require(_from != address(0), "ERC20: transfer from address 0");
        require(_to != address(0), "ERC20: transfer to address 0");

        uint senderBalance = balance[_from];
        require(senderBalance - _amount >= 0, "ERC20: amount exceeds balance"); //because unchecked block

        unchecked {
            balance[_from] -= _amount; //first decrement then increment to not go over total supply
            balance[_to] += _amount;
        }
        emit Transfer(_from, _to, _amount);
    }

    function _mint(address _account, uint _amount) internal virtual {
        require(_account != address(0), "ERC20: mint to address 0");

        _totalSupply += _amount;
        balance[_account] += _amount;

        emit Transfer(address(0), _account, _amount);
    }

    function _burn(address _account, uint _amount) internal virtual {
        require(_account != address(0), "ERC20: mint to address 0");

        balance[_account] -= _amount;
        _totalSupply -= _amount;

        emit Transfer(address(0), _account, _amount);
    }

    ///TODO: add hook _beforeTokenTransfer + hook _afterTokenTransfer for child contracts' inheritance
    ///TODO: refactor with internal _transfer to use in transfer & transferFrom
}