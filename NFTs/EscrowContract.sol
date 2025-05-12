// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
    function transderFrom(address to, address from, uint id) external;
}
contract EscrowContract {
    address public nftAddress;
    address payable public seller;
    address public inspector;
    address public lender;

    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }
}