# Nft project based on foundry testing framework

With spec:
- Compatible with ERC-721 standard
- Max 100 tokens
- 0.01 ETH mint cost
- Max 5 Nfts in single transaction
- Owner (ie. deployer) can withdraw funds from the contract (ie. minting fees)
- with unit tests for corner cases

# Deployment in foundry
https://book.getfoundry.sh/tutorials/solidity-scripting
```bash
forge script script/FirstNft.s.sol:MyScript --rpc-url $GOERLI_RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv

```

Deployed on goerli testnet:
`https://goerli.etherscan.io/tx/0x58dc548e737599a6779fda7ad00d4e2f607954ef65df271809700e461b96b70e`