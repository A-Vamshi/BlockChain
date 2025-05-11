// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Counter } from "@openzeppelin/contracts/utils/Counter.sol";
import { ERC721URIStorage, ERC721 } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTCreation is ERC721URIStorage {
    Counter private _tokenIds;

    constructor () ERC721("NFTToken", "Token") {}

    function mint(string memory tokenURI) public returns(uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return _tokenId;
    }

    function totalSupply() public view returns(uint) {
        return _tokenIds.current();
    }
}