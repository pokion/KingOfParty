import sqlite from './sqlite.js';
const allModesSQL = 'SELECT name, code, id FROM modes';

class modes {
    constructor() {
        this.sqlite = new sqlite();
    }

    getAll(){
        return this.sqlite.getAll(allModesSQL);
    }
}

export default modes;