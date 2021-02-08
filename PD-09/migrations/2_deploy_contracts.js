const { deployProxy } = require('@openzeppelin/truffle-upgrades');

var PropertyContract = artifacts.require("PropertyContract");

module.exports = async function(deployer) {
    const PropertyContractContract = await deployProxy(PropertyContract, [], { deployer });
    console.log(`Address of PropertyContractContract: ${PropertyContractContract.address}`)

};