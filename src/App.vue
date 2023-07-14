<template>
	<nav>
		<div class="back" @click="pageBack">
			<span class="material-icons">
				arrow_back
			</span>
		</div>
		<div class="title">
			{{ currentRouteName }}
		</div>
		<div class="setting">
			<span class="material-icons">
				more_vert
			</span>
		</div>
	</nav>
	
	<main>
		<router-view></router-view>
	</main>

</template>

<script>
import modes from './database/modes.js';
import tags from './database/tags.js';
import cards from './database/cards.js';

export default { 
	name: 'App',
	components: {
		
	}, 
	data() {
		return {
			title: 'King Of Party',
			Modes: new modes(),
			Tags: new tags(),
			Cards: new cards()
		}
	},
	beforeMount() {
		localStorage.modes = JSON.stringify(this.Modes.getAll());
		localStorage.tags = JSON.stringify(this.Tags.getAll());
		localStorage.cards = JSON.stringify(this.Cards.getAll());
	},
	computed: {
		currentRouteName() {
			return this.$route.name;
		}
	},
	methods: {
		pageBack(){
			this.$router.back();
		}
	}
}
</script>

<style>
	:root{
		font-size: 24px;
	}
	@font-face {
		font-family: 'Roboto';
		src: local('Roboto'),
			url(./fonts/Roboto/Roboto-Medium.ttf);
	}
	@font-face{
		font-family: 'Roboto-Light';
		src: local('Roboto-Light'),
			url(./fonts/Roboto/Roboto-Light.ttf)
	}
	@font-face {
		font-family: 'Material Icons';
		font-style: normal;
		font-weight: 400;
		src: local('Material Icons'),
			local('MaterialIcons-Regular'),
			url(./icons/MaterialIcons-Regular.ttf) format('truetype');
	}
	body{
		background-color: var(--background);
		padding: 0;
		margin: 0;
	}
	*{
		font-family: 'Roboto';
		font-size: 24px;
		letter-spacing: 1.5px;
	}
	.material-icons {
		font-family: 'Material Icons';
		font-weight: normal;
		font-style: normal;
		font-size: 24px;
		display: inline-block;
		line-height: 1;
		text-transform: none;
		letter-spacing: normal;
		word-wrap: normal;
		white-space: nowrap;
		direction: ltr;
		text-rendering: optimizeLegibility;
	}
	nav{
		display: flex;
		flex-direction: row;
		color: var(--overlay);
		padding-top: 20px;
		height: 3rem;
		box-sizing: border-box;
	}
	main{
		height: calc(100vh - 3rem);
		width: 85%;
		margin: auto;
	}
	nav>div{
		font-size: 1.5rem;
	}
	.setting>span{
		font-size: 2rem;
	}
	.title{
		flex-grow: 1;
		text-align: center;
	}
	.back>span{
		font-size: 2rem;
	}
</style>
