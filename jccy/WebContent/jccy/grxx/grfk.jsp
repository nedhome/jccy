
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
body {
	background-color: #808080;
	margin: 0 auto;
}
</style>

<script type="text/javascript">
	/* 请求函数 */
	function getMyjy(){
		$.ajax({
	        url:'<%=url%>/grxx/myfk.do',
			data : {currentPage:1},
			type : 'post',
			success : function(data) {
				$("#myfk_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
				if(data.total==0){
					$("#myfk_show").append("<tr><td colspan='3'>你没有提过建议喔</td></tr>");
					$("#feny_table").css("display","none");
				}else{
					show(data);				
				} 
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var myfkjsp="";
			$(data.list).each(function(id,yhjy){ 
				myfkjsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td><td title='+yhjy.data+'>'+yhjy.data+'</td><td title='+yhjy.content+'>'+yhjy.content+'</td></tr>';
	 	});
		$("#myfk_show").append(myfkjsp);
	}
	
	
	
	/* 分页时调用请求函数 */
	function fenye(){
		getYhjy();
	} 
	
	function fkshow(){
		$(".fk").show();
		$(".myfk").hide();
		$(".minefk").hide();
		$(".back").show();
	}
	
	function back(){
		$(".fk").hide();
		$(".myfk").show();
		$(".minefk").show();
		$(".back").hide();
		
	}
	
	function fksubmit(){
		if($("#content").val().length<6) {alert("不能少于6个字符");return;}
		$.ajax({
	        url:'<%=url%>/grxx/grfk.do',
			data : $("#xxzx_myform").serialize(),
			type : 'post',
			success : function(data) {
				alert(data);
				window.location.reload();
			}
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人建议</title>
</head>
<body>
	<div id="linear" class="linear">
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
		<div class="fk" style="margin-left: 2%; display: none">
			<form id="xxzx_myform"  method="post">
				<font style="color: red; font-size: 10px; font-weight: bold;"> [ 个人反馈 ]</font><br><br>
				<textarea id="content" name="content" cols=100 rows=8></textarea><br><br>
				<input type="button" value="提交" style="margin: auto;" onclick="fksubmit()">
				<input type="reset" value="重置">
			</form>
		</div>
		<button class="minefk" style="position: absolute; right: 25px; top: 25px; font-size: 10px;" onclick="fkshow()">提建议</button>
		<button class="back" style="position: absolute; right: 25px; top: 25px; font-size: 10px;display: none" onclick="back()">返回</button>
		<div class="myfk" style="width: 96%;">
			<font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 我的建议 ]</font>
			<br><br>
			<table id="myfk_show" class="show_table" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<tr>
				<th width="30px">序号</th>
				<th width="180px">提交日期</th>
				<th>建议内容</th>
				<!-- <th width="180px">结果</th> -->
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
	</div>
</body>
</html>