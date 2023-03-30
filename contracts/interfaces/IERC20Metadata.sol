// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20Metadata {
    
    /**
     * @notice Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @notice Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @notice Returns the decimals places of the token.
     */
    function decimals() external view returns (uint256);
}