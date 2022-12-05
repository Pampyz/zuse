import { ethers } from "hardhat";

async function deploy(tag) {
  const Factory = await ethers.getContractFactory(tag);
  const zuse = await Factory.deploy();
  return zuse;
}

async function deploy_MM() {
  const Factory = await ethers.getContractFactory('SimpleMM')
  const MM = await Factory.deploy()
  return MM
}

async function main() {
  const zuse = await deploy('ZUSE');

  const supply = await zuse.totalSupply(); // Can call the functions directly on the contract object

  const contract_address = zuse.address; // Can obtain the address of the contract
  const owner_address = await zuse.owner(); // Can obtain the address of the owner - as a state variable

  console.log('Total supply: ', supply);
  console.log('Contract deployed to address: ', contract_address);
  
  // Get other addresses
  const [_, addr1, addr2] = await ethers.getSigners(); // Can create other accounts, 'signers'
  const address1 = await addr1.getAddress()
  const address2 = await addr2.getAddress()

  const senderBalance = await ethers.provider.getBalance(owner_address);
  const contractBalance = await ethers.provider.getBalance(contract_address);
  const balance1 = await ethers.provider.getBalance(address1);
  const balance2 = await ethers.provider.getBalance(address2);
  

  console.log('ETH balance of owner, contract, address1, address2: ', senderBalance, contractBalance, balance1, balance2);
  console.log('Token balance of owner, address1, address2: ', await zuse.balanceOf(owner_address), await zuse.balanceOf(address1), await zuse.balanceOf(address2));

  await addr1.sendTransaction({
    to: contract_address,
    value: ethers.utils.parseEther("1.0"), // Sends exactly 1.0 ether
  });

  console.log('ETH balance of owner, contract, address1, address2 after sending TX: ', senderBalance, contractBalance, balance1, balance2);
  
  await zuse.transfer(address2, 100000);
  console.log('Token balance of owner, address1, address2 after using transfer: ', await zuse.balanceOf(owner_address), await zuse.balanceOf(address1), await zuse.balanceOf(address2));

  
  const res = await zuse.connect(addr1).buy({value: ethers.utils.parseEther("0.5")});
  console.log('ETH balance of owner, contract, address1, address2 after purchasing: ', senderBalance, contractBalance, balance1, balance2);
  console.log('Token balance of owner, address1, address2 after purchasing: ', await zuse.balanceOf(owner_address), await zuse.balanceOf(address1), await zuse.balanceOf(address2));


  console.log('ETH balance of address1: ', await ethers.provider.getBalance(address1));
  console.log('Contract ETH balance: ', await ethers.provider.getBalance(contract_address));
  console.log('Address1 ETH balance: ', await ethers.provider.getBalance(address1));
  console.log('Address2 ETH balance: ', await ethers.provider.getBalance(address2));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
