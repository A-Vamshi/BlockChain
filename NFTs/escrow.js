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
        nftContract = await NFTCreationContact.deploy();

        // Mint
        let transaction = await nftContract.connect(seller).mint("https://example.metadataUrl/whatever/1.json");
        await transaction.wait();

        const Escrow = await ethers.getContactFactory("EscrowContract");
        escrow = await Escrow.deploy(nftContract.address, seller.address, inspector.address, lender.address);

        // Approve property
        transaction = await nftContract.connect(seller).approve(escrow.address, 1);
        await transaction.wait();

        // List property
        transaction = await escrow.connect(seller).list(1, tokens(10), tokens(5), buyer.address);
        await transaction.wait();

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

    describe("Listing", () => {
        // To check if the ownership of NFT changed or not
        it("Updates the ownership", async () => {
            expect(await nftContract.ownerOf(1)).to.be.equal(escrow.address);
        })
        it("Tests if it's listed", async () => {
            const result = await escrow.isListed(1);
            expect(result).to.be.equal(true);
        })
        it("Returns buyer", async () => {
            const result = await escrow.buyer(1);
            expect(result).to.be.equal(buyer.address);
        })
        it("Returns purchase price", async () => {
            const result = await escrow.purchasePrice(1);
            expect(result).to.be.equal(tokens(10));
        })
        it("Returns escrow amount", async () => {
            const result = await escrow.escrowAmount(1);
            expect(result).to.be.equal(tokens(5));
        })
    })

    describe("Deposit earnest", () => {
        // To update contract balance after depositing earnest
        it("Updates contreact balancce", async () => {
            const transaction = await escrow.connect(buyer).depositEarnest(1, {value: tokens(5)});
            await transaction.wait();
            const result = await escrow.getBalance();
            expect(result).to.be.equal(tokens(5));
        })
    })

    describe("Inspection", () => {
        // To check if inspector passes
        it("Updates inspection status", async () => {
            const transaction = await escrow.connect(inspector).updateInspectionStatus(1, true);
            await transaction.wait();
            const result = await escrow.inspectionPassed(1);
            expect(result).to.be.equal(true);
        })
    })

    describe("Approval", () => {
        // To update approval status
        it("Updates approval status", async () => {
            let transaction = await escrow.connect(buyer).approveSale(1);
            await transaction.wait();
            transaction = await escrow.connect(seller).approveSale(1);
            await transaction.wait();
            transaction = await escrow.connect(lender).approveSale(1);
            await transaction.wait();
            expect(await escrow.approval(1, buyer.address)).to.be.equal(true);
            expect(await escrow.approval(1, seller.address)).to.be.equal(true);
            expect(await escrow.approval(1, lender.address)).to.be.equal(true);
        })
    })

    describe("Sale", async () => {
        beforeEach(async () => {
            let transaction = await escrow.connect(buyer).depositEarnest(1, {value: tokens(5)});
            await transaction.wait();

            transaction = await escrow.connect(inspector).updateInspectionStatus(1, true);
            await transaction.wait();
            
            transaction = await escrow.connect(buyer).approveSale(1);
            await transaction.wait();

            transaction = await escrow.connect(seller).approveSale(1);
            await transaction.wait();

            transaction = await escrow.connect(lender).approveSale(1);
            await transaction.wait();

            await lender.sendTransaction({to : escrow.address, value: tokens(5)});

            transaction = await escrow.connect(seller).finalizeSale(1);
            await transaction.wait();
        })

        it("Updates balance", async () => {
            expect(await escrow.getBalance()).to.be.equal(0);
        })

        it("Updates ownership", async () => {
            expect(await nftContract.ownerOf(1)).to.be.equal(buyer.address);
        })
    })
})