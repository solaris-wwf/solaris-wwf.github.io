//app.js
App({
  globalData:{
    distinct:'longxiaozhai_cource'
  },
  onLaunch() {
    try {
      const deviceInfo = wx.getStorageSync('deviceInfo');
      if(!deviceInfo){
        const res = wx.getSystemInfoSync()
        this.globalData.windowHeight = res.windowHeight;
        this.globalData.windowWidth = res.windowWidth;
        console.log(1)
        wx.setStorageSync('deviceInfo',{
          windowHeight: res.windowHeight,
          windowWidth: res.windowWidth
        })
      }else{
        this.globalData.windowHeight = deviceInfo.windowHeight;
        this.globalData.windowWidth = deviceInfo.windowWidth;
      }
      
      
    } catch (e) {
      // Do something when catch error
    }
  }
})