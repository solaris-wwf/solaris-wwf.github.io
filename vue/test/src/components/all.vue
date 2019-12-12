<template>
  <div>
      all组件
      <ul>
          <li v-for = "data in list"><input type="checkbox" v-model="data.isChecked">
          <!-- 当data.isChecked是true的时候，delTxt这个类样式就会生效 -->
          <span :class="{delTxt:data.isChecked}">{{data.name}}</span>
          </li>
      </ul>
  </div>
</template>

<script>
import {mapState} from 'vuex';
export default {
    name:'all',
    data() {
        return {
            
        }
    },
    computed: {
        ...mapState(['list'])
    },
}
</script>

<style lang="scss" scoped>
.delTxt{text-decoration: line-through}
</style>