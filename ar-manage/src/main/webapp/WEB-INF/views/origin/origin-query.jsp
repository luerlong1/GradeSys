<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/views/global/common-taglib.jsp" %>
<div class="layui-elem-quote overh" style="overflow: hidden;">
    <div class="fl" style="float: left;">组织管理</div>
        <%--<button class="layui-btn layui-btn-normal2 fr" style="float: right;" onclick="window.location.href='origin/add.action'"><img src="${pageContext.request.contextPath }/images/add.png">创建组织</button>--%>
</div>
<div class="am-g">
    <div class="am-u-md-9 am-cf">
        <div class="am-btn-group am-btn-group-xs">
             &nbsp;&nbsp;&nbsp;&nbsp;状态：
            <select id="state" class="dll-query">
                <option value="" name="state" selected>全部</option>
                <option value="A" name="state" >正常</option>
                <option value="X" name="state" >已删除</option>
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;年级：
            <select id="originGrade" class="dll-query">
                <option value="" <c:if test="${originGrade == ''}">selected</c:if>>全部</option>
                <c:forEach items="${grades}" var="grade">
                    <option value="${grade.value}"
                            <c:if test="${originGrade == grade.value}">selected</c:if>>${grade.value}</option>
                </c:forEach>
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;类型：
            <select id="originType" class="dll-query">
                <option value="" <c:if test="${originType == ''}">selected</c:if>>全部</option>
                <c:forEach items="${types}" var="type">
                    <option value="${type.value}"
                            <c:if test="${originType == type.value}">selected</c:if>>${type.name}</option>
                </c:forEach>
            </select>
                &nbsp;&nbsp;&nbsp;&nbsp;
                    <button class="am-btn am-btn-default" type="button"
                            onclick="removeInfos()">
                        <span class="am-icon-trash-o"></span> 批量禁用
                    </button>

        </div>
    </div>
    <div class="am-u-md-3 am-cf">
        <div class="am-fr">
            <div class="am-input-group am-input-group-sm">
                <input type="text" id="query" class="am-form-field"
                       placeholder="名称" value="${query}"
                       onkeypress="if(event.keyCode==13){'#queryBtn'.click();return false;}">
                <span class="am-input-group-btn">
					<button class="am-btn am-btn-default dll-query" type="button" onclick="queryOrigin(1,10)"
                            id="queryBtn">搜索</button>
				</span>
            </div>
        </div>
    </div>
</div>
<button id="_message" name="_message" type="hide"></button>
<div class="am-g">
    <div class="am-u-sm-12">
        <form class="am-form">
            <table class="am-table am-table-striped am-table-hover table-main am-table-bordered am-table-condensed">
                <thead>
                <tr>
                    <th class="table-check"><input type="checkbox" class="alls"/></th>
                    <th class="table-title">名称</th>
                    <th class="table-type">类型</th>
                    <th class="table-type">年级</th>
                    <th class="table-detail">成员数</th>
                    <th class="table-detail">管理员</th>
                    <th class="table-detail">近期活动</th>
                    <th class="table-detail">状态</th>
                    <th class="table-set">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${page.beanList != null}">
                    <c:forEach items="${page.beanList}" var="origin">
                        <tr>
                            <td><input type="checkbox" value="${origin.originId}"/></td>
                            <td>
                                <a href="origin/member.action?originId=${origin.originId}">${origin.originName}</a>
                            </td>
                            <td><ar:dictdata dictdata="${origin.originType}" dict="ot"></ar:dictdata></td>
                            <td>${origin.originGrade}</td>
                            <td>${origin.members}</td>
                            <td><a href="user/account.action?userId=${origin.mgrId}">${origin.mgrName}</a></td>
                            <td><fmt:formatDate value="${origin.stateTime}" pattern="YYYY-MM-dd HH:mm"></fmt:formatDate></td>
                            <%--<td><ar:dictdata dictdata="${origin.state}" dict="state"/></td>--%>
                            <td><c:if test="${origin.state=='A'}">正常</c:if><c:if test="${origin.state=='X'}">已禁用</c:if></td>
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <c:if test="${origin.state=='A'}">
                                            <button type="button"
                                                    onclick="javascript:removeInfo('${origin.originId}')"
                                                    class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                <span class="am-icon-trash-o"></span> 禁用
                                            </button>&nbsp;&nbsp;
                                            <button type="button"
                                                    onclick="window.location.href='origin/home.action?originId=${origin.originId}'"
                                                    class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                <span class="am-icon-edit"></span> 编辑
                                            </button>&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${origin.state=='X'}">
                                            <button type="button"
                                                    onclick="javascript:recoverInfo('${origin.originId}')"
                                                    class="am-btn am-btn-default am-btn-xs am-text-danger confirm">
                                                <i class="am-icon-recycle"></i> 恢复
                                            </button>
                                            <%--<button type="button"--%>
                                                    <%--onclick="javascript:deleteInfo('${origin.originId}')"--%>
                                                    <%--class="am-btn am-btn-default am-btn-xs am-text-danger confirm">--%>
                                                <%--<span class="am-icon-trash-o"></span> 彻底删除--%>
                                            <%--</button>--%>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${ empty page.beanList}">
                    <tr>
                        <td colspan="9" align="center">暂无信息</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
            <%--<%@ include file="/WEB-INF/views/global/page-size.jsp" %>--%>
            <%--&nbsp;&nbsp;--%>

            <!-- 页码 -->
            <%@ include file="/WEB-INF/views/global/page-index.jsp" %>
            <!-- 页面操作备注 -->
            <%@ include file="/WEB-INF/views/global/operate-remarks.jsp" %>
        </form>
    </div>
    <%--<!-- 操作说明 -->--%>
    <%--<%@ include file="/WEB-INF/views/global/operate-message.jsp" %>--%>
    <!-- 控制 js -->
    <script src="assets/script/origin/origin-query.js"></script>
</div>