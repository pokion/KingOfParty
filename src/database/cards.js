import sqlite from './sqlite.js';
import tagsAPI from  './tags.js';
const allCardsSQL = 'SELECT content, author, id, mode FROM cards';
const saveCardSQL = 'INSERT INTO cards(content, author, mode) VALUES(@content, @author, @mode)';
const addTagsToCardSQL = 'INSERT INTO tagsJunction(cardID, tagID) VALUES(@cardID, @tagID)';
const getCardSQL = 'SELECT content, author, mode FROM cards WHERE id = @cardId';
const updateCardSQL = 'UPDATE cards SET content = @content, author = @author, mode = @mode WHERE id = @id';
const deleteCardSQL = 'DELETE FROM cards WHERE id = @id';

class cards {
    constructor(sqliteInstance) {
        this.sqlite = new sqlite() || sqliteInstance;
        this.tags = new tagsAPI(this.sqlite);
    }

    getAll(){
        return this.sqlite.getAll(allCardsSQL);
    }

    saveCard({cards, tags}){
        let insertCard = this.sqlite.runQueryWithValues(saveCardSQL, cards);
        for(let tag of tags){
            tag.cardID = insertCard[0].lastInsertRowid
        }

        this.sqlite.runQueryWithValues(addTagsToCardSQL, tags);
    }

    getCard(cardId){
        let getCard = this.sqlite.getAll(getCardSQL, {cardId: cardId} );
        let getTags = this.tags.getTags(cardId);
        return {card: getCard, tag: getTags};
    }

    updateCard({card, tags}){
        console.log(card,tags,updateCardSQL)
        let updateCard = this.sqlite.runQueryWithValues(updateCardSQL, card);
        let deleteTags = this.tags.deleteTags(card[0].id);
        let insetTags;
        if(tags.length > 0){
            for(let tag of tags){
                tag.cardID = card[0].id
            }
            insetTags = this.sqlite.runQueryWithValues(addTagsToCardSQL, tags);
        }
        console.log(updateCard, deleteTags, insetTags)
    }

    deleteCard(cardId){
        let deleteTags = this.tags.deleteTags(cardId);
        let deleteCard = this.sqlite.runQueryWithValues(deleteCardSQL, [{id: cardId}]);
        console.log(deleteTags,deleteCard);
    }
}

export default cards;