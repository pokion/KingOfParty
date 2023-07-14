<template>
    <div class="container" v-dragscroll.x>
        <div class="scrollable" :class="{noWrap: oneLine}" >
            <div class="item"  v-for="item in items" :class="{true: item.selected}" :key="item.id" @click="onClick(item.id)">
                {{ item.name }}
            </div>
        </div>
    </div>
</template>
<script>

export default {
    props: ['items', 'oneLine'],
    methods: {
        onClick(id){
            this.$emit('clicked', id);
        }
    }
}
</script>
<style scoped>
    .scrollable{
        display: flex;
        flex-wrap: wrap;
        align-content: stretch;
        gap: 10px;
    }
    .noWrap{
        flex-wrap: nowrap !important;
    }
    .noWrap>.item{
        border-radius: 10px;
        display: inline-block;
    }
    .container{
        overflow: hidden;
    }
    .item{
        border: 2px solid var(--overlay);
        background-color: var(--background);
        color: var(--text);
        padding: 10px;
        flex-grow: 1;
        text-align: center;
        white-space: nowrap;
    }
    .true{
        background-color: var(--overlay) !important;
    }
</style>