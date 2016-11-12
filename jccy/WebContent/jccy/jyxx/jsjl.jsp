<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<style type="text/css">
span {
	cursor: pointer;
}

span:hover {
	color: #ff0000;
}
</style>
<script type="text/javascript">
	
	/* 请求函数 */
	function getJsjl(){
		$.ajax({
	        url:'<%=url%>/jyxx/jsjl.do',
			data : $("#jsjl_myform").serialize(),
			type : 'post',
			success : function(data) {
				$("#jsjl_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
		   		if(data == "" || data == null || data == undefined ||data.total==0){
					$("#jsjl_show").append("<tr><td colspan='6'>您还没有捐赠过图书喔</td></tr>");
					$("#feny_table").hide();
				}else{
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var jsjljsp="";
   		$(data.list).each(function(id,jsjl){ 
   			jsjljsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td>'
		   			+'<td title=\''+jsjl.contributor_name+'\'>'+jsjl.contributor_name+'</td>'
		   			+'<td title=\''+jsjl.book_name+'\'>'+jsjl.book_name+'</td>'
		   			+'<td title=\''+jsjl.book_id+'\'>'+jsjl.book_id+'</td>'
		   			+'<td title=\''+jsjl.book_publish+'\'>'+jsjl.book_publish+'</td>'
		   			+'<td title=\''+jsjl.on_time+'\'>'+jsjl.on_time+'</td>'
		   			+'</tr>';
   		});
   		$("#jsjl_show").append(jsjljsp);
   		$("#jsjl_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	
	/* 分页时调用请求函数 */
	function fenye(){
		getJsjl();
	}
</script>
<title>贡献光荣榜</title>
</head>
<body style="background-color: #808080;; margin: 0 auto;">
	<div class="linear"><br>
		<!-- 表格区 -->
		<div id="chakan" style="width: 96%;">
		 <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 捐书记录 ]</font>
			<br><br>
			<table id="jsjl_show" class="show_table" style="word-break: break-all; word-wrap: break-word;width: 100%">	
				<tr>
					<th width="50px">序号</th>
					<th>捐赠者</th>
					<th>书名</th>
					<th>书号</th>
					<th>出版社</th>
					<th>日 期 </th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
		<div>
			<form id="jsjl_myform">
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				
				<input type="hidden" name="user_id" value="${sessionScope.currentUser.getUser_id()}">
			</form>
		</div>
		<br>
	</div>
</body>
</html>