<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>轻大校友汇-用户注册</title>
<jsp:include page="../include/headtag.jsp" />
<!-- CSS -->
<!-- <link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500"> -->

<link rel="stylesheet"
	href="../../assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="../../assets/css/form-elements.css">
<link rel="stylesheet" href="../../assets/css/loginStyle.css">
<style>
input:-webkit-autofill {
	-webkit-box-shadow: 0 0 0px 1000px white inset;
	border: 1px solid #CCC !important;
}
</style>
</head>

<body>

	<%--<jsp:include page="../include/head.jsp" />--%>
	<%--<jsp:include page="../include/menu.jsp" />--%>
	<div class="inner-bg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3 form-box">
					<div class="form-top">
						<div class="form-top-left">
							<h3 style="color: #969696;">用户注册</h3>
							<p>请输入注册信息</p>
							<p style="color: red">${signError}</p>
						</div>


					</div>
					<div class="form-bottom">
						<form role="form" action="/login/doSign.action" method="post" class="login-form">
							<div class="pull-right-bottom">
								<p class="text-danger"
								   style="position: absolute; right: 60px; bottom: 430px"
								   id="errorTip">${error}</p>
							</div>
							<div class="form-group col-xs-12"><label class="sr-only" >userName</label><input
									style="font-weight: bold" type="text" name="account" placeholder="请输入账号(6-15位)"
									id="account" class="form-username form-control" onkeyup="isCheckAccount()" required /><span id="accountTip" style="color: #fc3a3a"></span>
							</div>
							<div class="form-group col-xs-12">
								<label class="sr-only" >password</label><input
									style="font-weight: bold" type="password" name="password" placeholder="请输入密码(8-16位字母、数字组成)"
									class="form-password form-control" id="password" onkeyup="isCheckPassword()" required /><span id="passwordTip" style="color: #fc3a3a"></span>
							</div>
							<div class="form-group col-xs-12">
								<label class="sr-only" >passwordCof</label><input
									style="font-weight: bold" type="password"
									name="rePassword" class="form-password form-control " placeholder="再次确认密码"
									id="rePassword" required onkeyup="isCheckRePwd()" /> <span id="pwdTip" style="color: #fc3a3a"></span>
							</div>
							<div class="form-group col-xs-12">
								<label class="sr-only" ></label><input
									type="text" name="trueName" class="form-username form-control" placeholder="请输入校友姓名"
									id="trueName" required style="font-weight: bold"/>
							</div>

							<div class="form-group col-xs-12">
								<label class="sr-only" >userEmail</label><input
									style="font-weight: bold" type="text" name="email"
									id="email" class="form-control input-control clearfix " placeholder="请输入邮箱"
									required onkeyup="isCheckEmail()" /><span id="emailTip" style="color: #fc3a3a"></span>
							</div>


							<!--
							<div class="form-group col-xs-12">
								<label class="sr-only" for="userMobile">userMobile</label>手机号(*):<input
									style="font-weight: bold" type="text" name="userMobile"
									id="userMobile" class="form-control input-control clearfix"
									required onkeyup="isCheckMobile()" /><span id="mobileTip"></span>
							</div>
							<div class="form-group col-xs-12">
							性别(*):
								<select class="form-control input-control " name="userSex">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
							-->
							<div class="form-group col-xs-12">
								<button type="submit" class="btn" id="btn">立即注册</button>
							</div>
							<div class="tr" style="text-align: right">
								已有账号，<a href="/login/login.action" class="main-color">点击登录</a>
							</div>
						</form>
						<span><a href="#">.</a></span> <span><a
							href="#" class="pull-right">.</a></span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Javascript -->
	<script src="../../assets/js/jquery-1.11.1.min.js"></script>
	<script src="../../assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="../../assets/js/jquery.backstretch.min.js"></script>
	<script src="../../assets/js/scripts.js"></script>
	<!--[if lt IE 10]>
            <script src="../../assets/js/placeholder.js"></script>
        <![endif]-->

	<script>
		function isCheckRePwd() {
			var pwd1 = document.getElementById("password").value;
			var pwd2 = document.getElementById("rePassword").value;
			document.getElementById("errorTip").innerHTML = "";
			if (pwd1 == pwd2) {
				document.getElementById("pwdTip").innerHTML = "";
				document.getElementById("btn").disabled = false;
			} else {
				document.getElementById("pwdTip").innerHTML = "两次密码不相同";
				document.getElementById("btn").disabled = true;
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

	<script type="text/javascript">
		function isCheckPassword() {
			var password = document.getElementById("password").value;
			document.getElementById("passwordTip").innerHTML = "";
			if (password != "") {
				var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
				isok = reg.test(password);
				if (isok) {
					document.getElementById("passwordTip").innerHTML = "";
					document.getElementById("btn").disabled = false;
				} else {
					document.getElementById("btn").disabled = true;
					document.getElementById("passwordTip").innerHTML = "密码8-16位字母、数字组成!";
				}
			} else {
				document.getElementById("passwordTip").innerHTML = "";
			}
		}
	</script>

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

</body>

</html>