import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const GOERLI_ALCHEMY_API_KEY = "c812QrF1x8PV1KmFgoIBsW02-8BAIpmM"
const MAINNET_ALCHEMY_API_KEY = "WtxNr6I2IfwJy_svd9cb02zOXi9uXTRT"

const GOERLI_PRIVATE_KEY = '470e60dd65d281ba541aab4c95aa2583eff7ee726cb98f986d31f50aa2cb0adb'
const MAINNET_PRIVATE_KEY = '470e60dd65d281ba541aab4c95aa2583eff7ee726cb98f986d31f50aa2cb0adb'

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
    },
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${GOERLI_ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY]
    },
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${MAINNET_ALCHEMY_API_KEY}`,
      accounts: [MAINNET_PRIVATE_KEY]
    }    
  }
};

export default config;
