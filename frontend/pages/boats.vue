<template>
    <div class="main">
      
      <div class="board">
        <div v-for="y in height" :key="y" class="row">
          <div 
            v-for="x in width" 
            :key="x" 
            class="cell" 
            :class="{ 'cell-activate': isShip(x-1, y-1) }" 
            @click="cellClicked(x-1, y-1)"
            >
          </div>
        </div>
      </div>
    </div>

    <br /><br /><br />

    <div>
      <!-- The 5 ships are:  Carrier (occupies 5 spaces), Battleship (4), Cruiser (3), Submarine (3), and Destroyer (2).   -->
      <div class="boat-list">
          <div v-for="(ship, index) in ships" :key="ship" class="boat-item" :style="{
             backgroundColor: 'red',
             width: ship.direction ? '30px' : (ship.size * 30) + 'px',
             height: ship.direction ? (ship.size * 30) + 'px' : '30px',
             boxShadow: ship.activate ? '0 0 5px 2px rgba(0, 0, 0, 0.5)' : 'none'
          }" @click="activate(index)" ></div>
      </div>

    </div>

    <div v-if="ships.length == 0" >
      <button @click="validateBoard">Validate</button>
    </div>

  
  </template>
  
  <script>
  // import { ref } from 'vue';
  // const { navigateToPage } = useCommon();
  
  // const txtNumberToEncrypt = ref(null);
  // const { address } = useChain();
  // const { encrypt, encryptedText } = useFHE();
  
  export default {
    props: ['userState'],
    data() {
      return {
        width: 10, 
        height: 10,
        // userState: Array.from({ length: 11 }, () => Array(11).fill(0)),
        placedBoat: [],
        ships: [
          { x: -1, y: -1, direction: false, activate: false, size: 2 },
          { x: -1, y: -1, direction: true, activate: false, size: 3 },
          { x: -1, y: -1, direction: false, activate: false, size: 3 },
          { x: -1, y: -1, direction: false, activate: false, size: 4 },
          { x: -1, y: -1, direction: false, activate: false, size: 5 }
        ],
        selectedX: null,
        selectedY: null,
        selectedShipIndex: null,
      };
    },
    methods: {

      validateBoard() {
        console.log("TODO :: send transaction");

        // If all OK - change the view
        this.$emit('change-view');
      },
      desactivateAllShips() {
        for (let i = 0; i < this.ships.length; i++) {
          this.ships[i].activate = false;
        }
      },
      activate(index) {
        if (!this.ships[index].activate) {
          this.desactivateAllShips();
          this.ships[index].activate = !this.ships[index].activate;
          this.selectedShipIndex = index;
        } else {
          this.ships[index].direction = !this.ships[index].direction;
        }
      },
      isShip(x, y) {
        return this.userState[x][y] == 1;
      },
      isValidPlace(ship, x, y) {
        for (let i = 0; i < ship.size; i++) {
          if (!ship.direction) {
            if (x+i >= 10 || this.userState[x+i][y]) {
              return false;
            }
          } else {
            if (y+i >= 10 || this.userState[x][y+i]) {
              return false;
            }
          }
        }
        return true;
      },
      cellClicked(x, y) {

        if (this.selectedShipIndex === null) { return; }

        let ship = this.ships[this.selectedShipIndex];

        // Check if it is possible to store it
        if (!this.isValidPlace(ship, x, y)) { return; }

        ship.x = x;
        ship.y = y;

        for (let w = 0; w < ship.size; w++) {
          this.userState[
            !ship.direction ? x + w : x
          ][
            ship.direction ? y + w : y
          ] = 1;
        }
        
        this.selectedX = x;
        this.selectedY = y;

        this.ships.splice(this.selectedShipIndex, 1);

        this.selectedShipIndex = null;
        this.placedBoat.push(ship)
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

  .cell-activate {
    background-color: aqua;
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

  .boat-list {
    display: flex;
  }

  .boat-item {
    margin-right: 50px;
  }
  </style>