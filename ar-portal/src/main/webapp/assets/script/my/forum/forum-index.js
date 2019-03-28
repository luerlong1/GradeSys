$(function () {
    $("#my-forum").attr("class", "active");

    _pageBond(queryOrigin1);
});

/* 条件查询 *//* 查询函数可以有多个参数，pageIndex要是第一个 */
function queryOrigin1(pageIndex, pageSize) {
    // 参数提取
    var userId = $('#userId').val();
    // 跳转
    post('/my/forum.action', {
        'userId': userId,
        'pageIndex': pageIndex,
        'pageSize': pageSize
    }, function (data) {
    });
}
function deleteMyPost(postId) {
    if (window.confirm('确定删除这条帖子？')) {
        post('my/info/delete.action', {"postId": postId});
    }
}
