<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String url = request.getContextPath();
%>
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
<title>添加图书</title>

<style type="text/css">
td {
	border: 0px;
	text-align: left;
	color: #2E3E3E;
	font-size: 15px;
}

</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#xiaoquname").val("${sessionScope.currentUser.getCampus()}");
		<c:if test="${empty requestScope.path}">
			$("#addinformation").show();
			$("#cutbookpicture").hide();

		</c:if>
		<c:if test="${not empty requestScope.path}">
			$("#addinformation").hide();
			$("#cutbookpicture").show();
		</c:if>
		
		<c:if test="${not empty requestScope.savePath}">
			$("#msg").val("上传成功");
			$("#confirm_path").attr("src","<%=url%>/${requestScope.savePath}");
			$("#confirm_picture").show();//封面
			$("#addinformation").show();//信息
			$("#cutbookpicture").hide();//剪切
		</c:if>

		/* 点击上传图片 */
		$("#msg").click(function() {
			$("#addinformation").hide();//填写信息
			$("#confirm_picture").hide();//封面
			$("#cutbookpicture").show();//剪切
			$("#successDate").html("");
		});

		/* 图片放大预览 */
		$("#confirm_path").mouseover(function() {
			$(this).width(240);
			$(this).height(320);
		}).mouseout(function() {
			$(this).width(150);
			$(this).height(200);
		});
		
		$("#inforsubmit").click(function(){
			if($("#successDate").text()!=""&&$("#successDate").text()!=null&&$("#successDate").text()!=undefined){alert("这本书已经上传过，如果重复请修改数量即可");return;}
			if($("#showUserName").val()=="不存在这个账号"){alert("提供者不存在");return;}
			if(!beforeCheck()) return false;
			$("#inforsubmit").attr("disabled",true);//按钮失效
			$.ajax({
				url:"<%=url%>/tsgl/addbook.do",
				data:$("#allfinish").serialize(),
				type:"post",
				success:function(data){
					if(data.substring(0,4)=="添加成功"){
						$("#successDate").html(data.substring(4,50));
					}
					alert(data);
					$("#inforsubmit").attr("disabled",false);//按钮恢复
				}
			});
		})
		
		/* 图片放大预览 */
		$("#findUser").click(function() {
			findUserName();
		});
	});
	
	

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
	

	/* 确认信息完整 */

	function beforeCheck() {
		if ($("#path").val() == "" || $("#book_name").val() == ""
				|| $("#publish").val() == "" || $("#academy").val() == ""
				|| $("#pic").val() == "" || $("#borrow_num").val() == ""
				|| $("#book_comment").val() == "" || $("#contributor").val() == "") {
			alert("对不起，请输入完整信息!");
			return false;
		} else {
			if (confirm("确认信息无误，提交保存")) {
				return true;
			}
		}
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
</script>
</head>
<body>
	<div class="linear">
		<br>
		<div id="addinformation">
			<form id="allfinish">
				<table class="infor">
					<tr>
						<td><span>图&nbsp;&nbsp;&nbsp;片:</span></td>
						<td><input type="hidden" id="path" name="picture_path"
							value="${savePath}"> <input type="button" id="msg"
							value="点击上传" style="width: 90px; margin-left: 0px"></td>
					</tr>
					<tr>
						<td></td>
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
						<td></td>
					</tr>

					<tr>
						<td><span>书名:</span></td>
						<td><input type="text" id="book_name" name="name" /><br></td>
					</tr>
					<tr>
						<td colspan="2"><span style="color: red" id="successDate"></span></td>
					</tr>
					<tr>
						<td><span>出版社:</span></td>
						<td><input type="text" id="publish" name="publish" /> <br></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span>学院:</span></td>
						<td><input type="text" id="academy" name="academy" 
						value="${sessionScope.currentUser.getAcademy()}"/></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span>专&nbsp;&nbsp;&nbsp;业:</span></td>
						<td><input type="text" id="profession" name="profession" 
						value="${sessionScope.currentUser.getProfession()}"/></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span>负责人:</span></td>
						<td><input type="text" id="pic" name="pic"
							readonly="readonly" style="background: #d4d4d4"
							value="${sessionScope.currentUser.getUser_id()}" /></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span>提供者:</span></td>
						<td><input type="text" id="contributor" name="contributor"
							value="信宜图书阁"  onblur="findUserName()"/>
							<input id="showUserName" name="contributor_name" value="信宜图书阁"  readonly="readonly" style="color:red; font-family:微软雅黑; BACKGROUND-COLOR: transparent; "></input> 
							
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span>可借数:</span></td>
						<td><input type="text" id="borrow_num" name="borrow_num"
							onkeyup="this.value=this.value.replace(/\D/g,'')" /></td>
					</tr>
					<tr>
						<td></td>
						<td><font size="1px" >(备注：包含主编，出版年，第几版和特殊情况)</font>

						</td>
					</tr>
					<tr>
						<td><span>备&nbsp;&nbsp;&nbsp;注:</span></td>
						<td>
						<textarea id="book_comment" name="book_comment" cols=80 rows=2></textarea>
						<!-- <input type="text" id="book_comment" name="book_comment"
							style="width: 500px;" /> --></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					
				</table>
			</form>
			<table>
				<tr>
					<td><button id="inforsubmit">提交</button></td>
					<td><button onclick="javascript:window.location.reload();">重置</button></td>
				</tr>
			</table>
		</div>

		<div id="cutbookpicture" class="cut_mid" style="display: none">
			<form id="headpicture" action="<%=url%>/tsgl/uploadpictue.do" enctype="multipart/form-data" method="post" onSubmit="return checkFile()">
				<input type="file" name="pictureFile" value="选择图片" id="myfile" style="background-color: lightblue" /> 
				<input type="submit" id="pictureonload" value="点击上传" style="width: 80px;" />
			</form>
			
			<font style="font-size: 10px; color: red; font-size: 12px;">[ 格式:.jpg、.jpeg、.gif、.png ;大小：3M内 ]</font> <br>

			<div class="one">
				<img  id="edit" src="${path}" />
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
							$('#preview').css(
									{
										width : Math.round(rx * boundx)
												+ 'px',
										height : Math.round(ry * boundy)
												+ 'px',
										marginLeft : '-'
												+ Math.round(rx * c.x)
												+ 'px',
										marginTop : '-'
												+ Math.round(ry * c.y)
												+ 'px',
									});
							$('#width').val(c.w); //c.w 裁剪区域的宽  
							$('#height').val(c.h); //c.h 裁剪区域的高  
							$('#x').val(c.x); //c.x 裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
							$('#y').val(c.y); //c.y 裁剪区域顶点的y坐标  
						}
					};
				});
			</script>
			<br>
			<form id="cutForm" action="<%=url%>/tsgl/cutpicture.do"  onSubmit="return checkCut()" >
				<input type="hidden" name="x" id="x" /> 
				<input type="hidden" name="y" id="y" /> 
				<input type="hidden" name="width" id="width" />
				<input type="hidden" name="height" id="height" />
				<input type="submit" value="剪切保存" style="position: absolute; right: 5px; top: 5px; font-size: 10px;"/>	
			</form>
		</div>
		<div id="confirm_picture" 
			style="display: none; position: absolute; left: 290px; top: 20px;">
			<img id="confirm_path" width="150px" height="200px" alt="封面" border="2px">
		</div>
	</div>
</body>
</html>