//日期格式化函数
Date.prototype.format = function (fmt) {
    var o = {
        'M+': this.getMonth() + 1,
        'd+': this.getDate(),
        'h+': this.getHours(),
        'm+': this.getMinutes(),
        's+': this.getSeconds(),
        'q+': Math.floor((this.getMonth() + 3) / 3),
        'S': this.getMilliseconds()
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length))
    }
    for (var k in o) {
        if (new RegExp('(' + k + ')').test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : ('00' + o[k]).substr(('' + o[k]).length))
        }
    }
    return fmt;
}

var v = new Vue({
    el: '#comment',
    data: {
        //原始用户评论信息
        comments: [{
            username: '张三',
            userimg: 'user01.jpg',
            words: '这里是不错，哈哈哈哈',
            time: "2017-02-17 09:15:25"
        },
        {
            username: '李四',
            userimg: 'user02.jpg',
            words: '这里是不错，哈哈哈哈',
            time: "2017-02-17 09:15:25"
        },
        {
            username: '赵武',
            userimg: 'user03.jpg',
            words: '这里是不错，哈哈哈哈',
            time: "2017-02-17 09:15:25"
        },
        ],
        //原始用户信息
        users: [{
            username: 'zhangsan',
            password: '123456',
            userimg: 'user01.jpg'
        },
        {
            username: 'sarah',
            password: '123456',
            userimg: 'user02.jpg'
        },
        {
            username: 'zjs',
            password: '123456',
            userimg: 'user03.jpg'
        },
        ],
        currentUser: { username: '', userimg: '' },
        loginStatus: false,
        registerStatus: false,
        userbarStatus: false,
        lrBtnStatus: true,
    },
    methods: {
        //登录
        showLogin: function () {
            document.getElementById('login').reset();
            this.loginStatus = true;
            this.registerStatus = false;
        },
        //注册
        showregister: function () {
            document.getElementById('register').reset();
            this.loginStatus = false;
            this.registerStatus = true;
        },
        //退出登录
        loginout: function () {
            this.currentUser.username = '';
            this.currentUser.userimg = '';
            alert('退出成功');
            this.userbarStatus = false;
            this.lrBtnStatus = true;
        },
        //遮罩层
        loginboxClick: function () {
            this.loginStatus = false;
        },
        registerboxClick: function () {
            this.registerStatus = false;
        },
        //点击登录或注册框来阻止事件冒泡
        stopProp: function (e) {
            e = e || event;
            e.stopPropagation();
        },
        //登录
        login:function(){
            var username = $('.loginbox').find('.username').val();
            var psw = $('.loginbox').find('.psw').val();
            var flag = false;
            for(var i = 0; i < this.users.length; i++){
                if(this.users[i].username === username && this.users[i].password === psw){
                    flag = true;
                    alert('登录成功');
                    this.loginStatus = false;
                    this.userbarStatus = true;
                    this.currentUser.username = this.users[i].username;
                    this.currentUser.userimg = this.users[i].userimg;
                    this.lrBtnStatus = false;
                    break;
                }
            }
            if(!flag){
                alert('登录失败');
                document.getElementById('login').reset();
            }
        },
        //注册
        register:function(){
            var obj = {};
            var flag = false;
            var username = $('.registerbox').find('.username').val();
            var psw = $('.registerbox').find('.psw').val();
            for(var i = 0; i < this.users.length; i++){
                if(this.users[i].username === username){
                    flag = true;
                    alert('用户名已经被注册');
                    break;
                }
            }
            if(!flag){
                if(username == '' || psw == ''){
                    alert('账号密码不能为空');
                }else{
                    var randomNum = Math.floor(Math.random() * 3) + 1;
                    var randomImg = 'user0' + randomNum + '.jpg';
                    obj.username = username;
                    obj.password = psw;
                    obj.userimg = randomImg;
                    this.users.push(obj);
                    alert('注册成功');
                    this.userbarStatus = true;
                    this.currentUser.username = obj.username;
                    this.currentUser.userimg = obj.userimg;
                    this.lrBtnStatus = false;
                    document.getElementById('register').reset();
                    this.registerStatus = false;
                }
            }
        },
        //评论
        subComment:function(){
            if(!this.userbarStatus){
                alert('登录后才可以评论')
                this.loginStatus = true;
            }else{
                if($('.wordsbox textarea').val() == ''){
                    alert('评论不能为空');
                }else{
                    var obj = {};
                    obj.username = this.currentUser.username;
                    obj.userimg = this.currentUser.userimg;
                    obj.words = $('.wordsbox textarea').val();
                    obj.time = new Date().format('yyyy-MM-dd hh:mm:ss');

                    this.comments.push(obj);
                    alert('评论成功');
                    $('.wordsbox textarea').val('');
                }
            }
        }
    },


})