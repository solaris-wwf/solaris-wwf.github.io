<template>
    <div>child 子组件
        <ul>
            <li>1111</li>
            <li>22222</li>
            <li>33333</li>
        </ul>
    </div>
</template>

<script>
    export default{
        name:'mychildapp',
        data(){//这里的data就不能像new Vue中设置成对象了，必须是一个函数
            return {
                
            }
        },
        methods: {
        },
    };
</script>

<style lang="scss" scoped>
    ul{
        li{background: #333}
    }
</style>