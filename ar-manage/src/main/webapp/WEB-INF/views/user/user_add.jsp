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
				<div class="fl">添加成员</div>
				<%--<a href="javascript:history.back(-1)" class="layui-btn layui-btn-normal fr"><img src="${pageContext.request.contextPath }/images/back.png">返回</a>--%>
			</div>

			<form id="info-form" method="post" action="/user/addUser.action" class="layui-form">
			<div id="inputWidth">
				<div class="layui-form-item">
					<span class="cfc">${accountError}</span>
					<label class="layui-form-label"><span class="cfc"> * </span>账号：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="account" id="account" class="layui-input" onkeyup="isCheckAccount()" required errormsg="登录账号仅支持6-15位" nullmsg="请设置登录账号" placeholder="请设置登录账号">
						<span id="accountTip" style="color: #fc3a3a"></span></div>
				</div>
				<input type="hidden" name="password" value="zzuli123456"/>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>校友姓名：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="trueName" id="trueName" class="layui-input" required errormsg="请输入正确的姓名格式" nullmsg="请填写成员姓名" placeholder="请填写校友姓名">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>邮箱地址：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="email" id="email" class="layui-input" onkeyup="isCheckEmail()" placeholder="请填写邮箱">
						<span id="emailTip" style="color: #fc3a3a"></span></div>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc"> * </span>设置角色：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<select name="isAdmin" id="isAdmin" required>
							<option value="" selected>请选择</option>
							<option value="1">管理员</option>
							<option value="0">前台用户</option>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><span class="cfc">  </span>介绍：</label>
					<div class="layui-input-block" style="line-height: 38px;">
						<input name="introduce" id="introduce" class="layui-input">
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
		<%--<script type="text/javascript" src="../../assets/script/user/user-query.js"></script>--%>
		<script src="assets/script/user/user-add.js"></script>
		<script type="text/javascript">
            function isCheckAccount() {
                var account = document.getElementById("account").value;
                document.getElementById("accountTip").innerHTML = "";
                if (account != "") {
                    var reg = /^[A-Za-z0-9]{6,15}$/;
                    isok = reg.test(account);
                    if (isok) {
                        document.getElementById("accountTip").innerHTML = "";
                        document.getElementById("btn").disabled = false;
                    } else {
                        document.getElementById("btn").disabled = true;
                        document.getElementById("accountTip").innerHTML = "账号由6-15位字母、数字组成!";
                    }
                } else {
                    document.getElementById("accountTip").innerHTML = "";
                }
            }
		</script>
		<script type="text/javascript">
            function isCheckEmail() {
                var email = document.getElementById("email").value;
                document.getElementById("emailTip").innerHTML = "";
                if (email != "") {
                    var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                    isok = reg.test(email);
                    if (isok) {
                        document.getElementById("emailTip").innerHTML = "";
                        document.getElementById("btn").disabled = false;
                    } else {
                        document.getElementById("btn").disabled = true;
                        document.getElementById("emailTip").innerHTML = "邮箱格式不正确";
                    }
                } else {
                    document.getElementById("errorTip").innerHTML = "";
                }
            }
		</script>
		<script>
            layui.use('form', function() {
                var form = layui.form;
				//动态添加下拉列表
				<%--function XIALIA() {--%>

					<%--$.ajax({--%>
						<%--url: '${pageContext.request.contextPath }/role/getRoleSelect',--%>
						<%--dataType: 'json',--%>
						<%--type: 'get',--%>
						<%--success: function (data) {--%>
                            <%--$('#roleId').append('');--%>
							<%--$.each(data.adUserRoleList, function (index, item) {--%>
								<%--$('#roleId').append(new Option(item.roleName, item.id));--%>
							<%--})--%>
                            <%--form.render();--%>
						<%--}--%>
					<%--})--%>
				<%--}--%>
                $(function () {
                    XIALIA();
                })
            });
            // $(function(){
            //
            //     //表单提交
            //     $('#addUser').Validform({
            //         tipSweep:true,
            //         tiptype: function (msg, o, cssctl) {
            //             if (o.type === 3)
            //                 layer.msg(msg);
            //             return false;
            //         },
				// 	datatype:{
            //             "a0-z": /^[a-zA-Z0-9\u4E00-\u9FA5\uf900-\ufa2d]{1,30}$/,
            //             "a1-z": /^[a-zA-Z0-9\u4E00-\u9FA5\uf900-\ufa2d]{6,15}$/
            //         },
                    <%--beforeSubmit: function () {--%>
                        <%--var roleId = $("#roleId").val();--%>
                        <%--if(roleId==""){--%>
                            <%--layer.msg("请选择角色！");--%>
                            <%--return false;--%>
						<%--}--%>
                        <%--$.post('${pageContext.request.contextPath }/set/updateUserInfo', $('#addUser').serialize(), function (data) {--%>
                            <%--if (data.code==0) {--%>
                                <%--layer.msg(data.message,{time:3*1000},function() {--%>
									<%--window.location.href='${pageContext.request.contextPath }/set/userManage';--%>
                                <%--});--%>
                            <%--} else {--%>
                                <%--layer.msg(data.message);--%>
                                <%--if(data.message == '登录名已经存在！'){--%>
                                    <%--$("#accountGl").focus();--%>
                                <%--}else {--%>
                                    <%--$("#phoneGl").focus();--%>
                                <%--}--%>

                            <%--}--%>
                        <%--});--%>
                        <%--return false;--%>
                    <%--}--%>
				// });
            // });

		</script>
	</body>

</html>