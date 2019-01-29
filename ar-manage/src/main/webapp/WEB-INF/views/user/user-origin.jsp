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
            <div class="fl" style="float: left;">组织列表</div>
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



                    <table class="am-table am-table-striped am-table-hover table-main">
                        <thead>
                        <tr>
                            <th class="table-title">名称</th>
                            <th class="table-type">类型</th>
                            <th class="table-detail">成员数</th>
                            <th class="table-detail">管理员</th>
                            <th class="table-detail">近期活动</th>
                            <th class="table-detail">组织状态</th>
                            <th class="table-set">操作</th>
                        </tr>
                        </thead>
                 <tbody>
                        <c:if test="${page.beanList != null}">
                            <c:forEach items="${page.beanList}" var="origin">
                                <tr>
                                    <td>
                                        ${origin.originName}
                                    </td>
                                    <td><ar:dictdata dictdata="${origin.originType}" dict="ot"></ar:dictdata></td>
                                    <td>${origin.members}</td>
                                    <td>${origin.trueName}</td>
                                    <td><fmt:formatDate value="${origin.stateTime}" pattern="YYYY-MM-dd HH:mm"></fmt:formatDate></td>
                                        <%--<td><ar:dictdata dictdata="${origin.state}" dict="state"/></td>--%>
                                    <td><c:if test="${origin.state=='A'}">正常</c:if><c:if test="${origin.state=='X'}">已禁用</c:if></td>
                                    <td>
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <c:if test="${origin.state=='X'}">
                                                    <input hidden id="originId" value="${origin.originId}">
                                                <button type="button"
                                                        onclick="javascript:removeMember('${origin.userId}')"
                                                        class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                    <i class="am-icon-recycle"></i> 退出q${origin.originId}${origin.userId}
                                                </button>
                                                </c:if>
                                                <%--<c:if test="${origin.state=='A'}">--%>
                                                    <%--<button type="button"--%>
                                                            <%--onclick="javascript:removeInfo('${origin.originId}')"--%>
                                                            <%--class="am-btn am-btn-default am-btn-xs am-text-danger confirm">--%>
                                                        <%--<span class="am-icon-trash-o"></span> 禁用${origin.originId}--%>
                                                    <%--</button>&nbsp;&nbsp;--%>
                                                    <%--<button type="button"--%>
                                                            <%--onclick="window.location.href='origin/home.action?originId=${origin.originId}'"--%>
                                                            <%--class="am-btn am-btn-default am-btn-xs am-text-danger confirm">--%>
                                                        <%--<span class="am-icon-edit"></span> 编辑${origin.originId}--%>
                                                    <%--</button>&nbsp;&nbsp;--%>
                                                <%--</c:if>--%>
                                                <%--<c:if test="${origin.state=='X'}">--%>
                                                    <%--<button type="button"--%>
                                                                     <%--onclick="javascript:recoverInfo('${origin.originId}')"--%>
                                                                     <%--class="am-btn am-btn-default am-btn-xs am-text-danger confirm">--%>
                                                    <%--<i class="am-icon-recycle"></i> 恢复q${origin.originId}--%>
                                                <%--</button>--%>
                                                    <%--<button type="button"--%>
                                                    <%--onclick="javascript:deleteInfo('${origin.originId}')"--%>
                                                    <%--class="am-btn am-btn-default am-btn-xs am-text-danger confirm">--%>
                                                    <%--<span class="am-icon-trash-o"></span> 彻底删除--%>
                                                    <%--</button>--%>
                                                <%--</c:if>--%>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                         <c:if test="${ empty page.beanList}">
                             <tr>
                                 <td colspan="8" align="center">暂无信息</td>
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

