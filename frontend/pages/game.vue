<template>
    <div class="main">

        <Boats v-if="view === 'BOATS'" @change-view="changeViewToBattle" :userState="userState" />
        <Battleship v-else-if="view === 'BATTLE'" :userState="userState" />

    </div>
</template>

<script>

import Boats from './boats.vue';
import Battleship from './battleship.vue';

export default {
    components: {
        Boats,
        Battleship
    },
    data() {
        return {
            view: "BOATS",
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