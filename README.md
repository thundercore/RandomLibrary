# ThunderCore RNGLibrary

## Summary
ThunderCore blockchain supports generating cryptographically secure 256-bit
random numbers through Thunder trusted random number generator procompile
contract.

## Motivation
When developing smart contract for Ethereum, there's no builtin support to
generate cryptographically secure random numbers. There are some possible
solutions e.g. using Ethereum Alarm or Oraclize. While these solutions rely
on external services and are not scalable. To address such requirements,
ThunderCore implements builtin support to generate cryptographically secure
random numbers through precompiled contract.

## Specification
ThunderCore implements a precompiled contract which resides at address
0x8cC9C2e145d3AA946502964B1B69CE3cD066A9C7. The address is the first 20
bytes of sha256("Thunder_Random"). Each invocation of fallback function
of trusted random generator precompiled contract will return a 256-bit
random number. The gas cost for each invocation is 1265040. Below is an example
which can be embedded into smart contract. ThunderCore also creates a
library interface which can be imported from Github with URL
github.com/thundercore/RandomLibrary/RandomInterface.sol in Remix.
The random number generator will always return a bytes32 value, so you
will need to cast/convert this value as it best suits your needs.

```
interface ThunderRandomLibraryInterface {
    function rand() external returns (uint256);
}
```

## Example
In the basic example shown below, a random number is used to determine
whether the contract will pay the user. If the number is greater than
the bet from the user, the contract takes the user's wager. If not, the
contract pays the user their own bet plus 1.

```
pragma solidity ^0.8.9;

interface ThunderRandomLibraryInterface {
    function rand() external returns (uint256);
}

contract RandomExampleInterfaceVersion {
    event didWin(bool);
    uint256 public contractBalance;
    // Random precompiled contract address is 0x8cC9C2e145d3AA946502964B1B69CE3cD066A9C7
    address constant public randomNumberContractAddress = 0x8cC9C2e145d3AA946502964B1B69CE3cD066A9C7; 
    ThunderRandomLibraryInterface internal RNGLibrary;

    constructor() payable {
        contractBalance = uint256(msg.value);
        RNGLibrary = ThunderRandomLibraryInterface(randomNumberContractAddress);
    }

    function betNumber(uint256 bet) payable external returns (bool) {
        if (msg.value < 5) {
            contractBalance = contractBalance + msg.value;

            emit didWin(false);
            return false;
        }

        uint256 randomNumber = RNGLibrary.rand();
        address payable sender = payable(msg.sender);
        if (bet < randomNumber) {
            sender.transfer(msg.value+1);
            emit didWin(true);

            contractBalance = contractBalance - (msg.value+1);
            return true;
        }

        contractBalance = contractBalance + msg.value;
        emit didWin(false);
        return false;
    }
}
 ```
