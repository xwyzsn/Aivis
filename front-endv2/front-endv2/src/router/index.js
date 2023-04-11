import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/sys',
      name: 'system',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/Layout/MainLayout.vue'),
      redirect: '/sys/algorithms',
      children: [
        {
          path: 'algorithms',
          name: 'algorithms',
          component: () => import('../views/Layout/AlLayout.vue'),
          redirect: '/sys/algorithms/triformer',
          children: [
            { path: 'triformer', component: () => import('../views/Algorithms/Triformer.vue'), name: 'triformer' },
          ]
        },
        {
          path: 'chart', component: () => import('../views/ChartView/NewChartView.vue'), name: 'newChartView',
          redirect: '/sys/chart/choose',
          children: [
            { path: 'choose',component:() => import('../views/ChartView/ChoosePage.vue'), name: 'chooseView' },
            {path:'allchart',component:() => import('../views/ChartView/AllChartView.vue'), name: 'allChartView' },
          ]
        },
        {
          path:'datasource',component:() => import('../views/Layout/DatasourceLayout.vue'), name: 'datasourceLayout',
        },
        { path:'sqllab',component:()=> import('../views/SqlLab/SqlLab.vue'),name:'sqlLab'}
      ]
    }
  ]
})

export default router
