<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>益简单crm管理系统-修改密码</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp">
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/Validform_v5.3.2_min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.cookie.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js"></script>
</head>

<body>
<div class="layui-anim layui-anim-up body-main">
	<div class="layui-elem-quote clearfix">
		<div class="fl">修改密码</div>
		<%--<a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr"><img src="/images/back.png">返回</a>--%>
	</div>

	<form id="changepwd" method="post" class="layui-form">
		<input hidden name="account" value="${adUser.account}"/>
		<input hidden name="userId" value="${adUser.userId}"/>
		<div class="layui-form-item">
			<label class="layui-form-label"><span class="cfc"> * </span>校友名称：</label>
			<div class="layui-input-inline" style="line-height: 38px;">
				${adUser.trueName}
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label"><span class="cfc"> * </span>邮箱：</label>
			<div class="layui-input-inline" style="line-height: 38px;">
				${adUser.email}
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label"><span class="cfc"> * </span>旧密码：</label>
			<div class="layui-input-inline">
				<input type="password" name="oldpwd" class="layui-input" datatype="*8-16" nullmsg="请输入旧密码" errormsg="密码必须由 8-16位字母和数字组成" placeholder="请输入旧密码">
			</div>
			<input id="userId" name="userId" value="${adUser.id}" type="hidden">

		</div>
		<div class="layui-form-item">
			<label class="layui-form-label"><span class="cfc"> * </span>新密码：</label>
			<div class="layui-input-inline">
				<input type="password" name="password" class="layui-input"  datatype="/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/" nullmsg="请输入新密码" errormsg="密码必须由 8-16位字母和数字组成" placeholder="请输入新密码">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label"><span class="cfc"> * </span>确认密码：</label>
			<div class="layui-input-inline">
				<input class="layui-input" id="newPassword" type="password" name="newPassword" datatype="/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/" recheck="password" errormsg="您两次输入的密码不一致！" nullmsg="请再次输入新密码" placeholder="再次输入新密码">
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" type="submit">提交</button>
			</div>
		</div>
	</form>
</div>
<script>
    layui.use('form', function() {
        var form = layui.form;
    });

    $(function(){
        //表单提交
        $('#changepwd').Validform({
            tipSweep:true,
            tiptype: function (msg, o, cssctl) {
                if (o.type === 3)
                    layer.msg(msg);
                return false;
            },
            beforeSubmit: function () {
                var userId = ${adUser.userId};
                $.post('/user/changePwd.action', $('#changepwd').serialize(), function (data) {
                    if (data.code==0 ) {
							layer.msg("修改成功，请重新登录",{time:2*1000},function() {
								window.location.href="/login/logout.action";
							});
                    } else {
                        layer.msg(data.message);
                        return false;
                    }
                });
                return false;
            }
        });
    });
</script>
</body>
</html>