<template>

    <Header />

    <div class="main">

        <Boats v-if="view === 'BOATS'" @change-view="changeViewToBattle" :userState="userState" />
        <Battleship v-else-if="view === 'BATTLE'" :userState="userState" />

    </div>
</template>

<script>

import Header from '../components/Header.vue';

import Boats from './boats.vue';
import Battleship from './battleship.vue';

export default {
    components: {
        Header,
        Boats,
        Battleship
    },
    data() {
        return {
            view: "BATTLE", // BATTLE
            userState: Array.from({ length: 11 }, () => Array(11).fill(0)),
            opponentState: Array.from({ length: 11 }, () => Array(11).fill(0)),
        };
    },
    methods: {
        changeViewToBattle() {
            this.view = "BATTLE";
        }
    }
};
</script>