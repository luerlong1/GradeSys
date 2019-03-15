$(function () {
    /* 翻页页码绑定查询器 必须绑定，否则页码无效 */
    _pageBond(queryInfo);

});

/* 条件查询 *//* 查询函数可以有多个参数，pageIndex要是第一个 */
function queryInfo(pageIndex, pageSize) {
    /* loading进度条 */
    $.AMUI.progress.start();
    var query = $("#query").val();
    var state = $("#state").val();
    var infoType = $('#infoType').val();
    $.post("info/queryInfo.action", {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "query": query,
        "state": state,
        "infoType": infoType
    }, function (data) {
        $.AMUI.progress.done();
        $("#admin-content").html(data);
    });
}

/* 置顶操作 */
function setTopInfo(infoId) {
    if (window.confirm("您确定置顶吗？")) {
        $.AMUI.progress.start();
        $.post('info/update.action', {
            'infoId': infoId,
            'isTop': '1'
        }, function (data) {
            $.AMUI.progress.done();
            $("#admin-content").html(data);
            _alert_messgae('顶置成功', 100, 1);
            queryInfo(1, 10);
        });
    }
}

/* 取消置顶操作 */
function cancelTopInfo(infoId) {
    if (window.confirm("您确定取消置顶吗？")) {
        $.AMUI.progress.start();
        $.post('info/update.action', {
            'infoId': infoId,
            'isTop': '0'
        }, function (data) {
            $.AMUI.progress.done();
            $("#admin-content").html(data);
            _alert_messgae('取消顶置成功', 100, 1);
            queryInfo(1, 10);
        });
    }
}


/* 批量审核操作 */
function auditInfos() {
    var infoIds = getIds();
    if (isValid(infoIds)) {
        $.AMUI.progress.start();
        $.post('info/update.action', {
            "recruitIds": recruitIds
        }, function (data) {
            $.AMUI.progress.done();
            $("#admin-content").html(data);
        });
    }
}

/* 删除 */
function removeInfo(infoId) {
    if (window.confirm("您，确定删除这条数据？")) {
        $.AMUI.progress.start();
        $.post("info/update.action", {
            'infoId': infoId,
            'state': 'X'
        }, function (data) {
            $.AMUI.progress.done();
            $("#admin-content").html(data);
            _alert_messgae('删除成功', 100, 1);
            queryInfo(1, 10);
        });
    }
}

/* piliang 删除 */
function removeInfos() {
    var infoIds = getIds();
    if (isValid(infoIds)) {
        if (window.confirm("您，确定删除这些数据？")) {
            $.AMUI.progress.start();
            $.post('info/removeInfos.action', {
                'infoIds': infoIds
            }, function (data) {
                $.AMUI.progress.done();
                _alert_messgae('批量删除成功', 100, 1);
                queryInfo(1, 10);
            });
        }
    }
}

/* 恢复删除数据 */
function recoverInfo(infoId) {
    if (window.confirm("您，确定恢复这条数据吗？")) {
        $.AMUI.progress.start();
        $.post("info/update.action", {
            "infoId": infoId,
            'state': 'A'
        }, function (data) {
            $.AMUI.progress.done();
            //$("#admin-content").html(data);
            _alert_messgae('恢复成功', 100, 1);
            queryInfo(1, 10);
        });
    }
}
