import { ethers } from "hardhat";


async function main() {
  const Zuse = await ethers.getContractFactory('ZUSE')
  const zuse = await Zuse.deploy()

  const supply = await zuse.totalSupply()
  const balance = await zuse.balanceOf(snek.address)
  
  await zuse.burn(1000)

  const sender = await zuse.getSender()
  const deployerBalance = await zuse.balanceOf(sender)
  /*snek.balanceOf() 
  function transfer(address to, uint256 value) public virtual returns (bool);
  */

  console.log(`Contract deployed to address: ${zuse.address}`);
  console.log(`Total supply: ${supply}`);
  console.log(`Contract balance: ${balance}`);
  console.log(`Sender: ${sender}`);
  console.log(`Deployer balance: ${deployerBalance}`);
  
  /*const simpleStorage = await ethers.getContractFactory("SimpleStorage");
  const ss = await simpleStorage.deploy()

  const res = await ss.add(2, 3)
  console.log(`Contract deployed to address: ${ss.address}`);
  */
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
