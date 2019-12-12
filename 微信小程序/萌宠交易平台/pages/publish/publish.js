//logs.js
const util = require('../../utils/util.js')
const app = getApp();
Page({
  data:{
    address:'点击选择，要勾选哦~',
    success:false,//发送成功后，设置success为true，把返回首页页面呈现
    items: [
      {name:'buy',
        value: '求购',
      checked: 'true'},{
        name:'sell',
        value: '转让',
        checked: 'false'
      }
    ]
  },
  staticData:{
    type:'buy'
  },
  //处理点击我的地址时候触发函数
  handleAddressClick(){
    wx.chooseLocation({
      success: this.handleChooseLocationSucc.bind(this)
    })
  },
  //选择地址后将经纬度地址写入data和staticData
  handleChooseLocationSucc(res){
    this.setData({
      address:res.address
    });
    Object.assign(this.staticData,{
      latitude:res.latitude,
      longitude:res.longitude
    })
  },
  //处理类型求购或者转让时候的触发函数
  handleTypeChange(e){
    this.staticData.type = e.detail.value;
    console.log(this.staticData)
  },
  //处理联系方式
  handleContactChange(e){
    this.staticData.contact = e.detail.value;
  },
  //处理说明
  handleMessageChange(e){
    this.staticData.message = e.detail.value;
  },
  //处理发送按钮
  handleSubmit(){
    if (this.data.address === '点击选择，要勾选哦~' || !this.data.address){
      wx.showToast({
        title: '请填写地址',
        icon: 'loading',
        duration: 2000
      })
      return;
    }
    if (!this.staticData.message) {
      wx.showToast({
        title: '请填写说明信息',
        icon: 'loading',
        duration: 2000
      })
      return;
    }
    if (!this.staticData.contact) {
      wx.showToast({
        title: '请填写练习方式',
        icon: 'loading',
        duration: 2000
      })
      return;
    }
    const data = Object.assign({},this.staticData,{
      address: this.data.address,
      distinct: app.globalData.distinct//因为接口是通用的，防止出现别人的数据
    })

    wx.request({
      url: 'https://nuanwan.wekeji.cn/student/index.php/trade/add_item',
      data: data,
      method:'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded' 
      },
      success:this.handleSubmitSucc.bind(this)
    })
  },
  handleSubmitSucc(res){
    if(res.data && res.data.ret){
      this.setData({
        success:true
      })
    }
  },
  //发送成功后，返回上一页
  handleBackTap() {
    wx.navigateBack({
      
    });
  },
  onShareAppMessage() {
    // 页面被用户分享时执行
    return {
      title: '萌宠交易平台',
      path: '/pages/index/index'
    }
  }
})
