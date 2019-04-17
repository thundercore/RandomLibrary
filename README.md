# ThunderCore RNGLibrary

Due to the difficulty of generating randomness on the Ethereum Blockchain coupled with the necessity of such a feature in many gambling/gaming contracts on smart-contract platforms, the ThunderCore team has decided to release a trusted random number API to allow smart-contract's to easily and reliably generate a random number on the ThunderCore network.

Interaction with this Solidity library is as easy as the following:
* Navigate to remix.ethereum.org, and import your smart contract.
* Under your Solidity version declaration (alongside other imports), copy and paste the following: 'import "http://github.com/thundercore/RandomLibrary/RandomLibrary.sol"
* You can now interact with the random number generator like so: GenerateRandom.getRandom()!
* The random number generator will always return a bytes32 value, so you will need to cast/convert this value as it best suits your needs.

Happy coding!
