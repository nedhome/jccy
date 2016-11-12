<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	String url = request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<style type="text/css">
table {margin-left: 30%;}

td {height: 40px; border: 0px;text-align:left;font-size: 15px;}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		
		$("#mmxgon").click(function(){
			if ($("#psdold").val()=="")
				{$("#msgc").html("<font color='red' size='2px'> 请输入</font>");return;}
			if ($("#psdnew").val()=="")
				{$("#msga").html("<font color='red' size='2px'> 请输入</font>");return;}
			if ($("#psd").val()=="")
				{$("#msgb").html("<font color='red' size='2px'> 请输入</font>");return;}
			$.ajax({  
		     	 url:'<%=url%>/grxx/mmxg.do',
		     	 data:$("#mmxg_form").serialize(),
		         type:'post',  
		         success: function(data){
	         		alert(data);  
	             } 
		    });
	    });
		
		
		$("#psdold").blur(function() {
			if ($("#psdold").val()=="")
				$("#msgc").html("<font color='red' size='2px'> 请输入</font>");
			else
				$("#msgc").html("<font></font>");
		});
				
		
		/* 设置密码合理性 */
		$("#psdnew").blur(function() {
			var psdnew = $("#psdnew").val();
			var reg = /^\w+$/;
			if (reg.test(psdnew) && psdnew.length>=8 && psdnew.length <= 16)
				$("#msga").html("<font color='green' size='2px'> 符合要求</font>");
			else
				$("#msga").html("<font color='red' size='2px'> 不符合要求</font>");
		});

		/* 两次密码输入验证 */
		$("#psd").blur(function() {
			if ($("#psd").val() == $("#psdnew").val()){
				if($("#psd").val().length>=8)
					$("#msgb").html("<font color='green' size='2px'> 符合要求</font>");
				else{
					$("#msgb").html("<font color='red' size='2px'> 请设置符合要求密码</font>");
					$("#psd").val("");
				}
			}
			else{
				$("#msgb").html("<font color='red' size='2px'> 两次输入不同</font>");
				$("#psd").val("");$("#psdnew").val("");
			}

		});
		
		/* 提交确定 */
	 	$("#mmxg_form").submit(function() {
		 	var psdnew = $("#psdnew").val();
		 	if ($("#psdnew").val()=="")
				$("#msgc").html("<font color='red' size='2px'> 请输入</font>");
			if (psdnew == $("#psdnew").val()&& (psdnew.length >= 8) && psdnew.length <= 16){
				if(!confirm("确定要保存提交吗!")) {
					return false;
				} 
			}else {
				alert("请输入正确完整信息");
				return false;
			}
		});
	});
	
</script>
</head>
<body>
	<div class="linear">
		 <div class="login_out">
			 <c:if test="${sessionScope.currentUser==null}">
				<script type="text/javascript">
					window.onload = function() {
						alert("你还没有登录！");
						top.location.href="<%=url%>/index.jsp";
					}
				</script>
			</c:if>
		</div>
		<div id="chakan">
			<form id="mmxg_form" >
				<br> <br> <br>
				<table style="text-align: left;">
					<tr>
						<td>当前帐号</td>
						<td width="30px;">:</td>
						<td>${sessionScope.currentUser.getUser_id()}</td>
					</tr>

					<tr>
						<td>当前密码</td>
						<td width="30px;">:</td>
						<td><input type="password" size="20px" name="oldPSD" id="psdold"><span id="msgc"></span></td>
					</tr>

					<tr>
						<td>新的密码</td>
						<td>:</td>
						<td><input type="password" size="20px" name="newPSD"
							id="psdnew"><span id="msga">（8-16位）</span></td>
					</tr>

					<tr>
						<td>确认密码</td>
						<td>:</td>
						<td><input type="password" size="20px" name="psd" id="psd"
							><span id="msgb"></span></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td><input id="mmxgon" type="button" value=" 确	定  " style="margin-left: 0px"></td>
					</tr>
				</table>
			</form>
			<br> <br> <br> <br> <br> <br> <br>
			<br>
		</div>
	</div>
</body>
</html>