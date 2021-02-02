  
var Migrations = artifacts.require("Migrations");
var PropertyContract = artifacts.require("PropertyContract");

module.exports = async function(deployer) {
    await deployer.deploy(Migrations);
    await deployer.deploy(PropertyContract);

    PropertyContract = await PropertyContract.deployed();

    console.log(`PropertyContract deployed at: ${PropertyContract.address}`);
}