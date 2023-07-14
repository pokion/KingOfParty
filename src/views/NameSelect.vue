<template>
    <div>
        <div>
            <AddButton :isShown="true" @tag="newPlayer"></AddButton>
        </div>
        <div class="players">
            <div v-for="player in players" :key="player" class="playerInit">
                <p>{{ player }}</p>
                <span class="circlePlayer">{{ player[0] }}</span>
            </div>
        </div>
        <div>
            <GameButton variant="primary" content="Next" @click="goToGameView"></GameButton>
        </div>
    </div>
</template>
<script>
import AddButton from '@/components/AddButton.vue';
import GameButton from '@/components/GameButton.vue';

export default {
    components:{
        AddButton,
        GameButton
    },
    data() {
        return {
            players: []
        }
    },
    methods: {
        newPlayer(name){
            this.players.push(name);
        },
        goToGameView(){
            this.$router.push('/game/' + JSON.stringify(this.players))
        }
    },
}
</script>
<style scoped>
    .players{
        display: flex;
        flex-direction: column;
        gap: 20px;
        color: var(--text);
    }
    .playerInit{
        display: flex;
        flex-direction: row;
        justify-content: center;
        text-align: center;
        align-items: center;
        gap: 10px;
    }
    .circlePlayer{
        height: 30px;
        width: 30px;
        border-radius: 200px;
        border: 2px solid var(--overlay);
        text-align: center;
        line-height: 30px;
    }
</style>