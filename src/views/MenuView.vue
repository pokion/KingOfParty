<template>
    <div class="menu">
        <router-link to="/nameSelect"><GameButton variant="primary" content="Play"></GameButton></router-link>
        <router-link to="/cards"><GameButton variant="primary" content="Cards"></GameButton></router-link>
        <router-link to="/"><GameButton variant="secondary" content="Author"></GameButton></router-link>
    </div>
</template>
<script>
import GameButton from '@/components/GameButton.vue';

export default {
    components: {
        GameButton
    }
}
</script>
<style scoped>
    .menu{
        height: 100%;
        display: flex;
        flex-direction: column;
        gap: 20px;
        align-items: center;
        justify-content: center;
    }
</style>