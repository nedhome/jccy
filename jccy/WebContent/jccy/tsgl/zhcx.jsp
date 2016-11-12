<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String url=request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<script src="<%=url%>/resources/js/jquery-1.9.1.js"
	type="text/javascript"></script>
<script src="<%=url%>/resources/js/jquery.Jcrop.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="<%=url%>/resources/css/jquery.Jcrop.css"
	type="text/css" />
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css"
	type="text/css" />
<style type="text/css">
.mid {
	margin-left: 8%;
	margin-right: 8%;
	margin-bottom: 15px;
	margin-top: 25px;
}

.mid table {
	box-shadow: 0 0 12px #029afb;
	border: 1px solid #33CCFF;
	width: 100%;
	margin-left: 0;
}

.mid table td {
	text-align: left;
}
 

</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#xiaoquname").val("${sessionScope.changeBook.getCampus()}");
		<c:if test="${not empty requestScope.path}">
			$("#find_div").hide();
			$("#zhcx_mid").hide();
			$("#changepictue").show();
		</c:if>
		
		/* 修改提交 */
		$("#changesubmit").click(function(){
			if("${sessionScope.changeBook.getPic()}" != "${sessionScope.currentUser.getUser_id()}"){alert("没有权限修改");return;}
			if($("#showUserName").val()=="不存在这个账号"){alert("提供者不存在");return;}
			if(confirm("确定要修改本书吗？")){
				$.ajax({
					url:"<%=url%>/tsgl/tsglchange.do",
					data:$("#changesumbitform").serialize(),
					type:"post",
					success:function(data){
						alert(data);
						getZhcx();
					}
				})
			}else{
				return false;
			}
		}); 
		
		/* 删除提交 */
		$("#deletesubmit").click(function(){
			if("${sessionScope.changeBook.getPic()}" != "${sessionScope.currentUser.getUser_id()}"){alert("没有权限修改");return;}
			if($("#showUserName").val()=="不存在这个账号"){alert("提供者不存在");return;}
			
			if(confirm("您确定要删除全部同名的图书吗？")){
				if(confirm("您操作的不是删除一本图书，而是把这多本同名的图书全部删除，你确定继续操作？？？？")){
					$.ajax({
						url:"<%=url%>/tsgl/tsgldelete.do",
						data:$("#changesumbitform").serialize(),
						type:"post",
						success:function(data){
							alert(data);
							getZhcx();
						}
					})
				}else{
					return false;
				}
			}
		}); 
		
		
		/* 封面修改 */
		$("#oldImg").click(function(){
			if($("#picture_show").val()!=null){
				if(confirm("您要更改封面吗？")){
					$("#zhcx_mid").hide();
					$("#find_div").hide();
					$("#changepictue").show(); 
				}
			}else{
					alert("目前还没有图书！");
			}
		});
	
	})
	
	
	/* 检测是选择图片 */
	function checkFile() {
		var result = true;
		$("#myfile").each(function() {
			if ($(this).val() == "") {
				result = false;
				alert("请选择图片");
			} else {
				/*判断图片大小*/
				var file = document.getElementById("myfile").files;  
				var size=(file[0].size)/1024/1024;
				if(size>3){
					alert("此图片大于3M，请选择3M内的图片上传");
					result=false;
				}
			}
		});
		return result;
	}
	
	/* 检测是图片剪切 */
	function checkCut() {
		var result = true;
		if($("#x").val() == ""){
			result=false;
			alert("请截取图片");
		}
		return result;
	}
	
	function findUserName(){
		$.ajax({
			url:"<%=url%>/tsgl/findUserName.do",
			data:{user_id:$("#contributor").val()},
			type:"post",
			success:function(data){
				if(data=="" || data == null || data == undefined ) data="不存在这个账号";
				$("#showUserName").val(data);
			}
		});
	}
	
	function getZhcx(){
		$("#zhcx_form").submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息中心</title>
</head>
<body>
	<div class="linear">
		<div class="login_out">
			<c:if test="${sessionScope.currentUser==null}">
				<script type="text/javascript">
				window.onload=function() {
					alert("你还没有登录！");
						top.location.href="<%=url%>/index.jsp";
					}
				</script>
			</c:if>
		</div>
		<br>
		<div id="find_div">
			<form id="zhcx_form" action="<%=url%>/tsgl/zhcx.do" >
				<span style="margin-left: 3%;">书号:</span> 
				<input type="text" name="book_id" size="25px"> 
				<input type="submit" id="zhcx_cx" value="查询"> 
				<input type="reset" value="重置">
			</form>
		</div>
		<br>
		<div id="zhcx_mid" class="mid">
			<form id="changesumbitform">
				<table>
					<tr>
						<td id="oldImg"  rowspan="12" style="text-align: center; width: 275px; height: 420px">
							<!-- 图片显示 --> 
							<input type="hidden" name="picture_path" value="${requestScope.savePath}">
							<c:if test="${requestScope.savePath!=null}">
								<span ><img id="picture_show" style=" width: 275px; height: 420px" src="<%=url%>/${requestScope.savePath}"></span>
							</c:if>
						</td>
						<td width="80px">&nbsp;&nbsp;[ 书&nbsp;&nbsp;&nbsp;号 ]</td>
						<td><input type="text" name="book_id" value="${sessionScope.changeBook.getBook_id()}" readonly="readonly" style="background-color: #d4d4d4"></td>
					
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[创建时间]</td>
						<td><input type="text" name="cjsj" title="${sessionScope.changeBook.getCjsj()}" value="${sessionScope.changeBook.getCjsj()}" readonly="readonly" style="background-color: #d4d4d4"></td>
					</tr>
					<tr>
						<td >&nbsp;&nbsp;[ 书&nbsp;&nbsp;名 ]</td>
						<td><input type="text" name="name" value="${sessionScope.changeBook.getName()}"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 出版社 ]</td>
						<td><input type="text" name="publish" value="${sessionScope.changeBook.getPublish()}"></td>
					</tr>
	
					<tr>
						<td>&nbsp;&nbsp;[ 校&nbsp;&nbsp;区 ]</td>
						<td><select id="xiaoquname"  name="campus">
									<option value="1"></option>
									<option value="2">大学城校区</option>
									<option value="3">东风路校区</option>
									<option value="4">龙洞校区</option>
									<option value="5">番禺校区</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 学&nbsp;&nbsp;院 ]</td>
						<td><input type="text" name="academy" value="${sessionScope.changeBook.getAcademy()}"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 专&nbsp;&nbsp;业 ]</td>
						<td><input type="text" name="profession" value="${sessionScope.changeBook.getProfession()}"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 负责人 ]</td>
						<td><input type="text" name="pic" value="${sessionScope.changeBook.getPic()}"  ></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 提供者 ]</td>
						<td><input type="text" name="contributor" id="contributor" value="${sessionScope.changeBook.getContributor()}" onblur="findUserName()">
						
						<input id="showUserName" name="contributor_name" value="${sessionScope.changeBook.getContributor_name()}"  readonly="readonly" style="color:red; font-family:微软雅黑; BACKGROUND-COLOR: transparent; "></input> 
				</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;[ 可借数 ]</td>
						<td><input type="text" name="borrow_num" value="${sessionScope.changeBook.getBorrow_num()}"></td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;[ 备&nbsp;&nbsp;注 ]</td>
						<td><textarea name="book_comment" cols=60 rows=4>${sessionScope.changeBook.getBook_comment()}</textarea></td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="button" id="changesubmit" style="width: 120px;" value="确认修改图书">
						<input type="button" id="deletesubmit" style="float: right; width: 120px" value="确认删除图书">
					
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div id="changepictue" class="cut_mid" style="display: none">

			<form id="headpicture" action="<%=url%>/tsgl/uploadpictue.do" enctype="multipart/form-data" method="post" onSubmit="return checkFile()">
				<input type="file" name="pictureFile" value="选择图片" id="myfile" style="background-color: lightblue" /> 
				<input type="hidden" name="xgbj" value="T"> 
				<input type="submit" id="pictureonload" value="点击上传" style="width: 80px;" />
			</form>
			<font style="font-size: 10px; color: red; font-size: 12px;"> [ 格式:.jpg、.jpeg、.gif、.png ;大小：3M内 ]</font> <br>

			<div class="one">
				<img id="edit" src="${path}" />
			</div>
			<div class="two" style="width: 150px; height: 200px;">
				<img id="preview" src="${path}" />
			</div>

			<script type="text/javascript">
				/* 图片剪切 */
				jQuery(function($) {
					// Create variables (in this scope) to hold the API and image size
					var jcrop_api, boundx, boundy;
					$('#edit').Jcrop({
						onChange : updatePreview,//调用各个事件
						onSelect : updatePreview,
						aspectRatio : 3 / 4
						//规定使用正方形来选择区域
						}, function() {
							var bounds = this.getBounds();
							boundx = bounds[0];
							boundy = bounds[1];
							jcrop_api = this;
						});
						function updatePreview(c) {
							if (parseInt(c.w) > 0) {
								//计算预览区域图片缩放的比例，通过计算显示区域的宽度(与高度)与剪裁的宽度(与高度)之比得到 
								var rx = 150 / c.w;//rx=$('#preview').value/ c.w
								var ry = 200 / c.h;
								$('#preview').css({
									width : Math.round(rx * boundx) + 'px',
									height : Math.round(ry * boundy) + 'px',
									marginLeft : '-' + Math.round(rx * c.x) + 'px',
									marginTop : '-' + Math.round(ry * c.y) + 'px',
								});
								$('#width').val(c.w); //c.w 裁剪区域的宽  
								$('#height').val(c.h); //c.h 裁剪区域的高  
								$('#x').val(c.x); //c.x 裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
								$('#y').val(c.y); //c.y 裁剪区域顶点的y坐标  
							}
						}
				});
			</script>
			<br>
			<form action="<%=url%>/tsgl/cutpicture.do" onSubmit="return checkCut()">
				<input type="hidden" name="oldPath" value="${sessionScope.changeBook.getPicture_path()}"> 
				<input type="hidden" name="x" id="x" /> 
				<input type="hidden" name="y" id="y" /> 
				<input type="hidden" name="width" id="width" /> 
				<input type="hidden" name="height" id="height" /> 
				<input type="submit" value="剪切保存" style="position: absolute; right: 5px; top: 5px; font-size: 10px;" />
			</form>
		</div>
	</div>
</body>
</html>