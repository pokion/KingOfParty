<template>
    <div>
        GAME SCENE
        <p>{{ this.getNameOfPlayer() }}</p>
        <CardView v-bind:Card="this.currentCard"/>
        <button @click="complited">Complited</button>
        <button @click="decline">Decline</button>
    </div>
</template>
<script>
import CardView from '@/components/CardView.vue';

export default {
    props: ['Cards','Players','Tags'],
    components: {
        CardView
    },
    data() {
        return {
            cards: this.Cards,
            players: this.Players,
            tags: this.Tags,
            currentPlayer: 0,
            currentCard: {},
            cardsPlayed: [], 
            isEnd: false
        }
    },
    methods: {
        getNameOfPlayer(){
            let key = Array.from(this.players.keys())[this.currentPlayer];
            return this.players.get(key).name;
        },
        getCard(){
            let cardsArray = Array.from(this.cards.values())

            if(this.cardsPlayed === null){
                this.currentCard = this.randomCard(cardsArray, this.cardsPlayed);
            }else{
                if(cardsArray.length != this.cardsPlayed.length){
                    this.currentCard = this.randomCard(cardsArray, this.cardsPlayed);
                    this.cardsPlayed.push(this.currentCard.id)
                }else{
                    this.isEnd = true;
                }
            }
        },
        randomCard(cardsArray, cardPlayed){
            let currentCard = cardsArray[Math.floor(Math.random() * cardsArray.length)];
            if(cardPlayed.includes(currentCard.id)){
                return this.randomCard(cardsArray, cardPlayed);
            }

            return currentCard;
        },
        nextPlayer(){
            if(this.players.size == (this.currentPlayer+1)){
                this.currentPlayer = 0;
            }else{
                this.currentPlayer++;
            }
        },
        complited(){
            this.getCard();
            this.nextPlayer();
        },
        decline(){
            this.getCard();
            this.nextPlayer();
        }
    },
    beforeMount(){
        this.getCard();
    }
}
</script>
<style>
    
</style>