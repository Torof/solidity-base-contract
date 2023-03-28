// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "../../interfaces/IERC20.sol";

contract ERC20 is IERC20 {
    function totalSupply() external view returns (uint256){}
    function balanceOf(address _owner) external view returns (uint256 balance){}
    function transfer(address _to, uint256 _value) external returns (bool success){}
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){}
    function approve(address _spender, uint256 _value) external returns (bool success){}
    function allowance(address _owner, address _spender) external view returns (uint256 remaining){}
}