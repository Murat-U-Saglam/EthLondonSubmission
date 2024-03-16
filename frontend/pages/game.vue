<template>

    <Header />

    <div class="main">

        <Boats v-if="view === 'BOATS'" @change-view="changeViewToBattle" :userState="userState" />
        <Battleship v-else-if="view === 'BATTLE'" :userState="userState" />
        <EndGame v-else-if="view === 'END'" :winner="winner" />

    </div>
</template>

<script>

import Header from '../components/Header.vue';

import Boats from './boats.vue';
import Battleship from './battleship.vue';
import EndGame from './end_game.vue';

export default {
    components: {
        Header,
        Boats,
        Battleship,
        EndGame
    },
    data() {
        return {
            winner: null,
            view: "BOATS", // BATTLE // END // BOATS
            userState: Array.from({ length: 4 }, () => Array(4).fill(0)),
            opponentState: Array.from({ length: 4 }, () => Array(4).fill(0)),
        };
    },
    methods: {
        changeViewToBattle() {
            this.view = "BATTLE";
        }
    }
};
</script>