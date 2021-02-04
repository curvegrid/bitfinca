const { Deployer } = require("truffle-multibaas-plugin");

const FincaToken = artifacts.require("FincaToken.sol");
const Bitfinca = artifacts.require("Bitfinca.sol");

module.exports = async function(_deployer, network) {
    const deployer = new Deployer(_deployer, network);
    await deployer.setup();

    // MultiBaas options for deployment
    const options = {
        fincaToken: {
            contractLabel: "finca_token",
            addressLabel: "finca_token",
        },
        bitfinca: {
            contractLabel: "bitfinca",
            addressLabel: "bitfinca",
        }
    };

    const [, fincaTokenAddress, fincaToken] = await deployer.deployWithOptions(options.fincaToken, FincaToken);
    const [, bitfincaAddress, bitfinca] = await deployer.deployWithOptions(options.bitfinca, Bitfinca, fincaTokenAddress.address);
};