// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FirstNft.sol";

contract FirstNftTest is Test {
    FirstNft contractUnderTests = new FirstNft();
    address someAdd = address(0x01);
    uint256 ETH_MIN_PRICE = 0.01 ether;
    uint256 ETH_NOT_SUFFICIENT_PRICE = 0.009 ether;
    address public owner;
    
    function setUp() public {
        owner = address(this);
    }

    function testMint100() public {
        for(uint256 i; i<100; i++ ) {
            contractUnderTests.mint{value:ETH_MIN_PRICE }();
//            console.log(string.concat(Strings.toString(contractUnderTests.totalSupply()), " ", Strings.toString(i)));
        }
        assertEq(100, contractUnderTests.totalSupply());
    }
    
    function testCannotMintMoreThan100() public {
        for(int i; i<100; i++ ) {
            contractUnderTests.mint{value:ETH_MIN_PRICE }();
        }
        vm.expectRevert("Total nft supply cannot exceed 100");
        contractUnderTests.mint{value:ETH_MIN_PRICE }();
    }
    
    function testCannotMintWithInsufficientEther() public {
        vm.expectRevert("You need to pay at least 0.01 ETH for each NFT to mint");
        contractUnderTests.mint{value:ETH_NOT_SUFFICIENT_PRICE }();
    }
    
    function testCannotExceedFiveTokensInSingleTransaction() public {
        vm.expectRevert("You can mint at most 5 NFTs in single transaction");
        contractUnderTests.mint{value:5*ETH_MIN_PRICE }(6);
    }
    
    function testCanMintUpToFiveTokensInSingleTransaction() public {
        for(uint8 i=1; i<5; i++ ) {
            contractUnderTests.mint{value:uint256(i)*ETH_MIN_PRICE}(i);
        }
    }
    
}
