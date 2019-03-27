<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/views/portal-common/portal-tag.jsp" %>


<h3 class="subtitle">热门新闻</h3>
<ul class="folder-list">
    <c:forEach items="${hotNews}" var="hot">
        <li>
            <div class="media">

                <div class="media-body" style="max-height: 40px;">
                    <a class="email-summary" href="news/detail.action?infoId=${hot.infoId}">
                        <ar:sub value="${hot.infoTitle}" length="20"></ar:sub>
                    </a>
                    <small class="text-muted">
                        发布于 ： <fmt:formatDate value="${hot.createTime}" pattern="yyyy-MM-dd"/>
                    </small>
                    <a class="email-summary" href="news/detail.action?infoId=${hot.infoId}">
                        <ar:sub value="${hot.content}" length="18"></ar:sub>
                    </a>
                </div>
            </div>
        </li>
    </c:forEach>
</ul>
