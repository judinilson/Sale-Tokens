const TwoDeepToken = artifacts.require("TwoDeepToken");

module.exports = function (deployer) {
  deployer.deploy(TwoDeepToken, 1000000);
};
