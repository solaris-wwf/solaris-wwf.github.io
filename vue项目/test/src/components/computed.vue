<template>
  <div>我是已完成组件
    <ul>
      <li v-for="data in completelist">
        <input type="checkbox" v-model="data.isChecked">
        <span :class="{delTxt:data.isChecked}">{{data.name}}</span></li>
    </ul>
  </div>
</template>

<script>
import {mapGetters} from 'vuex';
export default {
    name:'computed',
    data() {
      return {
        
      }
    },
    computed: {
      ...mapGetters(['completelist'])
    },
}
</script>

<style scoped>
.delTxt{text-decoration: line-through}
</style>