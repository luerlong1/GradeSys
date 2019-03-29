<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>${ta.trueName}的主页-轻大校友汇</title>
    <%@ include file="/WEB-INF/views/portal-common/portal-meta.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/portal-common/header.jsp" %>
<div class="container higher" id="container">
    <div class="pageheader">
        <h2>
            <i class="fa fa-user"></i> 个人中心 <span>${ta.trueName}的主页</span>
        </h2>
        <div class="breadcrumb-wrapper">
            <span class="label"></span>
            <ol class="breadcrumb">
                <li><a href="index.action">首页</a></li>
                <li class="active">个人中心</li>
            </ol>
        </div>
    </div>
    <div class="mb5"></div>
    <div class="row">
        <div class="col-sm-3">
            <img src="${ta.portrait}" class="thumbnail img-responsive" alt=""/>

            <div class="mb30"></div>

            <h5 class="subtitle">关于${ta.trueName}</h5>
            <p class="mb30">${ta.introduce}</p>

            <h5 class="subtitle">联系方式</h5>
            <ul class="profile-social-list">
                <li><i class="fa fa-qq"></i> <a href="javascript:;">${ta.qq}</a></li>
                <li><i class="fa fa-wechat"></i> <a href="javascript:;">${ta.weChat}</a></li>
                <li><i class="fa fa-weibo"></i> <a href="javascript:;">${ta.microblog}</a></li>
                <li><i class="fa fa-phone"></i> <a href="javascript:;">${ta.phone}</a></li>
                <li><i class="fa fa-envelope-o"></i> <a href="javascript:;">${ta.email}</a></li>
            </ul>

            <div class="mb30"></div>

            <h5 class="subtitle">地址：</h5>
            <address>
                ${ta.address}<br>
            </address>

        </div><!-- col-sm-3 -->
        <div class="col-sm-9">

            <div class="profile-header">
                <h2 class="profile-name">${ta.trueName}</h2>
                <div class="profile-location"><i class="fa fa-map-marker"></i> ${ta.address}</div>
                <div class="profile-position"><i class="fa fa-briefcase"></i> ${userJobs.jobName} 任职于 <a href="">${userJobs.jobUnit}</a></div>
                
                <div class="mb20"></div>

                <button class="btn btn-success mr5"><i class="fa fa-user"></i> 关 注 </button>
                <button class="btn btn-white"><i class="fa fa-envelope-o"></i> 私 信 </button>
            </div><!-- profile-header -->

            <!-- Nav tabs -->
            <ul class="nav nav-tabs nav-justified nav-profile">
                <li class="active"><a href="#activities" data-toggle="tab"><strong>他的班级组织</strong></a></li>
                <li><a href="#followers" data-toggle="tab"><strong>他的论坛</strong></a></li>
                <li><a href="#following" data-toggle="tab"><strong>TA关注的</strong></a></li>
                <li><a href="#events" data-toggle="tab"><strong>TA的相关</strong></a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="activities">
                    <input hidden id="userId" value="${userId}">

                        <c:forEach items="${page1.beanList}" var="clazz">
                            <div class="col-md-6">
                                <div class="people-item">
                                    <div class="media">
                                        <a href="classroom.action?classId=${clazz.originId}" class="pull-left"
                                           style="color: black">
                                            <h1><i class="fa fa-mortar-board"></i></h1>
                                        </a>
                                        <div class="media-body">
                                            <a href="classroom.action?classId=${clazz.originId}" style="color: black">
                                                <h4 class="person-name">${clazz.originName}</h4>
                                            </a>
                                            <div class="text-muted">
                                                <i class="fa fa-users"></i>班级成员： ${clazz.members}
                                            </div>
                                            <div class="text-muted">
                                                <i class="fa fa-calendar"></i>最近活动：
                                                <fmt:formatDate value="${clazz.stateTime}"
                                                                pattern="YYYY-MM-dd"></fmt:formatDate>
                                            </div>
                                            <ul class="social-list">
                                                <c:if test="${clazz==null}">
                                                    <li><a href="javascript:;" class="tooltips" data-toggle="tooltip"
                                                           data-placement="top" title="手机："><i
                                                            class="fa fa-mobile"></i></a></li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- col-md-6 -->
                        </c:forEach>

                <%@include file="/WEB-INF/views/portal-common/originPagination.jsp"%>
                </div>

                <div class="tab-pane" id="followers">
                            <table class="table table-hover mb20">
                                <thead>
                                <tr>
                                    <th>帖子标题</th>
                                    <th>评论 / 浏览</th>
                                    <th>发布时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${page.beanList}" var="post">
                                    <tr>
                                        <td><ar:sub value="${post.infoTitle}" length="10"></ar:sub></td>
                                        <td>${post.comments} / ${post.views}</td>
                                        <td><fmt:formatDate value="${post.createTime}"
                                                            pattern="YYYY-MM-dd HH:mm"></fmt:formatDate></td>
                                        <td>
                                            <a class="btn btn-primary btn-xs" href="post/detail.action?postId=${post.infoId}">详情</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <%@include file="/WEB-INF/views/portal-common/originPagination.jsp"%>
                </div>
                <div class="tab-pane" id="following">

                </div>
                <div class="tab-pane" id="events">


                </div>
            </div><!-- tab-content -->

        </div><!-- col-sm-9 -->
    </div>
    <!-- row -->
</div>

<%@ include file="/WEB-INF/views/portal-common/footer.jsp" %>

</body>
<%@ include file="/WEB-INF/views/portal-common/portal-js.jsp" %>
<script src="assets/script/my/ta/ta-index.js"></script>
</html>