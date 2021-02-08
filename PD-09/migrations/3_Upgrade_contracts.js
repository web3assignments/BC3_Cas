const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');
var PropertyContract = artifacts.require("PropertyContract");
var PropertyContractV2 = artifacts.require("PropertyContractV2");

module.exports = async function(deployer) {    
    const PropertyContractContract=await PropertyContract.deployed()
    const PropertyContractV2Contract=await upgradeProxy(PropertyContractContract.address, PropertyContractV2,{ deployer });
    console.log(`Address of PropertyContract: ${PropertyContractContract.address}`)
    console.log(`Address of PropertyContractV2: ${PropertyContractV2Contract.address}`)
   
}