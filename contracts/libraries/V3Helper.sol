// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// LIBRARIES
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

/**
 * @title V3Helper
 *
 * @author 0xkmmm
 *
 * @notice This library serves as a helper for sorting and calculating initial prices when using uniswap v3
 */
library V3Helper {
    uint256 private constant Q192 = 2 ** 192;

    function _sortTokens(
        address _tokenA,
        address _tokenB
    ) internal pure returns (address _sortedTokenA, address _sortedTokenB) {
        require(_tokenA != address(0) && _tokenB != address(0), "Token addresses cannot be zero.");

        // Sort the token addresses
        (_sortedTokenA, _sortedTokenB) = _tokenA < _tokenB
            ? (_tokenA, _tokenB)
            : (_tokenB, _tokenA);
    }

    ///@notice Encode price square root function
    function encodePriceSqrt(uint256 reserve1, uint256 reserve0) internal pure returns (uint160) {
        require(reserve0 > 0, "reserve0 must be greater than 0");

        uint256 ratio = (reserve1 * Q192) / reserve0;
        uint256 sqrtRatio = Math.sqrt(ratio);

        // Downcast to uint160 as required by the Uniswap V3 protocol
        return uint160(sqrtRatio);
    }
}
