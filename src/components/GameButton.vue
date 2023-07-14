<template>
    <button :class="variant">{{ content }}</button>
</template>
<script>
export default {
    props: ['variant', 'content']
}
</script>
<style scoped>
    button{
        padding: 15px 30px 15px 30px;
        border-radius: 30px;
        border: none;
    }
    .primary{
        background-color: var(--overlay);
        color: var(--text);
    }
    .secondary{
        background-color: var(--background);
        border: 2px solid var(--overlay);
        color: var(--text);
    }
    .blocked{
        color: var(--blocked-text); 
        background-color: var(--blocked-overlay);
    }
</style>