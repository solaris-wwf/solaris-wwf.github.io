import Vuex from 'vuex';
import Vue from 'vue';
Vue.use(Vuex);

const store = new Vuex.Store({
    state:{
        list:[]
    },
    mutations:{
        add:(state,payLoad)=>{//这时它会传过来状态state这个对象，还会传过来真实的payLoad
            //console.log(payLoad)
            state.list.push(payLoad);
        }
    },
    getters:{
        activelist(state){//state代表状态属性，isChecked是true 或者 false,用filter方法进行过滤，遍历当中的属性值是true或者false，如果是false，则筛选出了未完成的
            return state.list.filter(item => item.isChecked == false)
        },
        completelist(state){//返回一个代表已完成的数组
            return state.list.filter(item => item.isChecked == true)
        },
        sum(state){//返回一个未完成总数
            return state.list.filter(item => item.isChecked == false).length
        },
    },
})
export default store;