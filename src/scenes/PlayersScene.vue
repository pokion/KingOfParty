<template>
    <div> 
        <PlayersAdding :objects="this.players" @delete="deletePlayer" @add="addPlayer"/>
    </div>
    <button @click="showGame">NEXT</button>
</template>
<script>
import PlayersAdding from '../components/PlayersAdding.vue' 
import { v4 as uuidv4 } from 'uuid';
  
export default {
    components: {
        PlayersAdding
    },
    data() {
        return {
            players: new Map()
        }
    },
    methods: {
        deletePlayer(player){
            this.players.delete(player[0])
        },
        addPlayer(name){
            let id = uuidv4();
            this.players.set(id, {name, id})
        },
        showGame(){
            this.$emit('players', this.players)
            this.$emit('route', 'game')
        }
    },
}
</script>
<style >
    
</style>