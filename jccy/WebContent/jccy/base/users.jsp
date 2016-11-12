
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%String url = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<script type="text/javascript">
	window.onload=function(){
		if("${sessionScope.currentUser}"==""){
			top.location.href="<%=url%>/index.jsp";
		}
		
	}
</script>
<title>我的图书馆</title>
</head>
<frameset rows="13%,*,4%" id="mainbackgroud" border="0" >
	<!-- logo -->
	<frame src="./logo.jsp" name="logo"  scrolling="no" noresize="noresize"/>
	<frameset cols="13%,87%"  border="0" >
		<frame src="./left.jsp" name="left" scrolling="no" noresize="noresize" frameborder="1"/>
		<frame src="./main.jsp" name="main" scrolling="no" noresize="noresize" frameborder="1"/>
	</frameset>
	<frame src="./footer.jsp" name="footer" scrolling="no" noresize="noresize"/>
</frameset>
</html>