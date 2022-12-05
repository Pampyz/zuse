import { ethers } from "hardhat";
import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { zuseSol } from "../typechain-types";


async function token_mm_fixture() {
    const zuse = await deploy('ZUSE');
    const mm = await deploy_with_argument('SimpleMM', zuse.address);

    console.log(`Zuse token contract deployed to address: ${zuse.address}`);
    console.log(`MM token contract deployed to address: ${mm.address}`);
    return {zuse, mm}
}

describe("Deploy", function () {
    // We define a fixture to reuse the same setup in every test.
    async function deploymentFixture() {
        it("Should deploy a MM contract with the address of the token contract", async function () {
            const {zuse, mm} = await token_mm_fixture();
            expect(true);
          });
        return true;
    }

    // async function 
  });

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
