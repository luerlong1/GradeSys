<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>用户登录</title>
	<jsp:include page="../include/headtag.jsp" />
	<!-- CSS -->
	<!-- <link rel="stylesheet"
        href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500"> -->

	<link rel="stylesheet"
		  href="../../assets/font-awesome/css/font-awesome.min.css"/>
	<link rel="stylesheet" href="../../assets/css/form-elements.css"/>
	<link rel="stylesheet" href="../../assets/css/loginStyle.css"/>

	<style>
		input:-webkit-autofill {
			-webkit-box-shadow: 0 0 0px 1000px white inset;
			border: 1px solid #CCC !important;
		}
	</style>
</head>

<body>

<div class="right-content">

	<div class="inner-bg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3 form-box">
					<div class="form-top">
						<div class="form-top-left">
							<h3 style="color: #969696;">轻院校友汇平台</h3>
							<%--<p>用户登录</p>--%>
						</div>
						<div class="pull-right-bottom">
							<p class="text-danger"
							   style="position: absolute; right: 60px; bottom: 300px"
							   id="errorTip">${error}</p>
						</div>
					</div>

					<div class="form-bottom">
						<form role="form" action="login/validate.action" method="post" class="login-form">
							<div class="form-group col-xs-12">
								<label class="sr-only" for="account">account</label>账号(*):<input
									style="font-weight: bold" type="text" name="araccount" placeholder="请输入账号"
									id="account" class="form-control input-control clearfix"
									required /><span id="emailTip"></span>
							</div>
							<div class="form-group col-xs-12">
								<label class="sr-only" for="password">password</label>密码(*):
								<input type="password" name="arpassword" placeholder="请输入密码"
									   class="form-password form-control" id="password"
									   style="font-weight: bold" required onkeyup="isClearTip()">
							</div>
							<div class="form-group col-xs-12">
								<button type="submit" class="btn" style="width:200px;display:inline-block">登录</button>
								<button class="btn" style="width:200px;display:inline-block" onclick="javascript:regist()">注册</button>
							</div>
						</form>
						<span><span>
								<a href="#" >.</a></span><a
								href="findPassword" class="pull-right">找回密码</a></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Javascript -->
<script src="../../assets/bootstrap/js/bootstrap.min.js"></script>
<script src="../../assets/js/jquery.backstretch.min.js"></script>
<script src="../../assets/js/scripts.js"></script>
<script type="text/javascript">
    function regist() {
        window.location.href ="/login/sign.action"
    }
</script>
<script type="text/javascript">
    function isClearTip() {
        document.getElementById("errorTip").innerHTML = "";
    }
</script>

</body>