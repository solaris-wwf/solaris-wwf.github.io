define(function(){
    var PI = 3.14;
    function multiple(num1,num2){//定义一个乘法，
        return num1 * num2;
    }
    function square(n){//定义平方
        return Math.pow(n,2);
    }
    return {//将数据导出
        PI : PI,
        multiple : multiple,
        square : square
    }
})
