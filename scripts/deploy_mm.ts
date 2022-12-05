import { ethers } from "hardhat";

async function deploy(tag) {
    const Factory = await ethers.getContractFactory(tag);
    const contract = await Factory.deploy();
    return contract;
  }

async function deploy_with_argument(tag, argument) {
    const Factory = await ethers.getContractFactory(tag);
    const contract = await Factory.deploy(argument);
    return contract;
  }

async function main() {
    const zuse = await deploy('ZUSE');
    const mm = await deploy_with_argument('SimpleMM', zuse.address);
    

    console.log(`Zuse token contract deployed to address: ${zuse.address}`);
    console.log(`MM token contract deployed to address: ${mm.address}`);


    console.log('Total token supply: ', await zuse.totalSupply());
    
    
    /*
    Connect to other contract via ethers.Contract(address, abi, providerOrSigner)
    */
    
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
