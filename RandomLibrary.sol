pragma solidity ^0.4.25;

library GenerateRandomNumber {
    function getRandom() external constant returns (uint256 r) {
        address addr = address(0x8cC9C2e145d3AA946502964B1B69CE3cD066A9C7);
        assembly {
            if iszero(call(not(0), addr, 0, 0, 0, r, 0x20)) {
                revert(0, 0)
            }
        }

        return value;
    }
}
