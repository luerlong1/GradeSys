<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>益简单业务管理平台-忘记密码</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.9,target-densitydpi=low-dpi">
	<meta http-equiv="Cache-Control" content="no-siteapp">
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/images/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
	<link rel="stylesheet" type="text/css" href="lib/layui/css/modules/layer/default/layer.css"/>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/Validform_v5.3.2_min.js" ></script>
</head>
<body class="login-bg">
    <div class="login layui-anim layui-anim-up">
		<!--横向步骤线图-->
	 	<div class="box">
	        <div class="disfl">
	            <div class="fl1 one">
	                <div style="flex:1"></div>
	                <div class="dot active">1</div>
	                <div class="item active" style="margin-left: 10px;"></div>
	            </div>
	            	
	            <div class="fl1 two">
	                <div class="item active" style="margin-right: 10px;"></div>
	                <div class="dot">2</div>
	                <div class="item" style="margin-left: 10px;"></div>
	            </div>
	
	            <div class="fl1 three">
	                <div class="item" style="margin-right: 10px;"></div>
	                <div class="dot">3</div>
	                <div style="flex:1;"></div>
	            </div>

	        </div>
	        <div class="disfl" style="margin-top: 15px;">
	            <div class="fl1 tc">验证邮箱</div>
	            <div class="fl1" style="justify-content:center;margin-left: 20px;">设置新密码</div>
	            <div class="fl1" style="justify-content: flex-end;padding-right: 18px;">完成</div>
	        </div>
	    </div>

		<form id="password-login" method="${pageContext.request.contextPath }/changePwd" class="layui-form">
			<div class="errorMsg cfc"></div>
			<!--步骤一验证手机号-->
			<div class="onebox-form">
				<!--填写组织联系人电话-->
				<div>
					<input type="text" name="phone" id="phone" nullmsg="请输入邮箱" errormsg="请填写正确的邮箱" placeholder="请输入邮箱">
				</div>
				<hr class="hr15">
				<!--填写验证码-->
				<div class="input-group">
					<input type="text" name="verCode" nullmsg="请输入验证码" errormsg="验证码格式错误" placeholder="请输入验证码">
					<div id="yzm" onclick="getVerCode()">获取验证码</div>
				</div>
				<hr class="hr20">
				<input type="hidden" id="acceptCode">
				<input value="下一步" type="button" onclick="checkCode()" class="loginbutt" style="width:100%;">
			</div>
			<!--步骤二设置新密码-->
			<div class="twobox-form hidden">
				<!--设置新密码-->
				<input type="password" name="password" datatype="a0-z" nullmsg="请输入新密码" errormsg="密码必须由 8-16位字母和数字组成" placeholder="请输入密码">
				<hr class="hr15">
				<!--确认新密码-->
				<input type="password" name="password2" datatype="*8-16" recheck="password" errormsg="您两次输入的密码不一致！" nullmsg="请再次输入新密码" placeholder="再次输入新密码" />
				<hr class="hr15">
				<input value="下一步" type="submit" class="loginbutt" style="width:100%;">
			</div>
			<!--步骤三完成-->
			<div class="threebox-form hidden">
				<div class="tc" id="textquit">修改完成，请再次登录</div>
				<hr class="hr20">
				<input value="登 录" type="button" class="loginbutt" style="width:100%;">
			</div>
			<hr class="hr10">
			
			<div class="tr frlogin">
				已经有账号了，<a href="${pageContext.request.contextPath }/" class="main-color">点击登录</a>
			</div>
		</form>
    </div>
    
<script>
	//获取验证码
	function getVerCode() {
		var email = $('#phone').val();
		var myreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(!myreg.test(email)) {
			alert("请输入正确的邮箱");
			return false;
		} else {
			$.post('/login/findPwd.action', {email: email}, function (data) {
			    console.log(data)
				if(data.code == '0'){
                    updateVerButton();
                    $("#acceptCode").val(data.data);
                    alert("验证码："+data.data);
				}else{
                    alert(data.message);
                }


			})
			return true;
		}
	}

    var time =60;
    function updateVerButton() {
        time--;
        if (time <= 0) {
            $('#yzm').text('获取验证码');
            $('#yzm').css({'background': '#FF6602',"pointer-events":'auto'});
            time = 60;
        } else {
            $('#yzm').text(time + '秒');
            $('#yzm').css({'background': '#cccccc',"pointer-events":'none'});
            setTimeout("updateVerButton()", 1000);
        }
    }
    //正则表达式验证手机号码和验证码  步骤一
    $(".onebox-form .loginbutt").click(function(){
    	var phone = $('#phone').val();
    	var yzm = $("input[name='verCode']").val();
		var myreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var trueCode = $("#acceptCode").val();
    	if(!myreg.test(phone))
    	{
    		$("#password-login").find('.errorMsg').text("请输入正确的邮箱")
    	}
    	else if(yzm.length!=4 || yzm!=trueCode)
    	{
    		$("#password-login").find('.errorMsg').text("请输入正确的验证码")
    	}
    	else
    	{
    		$("#password-login").find('.errorMsg').text("")
    		$(".onebox-form").addClass("hidden")
    		$(".two").find(".dot").addClass("active")
    		$(".two").find(".item").addClass("active")
    		$(".three").find(".item").addClass("active")
    		$(".twobox-form").removeClass("hidden")
    	}
    })
   

    $(function(){
    	//正则表达式判断密码格式是否正确
    	var pwd = $("input[name='password']").val();
    	if(pwd.length!=0){
    		$(".twobox-form  .loginbutt").click(function(){
	    		var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;
	    		if(!reg.test(pwd)){
			    	$("#password-login").find('.errorMsg').text("密码必须由 8-16位字母、数字组成")
			    	return false;
			    }
	    	})
    	}
    	
		//表单提交
        $('#password-login').Validform({
            tipSweep:true,
            tiptype: function (msg, o, cssctl) {
                if (o.type === 3)
                    $("#password-login").find('.errorMsg').text(msg)
                if (o.type === 2)
                    $("#password-login").find('.errorMsg').text("")
                return;
            },
            datatype:{
                "a0-z": /^(?!([a-zA-Z]+|\d+)$)[a-zA-Z\d]{8,16}$/
            },
            beforeSubmit: function () {
            	$(".twobox-form").addClass("hidden")
            	$(".frlogin").addClass("hidden")
            	$(".three").find(".dot").addClass("active")
            	$(".threebox-form").removeClass("hidden")
                $.post('/login/changePwd.action', $('#password-login').serialize(), function (data) {
                    if (data.code==0) {
                        $("#textquit").text(data.message);
                    } else {
                        if ($("#password-login").find('.errorMsg')) {
                            $("#textquit").text(data.message);
                        }
                    }
                });
                return false;
            }
        });
        //跳转登录页面
		$(".threebox-form .loginbutt").click(function(){
			window.location.href = '${pageContext.request.contextPath }/';
		})
    });

</script>
<!-- 底部结束 -->
</body>
</html>