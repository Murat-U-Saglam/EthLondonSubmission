<template>

    <Header />

    <div class="main">

        <Boats 
            v-if="view === 'BOATS'" 
            @change-view="validateUserBoard" 
            :userState="userState"
        />
        <Battleship 
            v-else-if="view === 'BATTLE'" 
            :userState="userState" 
            @attack-requets="attackRequest"    
        />
        <EndGame v-else-if="view === 'END'" :winner="winner" />

    </div>
</template>

<script>
import { ethers } from "ethers";
import { FhenixClient, EncryptionTypes } from 'fhenixjs';
import { BrowserProvider } from "ethers";

import Header from '../components/Header.vue';

import Boats from './boats.vue';
import Battleship from './battleship.vue';
import EndGame from './end_game.vue';

import abi from '../../backend/contracts/battleship_abi.json';

export default {
    components: {
        Header,
        Boats,
        Battleship,
        EndGame
    },
    data() {
        return {
            contractAddress: "0x8f1183a777B8e955993B193137b6850f0807b99F",
            contract: null,
            fhenixClient: null,
            winner: null,
            view: "BOATS", // BATTLE // END // BOATS
            userState: Array.from({ length: 5 }, () => Array(5).fill(0)),
            opponentState: Array.from({ length: 5 }, () => Array(5).fill(0)),
        };
    },
    methods: {
        changeViewToBattle() {
            this.view = "BATTLE";
        },
        async validateUserBoard() {

            console.log("Validate the user dashboard.");

            const flattenedList = this.userState.flat()
            const flattenedString = flattenedList.join('');
            const intValue = parseInt(flattenedString, 2);
            const uint32Value = new Uint32Array([intValue])[0];

            const encryptedUserState = await this.fhenixClient.encrypt(uint32Value, EncryptionTypes.uint32);

            console.log(encryptedUserState.data);

            this.contract.placeShips(encryptedUserState.data).then(
                () => {
                    this.changeViewToBattle()
                }
            ).catch((err) => {
                console.log("Error on transaction");
                console.log(err);
            })
        },
        async attackRequest(x, y) {

            console.log("Attack on:", x, y)

            this.contract.attack(x, y)
                .then()
                .catch((err) => {
                console.log("Error on transaction");
                console.log(err);
            })
        }
    },
    async created() {

        // Get the provider & define the clent
        const provider = new BrowserProvider(window.ethereum);
        this.fhenixClient = new FhenixClient({provider});

        // Get the signer & get the contract from the address
        const signer = await provider.getSigner();
        this.contract = new ethers.Contract(this.contractAddress, abi, signer);
        
    }
};
</script>