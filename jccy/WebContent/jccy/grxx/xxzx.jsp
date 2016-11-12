
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
<style type="text/css">
body {
	background-color: #808080;
	margin: 0 auto;
}

span {
	cursor: pointer;
}

span:hover{ 
	color:#ff0000; 
}

.zt, .nr, .ztai, .qssj, .zzsj {
	font-size: 12px;
	color: #33CCFF;
}
.news_show {
	color: #6e2300;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		/*查询按钮调用*/
		$("#xxzx_find").click(function(){
			getNews();
		});
	});
	
	/* 请求函数 */
	function getNews(){
		$.ajax({
	        url:'<%=url%>/grxx/xxzx.do',
			data : $("#xxzx_myform").serialize(),
			type : 'post',
			beforeSend: function(){  
			    var height = document.body.scrollWidth + "px";//滚动位置可能大于屏幕高度  
			    
			    $("#bg").css("display","block").css("height",height).css("text-align","center").html('<img style="padding-top:200px;"    src="<%=url%>/resources/img/loading.gif" />');  
			    
			},  
			complete:function(data) {
				$('#bg').css("display","none");
			},//#bg是遮蔽层div  
			success : function(data) {
				$("#news_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
				if(data.total==0){
					$("#news_show").append("<tr><td colspan='6'>没有结果</td></tr>");
				}else{
					show(data);				
				}
			}
		});
	}
	
	/* 查询有结果是显示函数 */
	function show(data){
		var newsjsp="";
   		$(data.list).each(function(id,news){ 
     		newsjsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td><td title='+news.theme+'>'+news.theme+'</td><td title='+news.content+'>'+news.content+'</td><td>'+news.bgtime+'</td><td>'+news.fqr+'</td><td>'+news.zt+'</td></tr>';
     	});
   		$("#news_show").append(newsjsp);
   		$("#news_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	/* 分页时调用请求函数 */
	function fenye(){
		getNews();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息中心</title>
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
		<div>
			<form id="xxzx_myform" action="xxzx" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				<input type="hidden" name="user_id" value="${sessionScope.currentUser.getUser_id()}">
				<span class="zt"  style="margin-left: 3%">主题:</span> 
				<input type="text" id="zhuti" name="theme" size="10px"> 
				<span class="nr">内容:</span>
				<input type="text" id="neirong" name="content" size="18px">
				<span class="ztai">状态:</span> 
				<select  id="zt" name="zt" style=" height: 18px; border: 0;">
					<option value="0">全部</option>
					<option value="1">已处理</option>
					<option value="2">待处理</option>
				</select> 
				<span class="qssj">起始时间:</span> 
				 <input  class="laydate-icon" id="begintime" name="bgtime" style="border: 0px;">
				<span class="zzsj">终止时间:</span>
				<input class="laydate-icon"  id="endtime" name="endtime" style="border: 0px;">  
				<input type="button" id="xxzx_find" value="查询">
				<input type="reset" value="重置">
			</form>
		</div>
		<!-- 这个放在这里的原因是当return后无法加载 -->
		<script>
			var start={
				elem : '#begintime',
				format : 'YYYY-MM-DD',
				min : '1099-06-16',//laydate.now(), 设定最小日期为当前日期
				max : '2099-06-16', //最大日期
				istime : true,
				istoday : false,
				choose : function(datas) {
					end.min=datas; //开始日选好后，重置结束日的最小日期
					end.start=datas //将结束日的初始值设定为开始日
				}
			};
			var end={
				elem : '#endtime',
				format : 'YYYY-MM-DD',
				min : '1099-06-16',
				max : '2099-06-16',
				istime : true,
				istoday : false,
				choose : function(datas) {
						start.max=datas; //结束日选好后，重置开始日的最大日期
				}
			};
			laydate(start);
			laydate(end);
		</script>		
		<div id="chakan" style="width: 96%;">
			<br> <br>
			<table id="news_show" class="show_table" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<tr bgcolor="#ff0000" id="dd">
					<th width="30px">序号</th>
					<th width="200px">主题</th>
					<th width="390px">内容</th>
					<th width="160px">发起时间</th>
					<th width="160px">发起人员</th>
					<th width="100px">状态</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
			<br><br><br>
		</div>
	</div><div id="bg" style="display: none;"></div>
	<script>
		var bodyWidth = $(window).width();
		if(bodyWidth<910){
			$(".linear").width("1110px");
		}
	</script>
</body>
</html>