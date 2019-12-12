<template>
    <div>
        welcome
        <el-button type="primary">主要按钮</el-button>
        <el-button type="primary" icon="el-icon-search">ICON的使用</el-button>
            <el-date-picker
      v-model="value1"
      type="date"
      placeholder="选择日期">
    </el-date-picker>
  </div>
</template>

<script>
export default {
    name:'elui',
    data() {
        return{
            value1: '',
        } 
    },
    methods: {
      
    }
  }
</script>

<style scoped>

</style>