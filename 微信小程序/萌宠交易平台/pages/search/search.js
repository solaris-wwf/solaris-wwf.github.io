const app = getApp();
Page({
  data:{
    list:[]
  },
  stataicData:{
    inputValue:''
  },
  onLoad(){
    this.getSearchResult('');
  },
  getSearchResult(keyword){
    wx.request({
      url: 'https://nuanwan.wekeji.cn/student/index.php/trade/get_search_list',
      data: {
        distinct: app.globalData.distinct,
        keyword: keyword
      },
      method:'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      success: this.getSearchSucc.bind(this)
    })
  },
  getSearchSucc(res){
    if(res.data.ret){
      this.setData({
        list: res.data.data
      })
    }else{
      this.setData({
        list:[]
      })
    }
  },
  //搜索框事件
  handleInputChange(e) {
    this.stataicData.inputValue = e.detail.value;
  },
  //点击搜索事件
  handleSearch(){
    this.getSearchResult(this.stataicData.inputValue);
  },
  //每个搜索结果点击跳转到详细页面
  handleItemTap(e){
    wx.navigateTo({
      url: '/pages/detail/detail?id=' + e.currentTarget.id,
    })
  }
})