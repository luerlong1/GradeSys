<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>轻大校友汇管理系统-欢迎页面</title>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"/>
    </head>
    <body>
	    <div class="x-body layui-anim layui-anim-up">
			<h1 class="welcoming">欢迎登录轻大校友汇管理系统</h1>
	    </div>
		<script src="${pageContext.request.contextPath }/js/jquery-2.0.3.min.js"></script>
	    <script src="${pageContext.request.contextPath }/lib/layui/layui.all.js"></script>
		<script>

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