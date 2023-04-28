<template>
    <div>
        <ul>
            <li v-for="player in allPlayers" :key="player.id">
                {{ player[1].name }} 
                <span @click="$emit('delete', player)">|del|</span>
            </li>
        </ul>
    </div>
    <div>
        <input type="text" v-model="name" placeholder="write name"> 
        <button @click="sendName">Add</button>
    </div>
</template>
<script>
export default {
    props: ['objects'],
    data() {
        return {
            allPlayers: this.objects,
            name: ''
        }
    },
    methods: {
        sendName(){
            this.$emit('add', this.name);
            this.name = '';
        }
    },
}
</script>
<style scoped>
    
</style>