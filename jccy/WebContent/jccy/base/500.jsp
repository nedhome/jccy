<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<title>500</title>
</head>
<body style="text-align: center; margin: 0;">
<img class="500img" alt="" src="<%=url%>/resources/img/500.jpg">

<script type="text/javascript">
		$(function(){
		    $('.500img').height($(window).height());
		    $('.500img').width($(window).width());
		});
	</script>
</body>
</html>