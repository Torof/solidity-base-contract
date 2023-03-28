// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "../../interfaces/IERC1155.sol";
import "../../interfaces/IERC1155TokenReceiver.sol";

contract ERC1155 is IERC1155, IERC1155TokenReceiver{

    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4){}

    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4){}

    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external{}

    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external{}

    function balanceOf(address _owner, uint256 _id) external view returns (uint256){}

    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory){}

    function setApprovalForAll(address _operator, bool _approved) external{}

    function isApprovedForAll(address _owner, address _operator) external view returns (bool){}
}