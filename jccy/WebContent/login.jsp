<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%String url = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>登录</title>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<!-- 登陆访问 -->
<script>
var _czc = _czc || [];
_czc.push(["_setAccount", "XXXXXXXX"]);
</script>

<style type="text/css">
body {
	background: #040309;
	text-align: center;
	position: relative;
	margin: 0 auto;
	font: #808080;
}



input[type="text"],input[type="password"] {
    width: 270px;
    height: 42px;
    margin-top: 25px;
    padding: 0 15px;
    background: #2d2d2d; /* browsers that don't support rgba */
    background: rgba(45,45,45,.15);
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    border: 1px solid #3d3d3d; /* browsers that don't support rgba */
    border: 1px solid rgba(255,255,255,.15);
    -moz-box-shadow: 0 2px 3px 0 rgba(0,0,0,.1) inset;
    -webkit-box-shadow: 0 2px 3px 0 rgba(0,0,0,.1) inset;
    box-shadow: 0 2px 3px 0 rgba(0,0,0,.1) inset;
    font-size: 14px;
    color: #fff;
    text-shadow: 0 1px 2px rgba(0,0,0,.1);
    -o-transition: all .2s;
    -moz-transition: all .2s;
    -webkit-transition: all .2s;
    -ms-transition: all .2s;
}



input[type="reset"] ,input[type="submit"]{
    cursor: pointer;
    width: 300px;
    height: 44px;
    margin-top: 25px;
    padding: 0;
    background: #07704e;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    border: 2px solid #0cab77;
    -moz-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.25) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.25) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 15px 30px 0 rgba(255,255,255,.25) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    
    font-size: 18px;
    font-weight: 700;
    color: #fff;
    text-shadow: 0 1px 2px rgba(0,0,0,.1);
    -o-transition: all .2s;
    -moz-transition: all .2s;
    -webkit-transition: all .2s;
    -ms-transition: all .2s;
}

</style>
<script type="text/javascript">
	function check() {
		if (document.all.user.value == "") {
			alert("对不起，登录帐号不能为空!");
			return false;
		}
		if (document.all.psd.value == "") {
			alert("对不起，登录密码不能为空!");
			return false;
		}
		_czc.push(["_setCustomVar","是否登录","次数",1]);
		return true;
	}
	function changeCode() {
		$("#chaImage").attr('src','validate.code?' + Math.floor(Math.random() * 100));
	}
</script>
</head>
<body style="color: #ffffff;margin: 0 auto;font-family: 微软雅黑;">
	<div >
		<a href="index.jsp"><img class="loginimg" alt="信宜图书阁"
			src="<%=url%>/resources/img/welcome.jpg" /></a>
		<div style="position: absolute; top:120px;width: 100%;">
			<br><h2>登录</h2>
			<form class="form" action="<%=url%>/login.do" method="post" onSubmit="return check()">
				<input type="text" id="user" name="user_id" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="账号"><br>
				<input type="password" id="psd" name="password" value="" placeholder="密码"> <br>
				
				<input type="text" name="validateCode" style="width: 140px;vertical-align:middle;" value="" placeholder="验证码"/> 
				<img src="validate.code" id="chaImage" onclick="changeCode()" style="width:120px;padding:0;margin:0; height:42px;vertical-align:bottom;"/> 
					
				<br>
				
				<input type="submit" class="onlogin" value="登录"> <br>
				<input type="reset" name="reset" value="重置"><br>
				<br> <br>
				管理者<input name="type_id" type="radio" value="2" style="margin-right: 26px;"/> 
				负责人<input name="type_id" type="radio" value="1" style="margin-right: 26px;"/> 
				学&nbsp;&nbsp;生<input name="type_id"type="radio" value="0" checked="checked" />
			</form>
			<br>
			<br>
		</div>
	</div><br>
			<br>
	<%@include file="../jccy/base/footer.jsp"%><br><br>
			<br>
			<br>
	<script>
			$(function(){
			    $('.loginimg').height(($(window).height()));
			    $('.loginimg').width($(window).width());
			});
		</script>
</body>
</html>