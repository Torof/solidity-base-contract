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

    constructor(
        string memory name_,
        string memory symbol_,
        string memory _uri
    ) {
        _name = name_;
        _symbol = symbol_;
        uri = _uri;
    }

    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
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

    function tokenURI(
        uint256 _tokenId
    ) public view virtual returns (string memory) {}

    function balanceOf(address _owner) public view returns (uint256) {
        return balance[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return owner[_tokenId];
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory data
    ) public payable virtual {
        require(
            msg.sender == ownerOf(_tokenId) ||
                tokenApproval[_tokenId] == msg.sender ||
                operatorApproval[_from][msg.sender],
            "ERC721: caller is not owner nor approved"
        );
        _transfer(_from, _to, _tokenId);
        require(
            checkOnERC721Received(_from, _to, _tokenId, data),
            "ERC721: transfer to non ERC721Receiver"
        );
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable {
        require(_approved != address(0), "ERC721: approve to address 0");
        address owner_ = ownerOf(_tokenId);
        require(
            owner_ == msg.sender || operatorApproval[owner_][msg.sender],
            "ERC721: not owner nor approved"
        );

        tokenApproval[_tokenId] = _approved;

        emit Approval(msg.sender, _approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0), "ERC721: approve to address 0");

        operatorApproval[msg.sender][_operator] = _approved;

        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
        return tokenApproval[_tokenId];
    }

    function isApprovedForAll(
        address _owner,
        address _operator
    ) external view returns (bool) {
        return operatorApproval[_owner][_operator];
    }

    function _mint(address _to, uint _tokenId) internal {
        require(_to != address(0), "ERC721: mint to address 0");
        require(
            ownerOf(_tokenId) == address(0),
            "ERC721: token already minted"
        );

        balance[_to] += 1;
        owner[_tokenId] = _to;

        emit Transfer(address(0), _to, _tokenId);
    }

    function _burn() internal {}

    ///TODO add unchecked block
    function _transfer(address _from, address _to, uint _tokenId) internal {
        require(ownerOf(_tokenId) == _from, "");
        require(_to != address(0), "ERC721: transfer to address 0");

        delete tokenApproval[_tokenId];

        balance[_from] -= 1;
        balance[_to] += 1;
        owner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function checkOnERC721Received(
        address _from,
        address _to,
        uint _tokenId,
        bytes memory data
    ) internal returns (bool) {}
}
