$(function () {
    // system side bar 打开
    $("#origin-manage").attr("class", "am-list am-collapse admin-sidebar-sub am-in");
});

/**
 * TODO 发布信息表单校验
 */
function saveOrigin() {
    if (!isLength($('#originName').val(), 4, 20)) {
        errMsg('originName', '组织名称在4-20字符之间');
        return false;
    }else if (!isValid($('#originType').val())) {
        errMsg('originType', '组织类型不为空！');
        return false;
    } else {
        // 新建组织类型为班级时，校验年级
        if ($('#originType').val() == 'C') {
            if (!isValid($('#originGrade').val())) {
                errMsg('originGrade', '年级不能为空');
                return false;
            }
            else {
                $('#origin-form').submit();
            }
        }
        else {
            $('#origin-form').submit();
        }
    }
}