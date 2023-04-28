export default{
    convertArrayToMap({
        key,
        array
    }){
        let tempMap = new Map();

        for(let item in array){
            tempMap.set(item[key], item);
        }

        return tempMap;
    }
}