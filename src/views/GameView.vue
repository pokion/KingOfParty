<template>
    <div>
        <div class="players">
            <div v-for="player in currentPlayers" :key="player.name">
                <span v-if="player.selected" class="circle">
                    {{ player.name }}
                </span>
                <span v-else class="circle">
                    {{ player.name[0] }}
                </span>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            players: JSON.parse(this.$route.params.players),
            currentPlayers: []
        }
    },
    mounted() {
        console.log(this.players)
        for(let player of this.players){
            this.currentPlayers.push({name: player, selected: false})
        }
        this.currentPlayers[0].selected = true;
        console.log(this.currentPlayers)
    },
}
</script>
<style scoped>
    .players{
        color: var(--text);
        display: flex;
        flex-direction: row;
        gap: 20px;
        justify-content: center;
    }
    .circle{
        min-width: 30px;
        min-height: 30px;
        border-radius: 100px;
        line-height: 30px;
        border: 2px solid var(--overlay);
        display: block;
        text-align: center;
        padding: 10px;
    }
</style>