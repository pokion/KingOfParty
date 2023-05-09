<template>
    <div class="card">
        <div class="cardBody ">{{ Card.body }}</div>
        <div class="cardAuthor">{{ Card.author }}</div>
    </div>
</template>
<script>
export default {
    props: ['Card']
}
</script>
<style scoped>
    .card{
        border: 2px solid black;
        border-radius: 5px;
        display: flex;
        flex-direction: column;
        gap: 20px;
        align-items: center;
        margin: auto;
    }
</style>