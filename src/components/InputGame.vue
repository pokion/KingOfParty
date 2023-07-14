<template>
    <div class="container" :class="{removePadding: ifLabelEmpty }">
        
        <input id="input" class="textarea" :style="{textAlign: text}" v-bind:value="value" v-on:input="passValue($event.target.value)" placeholder=" ">
        <label>{{ label }}</label>
    </div>
</template>
<script>
export default {
    props: ['value', 'label', 'textAlign'],
    data() {
        return {
            text: this.textAlign || 'center'
        }
    },
    methods: {
        passValue: function(value){
            this.$emit('value', value);
        }
    },
    computed: {
        ifLabelEmpty(){
            return !(typeof this.label == "string")
        }
    }
}
</script>
<style scoped>
    label{
        color: var(--text);
        font-family: 'Roboto-Light';
        font-size: .9rem;
        position: absolute;
        left: 10px;
        top: 20px;
        transition: all 0.2s;
    }
    .textarea{
        background-color: transparent;
        border: none;
        border-bottom: 1px solid var(--overlay);
        outline: none;
        color: var(--text);
        box-sizing: border-box;
    }
    .textarea:focus{
        border-bottom: 2px solid var(--overlay);
    }
    .textarea:focus ~ label{
        font-size: 0.6rem;
        top: 0px;
        color: var(--blocked-text);
    }
    .textarea:not(:placeholder-shown)~ label{
        font-size: 0.6rem;
        top: 0px;
        color: var(--blocked-text);
    }
    .container{
        box-sizing: border-box;
        padding-top: 1rem;
        position: relative;
        display: inline;
    }
    .removePadding{
        padding: 0px !important;
    }
</style>