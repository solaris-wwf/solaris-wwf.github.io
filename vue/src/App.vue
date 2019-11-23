<template>
  <div id="app">
            <!-- vuex验证模块 -->
        <input type="text" autofocus="autofocus" autocomplete="off" placeholder="打算做什么" class="txt" @keyup.enter="handleEnter"><br/>
        <router-link to="/all">所有</router-link>
        <router-link to="/computed">完成</router-link>
        <router-link to="/active">未完成</router-link>
    <router-view></router-view>
    <p>未完成总数{{sum}}</p>
  </div>
</template>

<script>
import {mapGetters} from 'vuex';
export default {
  name: 'App',
  methods: {
    handleEnter(ev){
      console.log(ev.target.value)
      this.$store.commit('add',{name:ev.target.value,isChecked:false})//用来提交数据给store，提交类型是add和vuex.js中mutations中的方法名字一样,提交的数据就是ev.target.value,用v-model来实现双向数据绑定，子组件all中checkbox的来进行通信
    }
  },
  computed: {
    ...mapGetters(['sum'])
  },
}
</script>

<style>
    /* vuex验证模块 */
    .txt{outline: none;height: 60px;width: 120px;border-bottom: 1px solid #333}
</style>
