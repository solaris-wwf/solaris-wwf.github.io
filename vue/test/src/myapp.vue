<template>
    <div>hello world111
        <input type="text" v-model="name">
        <button @click="addLi">add</button>
        <transition-group tag="ul" name="bounce">
            <li v-for="(data,index) in datalist" :key="data">{{data}}<button @click="delLi(index)">delete</button></li>
        </transition-group>
        <mychild></mychild>
        <!-- 这里就是router要显示的区域，在components下面的文件，在href中输入/相对应的文件名就可以 -->
        <router-view/>


    </div>
</template>

<script>
    import mychild from './mychildapp';
    export default{
        data(){//这里的data就不能像new Vue中设置成对象了，必须是一个函数
            return {
                datalist:['111','222','333'],
                name:'',
            }
        },
        methods: {
            addLi:function(){
                this.datalist.push(this.name);
            },
            delLi:function(index){
                this.datalist.splice(index,1)
            },
            
        },
        components:{
            mychild:mychild,
        }
    }
</script>

<style lang="css" scoped>
    .bounce-enter-active{animation: bounce-in .5s;}
    .bounce-leave-active{animation: bounce-in .5s reverse;}
    @keyframes bounce-in {
        0%{transform: translateX(100px);opacity: 0;}
        100%{transform: translateX(0px);opacity: 1;}
    } 


</style>
