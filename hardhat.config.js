require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "hardhat",
  gasReporter: {
    enabled: true,
  },
  networks: {
    hardhat: {
      // url: '127.0.0.1',
      accounts: [
        {
          privateKey: process.env.PRIVATE_KEY,
          balance: "1000000000000000000000",
        },
      ],
    },
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.PRIVATE_KEY],
    },
    bitgertTestnet: {
      url: `https://testnet-rpc.brisescan.com`,
      accounts: {
        mnemonic:
          "coyote stuff tired ancient flat practice state urban trade tonight sentence cry",
      },
    },

    goerli: {
      url: "https://rpc.ankr.com/eth_goerli",
      accounts: [process.env.PRIVATE_KEY],
    },

    bsctestnet: {
      url: "https://rpc.ankr.com/bsc_testnet_chapel",
      accounts: [process.env.PRIVATE_KEY],
    },

    shardeum: {
      url: "https://liberty20.shardeum.org/",
      accounts: [process.env.PRIVATE_KEY]
    },

    //polygon, bsc, eth
    polygon: {
      url: "https://polygon-rpc.com",
      accounts: [process.env.PRIVATE_KEY],
    },
    bsc: {
      url: "https://bsc-dataseed1.binance.org",
      accounts: [process.env.PRIVATE_KEY],
    },
    eth: {
      url: "https://rpc.ankr.com/eth",
      accounts: [process.env.PRIVATE_KEY],
    },
    bitgert: {
      url: "https://chainrpc.com",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
