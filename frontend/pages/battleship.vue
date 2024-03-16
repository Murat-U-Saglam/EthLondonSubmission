<template>
    <div class="main">
    
        <section class="vision">
            <div class="board">
                <h2>User Board</h2>
                <div v-for="y in height" :key="y" class="row">
                    <div 
                        v-for="x in width" 
                        :key="x" 
                        class="cell" 
                        :class="{ 'cell-activate': hasShip(userState, x-1, y-1) }"
                        >
                    </div>
                </div>
            </div>
            
            <div class="board">
                <h2>Opponent Board</h2>
                <div v-for="y in height" :key="y" class="row">
                    <div 
                        v-for="x in width" 
                        :key="x" 
                        class="cell" 
                        :class="{ 'cell-attacked': hasShip(opponentState, x-1, y-1) }"
                        @click="attack(x-1, y-1)"
                        >
                    </div>
                </div>
            </div>


        </section>
    </div>

    
  
  
  </template>
  
  <script>

  const { address } = useChain();
  const { encrypt, encryptedText } = useFHE();


  // import { ref } from 'vue';
  // const { navigateToPage } = useCommon();
  
  // const txtNumberToEncrypt = ref(null);
  // const { address } = useChain();
  // const { encrypt, encryptedText } = useFHE();
  
  export default {
    props: ["userState"],
    data() {
      return {
        width: 10, 
        height: 10,
        
        opponentState: Array.from({ length: 11 }, () => Array(11).fill(0)),

        selectedX: null,
        selectedY: null
      };
    },
    methods: {
      hasShip(state, x, y) {
        return state[x][y];
      },
      async attack(x, y) {

        // Already attacked
        if (this.opponentState[x][y]) { return; }

        // Encrypt position
        let x_encrypted = await encrypt(x);
        let y_encrypted = await encrypt(y);

        console.log(x_encrypted)
        console.log(y_encrypted)

        // TODO :: Send transaction 


        // Update the front state
        this.opponentState[x][y] = 1;
      },
      isGameFinished() {
        // TODO :: Return if the game is finished or not
      },
      userTurn() {
        // TODO :: Return if it is the user turn or not
      },
      cellClicked(x, y) {
        // Handle cell click event
        console.log(`Cell (${x}, ${y}) clicked`);

        this.selectedX = x;
        this.selectedY = y;
      }
    }
  };
  </script>
  
  <style scoped>


  .main {
    display: flex;
  }

  .main input {
    width: 300px;
  }

  .vision {
    display: flex;
    justify-content: space-between;
  }
 
    .board {
        padding-left: 50px;
        padding-right: 50px;
    }

  .cell {
        width: 40px;
        height: 40px;
        border: 1px solid black;
        background-color: gray;
        cursor: pointer;
        transition: all 0.3s ease;
        margin: 2px; 
    }

    .cell:hover {
        background-color: lightgray;
        box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.5);
    }

    .cell-activate {
    background-color: aqua;
  }
  .cell-attacked {
    background-color: red;
  }

  .encrypt-line {
    display: flex;
    gap: 10px
  }
  
  .result {
    white-space: normal; 
    word-break: break-all;
    
    padding: 10px;
    width: 400px;
    max-height: 200px;
    overflow-y: scroll;
  
    font-family: 'Courier New', Courier, monospace;
    font-size: 12px;
    border-radius: 10px;
    background-color: var(--custom-select); 
    color: black;
  }
  </style>