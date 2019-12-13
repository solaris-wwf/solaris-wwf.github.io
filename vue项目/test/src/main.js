// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import router from './router'

import App from './App'//vuex的验证使用页面
import myapp from './myapp.vue';//vue单文件学习页面
import elui from './elui.vue';//element ui学习
import store from './vuex';//可以省略/index.js
import ElementUI from 'element-ui' //引入element ui
import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false
Vue.use(ElementUI);//引入element ui
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,//引入Vue的路由
  store,//引入Vuex状态管理文件
  
  //render:h=>h(App),//vuex的验证使用页面
  render:h=>h(elui),//element ui 学习页面
  /* components:{myapp},
  template: '<myapp/>', */
  //也可以使用 render:h=>h(myapp), 
})
