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
		function getJyls(){
			$.ajax({
		        url:'<%=url%>/jyxx/jyls.do',
				data : $("#jyls_myform").serialize(),
				type : 'post',
				success : function(data) {
					$("#jyls_show tr:gt(0)").remove();
			   		$("#dqy").val(data.pageNum);
			   		$("#totalPage").html(data.pages);
			   		$("#total").html(data.total);
					if(data.total==0){
						$("#jyls_show").append("<tr><td colspan='10'>您没有借阅图书记录喔</td></tr>");
						$("#feny_table").hide();	
					
					}else{
						show(data);				
					}
				}
			});
		}
		
		/* 查询有结果是显示函数 */
		function show(data){
			var ifb={"2":"已归还","1":"没归还","3":"你已经丢失它了~"};
			var jylsjsp="";
				$(data.list).each(function(id,jyls){ 
					jylsjsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td>'
			   			+'<td title=\''+jyls.book_name+'\'>'+jyls.book_name+'</td>'
			   			+'<td title=\''+jyls.book_id+'\'>'+jyls.book_id+'</td>'
			   			+'<td title=\''+jyls.book_publish+'\'>'+jyls.book_publish+'</td>'
			   			+'<td title='+'\'【校   区】：'+jyls.book_campus+'&#10;【学   院】：'+jyls.book_academy+'&#10;【专   业】：'+jyls.book_profession+'\'>'+jyls.book_campus+'/'+jyls.book_academy+'/'+jyls.book_profession+'</td>'
			   			+'<td title=\''+jyls.jysj+'\'>'+jyls.jysj+'</td>'
			   			+'<td title=\''+jyls.dqsj+'\'>'+jyls.dqsj+'</td>'
			   			+'<td title=\''+jyls.ghsj+'\'>'+jyls.ghsj+'</td>'
			   			+'<td title=\''+ifb[jyls.ghbj]+'\'>'+ifb[jyls.ghbj]+'</td>'
			   			+'<td title=\''+jyls.pic_name+'\'>'+jyls.pic_name+'</td>'
			   			+'</tr>';
				});
				$("#jyls_show").append(jylsjsp);
				$("#jyls_show tr").click(function(){
					$("tr").css('background','');
					$(this).css('background','#53aca4');
				});
		}
		
		
		/* 分页时调用请求函数 */
		function fenye(){
			getJyls();
		}	
</script>
<title>借阅历史</title>
</head>
<body style="background-color: #808080; margin: 0 auto;">
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
		<!-- 表格区 -->
		<div id="chakan" style="width: 96%;">
		 <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 借阅历史 ]</font>
			<br><br>
			<table id="jyls_show" class="show_table" style="word-break: break-all; word-wrap: break-word;width: 100%">
				<tr>
					<th width="50px">序号</th>
					<th>书名</th>
					<th>书号</th>
					<th>出版社</th>
					<th>校区/学院/专业</th>
					<th>借阅日期</th>
					<th>到期日期</th>
					<th>归还日期</th>
					<th>是否归还</th>
					<th>负责人</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
		
		<div>
			<form id="jyls_myform">
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				<input type="hidden" name="user_id" value="${sessionScope.currentUser.getUser_id()}">
			</form>
		</div>
		
	</div>
</body>
</html>