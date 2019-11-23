//冒泡排序，从小到大排序
function mppx(arr){
    for(i = 0;i < arr.length;i++)
    {
        for(j = 0;j < arr.length -i -1 ; j++)
        {
            if(arr[j] > arr[j+1])//比较前后两个数字是否符合交换条件,
            {
                var tmp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
            }}}}
//选择排序，从大到小
function xzpx(arr){
    for(i = 0;i < arr.length;i++)
    {
        for(j = i;j < arr.length  ; j++)
        {
            if(arr[j] < arr[i])//比对当前所有数字，
            {
                var tmp = arr[i];
                arr[i] = arr[j];
                arr[j] = tmp;
            }}}}
//兼容IE获取className相应的节点的封装函数
function elementByClassName(parent,classStr){
    var child = parent.getElementsByTagName("*");//*代表所有类型的节点
    var getE = [];//用来记录符合的元素节点数组
    for(i=0;i<child.length;i++){
        if(child[i].className == classStr){//遍历节点的className查找需要的
            getE.push(child[i]);
        }}
    return getE;
}
//id,tagName,name,class简化操作封装函数，获取上述节点
function $(elStr){
    switch(elStr[0]){
        case "#"://判断是否是ID
            return document.getElementById(elStr.substring(1));
            break;
        case "."://className
            return elementByClassName(document,elStr.substring(1));
            break;
        default:
            if(elStr.substring(0,5) == "name="){//name=
                return document.getElementsByName(elStr.substring(5));
            }
            else{
                return document.getElementsByTagName(elStr);//tagName
            }
            break;
    }}
//浏览器兼容性函数，获取外部样式表
function getStyle(el,styleStr){
    return el.currentStyle ? el.currentStyle[styleStr] : getComputedStyle(el)[styleStr];
}
//封装函数，识别掉空白节点
function defineSpaceNode (nodes){
    var result = [];
    for (i = 0; i < nodes.length; i++){
        if(nodes[i].nodeType == 3 && /^\s+$/.test(nodes[i].nodeValue)){
            continue;
        }
        result.push(nodes[i]);
    }
    return result;
}
//封装函数，识别删除空白节点，1,2,3,,,3,2     1,2,3,,3,2,为何需要倒序删除，因为当删除一个元素之后，后面一个元素就顶替了前面这个元素的下标，就会被直接忽略判断。
function removeSpaceNode (parent){
    var nodes = parent.childNodes;
    for (i = nodes.length - 1; i <= 0; i--){需要倒序删除
        if(nodes[i].nodeType == 3 && /^\s+$/.test(nodes[i].nodeValue)){
            parent.removeChildNodes(nodes[i]);
        }}}
//封装一个带文本的节点
function creatElementWithTxt(el,txt){
    var nodeEl = document.createElement(el);//创建一个node节点
    var oText = document.createTextNode(txt);//创建一个文本节点
    nodeEl.appendChild(oText);
    return nodeEl;//node带上了文本
}
//封装函数，插入到元素节点后边
function insertAfter(newNode,oldNode){
    var parent = oldNode.parentNode;
    if(oldNode == parent.lastChild){//如果是最后一个节点
        parent.appendChild(newnode);
    }else{
        parent.insertBefore(newNode,oldNode.nextSibling);
    }}
//给节点添加DOM二级事件函数，封装函数适用于IE,true代表捕获，false代表冒泡（默认）
function addEvent(obj,evt,fun,booltf){
    if(obj.addEventListener){
        obj.addEventListener(evt,fun,booltf);
    }else{
        obj.attachEvent("on"+evt,fun);
    }}
//给节点删除DOM二级事件函数，封装函数适用于IE
function removeEvent(obj,evt,fun){
    if(obj.removeEventListener){
        obj.removeEventListener(evt,fun);
    }else{
        obj.detachEvent("on"+evt,fun);
    }}
//cookie的封装 添加，获取，删除
function setCookie(name,value,day){
    var oDate = new Date();
    oDate.setDate(oDate.getDate()+day);
    document.cookie(name + "=" + value + ";expire=" + oDate);
}
function getCookie(name){
    var str = document.cookie;
    var arr = str.split(";");
    for(i = 0;i < arr.length; i++){
        var arr1 = arr[i].split("=");
        if(arr1[0] == name){
            return arr1[1];
        }
    }
}
function removeCookie(name){
    setCookie(name,1,-1);
}