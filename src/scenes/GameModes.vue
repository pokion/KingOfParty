<template>
    <main>
        <ButtonsColumn :buttons="buttons" @on-click="chooseGameMode" />
    </main>
</template>
<script>
import ButtonsColumn from '@/components/ButtonsColumn.vue';

export default {
    components:{
        ButtonsColumn
    },
    props: ['routes'],
    data() {
        return {
            buttons: [
                {name: 'Pytania i wyzwania', id: 'players'},
                {name: 'Coś jeszcze', id: 'cosJeszcze'},
            ]
        }
    },
    methods: {
        chooseGameMode(button){
            console.log(button)
            this.$emit('route', button.id);
        }
    },
}
</script>
<style scoped>

</style>