<template>
    <div class="container">
        <input type="text" placeholder="Search">
        <div class="icon" v-if="!(withFilters == 'false')">
            <span class="material-icons">filter_alt</span>
        </div>
    </div>
</template>
<script>
export default {
    props: ['withFilters']
}
</script>
<style scoped>
    .icon{
        width: 18%;
        border-bottom: 1px solid var(--overlay);
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
    }
    .icon::before{
        border-left: 1px solid var(--blocked-text);
        height: 80%;
        content: '';
        position: absolute;
        left: 0;
        bottom: 50%;
        transform: translateY(50%);
    }
    .container{
        position: relative;
        display: flex;
        justify-content: center;
        flex-direction: row;
    }
    input{
        width: 80%;
        border: none;
        background-color: var(--background);
        border-bottom: 1px solid var(--overlay);
        color: var(--text);
        text-align: center;
    }
    input:focus{
        outline: none;
        border-bottom: 2px solid var(--overlay);
    }
    input:focus ~ .icon{
        border-bottom: 2px solid var(--overlay); 
    }
    span{
        color: var(--blocked-text);
    }
</style>