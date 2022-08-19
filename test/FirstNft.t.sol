// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "/src/FirstNft.sol";

contract FirstNftTest is Test {
    FirstNft contractUnderTests;
    uint256 ETH_MIN_PRICE = 0.01 ether;
    uint256 ETH_NOT_SUFFICIENT_PRICE = 0.009 ether;
    address owner = address(0x1223);
    address someAddress = address(0x1889);
    
    function setUp() public {
        vm.startPrank(owner);
        contractUnderTests = new FirstNft();
        vm.stopPrank();
    }

    function testMint100() public {
        for(uint256 i; i<100; i++ ) {
            contractUnderTests.mint{value:ETH_MIN_PRICE }();
//            console.log(string.concat(Strings.toString(contractUnderTests.totalSupply()), " ", Strings.toString(i)));
        }
        assertEq(contractUnderTests.totalSupply(), 100);
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
    
    function testOwnerCanWithdraw() public {
        contractUnderTests.mint{value:ETH_MIN_PRICE}();
        vm.prank(owner);
        contractUnderTests.withdraw();
    }
    
    function testNotOwnerCannotWithdraw() public {
        contractUnderTests.mint{value:ETH_MIN_PRICE}();
        vm.expectRevert("Only owner can withdraw funds");
        vm.prank(someAddress);
        contractUnderTests.withdraw();
    }
    
    function testBalancesChangeAfterWithdraw() public {
        vm.deal(owner, 1 ether);
        vm.deal(someAddress, 1 ether);
        
        // testing preconditions
        assertEq(address(contractUnderTests).balance, 0);
        assertEq(owner.balance, 1 ether);
        assertEq(someAddress.balance, 1 ether);
        
        // minting
        vm.prank(someAddress);
        contractUnderTests.mint{value:0.5 ether}(3);
    
        assertEq(address(contractUnderTests).balance, 0.5 ether);
        assertEq(owner.balance, 1 ether);
        assertEq(someAddress.balance, 0.5 ether);

        // withdrawing
        vm.prank(owner);
        contractUnderTests.withdraw();
    
        assertEq(address(contractUnderTests).balance, 0);
        assertEq(owner.balance, 1.5 ether);
        assertEq(someAddress.balance, 0.5 ether);
    }
}
