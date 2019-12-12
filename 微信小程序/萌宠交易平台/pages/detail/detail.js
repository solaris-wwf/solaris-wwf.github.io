const app = getApp();
Page({
  data:{
    address:'',
    type:'',
    message:'',
    contact:''
  },
  //只有onLoad函数才能接收首页点击marker传过来的id
  onLoad(options){
    this.getDetailInfo(options.id);
  },
  getDetailInfo(id){
    wx.request({
      url: 'https://nuanwan.wekeji.cn/student/index.php/trade/get_item',
      data: {
        distinct: app.globalData.distinct,
        id:id
      },
      method:'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      success: this.getDetailSucc.bind(this)
    })
  },
  getDetailSucc(res){
    this.setData({
      address:res.data.data.address,
      type:res.data.data.type,
      message:res.data.data.message,
      contact:res.data.data.contact
    })
  }
})