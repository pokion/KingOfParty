<template>
    <div class="box" id="menu">
        <ButtonsColumn :buttons="buttons" @on-click="menuClick" />
    </div>
    <div class="box" id="settings" v-if="false">

    </div>
    <div class="box" id="author" v-if="false">
        
    </div>
</template>
<script>
import ButtonsColumn from '../components/ButtonsColumn.vue'

export default {
    name: 'MenuScene',
    components: {
		ButtonsColumn
	},
    props: ['routes'],
    data() {
		return {
			buttons: [
				{name: 'Start', id: 'start'},
				{name: 'Settings', id: 'settings'},
				{name: 'Author', id: 'author'}
			],
            allRoutes: this.routes
		}
	},
    methods: {
        menuClick(button) {
            if(button.id === 'start'){
                this.$emit('route', 'gameModes')
            }
        }
    },
}
</script>
<style scoped>
    .box{
        width: 60%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>