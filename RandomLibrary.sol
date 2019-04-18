pragma solidity ^0.4.25;

library GenerateRandomNumber {
    function generateRandom() internal returns (uint256) {
        address addr = address(0x8cC9C2e145d3AA946502964B1B69CE3cD066A9C7);
        bytes4 randomSignature = bytes4(keccak256("generateRandom()"));
        uint256 value;

        assembly {
            let o := mload(0x40)
            mstore(o, randomSignature)

            let success := call(
                15000,
                addr,
                0,
                o,
                0x04,
                o,
                0x20
            )

            if success {
                value := mload(o)
            }
        }

        return value;
    }
}
