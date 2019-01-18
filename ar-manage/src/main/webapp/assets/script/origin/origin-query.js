$(function () {
    /* 翻页页码绑定查询器 必须绑定，否则页码无效 */
    _pageBond(queryOrigin);

});

/* 条件查询 *//* 查询函数可以有多个参数，pageIndex要是第一个 */
function queryOrigin(pageIndex, pageSize) {
    /* loading进度条 */
    $.AMUI.progress.start();
    var query = $("#query").val();
    var state = $("#state").val();
    var originGrade = $('#originGrade').val();
    var originType = $('#originType').val();
    var queryStr = $('#queryBtn').val();
    $.post("origin/queryOrigin.action", {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "query": query,
        "state": state,
        'originGrade': originGrade,
        'originType': originType,
        'queryStr' : queryStr
    }, function (data) {
        $.AMUI.progress.done();
        $("#admin-content").html(data);
    });
}

// /* 置顶操作 */
// function setTopInfo(infoId) {
//     $.AMUI.progress.start();
//     $.post('info/update.action', {
//         'infoId': infoId,
//         'isTop': '1'
//     }, function (data) {
//         $.AMUI.progress.done();
//         $("#admin-content").html(data);
//     });
// }
//
// /* 取消置顶操作 */
// function cancelTopInfo(infoId) {
//     $.AMUI.progress.start();
//     $.post('info/update.action', {
//         'infoId': infoId,
//         'isTop': '0'
//     }, function (data) {
//         $.AMUI.progress.done();
//         $("#admin-content").html(data);
//     });
// }



/* 单个删除 */
function removeInfo(infoId) {
    if (window.confirm("您确定禁用这条组织吗？")) {
        $.AMUI.progress.start();
        $.post("origin/update.action", {
            'originId': infoId,
            'state': 'X'
        }, function (data) {
            $.AMUI.progress.done();

            $("#admin-content").html(data);
        });
    }
}

/* 批量删除 */
function removeInfos() {
    var infoIds = getIds();
    if (isValid(infoIds)) {
        if (window.confirm("您，确定删除这些数据？")) {
            $.AMUI.progress.start();
            $.post('origin/delete.action', {
                'originId': infoIds
            }, function (data) {
                $.AMUI.progress.done();
                $("#admin-content").html(data);
            });
        }
    }
}
/* 彻底删除 */
function deleteInfo(infoId) {
    if (isValid(infoId)) {
        if (window.confirm("您，确定要彻底删除这条数据？")) {
            $.AMUI.progress.start();
            $.post("origin/delete.action", {
                "originId": infoId
            }, function (data) {
                $.AMUI.progress.done();
                $("#admin-content").html(data);
            });
        }
    }
}



/* 恢复删除数据 */
function recoverInfo(infoId) {
    if (window.confirm("您，确定恢复这条数据吗？")) {
        $.AMUI.progress.start();
        $.post("origin/update.action", {
            "originId": infoId,
            'state': 'A'
        }, function (data) {
            $.AMUI.progress.done();
            $("#admin-content").html(data);

        });
    }
}

/* 恢复删除数据 */
function recoverInfos() {
    var infoIds = getIds();
    if (isValid(infoIds)) {
        if (confirm("您，确定恢复这些数据吗？")) {
            $.AMUI.progress.start();
            $.post("info/recoverInfos.action", {
                "infoIds": infoIds
            }, function (data) {
                $.AMUI.progress.done();
                $("#admin-content").html(data);
            });
        }
    }
}