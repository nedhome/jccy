<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String url=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />

<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<style type="text/css">
td {height: 40px;border: 0px;text-align:left;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		/*查询按钮调用*/
		$("#xtgg_find").click(function(){
			getXtgg();
		});
	});
	
	function getGG(){
		$.ajax({
			url:"<%=url%>/common/getxtgg.do",
			type:"post",
			success:function(data){
				$("#title").val(data.title);
				$("#content").html(data.content);
			}
		})
	}
	
	/* 请求函数 */
	function getXtgg(){
		if (!confirm("您确定要提交公告吗？")) {
			return;
		}
		$.ajax({
	        url:'<%=url%>/xtwh/xtgg.do',
			data : $("#xtgg_form").serialize(),
			type : 'post',
			success : function(data) {
				alert(data);
			}
		});
	}
	
	
</script>
<title>系统公告</title>
</head>
<body>
	<div class="linear"><br>
	 <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 系统公告发布 ]</font>
			<br><br>
		<div>
			<form id="xtgg_form">
				<table>
				<tr>
					<td>标题</td>
					<td>:</td>
					<td><input type="text" id="title" name="title" size="80"></input></td>
				</tr>
				<tr>
					<td>正文</td>
					<td>:</td>
					<td><textarea id="content" name="content" cols=100 rows=10></textarea></td>
				</tr>
				<tr>
					
					<td colspan="2"><input id="xtgg_find" type="button" value="确定修改" style="width: 70px;margin-left: 0;"> </td>
					<td></td>
				</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>