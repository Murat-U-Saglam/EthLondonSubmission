<template>

  <Header />

  <div class="main">

    <h2>Battle game</h2>

    <div>

      <p>
        User 1 address: 
        <input v-model="user_1">
      </p>

      <p>
        User 2 address: 
        <input v-model="user_2">
      </p>
      
      <button @click="run_game">
        Run the game  
      </button>

    </div>

    <div v-if="contractAddress">
      <p>
        Contract deployed: {{ contractAddress }}
      </p>
    </div>


  </div>
</template>


<script>

// import { ethers } from "ethers";
// import { FhenixClient, EncryptionTypes } from 'fhenixjs';

// import hre from "hardhat";

import { BrowserProvider } from "ethers";
// const { fhenixjs, ethers } = hre;
// const { deploy } = hre.deployments;

// // Get the provider & define the clent
// const provider = new BrowserProvider(window.ethereum);
// fhenixClient = new FhenixClient({provider});


// import { ethers } from "ethers";
// import { FhenixClient, EncryptionTypes } from 'fhenixjs';
// import { BrowserProvider } from "ethers";

import rawContract from "./ABI.json";

import { ContractFactory } from 'ethers';

export default {
  data() {
    return {
      contractAddress: null,
      user_1: "",
      user_2: "",
    };
  },
  methods: {
    async run_game() {
      // if (
      //   this.user_1 === "" ||
      //   this.user_2 === ""
      // ) { 
      //   console.log("Check the parameter...")
      //   return ; 
      // }
      const provider = new BrowserProvider(window.ethereum);
      let signer = await provider.getSigner();

      const factory = new ContractFactory(rawContract.abi, rawContract.bytecode, signer);

      // If your contract requires constructor args, you can specify them here
        let contract = await factory.deploy(
          "0x2B8D536768163cBCd2cC5D91D4b03B913244A784", 
          "0x7a47A0B8Fb2F1e56Db819e186B1A38e95B3c7d3B"
        );

        console.log("Contract:");
        console.log(contract);

        await contract.waitForDeployment;

        this.contractAddress = contract.target;

    }
  }
};
</script>