<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath();
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
	function getDqjy(){
		$.ajax({
	        url:'<%=url%>/jyxx/dqjy.do',
			data : {user_id:'${sessionScope.currentUser.getUser_id()}'},
			type : 'post',
			success : function(data) {
				if(data == "" || data == null || data == undefined ||data.total==0){
					$("#dqjy_show").append("<tr><td colspan='11'>您没有借阅图书喔</td></tr>");
				}else{
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var dqjyjsp="";
		var xujie={"0":"<span>续 借</span>","1":"<div  style='color:#808080'>已续借</div>"};
   		$(data).each(function(id,dqjy){
   			dqjyjsp+= '<tr><td>'+(id+1)+'</td><td onclick=\"xuJie(\''+dqjy.dqjy_id+'\',\''+dqjy.book_name+'\',\''+dqjy.xjbj+'\')\">'+xujie[dqjy.xjbj]+'</td><td>'+dqjy.book_id+'</td><td title='+'\'【书   名】：'+dqjy.book_name+'&#10;【出版社】：'+dqjy.book_publish+'\'><span>'+dqjy.book_name+'/'+dqjy.book_publish+'</span></td>'
   			+'<td title='+'\'【校   区】：'+dqjy.book_campus+'&#10;【学   院】：'+dqjy.book_academy+'&#10;【专   业】：'+dqjy.book_profession+'\'>'+dqjy.book_campus+'/'+dqjy.book_academy+'/'+dqjy.book_profession+'</td>'
   			+'<td title=\''+dqjy.jysj+'\'>'+dqjy.jysj+'</td>'
   			+'<td title=\''+dqjy.dqsj+'\'>'+dqjy.dqsj+'</td>'
   			+'<td title=\''+dqjy.pic_name+'\'>'+dqjy.pic_name+'</td>'
   			+'<td title='+'\'【长   号】：'+dqjy.pic_lphone+'&#10;【短   号】：'+dqjy.pic_sphone+'\'>'+dqjy.pic_lphone+'/'+dqjy.pic_sphone+'</td>'
   			+'<td title=\''+dqjy.pic_adress+'\'>'+dqjy.pic_adress+'</td>'
   			+'<td><span onclick=\"guaShi(\''+dqjy.dqjy_id+'\',\''+dqjy.book_name+'\',\''+dqjy.book_id+'\')\">挂失</span></td>'
   			+'</tr>'
   		});
   		$("#dqjy_show").append(dqjyjsp);
   		$("#dqjy_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	/* 续借图书 */
	function xuJie(jyid,book_name,xjbj){
		if (xjbj==1) {return;}
		if (confirm("你确定要续借【 "+book_name+" 】吗？")) {
			$.ajax({
				url:'<%=url%>/jyxx/xujie.do',
				data : {dqjyId:jyid},
				type : 'post',
				success : function(data) {
					alert(data);
					$("#dqjy_show tr:gt(0)").remove();
					getDqjy();
				}
			});
		}
		
	}
	
	function guaShi(gsid,book_name,bookid){
		if (confirm("你确定要挂失【 "+book_name+" 】吗？")) {
			$.ajax({
				url:'<%=url%>/jyxx/guashi.do',
				data : {gsID:gsid,book_id:bookid,name:book_name},
				type : 'post',
				success : function(data) {
					alert(data);
					$("#dqjy_show tr:gt(0)").remove();
					getDqjy();
				}
			});
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>当前借阅</title>
</head>

<body style="background-color: #808080;margin: 0 auto;">

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
		   <font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 最 多 借 阅 30 本 ]</font>
			<br><br>
			<table id="dqjy_show" style="word-break: break-all; word-wrap: break-word;width: 100%">
				<tr bgcolor="#ff0000" id="dd">
					<th width="30">序号</th>
					<th width="50">续借</th>
					<th >书号</th>
					<th >书名/出版社</th>
					<th >校区/学院/专业</th>
					<th width="80">借阅日期</th>
					<th width="80">到期日期</th>
					<th width="80">负责人</th>
					<th width="100">负责人长/短号</th>
					<th width="80">负责人地址</th>
					<th width="50">挂失</th>
				</tr>
				
			</table>
			
		</div>
	</div>			
</body>
</html>