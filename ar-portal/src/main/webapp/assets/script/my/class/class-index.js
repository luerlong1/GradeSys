

$(function () {
    $("#origin-manage").attr("class", "am-list am-collapse admin-sidebar-sub am-in");
    /* 翻页页码绑定查询器 必须绑定，否则页码无效 */
    _pageBond(queryOrigin1);

});

/* 条件查询 *//* 查询函数可以有多个参数，pageIndex要是第一个 */
function queryOrigin1(pageIndex, pageSize) {
    // 参数提取
    var userId = $('#userId').val();
    // 跳转
    post('/my/class.action', {
        'userId': userId,
        'pageIndex': pageIndex,
        'pageSize': pageSize
    }, function (data) {
    });
}
