<template>

    <div class="main">

        <h1 v-if="winner">You win !</h1>
        <h1 v-else-if="winner === false">You lose ! Try again ! </h1>

        <h2>Thanks for playing ! </h2>
        
    </div>
</template>

<script>

import Header from '../components/Header.vue';

export default {
    props: ["winner"],
    components: {
        Header,
    },
    data() {
        return {};
    },
    methods: {}
};
</script>