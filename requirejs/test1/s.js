define(['math'],function(m1){//用中括号定义依赖模块的名字，并且要传入一个参数m1代表这个math模块，如果引用了多个模块，要按照顺序写入对应的参数，
    function circle(r){//定义一个圆的面积,r代表半径
        return m1.multiple(m1.PI,m1.square(r));
    }
    return{
        s_circle : circle//返回这个方法
    }
})