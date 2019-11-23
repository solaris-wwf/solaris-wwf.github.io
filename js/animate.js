function getStyle(el,property){//ie8兼容性
    return el.currentStyle ? el.currentStyle[property] :window.getComputedStyle(el)[property];
}
function animateEl(el,properties,fn){
    clearInterval(el.timer);
    el.timer = setInterval(function() {//设定周期调用函数
        var stop = true;//设置是否得到的属性都匹配了设定的值，则返回true
        for(var property in properties){//遍历对象中的键名
            var curpro;
            var target = properties[property];
            if(property == "opacity"){
                curpro = Math.round(parseFloat(getStyle(el,property)) * 100);//将值乘以100取整，方便计算speed
                target = parseFloat(target)*100;
            }else{
                curpro = parseFloat(getStyle(el,property));//width如果使用parseInt,不会得到指定值，其他可以
            }
            var speed = (target - curpro) / 30;//目标距离减去当前距离除以30作为速度。
            speed = speed > 0 ? Math.ceil(speed): Math.floor(speed);//如果速度大于0，则向上取整，至少为1,相反为-1；
            if(properties[property] != curpro){//如果这个值没有达到指定值，则设定stop为false，不让定时器停止。
                stop = false;
            }
            if(property == "opacity"){
                el.style[property] =(curpro + speed)/100 ;
            }else{
                el.style[property] =curpro + speed + "px";
            }
        }
        if(stop){//如果一个值匹配了指定值，则停止定时器
            clearInterval(el.timer);
            fn && fn();//因为停止了第一个定时器，需要开启下一次运算，用回调函数来决定。这个意思是你返回一个函数，则调用这个函数。
        }
    }, 20);
}
var speedX = 30;//设置div距离页面左边距离
    var speedY = 30;
    /* oDiv.speedX = 15;
    oDiv.speedY = 3;
    oDiv2.speedX = 18;
    oDiv2.speedY = 2; */
//盒子碰撞到了页面边缘检测
function check_border_conllision(el){
    var elStyle = window.getComputedStyle(el);
    var left = parseInt(elStyle.left);
    var top = parseInt(elStyle.top);
    var w = parseInt(elStyle.width);//div的宽度
    var h = parseInt(elStyle.height);
    if(left < 0){//如果左侧位置是负值，则将它设为0，平移值转换
        left = 0;
        el.speedX *= -1;
    }
    if(left > window.innerWidth - w){//如果现在的左侧距离大于了页面宽度减去div的宽度，表示右边已经撞上了。
        left = window.innerWidth -w;
        el.speedX *= -1;
    }
    if(top < 0){
        top = 0;
        el.speedY *= -1;
    }
    if(top > window.innerHeight - h){
        top = window.innerHeight - h;
        el.speedY *= -1;
    }
    el.style.left = left + 'px';
    el.style.top = top + 'px';
}
//检测两个盒子相撞
function check_conllision(el,el2){
    var style1 = window.getComputedStyle(el);
    var style2 = window.getComputedStyle(el2);
    var left1 = parseInt(style1.left);
    var left2 = parseInt(style2.left);
    var top1 = parseInt(style1.top);
    var top2 = parseInt(style2.top);
    var w1 = parseInt(style1.width);
    var w2 = parseInt(style2.width);
    var h1 = parseInt(style1.height);
    var h2 = parseInt(style2.height);
    var style1Zx = {x:left1 + w1 / 2,y:top1 + h1 / 2};//箱子1的中心点位置
    var style2Zx = {x:left2 + w2 / 2,y:top2 + h2 / 2};//箱子2的中心点位置
    var leftc = Math.abs(style1Zx.x - style2Zx.x);//取绝对值
    var topc = Math.abs(style1Zx.y - style2Zx.y);
    if(leftc <= (w1 + w2)/2 && topc <= (h1 + h2)/2){//如果箱子的中心点小于他们的高度和宽度一半之和，我们判断为相撞
        return true;
    }
    return false;
}
function move2(el){
    var currentLeft = parseInt(window.getComputedStyle(el).left);
    var currentTop = parseInt(window.getComputedStyle(el).top);
    check_border_conllision(el);
    var tempX, tempY;
    if(check_conllision(oDiv,oDiv2)){//判断是否相撞，将箱子的速度互换
        tempX = oDiv.speedX;
        tempY = oDiv.speedY;
        oDiv.speedX = oDiv2.speedX;
        oDiv.speedY = oDiv2.speedY;
        oDiv2.speedX = tempX;
        oDiv2.speedY = tempY;
    }
    var left = currentLeft + el.speedX;//设置div距离页面左边的位置
    var top = currentTop + el.speedY;
    el.style.left = left + 'px';
    el.style.top = top + 'px';
}