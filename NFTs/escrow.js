const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), "ether");
}

describe("Escrow", () => {

    it("saves the addresses", async () => {
        const EscrowContract = await ethers.getContactFactory("EscrowContract");
        const escrowContact = await EscrowContract.deploy();

        console.log(escrowContact.address); 
    })
})