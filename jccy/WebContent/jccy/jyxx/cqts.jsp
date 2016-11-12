
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
		function getCqts(){
			$.ajax({
		        url:'<%=url%>/jyxx/cqts.do',
				data : {user_id:'${sessionScope.currentUser.getUser_id()}'},
				type : 'post',
				success : function(data) {
					if(data!=""){
						show(data);				
					}else{
						$("#cqts_show").append("<tr><td colspan='9'>您没有借阅图书喔</td></tr>");
					}
				}
			});
		}
		
		/* 查询有结果是显示函数 */
		function show(data){
			var cqtsjsp="";
				$(data).each(function(id,cqts){ 
					cqtsjsp+= '<tr><td>'+(id+1)+'</td><td title='+'\'【书   名】：'+cqts.book_name+'&#10;【出版社】：'+cqts.book_publish+'\'><span>'+cqts.book_name+'/'+cqts.book_publish+'</span></td>'
					+'<td title='+'\'【校   区】：'+cqts.book_campus+'&#10;【学   院】：'+cqts.book_academy+'&#10;【专   业】：'+cqts.book_profession+'\'>'+cqts.book_campus+'/'+cqts.book_academy+'/'+cqts.book_profession+'</td>'
					+'<td title=\''+cqts.jysj+'\'>'+cqts.jysj+'</td>'
					+'<td title=\''+cqts.dqsj+'\'>'+cqts.dqsj+'</td>'
					+'<td style=\'color:red\'>超期'+cqts.cqts+'(天)</td>'
					+'<td title=\''+cqts.pic_name+'\'>'+cqts.pic_name+'</td>'
					+'<td title='+'\'【长   号】：'+cqts.pic_lphone+'&#10;【短   号】：'+cqts.pic_sphone+'\'>'+cqts.pic_lphone+'/'+cqts.pic_sphone+'</td>'
					+'<td title=\''+cqts.pic_adress+'\'>'+cqts.pic_adress+'</td>'
					+'</tr>'
				});
				$("#cqts_show").append(cqtsjsp);
				$("#cqts_show tr").click(function(){
					$("tr").css('background','');
					$(this).css('background','#53aca4');
				});
		}
	
</script>
<title>超期图书</title>
</head>
<body style="background-color: #808080; margin: 0 auto;">
	<div class="linear">
	
		<div class="login_out">
			
		</div><br>

		<!-- 表格区 -->
		<div id="chakan" style="width: 96%;">
			 <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 超期图书 ]</font>
			<br><br>
				
			<table id="cqts_show" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<!-- 标题 -->
				<tr bgcolor="#ff0000" id="dd">
					<th width="35">序号</th>
					<th>书名/出版社</th>
					<th>校区/学院/专业</th>
					<th width="100">借阅日期</th>
					<th width="100">到期日期</th>
					<th width="100">超期天数</th>
					<th width="100">负责人</th>
					<th width="120">负责人长号/短号</th>
					<th width="100">负责人地址</th>
				</tr>
			</table>
			<br> <br> <br>
		</div>
	</div>
</body>
</html>