<template>
    <div class="main">
      
      <div class="board">
        <div v-for="y in height" :key="y" class="row">
          <div v-for="x in width" :key="x" class="cell" :class="{ 'ship': isShip(x, y) }" @click="cellClicked(x, y)">
          </div>
        </div>
      </div>
    </div>
  
  
  </template>
  
  <script>
  // import { ref } from 'vue';
  // const { navigateToPage } = useCommon();
  
  // const txtNumberToEncrypt = ref(null);
  // const { address } = useChain();
  // const { encrypt, encryptedText } = useFHE();
  
  export default {
    data() {
      return {
        width: 10, 
        height: 10,
        ships: [
          { x: 3, y: 4 }, 
          { x: 7, y: 2 }  
        ],
        selectedX: null,
        selectedY: null
      };
    },
    methods: {
      isShip(x, y) {
        return this.ships.some(ship => ship.x === x && ship.y === y);
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
  .main input {
    width: 300px;
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