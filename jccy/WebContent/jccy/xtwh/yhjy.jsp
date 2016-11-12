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
<script type="text/javascript">
	/* 请求函数 */
	function getYhjy(){
		$.ajax({
	        url:'<%=url%>/xtwh/yhjy.do',
			data : {currentPage:1},
			type : 'post',
			success : function(data) {
				$("#yhjy_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
				if(data.total==0){
					$("#yhjy_show").append("<tr><td colspan='4'>没有用户提建议喔</td></tr>");
					$("#feny_table").css("display","none");
				}else{
					$("#mainbackgroud").css("opacity","0.1");
					show(data);				
				} 
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var yhjyjsp="";
			$(data.list).each(function(id,yhjy){ 
				yhjyjsp+= '<tr onclick=\"showContent(\''+yhjy.content+'\')\"><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td><td title='+yhjy.user_id+'>'+yhjy.user_id+'</td><td title='+yhjy.content+'>'+yhjy.content+'</td><td title='+yhjy.data+'>'+yhjy.data+'</td></tr>';
	 	});
		$("#yhjy_show").append(yhjyjsp);
	}
	
	function showContent(){
		
	}
	
	/* 分页时调用请求函数 */
	function fenye(){
		getYhjy();
	} 
</script>
<title>用户建议</title>
</head>
<body>
	<div class="linear"  >
	<br>
		<div style="width: 96%;">
			<font style="margin-left: 2%; color: red; font-size: 10px; font-weight: bold;"> [ 用户建议 ]</font>
			<br><br>
			<table id="yhjy_show" class="show_table" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<tr>
				<th width="30px">序号</th>
				<th width="150px">用户帐号</th>
				<th>建议内容</th>
				<th width="180px">提交日期</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
		<!-- show content -->
		<!-- <div id="showContent" width="96%">
	    <div style="background-color:#808080;margin: auto;  
  position: absolute;  width:600px; height:400px; display:block; position: absolute;">
 </div>
	    		<p>小投入大收益，戰力提升好容易</p>
		</div> -->
	</div>
</body>
</html>