<template>
	<main>
		<component v-bind:is="currentScene" 
		@route="routing" 
		@players="setPlayers" 
		:routes="allRoutes"
		:Cards="this.allCards"
		:Players="this.allPlayers" />
	</main>
	<div class="settings" @click="settings">
		<SettingsGear />
	</div>
</template>

<script>
//vue
import MenuScene from './scenes/Menu.vue'
import GameModes from './scenes/GameModes.vue'
import SettingsGear from './components/SettingsGear.vue'
import PlayersScene from './scenes/PlayersScene.vue'
import GameScene from './scenes/GameScene.vue'

//js
import Cards from './helpers/Helpers'

export default { 
	name: 'App',
	components: {
		MenuScene,
		SettingsGear,
		GameModes,
		PlayersScene,
		GameScene
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
				},
				'players': {
					name: 'players',
					component: PlayersScene
				},
				'game': {
					name: 'game',
					component: GameScene
				}
			},
			currentScene: MenuScene,
			allPlayers: null,
			allCards: Cards.getMapOfCards
		}
	},
	methods: {
		routing(name) {
			this.currentScene = this.allRoutes[name].component;
		},
		settings(){
			this.currentScene = this.allRoutes['menu'].component;
		},
		setPlayers(mapOfPlayers){
			this.allPlayers = mapOfPlayers;
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
