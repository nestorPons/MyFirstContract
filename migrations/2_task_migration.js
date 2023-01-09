const Tsk = artifacts.require("TaskContract");

module.exports = function (deployer) {
  deployer.deploy(Tsk);
};
