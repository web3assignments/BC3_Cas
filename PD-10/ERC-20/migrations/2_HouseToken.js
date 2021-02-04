const Token_erc20 = artifacts.require("HouseToken");

module.exports = function(deployer) {
  deployer.deploy(Token_erc20);
};