// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "./ERC721.sol";
import "../../interfaces/IERC721Enumerable.sol";
import "../../interfaces/IERC165.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

function supportsInterface(bytes4 interfaceID) public override view returns (bool){}
function totalSupply() external view returns (uint256){}
function tokenByIndex(uint256 _index) external view returns (uint256){}
function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){}
}