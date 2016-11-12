
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String url=request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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
	function getBack(){
		$.ajax({
	        url:'<%=url%>/tsgl/findback.do',
			data : $("#back_myform").serialize(),
			type : 'post',
			success : function(data) {
				$("#back_show tr:gt(0)").remove();
				if(data == "" || data == null || data == undefined ||data.total==0){
					$("#back_show").append("<tr><td colspan='8'>没找到结果</td></tr>");
				}else{
					
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var backjsp="";	
   		$(data).each(function(id,back){
   			backjsp+= '<tr><td>'+(id+1)+'</td>'
   			+'<td title=\''+back.user_id+'\'>'+back.user_id+'</td>'
   			+'<td title=\''+back.book_id+'\'>'+back.book_id+'</td>'
   			+'<td title=\''+back.book_name+'\'>'+back.book_name+'</td>'
   			+'<td class="ts">还剩 <label>'+back.cqts+'</label>天</td>'
   			+'<td title=\''+back.jysj+'\'>'+back.jysj+'</td>'
   			+'<td title=\''+back.dqsj+'\'>'+back.dqsj+'</td>'
   			+'<td><span onclick=\"guiHua(\''+back.back_id+'\',\''+back.book_name+'\',\''+back.book_id+'\')\">归还</span></td></tr>'
   		});
   		
   		$("#back_show").append(backjsp);
   		
   		$("#back_show tr:gt(0)").each(function(i){
   			var cqts= $(this).children(".ts");
   		    if(cqts.children("label").text()<0)
   		    	cqts.css("color","red");
   		    else{cqts.css("color","#04C75C");}
   		   
   		});
   		$("#back_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	function guiHua(a,b,c){
		if (confirm("确定【 "+b+" 】已经归还？")) {
			$.ajax({
				url:'<%=url%>/tsgl/back.do',
				data : {back_id:a,book_id:c},
				type : 'post',
				success : function(data) {
					alert(data);
					$("#dqjy_show tr:gt(0)").remove();
					getBack();
				}
			});
		}
	}
</script>
<title>还书</title>
</head>
<body>
	<div class="linear">
		<div class="login_out" >
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
		<div>
			<form id="back_myform"  method="post">
				<span style="margin-left: 3%">用户帐号:</span> 
				<input type="text" id="user_id" name="user_id" size="20px"> 
				<span style="margin-left: 3%">图书书号:</span> 
				<input type="text" id="book_id" name="book_id" size="20px"> 
				<input type="button" id="back_find" value="查询" onclick="getBack()">
				<input type="reset" value="重置">
			</form>
		</div>
		<div id="chakan" style="width: 96%;">
			<br> <br>
			<table id="back_show" style="word-break: break-all; word-wrap: break-word;width: 100%">
				<tr bgcolor="#ff0000" id="dd">
					<th width="30">序号</th>
					<th >账号</th>
					<th >书号</th>
					<th >书名</th>
					<th >状态</th>
					<th >借阅日期</th>
					<th >到期日期</th>
					<th >归还</th>
				</tr>
			</table>
		
		</div>
	</div>
</body>
</html>