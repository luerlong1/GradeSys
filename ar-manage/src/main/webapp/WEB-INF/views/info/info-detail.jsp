<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>益简单业务管理平台-发布的活动详情</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.9,target-densitydpi=low-dpi">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"/>
</head>
<body id="activeListDetBox">
<div class="layui-anim layui-anim-up body-main">
        <c:if test="${info.infoType=='BBS' || info.infoType=='AN'}">
    <div class="layui-elem-quote overh">
        <div class="fl">新闻帖子信息详情</div>
        <a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr" style="margin-left: 10px;"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>
    </div>
    <form class="layui-form" action="">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>新闻/帖子详情</legend>
        </fieldset>
        <div class="layui-form-item">
            <label class="layui-form-label">标题：</label>
            <div class="layui-input-block">
                ${info.infoTitle}
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">主题：</label>
            <div class="layui-input-block">
                <c:if test="${info.theme=='t'}">旅游</c:if>
                <c:if test="${info.theme=='j'}">就业</c:if>
                <c:if test="${info.theme=='yt'}">研讨</c:if>
                <c:if test="${info.theme=='gra'}">毕业</c:if>
                <c:if test="${info.theme=='job'}">工作</c:if>
                <c:if test="${info.theme=='an'}">校友</c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型：</label>
            <div class="layui-input-block">
                <c:if test="${info.infoType=='BBS'}">帖子论坛</c:if>
                <c:if test="${info.infoType=='AN'}">校友新闻</c:if>

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否顶置：</label>
            <div class="layui-input-block">
                <c:if test="${info.isTop==1}">是</c:if>
                <c:if test="${info.isTop==0}">否</c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态：</label>
            <div class="layui-input-block">
                <c:if test="${info.state=='X'}">已关闭</c:if>
                <c:if test="${info.state=='A'}">正常</c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">浏览量：</label>
            <div class="layui-input-block">
                ${info.views}
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">点赞量：</label>
            <div class="layui-input-block">
                ${info.loves}
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">评论数：</label>
            <div class="layui-input-block">
                ${info.comments}
            </div>
        </div>
        </c:if>
        <c:if test="${info.infoType!='BBS' || info.infoType!='AN'}">
            <div class="layui-elem-quote overh">
                <div class="fl">留言详情</div>
                <a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr" style="margin-left: 10px;"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>
            </div>
        <fieldset class="layui-elem-field layui-field-title">
            <legend>留言详情</legend>
        </fieldset>
        </c:if>
        <div class="layui-form-item">
            <label class="layui-form-label">发布时间：</label>
            <div class="layui-input-block">
                <fmt:formatDate value='${info.createTime}' pattern='yyyy-MM-dd HH:mm'/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发布方：</label>
            <div class="layui-input-block">
                ${publisher}
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">内容：</label>
            <div class="layui-input-block">
                <span style="font-size:16px;"><p>${info.content}</p></span>
            </div>
        </div>
    </form>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js" ></script>
<script src="${pageContext.request.contextPath }/lib/layui/layui.all.js" charset="utf-8"></script>
</body>
</html>