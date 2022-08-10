// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FirstNft is ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _counter;
    address private owner = msg.sender;

    uint private constant MAX_SUPPLY = 100;
    uint private constant MIN_MINT_PRICE = 0.01 ether;
    uint private constant MAX_AMOUNT_PER_TRANSACTION = 5;
    
    string private constant IMG_URL = "https://ipfs.io/ipfs/QmTsd2FfrD2x6yryLsrJ6ep95vR5sVrKg9RQxYHkzyAPvw?filename=Aleksander%20Wo%CC%81jcik%20druk-79.jpg";

    constructor() ERC721("FirstNft", "FN") public {
    }
    
    /**
    * owner - allows to mint token for other user than msg.sender
    */
    function mint(address owner) public payable {
        mint(owner, uint8(1));
    }

    /**
    * owner - allows to mint token for other user than msg.sender
    */
    function mint(address owner, uint8 amount) public payable {
        require(amount > 0 && amount <= 5, "You can mint at most 5 NFTs in single transaction");
        require(_counter.current() < MAX_SUPPLY - amount, "Total nft supply cannot exceed 100");
        require(msg.value >= MIN_MINT_PRICE * amount, "You need to pay at least 0.01 ETH for each NFT to mint");

        for (uint i; i < amount; i++) {
            _counter.increment();
            uint256 newItemId = _counter.current();
            _mint(owner, newItemId);
            _setTokenURI(newItemId, IMG_URL);
        }
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw funds");
        _;
    }

    // overriden for inheritance solidity
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        return ERC721URIStorage.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721) returns (bool) {
        return ERC721Enumerable.supportsInterface(interfaceId);

    }

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        ERC721URIStorage._burn(tokenId);
    }


}