# Nft project based on foundry testing framework

With spec:
- Compatible with ERC-721 standard
- Max 100 tokens
- 0.01 ETH mint cost
- Max 5 Nfts in single transaction
- Owner (ie. deployer) can withdraw funds from the contract (ie. minting fees)
- with unit tests for corner cases


# Foundry build
```html
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup
forge build 
forge test

```

# Deployment in foundry
https://book.getfoundry.sh/tutorials/solidity-scripting
```bash
forge script script/FirstNft.s.sol:MyScript --rpc-url $GOERLI_RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv

```

Deployed on goerli testnet:
`https://goerli.etherscan.io/tx/0x58dc548e737599a6779fda7ad00d4e2f607954ef65df271809700e461b96b70e`

# Echidna

To run echidna:
```html
docker pull trailofbits/eth-security-toolbox
docker run -it -v "$PWD":/home/training trailofbits/eth-security-toolbox
solc-select install 0.8.13
solc-select use 0.8.13
cd  ../training/
echidna-test ./echidna/FirstNftEchidnaTest.sol

```