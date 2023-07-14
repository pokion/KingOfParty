import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import VueDragscroll from "vue-dragscroll"
import sqlite from './database/sqlite';
const sql = new sqlite();
import "@/assets/global.css"

sql.init();

createApp(App).use(router).use(VueDragscroll).mount('#app')
