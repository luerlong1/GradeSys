<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/global/common-taglib.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <%@ include file="/WEB-INF/views/global/base-path.jsp" %>
    <title>${origin.originId}成员-后台管理</title>
    <%@ include file="/WEB-INF/views/global/manage-meta.jsp" %>
    <%@ include file="/WEB-INF/views/global/common-css.jsp" %>
</head>
<body>
<!-- header -->
<%--<%@ include file="/WEB-INF/views/global/header.jsp" %>--%>

<!-- 主管理区域 admin-main -->
<div class="am-cf admin-main">
    <!-- 侧边栏 side bar start -->
    <%--<div class="admin-sidebar">--%>
        <%--<%@ include file="/WEB-INF/views/global/sidebar.jsp" %>--%>
    <%--</div>--%>
    <!-- side bar end -->

    <!-- 内容区域 content start -->
    <div class="admin-content" id="admin-content">

        <div class="layui-elem-quote overh" style="overflow: hidden;">
            <div class="fl" style="float: left;">成员列表</div>
            <a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr" style="margin-left: 10px;"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>
        </div>

        <div class="am-tabs am-margin">
            <%--<ul class="am-tabs-nav am-nav am-nav-tabs">--%>
                <%--<li><a href="origin/home.action?originId=${origin.originId}">主页</a></li>--%>
                <%--<li class="am-active"><a href="javascript:;">成员</a></li>--%>
            <%--</ul>--%>
            <%--<br>--%>

            <div class="am-g">
                <form class="am-form">

                    <input hidden id="originId" value="${origin.originId}">

                    <table class="am-table am-table-striped am-table-hover table-main">
                        <thead>
                        <tr>
                            <th class="table-check"><input type="checkbox" class="alls"/></th>
                            <th class="table-title">成员名</th>
                            <th class="table-detail">加入时间</th>
                            <th class="table-detail">用户状态</th>
                            <th class="table-set">操作</th>
                        </tr>
                        </thead>
                 <tbody>
                        <c:if test="${page.beanList != null}">
                            <c:forEach items="${page.beanList}" var="member">
                                <tr>
                                    <td><input type="checkbox" value="${member.userId}"/></td>
                                    <td>
                                        <a href=""
                                           target="blank">${member.trueName}</a>
                                        <c:if test="${member.userId == origin.mgrId}">
                                            &nbsp;<span class="am-badge am-badge-success">管理员</span>
                                        </c:if>
                                    </td>
                                    <td><fmt:formatDate value="${origin.stateTime}"
                                                        pattern="YYYY-M-d HH:mm:ss"></fmt:formatDate></td>
                                    <td><c:if test="${member.state=='A'}">正常</c:if><c:if test="${member.state=='X'}">已禁用</c:if></td>
                                    <td>
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <c:if test="${member.userId != origin.mgrId && member.state=='X'}">
                                                    <button type="button"
                                                            onclick="javascript:removeMember('${member.userId}')"
                                                            class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                        <span class="am-icon-trash-o"></span> 移除
                                                    </button>
                                                </c:if>
                                                <c:if test="${member.userId != origin.mgrId && member.state=='A'}">
                                                    <button type="button"
                                                            onclick="javascript:setManager('${member.userId}')"
                                                            class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                        <span class="am-icon-recycle"></span> 设为管理员
                                                    </button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                         <c:if test="${ empty page.beanList}">
                             <tr>
                                 <td colspan="5" align="center">暂无信息</td>
                             </tr>
                         </c:if>
                        </tbody>
                    </table>
                    <!-- 页码 -->
                    <%@ include file="/WEB-INF/views/global/page-index.jsp" %>
                    <!-- 页面操作备注 -->
                    <%@ include file="/WEB-INF/views/global/operate-remarks.jsp" %>
                </form>
            </div>
        </div>
        <!-- content end -->
    </div>
</div>

<%--<!-- footer -->--%>
<%--<%@ include file="/WEB-INF/views/global/footer.jsp" %>--%>
<%@ include file="/WEB-INF/views/global/operate-message.jsp" %>
<!-- 控制js -->
<%@ include file="/WEB-INF/views/global/common-js.jsp" %>
<script src="assets/script/origin/origin-home-member.js"></script>
</body>
</html>

