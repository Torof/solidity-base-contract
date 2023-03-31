// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "../../interfaces/IERC721.sol";
import "../../interfaces/IERC165.sol";
import "../../interfaces/IERC721Metadata.sol";

contract ERC721 is IERC721, IERC165, IERC721Metadata {

    string private _name;
    string private _symbol;
    string private uri;

    mapping(address => uint) balance;
    mapping(uint => address) owner;
    mapping(uint => address) tokenApproval;
    mapping(address => mapping(address => bool)) operatorApproval;


    function supportsInterface(bytes4 interfaceId) public view returns (bool) {
        return
        interfaceId == type(IERC721).interfaceId ||
        interfaceId == type(IERC721Metadata).interfaceId ||
        interfaceId == type(IERC165).interfaceId;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 _tokenId) public virtual view returns (string memory) {}

    function balanceOf(address _owner) public view returns (uint256) {
        return balance[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return owner[_tokenId];
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public payable {}

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {}

    ///TODO: enable operatorForAll to approve for 1
    function approve(address _approved, uint256 _tokenId) external payable {
        require(_approved != address(0), "ERC721: approve to address 0");
        require(ownerOf(_tokenId) == msg.sender, "ERC721: not owner");
        tokenApproval[_tokenId] = _approved;
        emit Approval(msg.sender,_approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) external {}

    function getApproved(uint256 _tokenId) external view returns (address) {
        return tokenApproval[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return operatorApproval[_owner][ _operator];
    }
}