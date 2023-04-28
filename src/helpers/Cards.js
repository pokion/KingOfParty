import {convertArrayToMap} from './Helpers.js'

export default {
    mapOfCards: null,
    mapOfTags: null,

    cards: [
        {id: 1, body: 'cos tam tam cos', author: 'Czezary', tags: [1,2]},
        {id: 2, body: 'cos tam tamasd cos', author: 'Czezary1', tags: [1,2]},
        {id: 3, body: 'casd', author: 'Czezary2', tags: [3,2]},
        {id: 4, body: 'coasds', author: 'Czezary3', tags: [3]},
        {id: 5, body: 'cosssss cos', author: 'Czezary4', tags: [1,2,3]}
    ],

    tags: [
        {id: 1, tag: 'pytanie'},
        {id: 2, tag: 'wyzwanie'},
        {id: 3, tag: 'coś innego ?'},
    ],



    getMapOfCards(){
        if(!this.mapOfCards){
            this.mapOfCards = convertArrayToMap({
                key: 'id',
                array: this.cards
            });
        }
        
        return this.mapOfCards;
    },

    getCardById(id){
        if(!this.mapOfCards){
            this.mapOfCards = convertArrayToMap({
                key: 'id',
                array: this.cards
            });
        }
        return this.mapOfCards.get(id);
    },

    getMapOfTags(){
        if(!this.mapOfTags){
            this.mapOfTags = convertArrayToMap({
                key: 'id',
                array: this.tags
            });
        }

        return this.mapOfTags;
    }
}