import Vue from 'vue'
import Router from 'vue-router'
import Film from '@/components/film'
import Card from '@/components/card'
import Home from '@/components/home'
import NowPlaying from '@/components/nowplaying'
import ComingSoon from '@/components/comingsoon'
import Detail from '@/components/detail'
import All from '@/components/all'
import Active from '@/components/active'
import Computed from '@/components/computed'

Vue.use(Router)

export default new Router({
  mode:'history',
  /* vuex验证 */
  routes: [
    {
      path: '/all',
      name:'all',
      component: All
    },
    {
      path: '/active',
      name:'active',
      component: () => import('@/components/active.vue')//如果不是要立马加载的文件，我们可以这样使用到的时候在加载
    },
    {
      path: '/computed',
      component: Computed
    },
    /* 单文件组件的学习 */
   /*  {
      path:'/',
      redirect:{name:'home'}//当地址中输入/回车的时候，默认显示home页,这里用的跳转方式就是命名的方式而不是路径
    }, */
    {
      path: '/home',
      name: 'home',//name的作用是在跳转的时候，可以使用命名的路由
      component: Home
    },
    {
      path:'/film',//也可以在这里写redirect:'/film/now-playing',
      component:Film,
      children:[
      {
        path:'now-playing',//因为是子组件所以不用在添加/
        component:NowPlaying
      },
      {
        path:'coming-soon',//因为是子组件所以不用在添加/
        component:ComingSoon
      },
      {
        path:'/film',//当地址输入/film的时候默认跳转到/film/now-playing
        redirect:'/film/now-playing'
      }
    ]
    },
    {
      path:'/card',
      component:Card,
      children:[
        {
          path:'/card/detail/:id',//动态路由匹配的写法/:id这里只起到占位的作用，也可以添加多个占位符
          component:Detail
        }
      ]
    },
  ]
})
