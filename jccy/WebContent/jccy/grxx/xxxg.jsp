<%@ page language="java" contentType="text/html; pageEncoding=UTF-8"
	pageEncoding="UTF-8"%>
<%
		String url = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>

<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<style type="text/css">

table {
	margin-left: 30%;
}

td {
	height: 40px;
	border: 0px;
	text-align:left;
	font-size: 15px
}
</style>

<script type="text/javascript">
	$(document).ready(function() {

		$("#xg").click(function(){
			$("#chakan").css('display', 'none');
			$("#xiugai").css('display', 'block');
	    });
		
		$("#fh").click(function(){
			$("#chakan").css('display', 'block');
			$("#xiugai").css('display', 'none');
	    });
		
		$("#qd").click(function(){
			if(!checkEmail()) return false;
			if(!checkPhone()) return false;
		    if (!confirm("确定要保存提交吗!")) {
				return false;
			}else{
				$.ajax({  
					url:'<%=url%>/grxx/xxxg.do',
				    data:$("#xxxg_form").serialize(),
				    type:'post',  
				    success: function(data){
				        alert(data);  
				        window.location.reload();
				        $("#chakan").css('display', 'block');
						$("#xiugai").css('display', 'none');
			        } 
				 });
			}
	    });
	})
	function checkPhone() {
		var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
		var Phonestr = $("#Phone").val();
		if (!reg.test(Phonestr) && Phonestr != "") {
			alert("手机号格式不对");
			return false;
		}else{
			return true;
		}
	}

	function checkEmail() {
		var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
		var emailstr = $("#email").val();
		if (!reg.test(emailstr) && emailstr != "") {
			alert("邮件格式不对");
			return false;
		}else{
			return true;
		}
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人 信息</title>
</head>
<body >

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
    <br><br>
	<div id="chakan">
		<table style="text-align: left;" >

			<tr>
				<td>账 号</td>
				<td width="30px;">:</td>
				<td>${sessionScope.currentUser.getUser_id()}</td>
			</tr>

			<tr>
				<td>姓 名</td>
				<td>:</td>
				<td>${sessionScope.currentUser.getName()}</td>
			</tr>

			<tr>
				<td>类 型</td>
				<td>:</td>
				<td>
					<c:if test="${sessionScope.currentUser.getType_id()==0}">
						普通用户
					</c:if>
					<c:if test="${sessionScope.currentUser.getType_id()==1}">
						负责人
					</c:if>
					<c:if test="${sessionScope.currentUser.getType_id()==2}">
						管理员
					</c:if>
				</td>
			</tr>

			<tr>
				<td>邮 箱</td>
				<td>:</td>
				<td >
				${sessionScope.currentUser.getEmail()}</td>
			</tr>

			<tr>
				<td>校 区</td>
				<td>:</td>
				<td><span id="xiaoqu"></span>
				<script type="text/javascript">
					var xiaoqu={"2":"大学城校区","3":"东风路校区","4":"龙洞校区","5":"番禺校区"}
					$("#xiaoqu").html(xiaoqu["${sessionScope.currentUser.getCampus()}"])
				</script>
				</td>
			</tr>
			

			<tr>
				<td>学 院</td>
				<td>:</td>
				<td>${sessionScope.currentUser.getAcademy()}</td>
			</tr>
			

			<tr>
				<td>专 业</td>
				<td>:</td>
				<td>${sessionScope.currentUser.getProfession()}</td>
			</tr>
			
			<c:if test="${sessionScope.currentUser.getType_id()==0}">
				<tr>
					<td>电 话</td>
					<td>:</td>
					<td>${sessionScope.currentUser.getPhone()}</td>
				</tr>
			</c:if>
			
			<c:if test="${sessionScope.currentUser.getType_id()!=0}">
				<tr>
					<td>长 号</td>
					<td>:</td>
					<td>${sessionScope.currentUser.getLphone()}</td>
				</tr>
				<tr>
					<td>短 号</td>
					<td>:</td>
					<td>${sessionScope.currentUser.getSphone()}</td>
				</tr>
				<tr>
					<td>地 址</td>
					<td>:</td>
					<td>${sessionScope.currentUser.getAddress()}</td>
				</tr>
			</c:if>
			<tr>
				<td>备注</td>
				<td>:</td>
				
				<td><textarea id="comment" name="comment" cols=80 rows=4 disabled="disabled" style="background-color:transparent; "> ${sessionScope.currentUser.getComment()}</textarea></td>
			</tr>
			

			<tr>
				<td></td>
				<td></td>
				<td><button id="xg">修 改</button></td>
			</tr>
		</table>
		<br> <br> <br>
	</div>
	<!-- 修改 -->
	<div id="xiugai" style="display: none">
		<form id="xxxg_form">
			<table>
				<tr>
					<td>姓 名</td>
					<td>:</td>
					<td><input type="text" size="35px" name="name"
						value="${sessionScope.currentUser.getName()}"></td>
				</tr>

				<tr>
					<td>邮 箱</td>
					<td>:</td>
					<td><input type="text" id="email" size="35px" name="email"
						onblur="checkEmail()"
						value="${sessionScope.currentUser.getEmail()}"></td>
				</tr>
				
				<tr>
					<td>专 业</td>
					<td>:</td>
					<td><input type="text" size="35px" name="profession"
						value="${sessionScope.currentUser.getProfession()}"></td>
				</tr>
				<c:if test="${sessionScope.currentUser.getType_id()==0}">
					<tr>
						<td>电 话</td>
						<td>:</td>
						<td><input type="text" id="Phone" size="35px" name="phone"
							onblur="checkPhone()"
							value="${sessionScope.currentUser.getPhone()}"></td>
					</tr>
				</c:if>
				<c:if test="${sessionScope.currentUser.getType_id()!=0}">
					<tr>
						<td>长 号</td>
						<td>:</td>
						<td><input type="text" id="Phone" size="35px" name="lphone"
							onblur="checkPhone()"
							value="${sessionScope.currentUser.getLphone()}"></td>
					</tr>
					<tr>
						<td>短 号</td>
						<td>:</td>
						<td><input type="text"  size="35px" name="sphone"
							value="${sessionScope.currentUser.getSphone()}"></td>
					</tr>
					<tr>
						<td>地 址</td>
						<td>:</td>
						<td><input type="text"  size="35px" name="address"
							value="${sessionScope.currentUser.getAddress()}"></td>
					</tr>
				</c:if>
			</table>
		</form>
		<table>
			<tr>
				<td></td>
				<td colspan="2"><button  id="qd">确定</button><button  id="fh" style="margin-left: 20px">返回</button></td>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>