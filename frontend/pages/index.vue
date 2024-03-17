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



import { BrowserProvider } from "ethers";


import battleshipMeta from '../../backend/artifacts/contracts/battleship.sol/Battleship.json';
import { ContractFactory } from 'ethers';

export default {
  data() {
    return {
      contractAddress: null,
      user_1: "0x2B8D536768163cBCd2cC5D91D4b03B913244A784",
      user_2: "0xb695f60c1B049696dF4C19faa348C22db679Ff3c",
    };
  },
  methods: {
    async run_game() {
      if (
        this.user_1 === "" ||
        this.user_2 === ""
      ) { 
        console.log("Check the parameter...")
        return ; 
      }

      console.log("Parameters: ", this.user_1, this.user_2)

      const provider = new BrowserProvider(window.ethereum);
      let signer = await provider.getSigner();

      const factory = new ContractFactory(battleshipMeta.abi, battleshipMeta.bytecode, signer);

      // If your contract requires constructor args, you can specify them here
        let contract = await factory.deploy(
          this.user_1, // "0x2B8D536768163cBCd2cC5D91D4b03B913244A784", 
          this.user_2  // "0xb695f60c1B049696dF4C19faa348C22db679Ff3c"
        );

        console.log("Contract:");
        console.log(contract);

        await contract.waitForDeployment;

        this.contractAddress = contract.target;

        this.$router.push('/game/' + this.contractAddress);

    }
  }
};
</script>