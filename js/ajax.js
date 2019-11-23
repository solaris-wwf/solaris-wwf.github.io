function ajax(url,fn){
    var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');//兼容ie的ajax
    xhr.open('GET',url,true);
    xhr.send();
    xhr.onreadystatechange = function(){
        if(xhr.readyState == 4 && xhr.status == 200){
            fn && fn(xhr.responseText);
        }
    }
}