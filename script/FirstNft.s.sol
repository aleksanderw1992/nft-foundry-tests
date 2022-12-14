// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/FirstNft.sol";

contract MyScript is Script {
    function run() external {
        vm.startBroadcast();
        FirstNft nft = new FirstNft();
        vm.stopBroadcast();
    }
}