import { ethers } from "hardhat";

async function deploy(tag) {
  const Factory = await ethers.getContractFactory(tag);
  const zuse = await Factory.deploy();
  return zuse;
}

async function main() {
  const zuse = await deploy('ZUSE');

  const supply = await zuse.totalSupply(); // Can call the functions directly on the contract object
  const contract_address = zuse.address; // Can obtain the address of the contract
  console.log('Total supply: ', supply);
  console.log('Contract deployed to address: ', contract_address);
  
  const [owner, addr1, addr2, addr3] = await ethers.getSigners(); // Can create other accounts, 'signers'
  
  const sender = await zuse.getSender();
  const ownerAddress = await owner.getAddress();
  const flag = (sender==ownerAddress);

  if (!flag) {
    return;
  }

  const address1 = await addr1.getAddress()
  const address2 = await addr2.getAddress()
  const address3 = await addr3.getAddress()

  console.log(sender, await owner.getAddress())
  console.log(await addr1.getAddress(), await addr2.getAddress(), await addr3.getAddress());
  
  const senderBalance = await ethers.provider.getBalance(sender);
  console.log('ETH balance of deployer: ', senderBalance)

  const balance1 = await ethers.provider.getBalance(address1);
  const balance2 = await ethers.provider.getBalance(address2);
  const balance3 = await ethers.provider.getBalance(address3);
  console.log('ETH balance of address1: : ', balance1)
  console.log('ETH balance of address2: : ', balance2)
  console.log('ETH balance of address3: : ', balance3)

  /*
  const transactionHash = await addr1.sendTransaction({
    to: contract_address,
    value: ethers.utils.parseEther("1.0"), // Sends exactly 1.0 ether
  });
  
  */

  console.log('ETH balance of address1: ', await ethers.provider.getBalance(address1));

  console.log('Deployer token balance: ', await zuse.balanceOf(sender));
  await zuse.transfer(address2, 100000);

  console.log('Deployer token balance: ', await zuse.balanceOf(sender));

  console.log('Fellback?', await zuse.getFellback());
  const res = await zuse.connect(addr1).buy({value: ethers.utils.parseEther("1")});
  console.log('Fellback?', await zuse.getFellback());


  console.log('ETH balance of address1: ', await ethers.provider.getBalance(address1));
  console.log('Contract ETH balance: ', await ethers.provider.getBalance(contract_address));
  console.log('Deployer token balance: ', await zuse.balanceOf(sender));
  console.log('Balance of address 1: ', await zuse.balanceOf(address1));
  console.log('Balance of address 2: ', await zuse.balanceOf(address2));

  console.log(await zuse.owner());
  console.log(await zuse.totalSupply());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
