const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    const VikramCoins = await ethers.getContractFactory("vikramcoins");
    const vikramcoins = await VikramCoins.deploy();
    console.log("Contract address: ", vikramcoins.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    })