<template>
    <div class="main">
        <div class="grow">
            <SearchBar ></SearchBar>
        </div>

        <div class="cardCounter grow">
            Cards • {{ cardsCount }}
        </div>

        <div class="container grow" v-dragscroll.x>
            <div class="scrollable">
                <GameCard  v-for="card in cards" :key="card.id" 
                :name="card.author"
                :content="card.content"
                :mode="card.mode"
                :author="card.author"
                :returnValue="card.id"
                side="1" 
                @clicked="rederictToUpdate"
                ></GameCard>
            </div>
        </div>

        <div class="addCard grow">
            <div>
                <router-link to="/addCards"><GameButton variant="primary" content="Add Card"></GameButton></router-link>
            </div>
            
        </div>

    </div>
</template>
<script>
import SearchBar from '@/components/SearchBar.vue';
import GameCard from '@/components/GameCard.vue';
import GameButton from '@/components/GameButton.vue';
//import SelectionChip from '@/components/SelectionChip.vue';

export default {
    components: {
        SearchBar,
        GameButton,
        GameCard,
       // SelectionChip
    },
    data() {
        return {
            cards: JSON.parse(localStorage.cards),
            modes: new Map(JSON.parse(localStorage.modes).map(mode => [mode.id, mode])),
            cardsCount: '',
        }
    },
    mounted() {
        console.log(this.modes)
        this.cardsCount = this.cards.length
        for(let card of this.cards){
            console.log(this.modes.get(card.mode), card.mode)
            card.mode = this.modes.get(card.mode).name
        }
    },
    methods: {
        rederictToUpdate(id){
            this.$router.push('/updateCard/' + id)
        }
    },
}
</script>
<style scoped>
    .scrollable{
        display: flex;
        flex-direction: row;
        gap: 40px;
        flex-wrap: nowrap;
    }
    .container{
        overflow: hidden;
    }
    .cardCounter{
        color: var(--text)
    }
    .main{
        height: 100%;
        display: flex;
        flex-direction: column;
        align-content: stretch;
    }
    .addCard{
        display: flex;
        justify-content: center;
    }
    .grow{
        flex-grow: 1;
    }
</style>