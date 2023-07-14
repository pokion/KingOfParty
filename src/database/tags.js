import sqlite from './sqlite.js';
const allTagsSQL = 'SELECT name, code, id FROM tags';
const saveTagsSQL = 'INSERT INTO tags(name) VALUES(@name)';
const getTagsSQL = 'SELECT tagID FROM tagsJunction WHERE cardID = @cardId';
const deleteTagsSQL = 'DELETE FROM tagsJunction WHERE cardID = @cardId';

class tags {
    constructor(sqliteInstance) {
        this.sqlite = new sqlite() || sqliteInstance;
    }

    getAll(){
        return this.sqlite.getAll(allTagsSQL);
    }

    saveTags(tags){
        let insertTags = this.sqlite.runQueryWithValues(saveTagsSQL, tags);
        return insertTags;
    }

    getTags(cardId){
        let tags = this.sqlite.getAll(getTagsSQL, {cardId: Number(cardId)})
        return tags;
    }

    deleteTags(cardId){
        let deletedTags = this.sqlite.runQueryWithValues(deleteTagsSQL, [{cardId}]);
        return deletedTags;
    }
}

export default tags;