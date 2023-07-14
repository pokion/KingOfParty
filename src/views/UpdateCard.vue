<template>
    <div class="container">
        <div>
            <div class="tagsTitle">
                <p>Tags</p>
                <AddButton @tag="addTag"></AddButton>
            </div>
            <SelectionChip :items="tags" oneLine="true" @clicked="tagChipClicked"></SelectionChip>
        </div>
        <div>
            <p>Game Mode</p>
            <SelectionChip :items="modes" @clicked="modeChipClicked" oneLine="true"></SelectionChip>
        </div>
        <div class="inputs">
            <InputGame label="Content" @value="getValue" :value="content"></InputGame>
            <InputGame label="Author" @value="getAuthor" :value="author"></InputGame>
        </div>
        <div class="card">
            <div>
                <GameCard :content="content" :author="author" side="back" :mode="cardMode.name"></GameCard>
            </div>
        </div>
        <div class="button">
            <GameButton content="Add" variant="primary" @click="updateCard"></GameButton>
            <GameButton content="Delete" variant="secondary" @click="removeCard"></GameButton>
        </div>
    </div>
</template>
<script>
import SelectionChip from '@/components/SelectionChip.vue';
import InputGame from '@/components/InputGame.vue';
import GameCard from '@/components/GameCard.vue';
import GameButton from '@/components/GameButton.vue';
import AddButton from '@/components/AddButton.vue';

import cardsApi from '@/database/cards.js';
import tagsApi from '@/database/tags';

export default {
    components: {
        SelectionChip, 
        InputGame,
        GameCard,
        GameButton,
        AddButton
    },
    data() {
        return {
            content: '',
            author: '',
            modes: JSON.parse(localStorage.modes),
            tags: JSON.parse(localStorage.tags),
            cardMode: '',
            CardsApi: new cardsApi(),
            TagsApi: new tagsApi(),
            currentCard: null,
            currentTags: null
        }
    },
    mounted(){
        let card = this.CardsApi.getCard(this.$route.params.id)
        this.currentCard = card.card[0];
        this.currentTags = card.tag.map(tag => tag.tagID);

        for(let tag of this.tags){
            if(this.currentTags.includes(tag.id)) tag.selected = true;
        }
        for(let mode of this.modes){
            if(this.currentCard.mode == mode.id){
                mode.selected = true;
                break
            }
        }
        this.content = this.currentCard.content;
        this.author = this.currentCard.author;
    },
    watch: {
        modes: {
            handler(oldValue, newValues){
                for(let value of newValues) if(value.selected ){
                    this.cardMode = value;
                    break;
                }
            },
            deep: true
        }
    },
    methods: {
        getValue(value){
            this.content = value;
        },
        getAuthor(value){
            this.author = value;
        },
        modeChipClicked(id){
            for(let mode of this.modes){
                if(mode.id === id) mode.selected = true;
                else mode.selected = false;
            }
        },
        tagChipClicked(id){
            for(let tag of this.tags){
                if(tag.id === id) tag.selected = (tag.selected == undefined || tag.selected == false) ? true : false;
            }
        },
        updateCard(){
            let tags = this.tags.filter(tag => tag.selected === true);
            for(let index = 0; index<tags.length; index++){
                tags[index] = {tagID: tags[index].id}
            }
            this.CardsApi.updateCard({
                card: [{content: this.content, author: this.author, mode: this.cardMode.id, id: Number(this.$route.params.id)}],
                tags
            })
            localStorage.cards = JSON.stringify(this.CardsApi.getAll());
            this.$router.back();
        },
        addTag(newTag){
            this.TagsApi.saveTags([{name: newTag}]);
            this.tags = this.TagsApi.getAll();
            localStorage.tags = JSON.stringify(this.tags);
        },
        removeCard(){
            this.CardsApi.deleteCard(this.$route.params.id);
            console.log(JSON.stringify(JSON.parse(localStorage.cards).reduce(card => card.id == this.$route.params.id)))
            localStorage.cards = JSON.stringify(this.CardsApi.getAll());
            this.$router.back();
        }
    }
}
</script>
<style scoped>
    p{
        color: var(--text);
        margin-top: 0px;
    }
    .container{
        overflow: hidden;
        display: flex;
        flex-direction: column;
        max-height: 100%;
        gap: 20px;
        justify-content: center;
        align-content: stretch;
    }
    .inputs{
        display: flex;
        flex-direction: row;
        gap: 20px;
    }
    .inputs > div{
        width: 60%;
    }
    .card{
        display: flex;
        justify-content: center;
    }
    .card > div{
        max-width: 50%;
    }
    .button{
        display: flex;
        justify-content: center;
    }
    .tagsTitle{
        display: flex;
        flex-direction: row;
        gap: 20px;
    }
</style>