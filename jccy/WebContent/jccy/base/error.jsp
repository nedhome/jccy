<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String url = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>error</title>
<script language="javascript">
	if("${login_message}"!=""){
		alert("${login_message}");
	}
    window.onload=function(){
		window.location.href = "<%=url%>/login.jsp";
	}
</script>
</head>
<body>
</body>
</html>