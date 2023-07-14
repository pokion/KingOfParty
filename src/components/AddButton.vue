<template>
    <div>
        <span class="material-icons" @click="clicked">
            {{ witchIcon }}
        </span>
        <div class="input" :class="{show: isClicked}">
            <InputGame withFilters="false" textAlign="left" @value="getValue"></InputGame>
        </div>
    </div>
</template>
<script>
import InputGame from './InputGame.vue';

export default {
    components: {
        InputGame
    },
    data(){
        return {
            isClicked: false,
            isEmpty: true,
            value: ''
        }
    },
    methods: {
        getValue(value){
            if(value != '') this.isEmpty = false
            else this.isEmpty = true
            this.value = value;
        },
        clicked(){
            if(this.isClicked == true && this.isEmpty == false){
                this.$emit('tag', this.value);
            }else{
                this.isClicked = !this.isClicked
            }
        }
    },
    computed: {
        witchIcon(){
            if(this.isClicked == true && this.isEmpty == true) return 'close'
            if(this.isClicked == true && this.isEmpty == false) return 'done'

            return 'add'
        }
    }
}
</script>
<style scoped>
    div > span{
        padding: 5px;
        background-color: var(--overlay);
        color: var(--text);
        border-radius: 100%;
        height: 1rem;
        width: 1rem;
        text-align: center;
    }
    div{
        display: flex;
        flex-direction: row;
        gap: 10px;
    }
    .show{
        width: 100% !important;
        transition: all 1s;
    }
    .input{
        width: 0%;
        overflow: hidden;
        transition: width 1s;
    }
</style>