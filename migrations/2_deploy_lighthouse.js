var Lighthouse = artifacts.require("Lighthouse");
var GoldShop = artifacts.require("GoldShop");

module.exports = function(deployer) {

// First deploy the lighthouse, then use the lighthouse's address to deploy the goldshop. This allows
// goldshop to know which lighthouse to obtain data from.
  deployer.deploy(Lighthouse).then(function() {
    return deployer.deploy(GoldShop, Lighthouse.address);
  });

};
