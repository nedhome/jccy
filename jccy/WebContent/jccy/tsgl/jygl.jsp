
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
<script src="<%=url%>/resources/cj/rlcj/laydate.js" type="text/javascript"></script>

<script type="text/javascript">
	$(document).ready(function() {
		/*查询按钮调用*/
		$("#jygl_find").click(function(){
			getJygl();
		});
	});
	
	/* 请求函数 */
	function getJygl(){
		$.ajax({
	        url:'<%=url%>/tsgl/jylb.do',
			data : $("#jygl_myform").serialize(),
			type : 'post',
			success : function(data) {
				$("#jygl_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
				if(data.total==0){
					$("#jygl_show").append("<tr><td colspan='8'>没有结果</td></tr>");
					$("#feny_table").hide();
				}else{
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var jygljsp="";
   		$(data.list).each(function(id,jygl){ 
   			jygljsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td><td title=\''+jygl.book_name+'\'><span>'+jygl.book_name+'</span></td>'
   					+'<td title=\''+jygl.book_id+'\'>'+jygl.book_id+'</td>'
   					+'<td title=\''+jygl.user_name+'\'>'+jygl.user_name+'</td>'
   					+'<td title=\''+jygl.user_id+'\'>'+jygl.user_id+'</td>'
   					+'<td title=\''+jygl.user_phone+'\'>'+jygl.user_phone+'</td>'
   					+'<td title=\''+jygl.yysj+'\'>'+jygl.yysj+'</td>'
   					+'<td ><a onclick=\"jyts(\''+jygl.borrow_id+'\',\''+jygl.user_name+'\',\''+jygl.user_id+'\',\''+jygl.book_id+'\',\''+jygl.yysj+'\')\">确认借阅</a></td></tr>';
     	});        
   		$("#jygl_show").append(jygljsp);
   		$("#jygl_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	/*取书借阅操作*/
	function jyts(id,user_name,user_id,book_id,yysj){
		if(!confirm("确认【"+user_name+"】已经取书！")){return false;}
		$.ajax({
	        url:'<%=url%>/tsgl/jyts.do',
			data : {id:id, user_id:user_id, book_id:book_id, yysj:yysj},
			type : 'post',
			success : function(data){
					alert(data);
					getJygl();
			}
		});
	}
	
	
	/* 分页时调用请求函数 */
	function fenye(){
		getJygl();
	}
</script>
<title>借阅管理</title>
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
			<form id="jygl_myform"  method="post">
				<span class="jyzzh"  style="margin-left: 3%">借阅者帐号:</span> 
				<input type="text" id="user_id" name="user_id" size="10px"> 
				<input type="hidden" id="pic_id" name="pic_id" value="${sessionScope.currentUser.getUser_id()}">
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				<input type="button" id="jygl_find" value="查询">
				<input type="reset" value="重置">
			</form>
		</div>
		<div id="chakan" style="width: 96%;">
			<br> <br>
			<table id="jygl_show" class="show_table" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<tr bgcolor="#ff0000" id="dd">
					<th width="30px">序号</th>
					<th width="100px">书名</th>
					<th width="100px">书号</th>
					<th width="100px">借阅者名称</th>
					<th width="100px">借阅者帐号</th>
					<th width="100px">借阅者电话</th>
					<th width="100px">预约时间</th>					
					<th width="100px">操作</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		
		</div>
	</div>
</body>
</html>