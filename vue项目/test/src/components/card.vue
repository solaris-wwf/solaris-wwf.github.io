<template>
  <div>
      我是card页面
      <ul>
        <li v-for="(data,index) in datalist" @click="handleClick(index)">{{data}}</li>
      </ul>
      <router-view></router-view>
  </div>
</template>

<script>
import router from '../router';//这里/index.js可以省略不用写。
export default {
    name:'card',
    data(){
      return {
        datalist:['card1','card2','card3',]
        };
    },
    methods: {
      handleClick:function(index){
        //你需要router引用进来，才能进行跳转
          router.push(`/card/detail/${index}`);//es6反向引号写法，
      }
    },
}
</script>

<style>
  li{list-style: none;cursor: pointer;;}
</style>