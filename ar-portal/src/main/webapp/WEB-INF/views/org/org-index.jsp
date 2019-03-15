<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/views/portal-common/portal-tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>校友组织-轻大校友汇</title>
    <%@ include file="/WEB-INF/views/portal-common/portal-meta.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/portal-common/header.jsp" %>

<%@ include file="/WEB-INF/views/portal-common/navmenu.jsp" %>

<div class="container higher" id="container">
    <section>
        <!-- 导航栏 -->
        <div class="header">
            <ol class="breadcrumb">
                <li><i class="fa fa-home"></i>&nbsp;<a href="index.action">主页</a></li>
                <li class="active">校友组织</li>
            </ol>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <%@include file="/WEB-INF/views/org/org-tab.jsp" %>
                <div id="bloglist" class="row" style="position: relative;">
                    <c:forEach items="${orgZongHius}" var="orgZongHiu">
                        <div class="col-sm-3">
                            <div class="blog-item">
                                <div class="blog-details">
                                    <h5 class="blog-title">
                                        <a href="orgroom.action?originId=${orgZongHiu.originId}">
                                            <i class="fa fa-users"></i> <ar:sub length="10" value="${orgZongHiu.originName}" /></a>
                                    </h5>
                                    <ul class="blog-meta">
                                        <li>最近活动：<fmt:formatDate value="${orgZongHiu.stateTime}" pattern="YYYY-MM-dd"></fmt:formatDate></li>
                                        <li>成员：<a href="orgroom.action?originId=${orgZongHiu.originId}">${orgZongHiu.members}</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-sm-3" id="org-outline">
                <img src="assets/images/icon/loading/loader.gif" class="center-block">
            </div>
        </div>
    </section>
</div>

<%@ include file="/WEB-INF/views/portal-common/footer.jsp" %>

</body>
<%@ include file="/WEB-INF/views/portal-common/portal-js.jsp" %>
<script>
    $(function() {
        $("#nav-org").attr("class", "active");
        $("#org-tab-li-org").attr("class", "active");
        // 加载outline信息
        $.post("org/outline.action?originType=org", function(data) {
            $("#org-outline").html(data);
        });
    });
</script>
</html>