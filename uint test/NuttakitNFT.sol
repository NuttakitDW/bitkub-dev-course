// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721A.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract NuttakitNFT is Ownable, ERC721A {

  uint256 public preSaleStartTime;
  uint256 public preSaleEndTime;
  uint256 public publicSaleStartTime;
  uint256 public publicSaleEndTime;

  uint256 public lastDevMintTime;

  uint256 public maxPerTxDuringMint;
  uint256 public amountForDevs;

  uint256 public allowlistPrice = 0.08 ether;
  uint256 public publicPrice = 0.15 ether;

  
  bool public usedDevMint = false;

  constructor(
    uint256 _publicSaleStartTime,
    uint256 _publicSaleEndTime,
    uint256 _lastDevMintTime,
    uint256 _maxBatchSize,
    uint256 _collectionSize,
    uint256 _amountForDevs
    ) ERC721A("Nuttakit NFT", "EFFY", _maxBatchSize, _collectionSize) {
      
      publicSaleStartTime = _publicSaleStartTime;
      publicSaleEndTime = _publicSaleEndTime;

      lastDevMintTime = _lastDevMintTime;

      amountForDevs = _amountForDevs;
      maxPerTxDuringMint = _maxBatchSize;
    
  }

  modifier callerIsUser() {
    require(tx.origin == msg.sender, "The caller is another contract");
    _;
  }

  function publicSaleMint(uint256 _amount)
    external
    payable
    callerIsUser
  {
    require(
      isPublicSaleOn(),
      "public sale has not begun yet"
    );
    require(totalSupply() + _amount <= collectionSize, "reached max supply");
    require(
      _amount <= maxPerTxDuringMint,
      "can not mint this many"
    );
    _safeMint(msg.sender, _amount);
    refundIfOver(publicPrice * _amount);

  }

  function refundIfOver(uint256 price) private {
    require(msg.value >= price, "Need to send more ETH.");
    if (msg.value > price) {
      payable(msg.sender).transfer(msg.value);
    }
  }


  function isPreSaleOn() 
  public view returns (bool) {
    return block.timestamp >= preSaleStartTime &&
    block.timestamp < preSaleEndTime;
  }

  function isPublicSaleOn() 
  public view returns (bool) {
    return block.timestamp >= publicSaleStartTime &&
    block.timestamp < publicSaleEndTime;
  }

  //Just in case, we have to change.
  function setPreSaleTime(uint256 _start, uint256 _end) external onlyOwner {
    preSaleStartTime = _start;
    preSaleEndTime = _end;
  }

  //Just in case, we have to change.
  function setPublicSaleTime(uint256 _start, uint256 _end) external onlyOwner {
    publicSaleStartTime = _start;
    publicSaleEndTime = _end;
  }

  // For marketing etc.
  function devMint() external {

    require(usedDevMint != true, "can only use once");

    require(
      amountForDevs % maxPerTxDuringMint == 0,
      "can only mint a multiple of the maxBatchSize"
    );

    usedDevMint = true;

    uint256 numChunks = amountForDevs / maxPerTxDuringMint;
    for (uint256 i = 0; i < numChunks; i++) {
      _safeMint(msg.sender, maxPerTxDuringMint);
    }
  }

  // // metadata URI
  string private _baseTokenURI;

  function _baseURI() internal view virtual override returns (string memory) {
    return _baseTokenURI;
  }

  function setBaseURI(string calldata baseURI) external onlyOwner {
    _baseTokenURI = baseURI;
  }

  function withdrawMoney() external onlyOwner nonReentrant {
    (bool success, ) = msg.sender.call{value: address(this).balance}("");
    require(success, "Transfer failed.");
  }

  function setOwnersExplicit(uint256 quantity) external onlyOwner nonReentrant {
    _setOwnersExplicit(quantity);
  }

  function numberMinted(address owner) public view returns (uint256) {
    return _numberMinted(owner);
  }

  function getOwnershipData(uint256 tokenId)
    external
    view
    returns (TokenOwnership memory)
  {
    return ownershipOf(tokenId);
  }
}