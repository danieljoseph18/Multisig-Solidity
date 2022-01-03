const MultiSig = artifacts.require("MultiSig");

module.exports = function (deployer) {
  deployer.deploy(MultiSig, ['0xe680B963e4E5f6d2403Fb73a92dE4eeF55aebbF0', '0x2Fc51083161093B24752665042624a9b4147fbA9', '0xB23a1bCF1B6DE84213075bEBD63934Cc661168e1'], 2);
};
