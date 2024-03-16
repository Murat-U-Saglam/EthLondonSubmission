<template>

  <Header />

  <div class="main">

    <h2>Battle game</h2>

    <div>

      <p>
        Contract address: 
        <input v-model="contractAddress">
      </p>

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


  </div>
</template>


<script>

export default {
  data() {
    return {
      contractAddress: "",
      user_1: "",
      user_2: "",
    };
  },
  methods: {
    run_game() {
      if (
        this.contractAddress === "" ||
        this.user_1 === "" ||
        this.user_2 === ""
      ) { 
        console.log("Check the parameter...")
        return ; 
      }

      // TODO :: Run the game

    }
  }
};
</script>