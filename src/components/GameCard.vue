<template >
    <div @click="$emit('clicked', returnValue)">
        <div class="cardFront card" :class="selected" v-if="side === 'front' || side === '0'">
        <p>{{ name }}</p>
    </div>
    <div class="cardBack card hide" :class="selected" v-if="side === 'back' || side === '1'">
        <div class="content">
            <div>
                <p>{{ mode }}</p>
            </div>
            <div>
                <p>{{ content }}</p>
            </div>
            <div>
                <p>{{ author }}</p>
            </div>
        </div>
    </div>
    </div>
</template>
<script>
export default {
    props: ['name', 'author', 'content', 'mode', 'side', 'selected', 'returnValue']
}
</script>
<style scoped>
    .true{
        background-color: var(--overlay) !important;
        color: var(--text) !important;
    }
    .card{
        min-width: 200px;
        display: flex;
        aspect-ratio: 1 / 2;
        border: 3px solid var(--overlay);
        color: var(--overlay);
        border-radius: 10px;
        align-items: center;
        justify-content: center;
        padding: 5%;
    }
    .content{
        text-align: center;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .content>div:nth-child(2){
        height: 80%;
        display: flex;
        align-items: center;
    }
</style>