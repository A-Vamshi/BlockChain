const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), "ether");
}

describe("Escrow", () => {

    let buyer, seller, inspector, lender;
    let nftContract, escrow;

    beforeEach(async () => {
        // To get a few blockchain accounts from hardhat
        [buyer, seller, inspector, lender] = await ethers.getSigners();

        // Deploying the smart contract
        const NFTCreationContact = await ethers.getContactFactory("NFTCreation");
        nftContract = await EscrowContract.deploy();

        // Mint
        let transaction = await escrowContact.connect(seller).mint("https://example.metadataUrl/whatever/1.json");
        await transaction.wait();

        const Escrow = await ethers.getContactFactory("EscrowContract");
        escrow = await Escrow.deploy(nftContract.address, seller.address, inspector.address, lender.address);
    })

    describe("Deployment", () => {
        // To check if they have same values, can be used for other variables
        it("Return NFT", async () => {
            const result = await escrow.nftAddress();
            expect(result).to.be.equal(nftContract.address);
        })
        it("Return seller", async () => {
            const result = await escrow.seller();
            expect(result).to.be.equal(seller.address);
        })
        it("Return lender", async () => {
            const result = await escrow.lender();
            expect(result).to.be.equal(lender.address);
        })
        it("Return inspector", async () => {
            const result = await escrow.inspector();
            expect(result).to.be.equal(inspector.address);
        })
    })
})