<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>益简单crm管理系统</title>
		<meta name="renderer" content="webkit|ie-comp|ie-stand">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Cache-Control" content="no-siteapp">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/Validform_v5.3.2_min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.cookie.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js"></script>
	</head>
	<style>
		#addUser{
			margin-bottom: 200px;
		}
	</style>
	<body>
		<div class="layui-anim layui-anim-up body-main">
			<div class="layui-elem-quote clearfix">
				<div class="fl">添加成员</div>
				<%--<a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>--%>
			</div>

			<form id="addUser" method="post" class="layui-form">
			<div id="inputWidth">
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>校友名称：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="trueName" id="trueName" class="layui-input" datatype='a0-z' errormsg="请输入正确的姓名格式" nullmsg="请填写成员姓名" placeholder="请填写成员姓名">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>登录名：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="account" id="account" class="layui-input" id="accountGl" datatype='a1-z' errormsg="登录账号仅支持6-30位" nullmsg="请设置登录账号" placeholder="请设置登录账号">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>邮箱地址：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="email" id="email" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>设置角色：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<select name="isAdmin" id="isAdmin">
							<option value="" selected>请选择</option>
							<option value="1">管理员</option>
							<option value="0">前台用户</option>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>介绍：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="introduce" id="introduce" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" type="" onclick="javascript:addUser()">提交</button>
					</div>
				</div>
			</div>
			</form>
		</div>
		<script type="text/javascript" src="../../assets/script/user/user-query.js"></script>

		<script>
            layui.use('form', function() {
                var form = layui.form;
				//动态添加下拉列表
				<%--function XIALIA() {--%>

					<%--$.ajax({--%>
						<%--url: '${pageContext.request.contextPath }/role/getRoleSelect',--%>
						<%--dataType: 'json',--%>
						<%--type: 'get',--%>
						<%--success: function (data) {--%>
                            <%--$('#roleId').append('');--%>
							<%--$.each(data.adUserRoleList, function (index, item) {--%>
								<%--$('#roleId').append(new Option(item.roleName, item.id));--%>
							<%--})--%>
                            <%--form.render();--%>
						<%--}--%>
					<%--})--%>
				<%--}--%>
                $(function () {
                    XIALIA();
                })
            });
            $(function(){

                //表单提交
                $('#addUser').Validform({
                    tipSweep:true,
                    tiptype: function (msg, o, cssctl) {
                        if (o.type === 3)
                            layer.msg(msg);
                        return false;
                    },
					datatype:{
                        "a0-z": /^[a-zA-Z0-9\u4E00-\u9FA5\uf900-\ufa2d]{1,30}$/,
                        "a1-z": /^[a-zA-Z0-9\u4E00-\u9FA5\uf900-\ufa2d]{6,15}$/
                    },
                    <%--beforeSubmit: function () {--%>
                        <%--var roleId = $("#roleId").val();--%>
                        <%--if(roleId==""){--%>
                            <%--layer.msg("请选择角色！");--%>
                            <%--return false;--%>
						<%--}--%>
                        <%--$.post('${pageContext.request.contextPath }/set/updateUserInfo', $('#addUser').serialize(), function (data) {--%>
                            <%--if (data.code==0) {--%>
                                <%--layer.msg(data.message,{time:3*1000},function() {--%>
									<%--window.location.href='${pageContext.request.contextPath }/set/userManage';--%>
                                <%--});--%>
                            <%--} else {--%>
                                <%--layer.msg(data.message);--%>
                                <%--if(data.message == '登录名已经存在！'){--%>
                                    <%--$("#accountGl").focus();--%>
                                <%--}else {--%>
                                    <%--$("#phoneGl").focus();--%>
                                <%--}--%>

                            <%--}--%>
                        <%--});--%>
                        <%--return false;--%>
                    <%--}--%>
				});
            });

		</script>
	</body>

</html>