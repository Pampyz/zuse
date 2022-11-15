# ERC20-token using typescript & hardhat

To deploy you will need to get keys from metamast & alchemy.

Deploy:

Start by running:
npm install --save-dev hardhat
npm install --save-dev "hardhat@^2.12.2" "@nomicfoundation/hardhat-toolbox@^2.0.0"

Then edit hardhat.config.ts:
const GOERLI_ALCHEMY_API_KEY = "your alchemy API-key for the goerli testnet"
const MAINNET_ALCHEMY_API_KEY = "your alchemy API-key for the mainnet" 

const GOERLI_PRIVATE_KEY = "your private key for the goerli testnet"
const MAINNET_PRIVATE_KEY = "your private key for the ethereum mainnet"

then run
npx hardhat compile

followed by 
npx hardhat run scripts/deploy.ts --network goerli (for testnet)
npx hardhat run scripts/deploy.ts --network mainnet (for mainnet)

make sure that you have Ethereum - it takes around 0.15 GETH on the goerli testnet 
