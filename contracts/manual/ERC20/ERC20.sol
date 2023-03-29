// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "../../interfaces/IERC20.sol";

contract ERC20 is IERC20 {
    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) _allowance;
    string private _name;
    string private _symbol;
    uint256 public decimals;
    uint256 private _totalSupply;

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) external view returns (uint256 balance){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) external returns (bool success){
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
        balances[_from] -= _value;
        balances[_to] += _value;
        success = true;
    }

    function approve(address _spender, uint256 _value) external returns (bool success){
        _allowance[msg.sender][ _spender] = _value;
        success = true;
    }

    function allowance(address _owner, address _spender) external view returns (uint256 remaining){
        return _allowance[_owner][ _spender];
    }
}