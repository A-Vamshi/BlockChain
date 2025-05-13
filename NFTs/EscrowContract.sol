// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(address to, address from, uint id) external;
}
contract EscrowContract {
    address public nftAddress;
    address payable public seller;
    address public inspector;
    address public lender;

    mapping(uint => bool) public isListed;
    mapping(uint => uint) public purchasePrice;
    mapping(uint => uint) public escrowAmount;
    mapping(uint => address) public buyer;

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can list property");
        _;
    }

    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }

    function list(uint nftId, uint _purchasePrice, uint _escrowAmount, address _buyer) payable onlySeller public {
        // Transfer NFT from seller to the contract
        IERC721(nftAddress).transferFrom(msg.sender, address(this), nftId);
        isListed[nftId] = true;
        purchasePrice[nftId] = _purchasePrice;
        escrowAmount[nftId] = _escrowAmount;
        buyer[nftId] = _buyer;

    }
}