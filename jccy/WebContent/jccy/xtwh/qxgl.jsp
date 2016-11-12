<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String url=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />

<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		/*查询按钮调用*/
		$("#xtgg_find").click(function(){
			getXtgg();
		});
	});
	
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
	<div class="linear">
		<div>
			<form id="xtgg_form">
				<table>
					
					<tr>
					<td>正文</td>
					<td>:</td>
					<td><textarea id="conent" name="content" cols=60 rows=4></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td><input id="xtgg_find" type="button" value="确定修改"> </td>
				</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>