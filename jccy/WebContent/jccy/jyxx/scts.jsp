<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<script src="<%=url%>/resources/cj/rlcj/laydate.js" type="text/javascript"></script>
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
		function getScts(){
			$.ajax({
		        url:'<%=url%>/jyxx/scts.do',
				data : $("#scts_myform").serialize(),
				type : 'post',
				success : function(data) {
					$("#scts_show tr:gt(0)").remove();
			   		$("#dqy").val(data.pageNum);
			   		$("#totalPage").html(data.pages);
			   		$("#total").html(data.total);
					if(data.total==0){
						$("#scts_show").append("<tr><td colspan='6'>您目前没有收藏图书喔</td></tr>");
						$("#feny_table").css("display","none");
					}else{
						show(data);				
					}
				}
			});
		}
		
		/* 查询有结果是显示函数 */
		function show(data){
			var sctsjsp="";
				$(data.list).each(function(id,scts){ 
					sctsjsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td>'
			   			+'<td title=\''+scts.book_name+'\'>'+scts.book_name+'</td>'
			   			+'<td title=\''+scts.book_id+'\'>'+scts.book_id+'</td>'
			   			+'<td title=\''+scts.book_publish+'\'>'+scts.book_publish+'</td>'
			   			+'<td title=\''+scts.scsj+'\'>'+scts.scsj+'</td>'
			   			+'<td ><span onclick=\"deleteSC(\''+scts.scts_id+'\',\''+scts.book_name+'\')\">取消收藏</span></td>'
			   			+'</tr>';
				});
				$("#scts_show").append(sctsjsp);
				$("#scts_show tr").click(function(){
					$("tr").css('background','');
					$(this).css('background','#53aca4');
				});
		}
		
		
		function deleteSC(scId,book_name){
			if (confirm("你确定要删除【 "+book_name+" 】的收藏吗？")) {
				$.ajax({
					url:'<%=url%>/jyxx/deletescts.do',
					data : {tsscId:scId},
					type : 'post',
					success : function(data) {
						alert(data);
						$("#dqjy_show tr:gt(0)").remove();
						getScts();
					}
				});
			}
		}
		
		/* 分页时调用请求函数 */
		function fenye(){
			getScts();
		}	
</script>
<title>借阅历史</title>
</head>
<body style="background-color: #808080; margin: 0 auto;">
	<div class="linear" >

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

		<!-- 表格区 -->
		<div id="chakan" style="width: 96%;">
		 <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 图书收藏 ]</font>
			<br>
			<br>
			<table id="scts_show" class="show_table" style="word-break: break-all; word-wrap: break-word;width: 100%">
				
				<tr>
					<th width="50px">序号</th>
					<th >书名</th>
					<th >书号</th>
					<th >出版社</th>
					<th >收藏日期</th>
					<th width="60px">操作</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
		
		<div>
			<form id="scts_myform">
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				<input type="hidden" name="user_id" value="${sessionScope.currentUser.getUser_id()}">
			</form>
		</div>
	</div>
</body>
</html>