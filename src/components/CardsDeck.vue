<template>
    <div class="deck">
        <p class="deckName">{{ name }}</p>
        <p class="cardCount">Cards: {{ count }}</p>
    </div>
</template>
<script>
export default {
    props: ['name', 'count']
}
</script>
<style scoped>
    .deck{
        max-width: 100%;
        position: relative;
        border: 2px solid var(--overlay);
        border-radius: 10px;
        text-align: center;
        padding: 40px;
    }
    .cardCount{
        font-size: .5rem;
        position: absolute;
        right: 10px;
        bottom: 5px;
    }
    p{
        color: var(--overlay);
    }
</style>