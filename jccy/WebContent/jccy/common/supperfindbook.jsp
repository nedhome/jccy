<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%String url = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<title>高级搜索区</title>
<style type="text/css">
.mid {
	font-family:微软雅黑;
	font-size:16px;
	margin-left: 20%;
	box-shadow: 0 0 20px #000000;
	margin-right: 20%;
}


td {
	border: 0px;
	text-align:left;
	font-size: 15px;
}
</style>
</head>
<body>
<div class="linear">

	<div id='logo'>
			<a href="javascript:top.location.href='/jccy/index.jsp';"><img class="indeximg_1" alt="信宜图书阁" src="<%=url%>/resources/img/index_1.jpg" />
			<img class="logo_img" src="<%=url%>/resources/img/logo.png"></img>
			</a><div class="logo_font">教 材 重 用 管 理 系 统</div>
		</div><br>
	<br><br><br>
		<div class="mid"><br><br>
		
			<form action="<%=url%>/common/supperfindbook.do" method="post"><center>
				<table>
				<tr>
						<td>校&nbsp;&nbsp;区</td>
						<td width="8px;">:</td>
						<td> 
							<select  name="campus" >
								<option value="1">全部</option>
								<option value="2">大学城校区</option>
								<option value="3">东风路校区</option>
								<option value="4">龙洞校区</option>
								<option value="5">番禺校区</option>
							</select>
						</td>
						
					</tr><tr>
						<td></td>
					</tr>
					
					<tr>
						<td>书&nbsp;&nbsp;号</td>
						<td width="8px;">:</td>
						<td><input type="text" name="book_id" /></td>
						
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>书&nbsp;&nbsp;名</td>
						<td width="8px;">:</td>
						<td><input type="text" name="name" /></td>
						
					</tr>
					<tr>
						<td></td>
					</tr>
					
					<tr>
						<td>出版社</td>
						<td width="8px;">:</td>
						<td><input type="text" name="publish" /></td>
					</tr>
					
					<tr>
						<td></td>
					</tr>
					
					
					<tr>
						<td>学&nbsp;&nbsp;院</td>
						<td width="8px;">:</td>
						<td><input type="text" name="academy" /></td>
						
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>专&nbsp;&nbsp;业</td>
						<td width="8px;">:</td>
						<td><input type="text" name="profession" /></td>
						
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>捐赠者</td>
						<td >:</td>
						<td><input type="text" name="contributor" /></td>
						
					</tr>
					<tr>
						<td></td>
					</tr>
					
					
					<tr></tr>
					<tr>
						<td><input type="button" value="返&nbsp;&nbsp;回" onClick="history.back(-1)"></td>
						<td style="text-align: right;"></td>
						<td>
							<input type="reset" name="reset" value="重置">
							<input type="hidden" name="currentPage" value="1">&nbsp;&nbsp;&nbsp;
							<input type="submit" name="" value="提交" />
						</td>
					</tr>
				

				</table></center>
			</form><br><br>
		</div>
	</div>
	<br>
	<br>
	<%@include file="../base/footer.jsp"%>
</html>