import Helper from './Helpers.js'

export default {
    mapOfCards: null,
    mapOfTags: null,

    cards: [
        {id: 1, body: 'Nigdy przenigdy nie, nasikałem/am w publicznym basenie', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 2, body: 'Nigdy przenigdy nie, byłam/byłem w nocnym klubie', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 3, body: 'Nigdy przenigdy nie, płakałam/płakałem w szkole', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 4, body: 'Nigdy przenigdy nie, jadłam/jadłem kawioru', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 5, body: 'Nigdy przenigdy nie, śpiewałam/śpiewałem publicznie', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 6, body: 'Nigdy przenigdy nie, biłam/biłem się', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 7, body: 'Nigdy przenigdy nie, zerwałam/zerwałem z kimś', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 8, body: 'Nigdy przenigdy nie, zasnęłam/zasnułem podczas sexu', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 9, body: 'Nigdy przenigdy nie, całowałam/całowałem się publicznie', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 10, body: 'Nigdy przenigdy nie, całowałam/całowałem się z dwiema różnymi osobami w 1 dzień', author: 'Czarek', tags: [4], gameMode: 4},
        {id: 11, body: 'Nigdy przenigdy nie, masturbowałam/masturbowałem się w miejscu publicznym', author: 'Czarek', tags: [4], gameMode: 4},
    ],

    tags: [
        {id: 1, tag: 'miłość'},
        {id: 2, tag: 'nazwy'},
        {id: 3, tag: 'praca'},
        {id: 4, tag: 'żenujące'},
    ],

    gameModes: [
        {id: 1, mode: 'question'},
        {id: 2, mode: 'challenge'},
        {id: 3, mode: 'time'},
        {id: 4, mode: 'neverEver'},
    ],

    getMapOfCards(){
        if(!this.mapOfCards){
            this.mapOfCards = Helper.convertArrayToMap({
                key: 'id',
                array: this.cards
            });
        }

        return this.mapOfCards;
    },

    getCardById(id){
        if(!this.mapOfCards){
            this.mapOfCards = Helper.convertArrayToMap({
                key: 'id',
                array: this.cards
            });
        }
        return this.mapOfCards.get(id);
    },

    getMapOfTags(){
        if(!this.mapOfTags){
            this.mapOfTags = Helper.convertArrayToMap({
                key: 'id',
                array: this.tags
            });
        }

        return this.mapOfTags;
    }
}