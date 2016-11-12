<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<title>main</title>
<style type="text/css">

.mid {
	/* background: url(${pageContext.request.contextPath}/resources/img/index.png) ; */
	text-align: center;
	margin-left: 8%;
	margin-right: 8%;
	position: relative;
}

.mid_img {
	filter: alpha(opacity = 70);
	-moz-opacity: 0.7;
	-khtml-opacity: 0.7;
	opacity: 0.7;
	-radius: 6px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#users_main").animate({
			width : "98%",
			right : "500px"
		}, 5000);
	});
</script>

</head>
<body style="overflow:hidden"> 
	<div class="indeximg"  style=" background: url(${pageContext.request.contextPath}/resources/img/index.png);background-size:cover;background-repeat:no-repeat;width:100%;text-align: center;no">

		<br><br><br>
		<div class="mid">
			<img class="mid_img" alt="" src="<%=url%>/resources/img/users/users_main.png"
				id="users_main" 
				style="height: 450px; width: 0px; margin-bottom: 20px; margin-top: 0px;">
		</div>
	</div>
<script type="text/javascript">
$(function(){
    $('.indeximg').height($(window).height());
});
</script>
</body>
</html>