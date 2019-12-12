<template>
  <div>我是未完成组件
      <ul>
        <li v-for="data in activelist"><input type="checkbox" v-model="data.isChecked">{{data.name}}</li>
      </ul>
  </div>

</template>

<script>
import {mapGetters} from 'vuex';
export default {
    name:'active',
    data() {
      return {
        
      }
    },
    computed: {
      ...mapGetters(['activelist'])//用简写方式，mapGetters的方法将数据引用出来，将vuex中的index.js的方法名引用进来，因此在当前的页面就可以获取到activelist这个属性
    },
}
</script>

<style>

</style>