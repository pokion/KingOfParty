import { createRouter, createWebHashHistory } from 'vue-router'

import MenuView from '@/views/MenuView.vue';
import AllCards from '@/views/AllCards.vue';
import AddCard from '@/views/AddCard.vue';
import UpdateCard from '@/views/UpdateCard.vue';
import NameSelect from '@/views/NameSelect.vue';
import GameView from '@/views/GameView.vue';

const routes = [
  {
    path: '/',
    name: 'King Of Party',
    component: MenuView
  },
  {
    path: '/cards',
    name: 'Cards',
    component: AllCards
  },
  {
    path: '/addCards',
    name: 'Add Card',
    component: AddCard
  },
  {
    path: '/updateCard/:id',
    name: 'Update Card',
    component: UpdateCard
  },
  {
    path: '/nameSelect',
    name: 'Players',
    component: NameSelect
  },
  {
    path: '/game/:players',
    name: '',
    component: GameView
  },
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
