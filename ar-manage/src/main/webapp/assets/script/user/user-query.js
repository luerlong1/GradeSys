$(function () {
    /* 翻页页码绑定查询器 必须绑定，否则页码无效 */
    _pageBond(queryUser);

});

/* 条件查询 *//* 查询函数可以有多个参数，pageIndex要是第一个 */
function queryUser(pageIndex, pageSize) {
    /* loading进度条 */
    $.AMUI.progress.start();
    var query = $("#query").val();
    var state = $("#state").val();
    var isAdmin = $('#isAdmin').val();
    $.post('user/queryUser.action', {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "query": query,
        "state": state,
        "isAdmin": isAdmin
    }, function (data) {
        $.AMUI.progress.done();
        $("#admin-content").html(data);
    });
}
//
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

// /* 审核操作 */
// function auditInfo(infoId) {
//     $.AMUI.progress.start();
//     $.post('info/update.action', {
//         'infoId': infoId,
//         'state': 'A'
//     }, function (data) {
//         $.AMUI.progress.done();
//         $("#admin-content").html(data);
//     });
// }
//
// /* 批量审核操作 */
// function auditInfos() {
//     var infoIds = getIds();
//     if (isValid(infoIds)) {
//         $.AMUI.progress.start();
//         $.post('info/update.action', {
//             "recruitIds": recruitIds
//         }, function (data) {
//             $.AMUI.progress.done();
//             $("#admin-content").html(data);
//         });
//     }
// }

/* 删除 */
function removeInfo(userId) {
    if (window.confirm("您，确定禁用该用户吗？")) {
        $.AMUI.progress.start();
        $.post("user/update.action", {
            'userId': userId,
            'state': 'X'
        }, function (data) {
            $.AMUI.progress.done();
            _alert_messgae('禁用成功', 100, 1);
            queryUser(1,10);
        });
    }
}

/* 批量禁用 */
function removeInfos() {
    var userIds = getIds();
    if (isValid(userIds)) {
        if (window.confirm("您确定禁用这些数据？")) {
            $.AMUI.progress.start();
            $.post('user/delete.action', {
                'userIds': userIds
            }, function (data) {
                $.AMUI.progress.done();
                _alert_messgae('批量禁用成功', 100, 1);
                queryUser(1, 10);
            });
        }
    }
}
/*添加用户*/
function addUser() {
    var account = $("#account").val();
    var email = $("#email").val();
    var introduce = $('#introduce').val();
    var isAdmin = $('#isAdmin').val();
    var trueName = $('#trueName').val();
    if (window.confirm("您，确定恢复这条数据吗？")) {
        $.AMUI.progress.start();
        $.post("user/addUser.action", {
            "account": account,
            "introduce": introduce,
            "isAdmin": isAdmin,
            "trueName": trueName,
            "password": 'zzuli123456',
            'email': email
        }, function (data) {
            $.AMUI.progress.done();
            _alert_messgae('添加成功', 100, 2);
            queryUser(1,10);
        });
    }
}
/* 恢复删除数据 */
function recoverInfo(infoId) {
    if (window.confirm("您，确定恢复这条数据吗？")) {
        $.AMUI.progress.start();
        $.post("user/update.action", {
            "userId": infoId,
            'state': 'A'
        }, function (data) {
            $.AMUI.progress.done();
            _alert_messgae('恢复成功', 100, 1);
            queryUser(1,10);
        });
    }
}
// /* 彻底删除 */
// function deleteInfo(infoId) {
//     if (isValid(infoId)) {
//         if (window.confirm("您，确定要彻底删除这条数据？")) {
//             $.AMUI.progress.start();
//             $.post("info/delete.action", {
//                 "infoId": infoId
//             }, function (data) {
//                 $.AMUI.progress.done();
//                 $("#admin-content").html(data);
//             });
//         }
//     }
// }

// /* 批量删除 */
// function deleteInfos() {
//     var infoIds = getIds();
//     if (isValid(infoIds)) {
//         if (window.confirm("您，确定彻底删除这些数据？")) {
//             $.AMUI.progress.start();
//             $.post("info/deleteInfos.action", {
//                 "infoIds": infoIds
//             }, function (data) {
//                 $.AMUI.progress.done();
//                 $("#admin-content").html(data);
//             });
//         }
//     }
// }



/* 恢复删除数据 */
// function recoverInfos() {
//     var infoIds = getIds();
//     if (isValid(infoIds)) {
//         if (confirm("您，确定恢复这些数据吗？")) {
//             $.AMUI.progress.start();
//             $.post("info/recoverInfos.action", {
//                 "infoIds": infoIds
//             }, function (data) {
//                 $.AMUI.progress.done();
//                 $("#admin-content").html(data);
//             });
//         }
//     }
// }