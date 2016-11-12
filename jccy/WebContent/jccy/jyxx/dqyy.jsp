
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%String url = request.getContextPath();%>

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
span {
	cursor: pointer;
}

span:hover {
	color: #ff0000;
}
</style>
<script type="text/javascript">
	
	/* 请求函数 */
	function getDqyy(){
		$.ajax({
	        url:'<%=url%>/jyxx/dqyy.do',
			data : {user_id:'${sessionScope.currentUser.getUser_id()}'},
			type : 'post',
			success : function(data) {
				if(data == "" || data == null || data == undefined ||data.total==0){
					$("#dqyy_show").append("<tr><td colspan='10'>您没有预约图书喔</td></tr>");
				}else{
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var dqyyjsp="";
   		$(data).each(function(id,dqyy){ 
   			dqyyjsp+= '<tr><td>'+(id+1)+'</td><td title='+'\'【书  号】：'+dqyy.book_id+'\'>'+dqyy.book_id+'</td><td title='+'\'【书   名】：'+dqyy.book_name+'&#10;【出版社】：'+dqyy.book_publish+'\'><span>'+dqyy.book_name+'/'+dqyy.book_publish+'</span></td>'
   			+'<td title='+'\'【校   区】：'+dqyy.book_campus+'&#10;【学   院】：'+dqyy.book_academy+'&#10;【专   业】：'+dqyy.book_profession+'\'>'+dqyy.book_campus+'/'+dqyy.book_academy+'/'+dqyy.book_profession+'</td>'
   			+'<td title=\''+dqyy.yysj+'\'>'+dqyy.yysj+'</td>'
   			+'<td title=\''+dqyy.gqsj+'\'>'+dqyy.gqsj+'</td>'
   			+'<td title=\''+dqyy.pic_name+'\'>'+dqyy.pic_name+'</td>'
   			+'<td title='+'\'【长   号】：'+dqyy.pic_lphone+'&#10;【短   号】：'+dqyy.pic_sphone+'\'>'+dqyy.pic_lphone+'/'+dqyy.pic_sphone+'</td>'
   			+'<td title=\''+dqyy.pic_adress+'\'>'+dqyy.pic_adress+'</td>'
   			+'<td><span onclick=\"deleteYy(\''+dqyy.dqyy_id+'\',\''+dqyy.book_name+'\')\">取消预约</span></td>'
   			+'</tr>'
   			});
   		$("#dqyy_show").append(dqyyjsp);
   		$("#dqyy_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	/* 取消预约 */
	function deleteYy(yyid,book_name){
		if (confirm("你确定要取消【 "+book_name+" 】的预约吗？")) {
			$.ajax({
				url:'<%=url%>/jyxx/deletedqyy.do',
				data : {dqyyId:yyid},
				type : 'post',
				success : function(data) {
					alert(data);
					$("#dqyy_show tr:gt(0)").remove();
					getDqyy();
				}
			});
		}
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>当前预约</title>
</head>
<body>
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
		<div id="chakan" style="width: 96%;">
		   <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 最 多 预 约 15 本 ]</font>
			<br><br>
			<table id="dqyy_show" style="word-break: break-all; word-wrap: break-word;width: 100%">
				
				<tr bgcolor="#ff0000" id="dd">
					<th width="30px">序号</th>
					<th width="100px">书号</th>
					<th width="150px">书名/出版社</th>
					<th width="200px">校区/学院/专业</th>
					<th width="70px">预约时间</th>
					<th width="70px">过期时间</th>
					<th width="70px">负责人</th>
					<th width="150px">负责人长号/短号</th>
					<th width="60px">取书地址</th>
					<th width="50px">操作</th>
				</tr>
			</table>
		</div>
	</div>
	<script>
		var bodyWidth = $(window).width();
		if(bodyWidth<910){
			$(".linear").width("1500px");
		}
	</script>
</body>
</html>