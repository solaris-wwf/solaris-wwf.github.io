<template>
  <div>
      我是home
      <router-link to="/film" id="alink">film</router-link>
      <router-link to="/card">card</router-link>
  </div>
</template>

<script>
export default {
    name:'home',
}
</script>

<style>
  #alink{text-decoration: none}
</style>