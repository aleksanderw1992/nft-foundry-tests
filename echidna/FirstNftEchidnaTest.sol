// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/FirstNft.sol";

contract FirstNftEchidnaTest {
    FirstNft private contractUnderTests = new FirstNft();
    
    function totalSupplyDoNotExceed100() public returns (bool) {
        return contractUnderTests.totalSupply() >= 0 && contractUnderTests.totalSupply() <= 100;
    }
}