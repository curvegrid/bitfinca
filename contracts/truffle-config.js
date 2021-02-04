/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * trufflesuite.com/docs/advanced/configuration
 */

// pull in environment variables, potentially from a .env file
require('dotenv').config()

const privateKey = process.env.BITFINCA_DEPLOYER_PRIVATE_KEY;
const networkID = process.env.BITFINCA_NETWORK_ID;

// For using MultiBaas proxy
const { Provider } = require("truffle-multibaas-plugin");
const MultiBaasDeploymentID = process.env.BITFINCA_MULTIBAAS_DEPLOYMENT_ID;

module.exports = {
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */

  networks: {
    // This can be any name, not just "development". However, this is the default network name for Truffle.
    development: {
      // See https://github.com/trufflesuite/truffle/tree/develop/packages/hdwallet-provider
      // for options other than the Deployment ID.
      provider: new Provider(privateKey, MultiBaasDeploymentID),

      network_id: networkID,

      // these are both critical and otherwise set to weird defaults
      gas: 8000000,   // Gas sent with each transaction (default: ~6700000)
      gasPrice: 1,    // 1 wei (default: 100 gwei)
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      settings: {
        // this is important to help keep contracts under the 24 KB limit on smart contract size
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  },

  // MultiBaas deployment
  multibaasDeployer: {
    apiKeySource: "env", // specify "file" if you have a mb_plugin_api_key instead of an environment variable.
    deploymentID: MultiBaasDeploymentID,
    // Choose the list of networks we can allow updating address for a label.
    // A definitive true/false also works, it will allow/block the action for all networks.
    allowUpdateAddress: ["development"],
  },
};
