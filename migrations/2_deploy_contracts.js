var NFTImplementations = artifacts.require("NFTImplementations");

module.exports = function(deployer) {
  deployer.deploy(NFTImplementations);
};