<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>益简单crm管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/Validform_v5.3.2_min.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.cookie.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js"></script>
</head>
<style>
    #addUser{
        margin-bottom: 200px;
    }
</style>
<body>
<div class="layui-anim layui-anim-up body-main">
    <div class="layui-elem-quote clearfix">
        <div class="fl">发布新闻</div>
        <%--<a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>--%>
    </div>

    <form id="info-form" method="post" action="/info/save.action" class="layui-form">
        <div id="inputWidth">
            <div class="layui-form-item">
                <span class="cfc">${error}</span>
                <label class="layui-form-label"><span class="cfc"> * </span>新闻标题：</label>
                <div class="layui-input-block" style="line-height: 38px;">
                    <input name="infoTitle" id="infoTitle" class="layui-input"  required placeholder="请输入组织名称">
                    <span id="" style="color: #fc3a3a"></span></div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><span class="cfc"> * </span>是否顶置：</label>
                <div class="layui-input-block" style="line-height: 38px;">
                    <%--<input name="isTop" id="isTop" class="layui-input"  required placeholder="请输入组织名称">--%>
                    <input type="radio" name="isTop" lay-filter="signUpRadio" value="1" title="是" checked>
                    <input type="radio" name="isTop" lay-filter="signUpRadio" value="0" title="否" >
                    <span id="qw" style="color: #fc3a3a"></span></div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><span class="cfc"> * </span>类型：</label>
                <div class="layui-input-block" style="line-height: 38px;">
                    <select name="infoType" id="infoType" required>
                        <option value="">请选择...</option>

                            <c:forEach items="${infoTypes}" var="type">
                                <option value="${type.value}"
                            <c:if test="${type.value == 'AN'}">selected</c:if>>${type.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><span class="cfc"> * </span>主题：</label>
                <div class="layui-input-block" style="line-height: 38px;">
                    <select name="infoTheme" id="theme" required>
                        <option value="">请选择...</option>
                        <c:forEach items="${infoThemes}" var="the">
                            <option value="${the.value}">${the.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <lael class="layui-form-label"><span class="cfc">  </span>内容：</lael>
                <div class="layui-input-block" style="line-height: 38px;">
                    <textarea name="content" id="content" class="layui-input" required></textarea>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" type="submit" id="btn">提交</button>
            </div>
        </div>
    </form>
</div>
<input type="hidden" id="_message"
       <c:if test="${_message != null && _message != ''}">value="${_message}"</c:if>>


<script type="text/javascript">
    /**
     * 浮动DIV定时显示提示信息,如操作成功, 失败等
     * @param string
     *            _messgae (提示的内容)
     * @param int
     *            height 显示的信息距离浏览器顶部的高度
     * @param int
     *            time 显示的时间(按秒算), time > 0
     * @sample <a href="javascript:void(0);" onclick="_alert_messgae( '操作成功', 100, 3
     *         );">点击</a>
     * @sample 上面代码表示点击后显示操作成功3秒钟, 距离顶部100px
     * @copyright Mr.Black 2015-12-28
     */
    function _alert_messgae(_messgae, height, time) {
        var windowWidth = document.documentElement.clientWidth;
        var tipsDiv = '<div class="_message-class">&nbsp;&nbsp;' + _messgae
            + '&nbsp;&nbsp;</div>';
        $('body').append(tipsDiv);
        $('div._message-class').css({
            'position': 'absolute',
            'top': height + 'px',
            'left': ((windowWidth / 2) - (_messgae.length) * 13) + 'px',
            'padding': '3px 5px',
            'background': '#8FCCFF',
            'font-size': 14 + 'px',
            'margin': '0 auto',
            'text-align': 'center',
            'width': 'auto',
            'color': '#fff',
            'opacity': '0.8'
        }).show();
        setTimeout(function () {
            $('div._message-class').fadeOut();
        }, (time * 1000));
    }
    /* 填充信息 */
    $(function () {
        var _message = $("#_message").val();
        if (_message.length > 1) {
            $('div').remove("._message-class");
            _alert_messgae(_message, 200, 2);
        }
    });
</script>
<script src="assets/script/info/info-add.js"></script>
<script>
    layui.use('form', function() {
        var form = layui.form;
        $(function () {
            XIALIA();
        })
    });

</script>
</body>

</html>