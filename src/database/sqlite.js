import betterSQL from 'better-sqlite3';

const CardsTable = 'create table if not exists cards(id INTEGER PRIMARY KEY, content, author, mode)';
const ModesTable = 'create table if not exists modes(id INTEGER PRIMARY KEY, name, code)';
const TagsTable = 'create table if not exists tags(id INTEGER PRIMARY KEY, name, code)';
const DecksTable = 'create table if not exists decks(id INTEGER PRIMARY KEY, name, code)';
const TagsJunctionCardsTable = 'create table if not exists tagsJunction(id INTEGER PRIMARY KEY, cardID, tagID)';

const AllTables = [ModesTable, CardsTable, TagsTable, TagsJunctionCardsTable, DecksTable];
const db = betterSQL('./src/database/kop.db', {verbose: console.log});

class sqlite{
    init(){
        this.runMultipleQueries(AllTables)();
        //this.runQueryWithValues('INSERT INTO tags(name, code) VALUES(@name, @code)', [{name: 'Fears', code: '1'},{name: 'Embarrassing', code: '2'}])
        //console.table(this.runMultipleQueries(['UPDATE cards SET mode = 1 WHERE id = 2'])()); console.log('test getAll')
        //this.runMultipleQueries(['DELETE FROM cards'])() CROSS JOIN tags tag ON tagj.tagID = tag.id , tag.name AS tagName, tag.id AS tagId
        
    }

    runQueryWithValues(sql, values){
        let dataReturned = [];
        let transaction = db.transaction((valuesToAdd) => {
            for(let value of valuesToAdd) dataReturned.push(db.prepare(sql).run(value));
        });
        transaction(values)
        return dataReturned;
    }

    runMultipleQueries(arrayOfQueries){
        const queries = arrayOfQueries.map(sql => db.prepare(sql));
        return db.transaction((data = {}) => {
            let result;
            for (const query of queries) {
                if (query.reader) result = query.all(data);
                else query.run(data);
            }
            return result;
        });
    }

    getAll(sql, params){
        let data;
        if(params) data = db.prepare(sql).all(params);
        else data = db.prepare(sql).all();
        return data;
    }

    runQuery(sql){
        let data = db.prepare(sql).run();
        return data;
    }
}

export default sqlite