<template>
    <div class="box">
        <button v-for="button in buttonsProp" @click="$emit('onClick', button)"
                :key="button.id" >
            {{ button.name }}
        </button>
    </div>
</template>
<script>
export default {
    /* 
        buttons: [
            button: {
                name: String,
                id: String
            }
        ]
    */
    props: ['buttons'],
    data() {
        return {
            buttonsProp: this.buttons
        }
    }
}
</script>
<style scoped>
    .box{
       width: 100%;
       height: 100%;
       display: flex;
       flex-direction: column;
       gap: 20px; 
    }
</style>