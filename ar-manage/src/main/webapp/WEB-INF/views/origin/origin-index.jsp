<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/WEB-INF/views/global/base-path.jsp"%>
<title>班级 / 校友组织-后台管理</title>
<%@ include file="/WEB-INF/views/global/manage-meta.jsp"%>
<%@ include file="/WEB-INF/views/global/common-css.jsp"%>
</head>
<body>
	<!-- 主管理区域 admin-main -->
	<div class="am-cf admin-main">
		<!-- 内容区域 content start -->
		<div class="admin-content" id="admin-content"></div>
		<!-- content end -->
	</div>
    <%@ include file="/WEB-INF/views/global/operate-message.jsp" %>
	<!-- 控制js -->
	<%@ include file="/WEB-INF/views/global/common-js.jsp"%>
	<script src="assets/script/origin/origin-index.js"></script>
    <%--<script src="../../assets/script/origin/origin-query.js"></script>--%>
</body>
</html>