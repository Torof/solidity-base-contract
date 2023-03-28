// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "../../interfaces/IERC721.sol";
import "../../interfaces/IERC165.sol";

contract ERC721 is IERC721, IERC165{
    function supportsInterface(bytes4 interfaceID) public view returns (bool){}

    function balanceOf(address _owner) public view returns (uint256){}

    function ownerOf(uint256 _tokenId) public view returns (address){}

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable{}

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable{}

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable{}

    function approve(address _approved, uint256 _tokenId) external payable{}

    function setApprovalForAll(address _operator, bool _approved) external{}

    function getApproved(uint256 _tokenId) external view returns (address){}

    function isApprovedForAll(address _owner, address _operator) external view returns (bool){}
}