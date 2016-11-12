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
	border: 1px;
	text-align:left;
	font-size: 15px
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#submituser").click(function(){
			if(!beforeCheck()) return false;
			$.ajax({
				url:"<%=url%>/rygl/adduser.do",
				data:$("#usersubmit").serialize(),
				type:"post",
				success:function(data){
					alert(data);
				}
			});
		})
		
		$("#submintpic").click(function(){
			if($("#newUser_id").val()=="" || $("#oldUser_id").val()==""){alert("请输入账号");return;}
			if($("#omsgc").html()=="不存在这个账号"){alert("旧账号不存在");return;}
			if($("#nmsgc").html()=="不存在这个账号"){alert("新账号不存在");return;}
			$.ajax({
				url:"<%=url%>/rygl/updatepic.do",
				data:$("#picsubmit").serialize(),
				type:"post",
				success:function(data){
					alert(data);
				}
			});
		})
	});
	function findAllPic(){
		$.ajax({
	        url:'<%=url%>/rygl/findallpic.do',
			data : {},
			type : 'post',
			success : function(data) {
				var picjsp="";
				$(data).each(function(id,pic){ 
					picjsp+="<option value='"+pic.bm+"'>"+pic.academy+"</option>";
				});		
				
				$("#user_pic").append(picjsp);
			}
		});
		
	}
	
	function picChange(){
		$(".commonUser").hide();
		$(".picshow").hide();
		$(".picUser").show();
		$(".back").show();
	}
	
	function back(){
		$(".back").hide();
		$(".picUser").hide();
		$(".commonUser").show();
		$(".picshow").show();
	}
	
	
	function findOUserName(){
		$.ajax({
			url:"<%=url%>/tsgl/findUserName.do",
			data:{user_id:$("#oldUser_id").val()},
			type:"post",
			success:function(data){
				if(data == "" || data == null || data == undefined ) data="不存在这个账号";
				$("#omsgc").html(data);
			}
		});
	}
	
	function findNUserName(){
		$.ajax({
			url:"<%=url%>/tsgl/findUserName.do",
			data:{user_id:$("#newUser_id").val()},
			type:"post",
			success:function(data){
				if(data=="" || data == null || data == undefined ) data="不存在这个账号";
				$("#nmsgc").html(data);
			}
		});
	}
	
	function beforeCheck() {
		if ($("#xiaoquname").val() == "" || $("#user_id").val() == ""
				|| $("#name").val() == "" || $("#user_pic").val() == ""
				|| $("#book_comment").val() == "" ) {
			alert("对不起，请输入完整信息!");
			return false;
		} else {
			if (confirm("确认信息无误，提交保存")) {
				return true;
			}
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
		<br>
		<button class="picshow" style="margin-left: 2%; width:100px; " onclick="picChange()">负责人变更</button>
		<button class="back" style="margin-left: 2%; width:100px; display: none;" onclick="back()">返回</button>
		<div class="commonUser">
			<br>
			<br>
			<form id="usersubmit">
				<table >

					<tr>
						<td colspan="2" style="font-size: 15px; font-weight: bold;">添加普通用户</td>
					</tr>

					<tr>
						<td><span>校&nbsp;&nbsp;&nbsp;区:</span></td>
						<td><select id="xiaoquname" name="campus">
								<option value="1"></option>
								<option value="2">大学城校区</option>
								<option value="3">东风路校区</option>
								<option value="4">龙洞校区</option>
								<option value="5">番禺校区</option>
						</select></td>
					</tr>
					<tr>
						<td><span>账&nbsp;&nbsp;&nbsp;号:</span></td>
						<td><input type="text" id="user_id" name="user_id" onkeyup="this.value=this.value.replace(/\D/g,'')"/><br></td>
					</tr>
					<tr>
						<td><span>姓&nbsp;&nbsp;&nbsp;名:</span></td>
						<td><input type="text" id="name" name="name" /> <br></td>
					</tr>
					<tr>
						<td><span>学&nbsp;&nbsp;&nbsp;院:</span></td>
						<td><input type="text" id="academy" name="academy" /></td>
					</tr>
					<!--
					<tr>
						<td><span>专&nbsp;&nbsp;&nbsp;业:</span></td>
						<td><input type="text" id="profession" name="profession" /></td>
					</tr> -->
					<tr>
						<td><span>负责人:</span></td>
						<td><select id="user_pic" name="user_pic">

						</select></td>
					</tr>


					<tr>
						<td><span>备&nbsp;&nbsp;&nbsp;注:</span></td>
						<td><textarea id="book_comment" name="book_comment" cols=80
								rows=2>无不良记录</textarea></td>
					</tr>
					<tr>
						<td><input type="button" id="submituser" value="确定"></input></td>
						<td><button onclick="javascript:window.location.reload();">重置</button>
						</td>
					</tr>

				</table>
			</form>
		</div>
		
		<div class="picUser" style="display:none">
		<br>
			<br>
			<form id="picsubmit">
			<table>
			<tr>
						<td colspan="2" style="font-size: 15px; font-weight: bold;">负责人变更</td>
					</tr>
				<tr>
					<td>旧帐号</td>
					<td width="30px;">:</td>
					<td><input type="text" size="20px" id="oldUser_id" name="oldID" onblur="findOUserName()" onkeyup="this.value=this.value.replace(/\D/g,'')"
						id="psdold"><span id="omsgc" style="color:red;"></span></td>
				</tr>

				<tr>
					<td>新账号</td>
					<td width="30px;">:</td>
					<td><input type="text" size="20px" id="newUser_id" name="newID" onblur="findNUserName()" onkeyup="this.value=this.value.replace(/\D/g,'')"
						><span id="nmsgc" style="color:red;"></span></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td><input id="submintpic" type="button" value=" 确	定  "
						style="margin-left: 0px"></td>
				</tr>

			</table>
			</form>
		</div>
	</div>
</body>
</html>