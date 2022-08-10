// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FirstNft.sol";

contract FirstNftTest is Test {
    FirstNft contractUnderTests = new FirstNft();
    address someAdd = address(0x01);
    uint256 ETH_MIN_PRICE = 10e16;
    
    function setUp() public {
    
    }

    function testMint100() public {
//        console.log(contractUnderTests.totalSupply());
        for(uint256 i; i<100; i++ ) {
            contractUnderTests.mint{value:ETH_MIN_PRICE }(someAdd, 1);
//            console.log(string.concat(Strings.toString(contractUnderTests.totalSupply()), " ", Strings.toString(i)));
        }
//        console.log(contractUnderTests.totalSupply());
        assertEq(100, contractUnderTests.totalSupply());
    }
    
    function testCannotMintMoreThan100() public {
        for(int i; i<100; i++ ) {
            contractUnderTests.mint{value:ETH_MIN_PRICE }(someAdd, 1);
        }
        vm.expectRevert("Total nft supply cannot exceed 100");
        contractUnderTests.mint{value:ETH_MIN_PRICE }(someAdd, 1);
    }
}
