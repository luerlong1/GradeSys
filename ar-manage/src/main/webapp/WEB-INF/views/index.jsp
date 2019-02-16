<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>益简单crm管理系统</title>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
		<script src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
	</head>

	<body>
		<!-- 顶部开始 111-->
		<div class="container">
			<div class="logo">
				<a>益简单crm管理系统</a>
			</div>
			<div class="left_open">
				<i title="展开左侧栏" class="iconfont">&#xe699;</i>
			</div>
			<div class="left_open2" onclick="refresh()" style="margin-left:10px; "><i class="layui-icon" title="刷新">&#xe666;</i></div>
			<ul class="layui-nav right" lay-filter="">
				<li class="layui-nav-item">

					<a href="javascript:;"><c:if test="${sessionScope.loginAdUser!=null}">${SESSION_ADMIN.account}</c:if>${SESSION_ADMIN.trueName}</a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a _href="user/userInfo.action?account=${SESSION_ADMIN.account}" id="userClick">个人信息</a>
						</dd>
						<dd>
							<a _href="user/changePwd.action?account=${SESSION_ADMIN.account}" id="userClickA">修改密码</a>
						</dd>
						<dd>
							<a href="login/logout.action">退出</a>
						</dd>
					</dl>
				</li>
			</ul>


		</div>
		<!-- 顶部结束 -->
		<!-- 中部开始 -->
		<!-- 左侧菜单开始 -->
		<div class="left-nav">
			<div id="side-nav">
				<ul id="nav">

					<%--<li>--%>
						<%--<a href="javascript:;">--%>
							<%--<i class="iconfont">&#xe6ae;</i>--%>
							<%--<cite>权限设置</cite>--%>
							<%--<i class="iconfont nav_right">&#xe697;</i>--%>
						<%--</a>--%>
						<%--<ul class="sub-menu">--%>
								<%--<li>--%>
									<%--<a _href="right/indexRight.action">--%>
										<%--<i class="iconfont">&#xe6a7;</i>--%>
										<%--<cite>权限列表</cite>--%>
									<%--</a>--%>
								<%--</li>--%>

								<%--<li>--%>
									<%--<a _href="role.action">--%>
										<%--<i class="iconfont">&#xe6a7;</i>--%>
										<%--<cite>角色管理</cite>--%>
									<%--</a>--%>
								<%--</li>--%>
							<%--<li>--%>
								<%--<a _href="origin/add.action">--%>
									<%--<i class="iconfont">&#xe6a7;</i>--%>
									<%--<cite>权限管理</cite>--%>
								<%--</a>--%>
							<%--</li>--%>
						<%--</ul>--%>
					<%--</li>--%>
					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe6ce;</i>
							<cite>组织管理</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="origin.action">
									<i class="iconfont">&#xe6a7;</i>
									<cite>组织管理</cite>
								</a>
							</li>

							<li>
								<a _href="origin/add.action">
									<i class="iconfont">&#xe6a7;</i>
									<cite>创建组织</cite>
								</a>
							</li>

						</ul>
					</li>
					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe6b4;</i>
							<cite>用户管理</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">

							<li>
								<a _href="user.action">
									<i class="iconfont">&#xe6a7;</i>
									<cite>用户列表</cite>
								</a>
							</li>

							<li>
								<a _href="user/add.action">
									<i class="iconfont">&#xe6a7;</i>
									<cite>创建用户</cite>
								</a>
							</li>
						</ul>
					</li>

                    <li>
                        <a href="javascript:;">
                            <i class="iconfont">&#xe6b4;</i>
                            <cite>新闻管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i>
                        </a>
                        <ul class="sub-menu">

                            <li>
                                <a _href="info.action">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>信息中心</cite>
                                </a>
                            </li>
							<li>
								<a _href="info.action">
									<i class="iconfont">&#xe6a7;</i>
									<cite>发布新闻</cite>
								</a>
							</li>
                        </ul>
                    </li>
					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe6b4;</i>
							<cite>个人中心</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="user/userInfo.action?account=${SESSION_ADMIN.account}">
									<i class="iconfont">&#xe6a7;</i>
									<cite>个人信息</cite>
								</a>
							</li>
							<li>
								<a _href="user/changePwd.action?account=${SESSION_ADMIN.account}">
									<i class="iconfont">&#xe6a7;</i>
									<cite>修改密码</cite>
								</a>
							</li>

						</ul>
					</li>
				</ul>
			</div>
		</div>
		<!-- <div class="x-slide_left"></div> -->
		<!-- 左侧菜单结束 -->
		<!-- 右侧主体开始 -->
		<div class="page-content">
			<div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
				<ul class="layui-tab-title">
					<li class="home layui-this"><i class="layui-icon">&#xe68e;</i>首页</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<iframe src='set/setName.action' frameborder="0" scrolling="yes" class="x-iframe iframe_m">
						</iframe>
					</div>
				</div>

			</div>
			
		</div>
		<div class="page-content-bg"></div>
		<!-- 右侧主体结束 -->
		<!-- 中部结束 -->
		<!-- 底部开始 -->
		<!--<div class="footer">
        <div class="copyright">Copyright ©2017 x-admin v2.3 All Rights Reserved</div>  
    </div>-->
		<!-- 底部结束 -->

	<script>
		$(function(){

            // $("#nav .sub-menu a").click(function () {
            //     $("iframe").each(function () {
            //         $(this).attr('src', $(this).attr('src'));//需要引用jquery
            //     })
            // })
			
			$(".left-nav #nav li ul li").click(function(){
				$("#nav").find("a").removeClass("active");
				$(this).children("a").addClass("active");
			})

		})
        function refresh(){
            $("iframe").each(function () {
                $(this).attr('src', $(this).attr('src'));//需要引用jquery
            })
        }
	</script>
	</body>

</html>