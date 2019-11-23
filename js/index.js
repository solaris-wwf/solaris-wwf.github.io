/* 手机端适配列表 */
$('#phonenav').hide();
$('#phone').hover(function(){
    $('#phonenav').slideDown();
},function(){
    $('#phonenav').slideUp();
});
$('#phonenav').hover(function(){
    $('#phonenav').show();
},function(){
    $('#phonenav').slideUp();
});
/* 游戏下拉列表 */
$('#gamesul').hide();
$('#games').hover(function(){
    $('#gamesul').slideDown();
},function(){
    $('#gamesul').slideUp();
});
$('#gamesul').hover(function(){
    $('#gamesul').show();
},function(){
    $('#gamesul').slideUp();
});
