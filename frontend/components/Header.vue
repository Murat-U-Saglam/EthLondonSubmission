<template>
    <div class="main">

        <button class="btn btn-success" @click="fnxConnect" :disabled="isItFhenixNetwork">{{ (isItFhenixNetwork) ?
            'Connected to Fhenix' : 'Connect to Fhenix Network' }}</button>
        <div class="address"><b>Address:</b> {{ isItFhenixNetwork ? address : '---' }}</div>
        <div><b>Balance:</b> {{ isItFhenixNetwork ? balance : '---' }}</div>
    </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';

const { fnxConnect, isItFhenixNetwork, balance, address } = useChain();

onMounted(async () => {
    if (localStorage.getItem("isConnected")) {
        if (typeof window.ethereum !== 'undefined') {
            try {
                await fnxConnect();
            } catch (err) {
                console.error(err);
            }
        }
    }
});
</script>
