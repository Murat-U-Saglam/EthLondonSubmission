import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import chalk from "chalk";

const hre = require("hardhat");

const func: DeployFunction = async function () {
  const { fhenixjs, ethers } = hre;
  const { deploy } = hre.deployments;
  const [signer] = await ethers.getSigners();

  if ((await ethers.provider.getBalance(signer.address)).toString() === "0") {
    if (hre.network.name === "localfhenix") {
      await fhenixjs.getFunds(signer.address);
    } else {
        console.log(
            chalk.red("Please fund your account with testnet FHE from https://faucet.fhenix.zone"));
        return;
    }
  }

  const counter = await deploy("Battleship", {
    from: signer.address,
    args: ["0x2B8D536768163cBCd2cC5D91D4b03B913244A784", "0x7a47A0B8Fb2F1e56Db819e186B1A38e95B3c7d3B"],
    log: true,
    skipIfAlreadyDeployed: false,

  });

  console.log(`Counter contract: `, counter.address);
};

export default func;
func.id = "deploy_counter";
func.tags = ["Counter"];
