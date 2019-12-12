//index.js
//获取应用实例
const app = getApp();

Page({
  data:{
    longitude:"",
    latitude:"",
    markers: [{
      iconPath: "/resources/others.png",
      id: 0,
      latitude: 23.099994,
      longitude: 113.324520,
      width: 50,
      height: 50
    }],
    controls: [{
      iconPath: '/resources/pin.png',
      position: {
        left: app.globalData.windowWidth / 2 - 11,
        top: (app.globalData.windowHeight - 40 ) / 2 - 34,
        width: 22,
        height: 34
      }
    },
      {
        id: 1,
        iconPath: '/resources/center.png',
        position: {
          left: 20,
          top: app.globalData.windowHeight - 90,
          width: 33,
          height: 33
        },
        clickable: true
      }]
  },
  onShow(){
    this.getLocation();
    this.getMessages();
  },
  //从服务器获得数据给地图放一些sell buy的图标
  getMessages(){
    wx.request({
      url: 'https://nuanwan.wekeji.cn/student/index.php/trade/get_list',
      data: {
        distinct: app.globalData.distinct
      },
      header: {
        'content-type': 'application/x-www-form-urlencoded' 
      },
      success:this.getMessagesSucc.bind(this)
    })
  },
  //返回一些服务器中的数据去修改地图的markers
  getMessagesSucc(res){
    const markers = res.data.data.map((value,index)=>{
      return{
        iconPath: '/resources/'+ value.type +'.png',
        id: value.id,
        latitude: value.latitude,
        longitude: value.longitude,
        width: 40,
        height: 40
      }
    })
    this.setData({
      markers: markers
    })
  },

  onReady(){
    this.mapCtx = wx.createMapContext('map');
  },
  //让地图定位到当前位置
  getLocation(){
    wx.getLocation({
      type: 'gcj02', //这里最好使用gcj02,否则发布版本的时候可能有问题
      success: this.handleGetLocationSucc.bind(this)
    })
  },
  handleGetLocationSucc(res) {
    this.setData({
      longitude : res.longitude,
      latitude: res.latitude
    })
  },

  //点击左下角的定位图标，让地图定位到当前位置
  controltap(e){
    this.mapCtx.moveToLocation();
  },
  //处理地图上的sell ，buy图标的点击事件,跳转到detail页面，并将当前的地图marker的id传过去
  handleMarkerTap(e){
    wx.navigateTo({
      url: '/pages/detail/detail?id=' + e.markerId
    })
  },
  onShareAppMessage() {
    // 页面被用户分享时执行
    return {
      title: '萌宠交易平台',
      path: '/pages/index/index'
    }
  },
})
