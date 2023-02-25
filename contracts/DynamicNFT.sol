// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, ERC721URIStorage, Ownable {
    constructor() ERC721("ClashOfClans", "COC") {}


    struct NFT {
        string name;
        uint8 level;// Current level of NFT
        string baseURI;
        string levelmaxURI;
         // Timestamp when NFT can be upgraded
    }
    mapping(uint8 => NFT) private characters;
function SetDetails(string memory _name,uint8 character, uint8 level,string memory uri,string memory uriMax ) public onlyOwner
{
    //add some reverts here
    characters[character] = NFT(_name,level, uri,uriMax);
}


    function safeMint(address to, uint256 tokenId, uint8 character)
        public
        payable
    {
        //Can we add a reentry gaurd here ??
        require(msg.value>1000000000000000 ,"send proper value");
       NFT memory data= characters[character];
       string memory uri=data.baseURI;
       require(data.level==1,"u can mint only level one character");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId,uri);
    }

    function PurchaseLevel(uint256 tokenId,uint8 character) public payable {
        //reentry gaurd here too
        require(msg.value>10000000000000000 ,"send proper value");
         require(_exists(tokenId) == true, "Token does not exist");
          NFT memory data= characters[character];
          require(data.level==1,"already maxed out");
          string memory uri=data.levelmaxURI;
          _setTokenURI(tokenId,uri);
          data.level=2;
          characters[character]=data;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

 /*Requirements
 there r 3 characters
->PEKKA, Valkyrie, and Hog Rider

->2 levels and each has its own metadata in IPFS

->I have uri for all

->now when a user pays 0.001eth  It should mint PEKKA or any one to him
*******Trivia fork repository and try adding this functionality create a pull request and I will verify it*******

->then when he calls upgrade it should check if he has 0.01 eth then put timestamp for one day from then

*****************************************************************************************************************
hint:(mdifications have to be made in struct add another mapping and finally use assert for timestamp)

->after which he can pay 1 eth and then the metadata is changed to level 2

->same for others**/
