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

    /* add sample data */
   console.log("Setting up demo data. ");
   bitfinca.addLender("l41", "0x58cA931505706323b53ff14710A94Fc5b813d8e2");
   bitfinca.addLender("l42", "0xA56fB9E4CB6acb91016a4394d31AfE470B64AC6B");
   bitfinca.addLender("Ada", "0xb382BF163373D157f8Eba6b467392d7A2A4d83aD"); // fake lender

   bitfinca.addValidator("Valerie", "0xCcce104A50a7D9B7b33BDe32C10292FFC294dF57");

   bitfinca.addEntrepreneur("22", "coworking_space", "0xCcea46B8A1213A37f95e6b850d10a3ed15fF6c21", 2000, 440);
   bitfinca.addEntrepreneur("66", "agriculture", "0x6Fd8dc807a827d45D19558703C5ba003435b9Eb1", 2000, 1320);
   bitfinca.addEntrepreneur("44", "small_business", "0x687b5480B2BB9E24bbb15975e801A212869c19DB", 2000, 880);
   bitfinca.addEntrepreneur("16", "resturant", "0x0fA061a18D1A821cdfB1A1fAaB3425c17faeEa53", 2000, 320);
   bitfinca.addEntrepreneur("18", "education_for_all", "0xb5eD4b29faE5813f9Bd0FE211cb1109a669681f1", 2200, 1280);
   bitfinca.addEntrepreneur("54", "assessibility", "0xeAb807e0a3850a12b6e5850A6cAC8133Fe26ccE4", 2500, 505);
   bitfinca.addEntrepreneur("24", "facial_recognition", "0x8da0239Ad91eF329bb837f5b56Bf51CDBfE58039", 3200, 846);
   bitfinca.addEntrepreneur("11", "blogging", "0xD84D552B2123a28b86851d5EDd5223B9A61a2C14", 2400, 1130);
   bitfinca.addEntrepreneur("26", "record_label", "0x0D53BF7d7B3a98Ff7eaeEa5F4a739FC23fF010F6", 2300, 120);
   bitfinca.addEntrepreneur("49", "mining", "0x1f033e4CD617174eC0D346C670dA82a875Fb97e5", 1800, 250);
   bitfinca.addEntrepreneur("27", "artificial_intelligence", "0x0a76B9039772939f3f28D9C3bf76f5644dD6ffb7", 1750, 520);
   bitfinca.addEntrepreneur("40", "car_rental", "0x22cFE705Db74F85b4A1bF71cbC78BbaFf0642022", 1700, 407);

   console.log("Finished adding users");

   // lenders
   fincaToken.mint("0x58cA931505706323b53ff14710A94Fc5b813d8e2", 50);
   fincaToken.mint("0xA56fB9E4CB6acb91016a4394d31AfE470B64AC6B", 80);
   fincaToken.mint("0xb382BF163373D157f8Eba6b467392d7A2A4d83aD", 70);

   // validator
   fincaToken.mint("0xCcce104A50a7D9B7b33BDe32C10292FFC294dF57", 20);

   // entrepreneur
   fincaToken.mint("0xCcea46B8A1213A37f95e6b850d10a3ed15fF6c21", 20);
   fincaToken.mint("0x6Fd8dc807a827d45D19558703C5ba003435b9Eb1", 25);
   fincaToken.mint("0x687b5480B2BB9E24bbb15975e801A212869c19DB", 22);
   fincaToken.mint("0x0fA061a18D1A821cdfB1A1fAaB3425c17faeEa53", 80);
   fincaToken.mint("0xb5eD4b29faE5813f9Bd0FE211cb1109a669681f1", 38);
   fincaToken.mint("0xeAb807e0a3850a12b6e5850A6cAC8133Fe26ccE4", 150);
   fincaToken.mint("0x8da0239Ad91eF329bb837f5b56Bf51CDBfE58039", 10);
   fincaToken.mint("0xD84D552B2123a28b86851d5EDd5223B9A61a2C14", 13);
   fincaToken.mint("0x0D53BF7d7B3a98Ff7eaeEa5F4a739FC23fF010F6", 12);
   fincaToken.mint("0x1f033e4CD617174eC0D346C670dA82a875Fb97e5", 76);
   fincaToken.mint("0x0a76B9039772939f3f28D9C3bf76f5644dD6ffb7", 15);
   fincaToken.mint("0x22cFE705Db74F85b4A1bF71cbC78BbaFf0642022", 26);

};