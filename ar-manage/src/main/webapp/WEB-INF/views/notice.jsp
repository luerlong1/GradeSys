<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>益简单crm管理系统-欢迎页面</title>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"/>
    </head>
    <body>
	    <div class="x-body layui-anim layui-anim-up">
			<h1 class="welcoming">欢迎登录益简单CRM信息管理平台</h1>
	    	<%--<fieldset class="layui-elem-field">--%>
            	<%--<legend>数据统计</legend>--%>
	            <%--<div class="layui-field-box">--%>
	                <%--<div class="layui-col-md12">--%>
	                    <%--<div class="layui-card">--%>
	                        <%--<div class="layui-card-body">--%>
	                            <%--<div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">--%>
	                                <%--<div carousel-item="">--%>
	                                    <%--<ul class="layui-row layui-col-space10 layui-this">--%>

	                                        <%--<li class="layui-col-xs4">--%>
	                                            <%--<a href="javascript:;" onclick="openInfo()" class="x-admin-backlog-body">--%>
	                                                <%--<h3>公益资讯</h3>--%>
	                                                <%--<p><cite>${totalPublicCount}</cite></p>--%>
	                                            <%--</a>--%>
	                                        <%--</li>--%>

	                                        <%--<li class="layui-col-xs4">--%>
	                                            <%--<a href="javascript:;" onclick="openPolicy()" class="x-admin-backlog-body">--%>
	                                                <%--<h3>政策导向</h3>--%>
	                                                <%--<p>--%>
	                                                    <%--<cite>${totalPolicyCount}</cite></p>--%>
	                                            <%--</a>--%>
	                                        <%--</li>--%>

	                                        <%--<li class="layui-col-xs4">--%>
	                                            <%--<a href="javascript:;" onclick="openNotice()" class="x-admin-backlog-body">--%>
	                                                <%--<h3>通知公告</h3>--%>
	                                                <%--<p>--%>
	                                                    <%--<cite>${totalNoticeCount}</cite></p>--%>
	                                            <%--</a>--%>
	                                        <%--</li>--%>

	                                    <%--</ul>--%>
	                                <%--</div>--%>
	                            <%--</div>--%>
	                        <%--</div>--%>
	                    <%--</div>--%>
	                <%--</div>--%>
	            <%--</div>--%>
	        <%--</fieldset>--%>
	    </div>
		<script src="${pageContext.request.contextPath }/js/jquery-2.0.3.min.js"></script>
	    <script src="${pageContext.request.contextPath }/lib/layui/layui.all.js"></script>
		<script>
////询问框
//
//layer.confirm('您是如何看待前端开发？', {
//btn: ['重要','奇葩'] //按钮
//}, function(){
//layer.msg('的确很重要', {icon: 1});
//}, function(){
//layer.msg('也可以这样', {
//  time: 20000, //20s后自动关闭
//  btn: ['明白了', '知道了']
//});
//});

function openInfo(){
    parent.openInfo();
}
function openNotice(){
    parent.openNotice();
}
function openPolicy(){
    parent.openPolicy();
}
		</script>
    </body>
</html>