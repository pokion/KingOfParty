<template>
	<main>
		<component v-bind:is="currentScene" @route="routing" :routes="allRoutes" />
	</main>
	<div class="settings" >
		<SettingsGear />
	</div>
</template>

<script>
import MenuScene from './scenes/Menu.vue'
import GameModes from './scenes/GameModes.vue'
import SettingsGear from './components/SettingsGear.vue'

export default { 
	name: 'App',
	components: {
		MenuScene,
		SettingsGear
	},
	data() {
		return {
			allRoutes: {
				'menu': {
					name: 'menu',
					component: MenuScene
				},
				'gameModes': {
					name: 'gameModes',
					component: GameModes
				}
			},
			currentScene: MenuScene
		}
	},
	methods: {
		routing(name) {
			this.currentScene = this.allRoutes[name].component;
		}
	},
}
</script>

<style scoped>
#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	color: #2c3e50;
	}
.settings{
	position: absolute;
	top: 10px;
	right: 10px;
}

main{
	height: 100vh;
	display: flex;
	justify-content: center;
}

</style>
