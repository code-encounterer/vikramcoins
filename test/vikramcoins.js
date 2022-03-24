const { inputToConfig } = require("@ethereum-waffle/compiler");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("vikramcoins contract", function() {
    let VikramCoins;
    let vikramcoins;

    beforeEach(async function() {
        VikramCoins = await ethers.getContractFactory("vikramcoins");
        [manager, addr1, addr2, ...addrs] = await ethers.getSigners();
        vikramcoins = await VikramCoins.deploy();
    })

    describe("Deployment", async function() {
        it("Should set maximum vikramcoins equal to 100000", async function() {
            expect(await vikramcoins.max_vikramcoins()).to.equal(100000);
        })
    })

    describe("Transactions", async function() {
        it("Investor should be able to buy vikramcoins", async function() {
            await vikramcoins.buy_vikramcoins(addr1.address, 50);
            const addr1Balance_vikramcoins = await vikramcoins.equity_in_vikramcoins(addr1.address)
            expect(addr1Balance_vikramcoins).to.equal(500);
        })
    })
})