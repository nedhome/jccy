 <%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 <%String url = request.getContextPath();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<script src="<%=url%>/resources/js/tab.js" type="text/javascript"></script>

<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>常用tab切换</title>
</head>
<style type="text/css">
.to_index{
	margin-left:5px;
	height:23px;
	margin-bottom:0px;
	width: 40px;
	background:lightblue;
	float: left;
	color:red;
	position: absolute;
	box-shadow: 0 0 2px #029afb;
}
.news{/* 消息 */
  	background:url(<%=url%>/resources/img/notice.gif) no-repeat left;
} 
</style>
<script type="text/javascript">

	 function showNews(){
			window.top.frames['main'].addtab("消息中心","<%=url%>/jccy/grxx/xxzx.jsp","xxzx");
        	window.top.frames['main'].iframe_xxzx.onload = function() {
        		window.top.frames['main'].iframe_xxzx.getNews();
        	}
	 }
</script>

<body style="margin:0;padding: 0;">

	<!-- 信息与登录  -->
	<div style="float: right; margin-right: 1%; color: #01c5f6;">
		<c:if test="${sessionScope.currentUser!=null}">
			<input type="button" 
				class='news'
				value="您有 (0)条信息"
				onclick="showNews()"
				style=" width: 110px; background-color: transparent; box-shadow: 0 0 0px #ffffff;">
			
			<input type="button"
				value="${sessionScope.currentUser.getName()}"
				style=" width: 80px; background-color: transparent; box-shadow: 0 0 0px #ffffff;">

			<input type="button" value="退出 |"
				style="width: 40px; background-color: transparent; box-shadow: 0 0 0px #ffffff;"
				onclick="javascript:top.location.href='<%=url%>/logout.do'">
		</c:if>
	</div>
	
	<button class="to_index" 
			onclick="javascript:top.location.href='<%=url%>/index.jsp';">主页</button>
		
	<div id="tab" >
		<ul id="tab_title">
			<li class="on" id="title_1" style="top:0px;text-align: center;width: 36px">首页</li>
		</ul>
		
		<ul id="tab_content" style="border: 0">
			<li id="content_1">
				<iframe name='iframe_sy' id='indexiframe' frameborder='0' scrolling='auto' style='width:100%;' src="<%=url%>/jccy/base/index.jsp"></iframe>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
		$(function(){
		    $('#indexiframe').height($(window).height());
		});
	</script>
</body>
</html>