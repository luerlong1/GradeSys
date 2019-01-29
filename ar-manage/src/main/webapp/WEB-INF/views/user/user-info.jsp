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
				<div class="fl">用户信息</div>
				<a href="javascript:history.back(-1)" id="aBlack" style="display: none;" class="layui-btn layui-btn-normal fr"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>
			</div>

			<form id="changepwd" method="post" class="layui-form" action="/set/doChangePwd">

				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>校友姓名：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						${adUser.trueName}
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>账号：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						${adUser.account}
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>邮箱地址：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						${adUser.email}
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>角色：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<c:if test="${adUser.isAdmin == 0}">前台用户</c:if>
						<c:if test="${adUser.isAdmin == 1}">后台用户</c:if>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>当前状态：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<c:if test="${adUser.state=='A'}">正常</c:if>
						<c:if test="${adUser.state=='X'}">已禁用</c:if>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>介绍：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						${adUser.introduce}
					</div>
				</div>



			</form>
		</div>
	<script>
		//  获取url中的参数
		(function($) {
			$.getUrlParam = function(name) {
				var reg = new RegExp("(^|&)" +
					name + "=([^&]*)(&|$)");
				var r = window.location.search.substr(1).match(reg);
				if(r != null) return unescape(r[2]);
				return null;
			}
		})(jQuery);
		$(function(){
			//接收id
			if($.getUrlParam('zc') == '2'){
			    $("#aBlack").css('display','block')
			}
		})
	</script>
	</body>

</html>