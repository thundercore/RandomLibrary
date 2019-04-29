# ThunderCore RNGLibrary

The ThunderCore blockchain has an internal random number generation function. We now realize that this function can also be used by gambling/gaming applications who have grappled with the difficulty of generating randomness on the Ethereum Blockchain. A random number generation feature is necessary for gambling/gaming applications on the smart-contract platforms. With ThunderCore's trusted random number API, applications can reliably generate a random number on the ThunderCore network. This API requires trusting the ThunderCore accelerator but we believe that it should not be a concern for most applications dealing with small amount of tokens.

Interaction with this Solidity library is as easy as the following:
* Navigate to remix.ethereum.org, and import your smart contract.
* Under your Solidity version declaration (alongside other imports), copy and paste the following: 'import "http://github.com/thundercore/RandomLibrary/RandomLibrary.sol"
* You can now interact with the random number generator like so: GenerateRandomNumber.generateRandom()!
* The random number generator will always return a bytes32 value, so you will need to cast/convert this value as it best suits your needs.

Happy coding!

Basic example:

```
    pragma solidity ^0.4.25;
    
    import "http://github.com/thundercore/RandomLibrary/RandomLibrary.sol";

    contract RandomExample {
        event didWin(bool);
        uint256 public contractBalance;
        
        constructor() payable {
            contractBalance = uint256(msg.value);
        }
        
        function betNumber(uint256 bet) payable external returns (bool) {
            if (msg.value < 5) {
                contractBalance = contractBalance + msg.value;
                        
                didWin(false);
                return false;
            }
            
            uint256 randomNumber = GenerateRandomNumber.generateRandom();
            if (bet < randomNumber) {
                msg.sender.transfer(msg.value+1);
                didWin(true);
                
                contractBalance = contractBalance - (msg.value+1);
                return true;
            } 
            
            contractBalance = contractBalance + msg.value;
            didWin(false);
            return false;
        }
    }
 ```
