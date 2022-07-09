const TwoDeepToken = artifacts.require("TwoDeepToken");
const TwoDeepTokenSale = artifacts.require("TwoDeepTokenSale");

module.exports = function (deployer) {
  deployer.deploy(TwoDeepToken, 1000000).then(function () {
    //token price is 0.001 Either
    var tokenPrice = 1000000000000000; //in wei
    return deployer.deploy(TwoDeepTokenSale, TwoDeepToken.address, tokenPrice);
  });
};
