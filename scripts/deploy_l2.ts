import { ethers } from "hardhat";

async function main() {
    const Token = await ethers.getContractFactory('ZUSE');
    const token = await Token.deploy()
    const address = token.address
    console.log(`Token contract deployed to address: ${address}`);

    /*
    Connect to other contract via ethers.Contract(address, abi, providerOrSigner)
    */

    console.log(address)
    const Marketplace = await ethers.getContractFactory('Marketplace');
    const mkt = await Marketplace.deploy(address);

    
    const deployTx = await mkt.deployTransaction.wait()
    console.log(mkt.deployTransaction)
    console.log(`Marketplace contract deployed to address: ${mkt.address}`)

    const token_contract_address = await mkt.getTokenContractAddress();
    console.log(`Address of token as given in marketplace: ${token_contract_address}`)

    await mkt.setTokenContractAddress(address)
    const token_contract_address_new = await mkt.getTokenContractAddress();
    console.log(`Address of token as given in marketplace: ${token_contract_address_new}`)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
