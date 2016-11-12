<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<script src="<%=url%>/resources/js/jquery-1.9.1.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css"
	type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书详情</title>
<style type="text/css">
body {
	background: lightblue;
	margin: 0 auto;
}

td {
	height: 29px;
	white-space: normal; /* 不换行 */
}

.mid {
	margin-left: 8%;
	margin-right: 8%;
	margin-bottom: 15px;
	margin-top: 25px;
}

.mid table {
	box-shadow: 0 0 12px #029afb;
	border: 1px solid #33CCFF;
	width: 100%;
	margin-left: 0;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		
		/* 预约 */
		$("#tsyy").click(function cqtuCheck(){
			if(logincheck())return;
			if(parseInt($("#borrow_num").text())<=0){alert("库存暂时没有了");returns;}
			if (!confirm("确定要预约吗!")) {
				return false;
			}	
			
			$("#tsyy").attr("disabled",true);
			$.ajax({  
		     	 url:'<%=url%>/tsgl/tsyy.do',  
		     	 data : {user_id:"${sessionScope.currentUser.getUser_id()}",book_id:"${map['bookInfo'].book_id}"},
		         type:'post',  
		         datatype:"json",
		         success: function(data){
               		alert(data);  
               		if(data==="预约成功！"){//可借数减一
               			$("#borrow_num").html(parseInt(parseInt($("#borrow_num").text())-1));
               		}
               		$("#tsyy").attr("disabled", false);
               }
		   }) 		
		});
		
		/* 收藏 */
		$("#tssc").click(function cqtuCheck(){
			if(logincheck())return;
			if (!confirm("确定要收藏吗!")) {
				return false;
			}
			$("#tssc").attr("disabled",true);
			$.ajax({  
				url:'<%=url%>/tsgl/tssc.do',
				data : {
					user_id : "${sessionScope.currentUser.getUser_id()}",
					book_id : "${map['bookInfo'].book_id}"
				},
				type : 'post',
				datatype : "json",
				success : function(data) {
					alert(data);
					$("#tssc").attr("disabled", false);
				}
			});
		});

		function logincheck() {
			var flag = '${sessionScope.currentUser}';
			if (flag == null || flag == "") {
				alert("请先登录！");
				return true;
			}
		}
	});
</script>
<script>
			$(function() {
				isPhone();
				is_iPad();
			})

			function isPhone() {
				var isIpad = 0;
				if (/AppleWebKit.*mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
					if (window.location.href.indexOf("?mobile") < 0) {
						if (/iPad/i.test(navigator.userAgent)) {
							isIpad = 0;
						} else {
							isIpad = 1;
						}
					} else {
						isIpad = 1;
					}
				} else if (window.screen.width > 800) {
					isIpad = 0;
				}
				if (isIpad == 1) {
					$(".flshTestTwo").hide();$(".flshTest").hide();
				}
			}

			function is_iPad() {
				var ua = navigator.userAgent.toLowerCase();
				if (ua.match(/iPad/i) == "ipad") {
					$(".flshTestTwo").hide();$(".flshTest").hide();
				}
			}
		</script>
</head>
<body>
	<!-- logo -->


	<div class="flshTest" style="position: absolute;right:16%;top:0px;"> 
			<object  >
			  <param name="src" value="<%=url%>/resources/flash/16.swf" />
			  <embed src="<%=url%>/resources/flash/16.swf"></embed>
			  <param name="wmode" value="transparent">
			</object>
	</div>

		<div class="flshTestTwo" style="position: absolute;right:16%;top:0px;"> 
			<object  >
			  <param name="src" value="<%=url%>/resources/flash/5.swf"/>
			  <embed src="<%=url%>/resources/flash/5.swf"></embed>
			  <param name="wmode" value="transparent">
			</object>
		</div>

	<div id='logo'>
		<a href="javascript:top.location.href='/jccy/index.jsp';"><img
			class="indeximg_1" alt="信宜图书阁"
			src="<%=url%>/resources/img/index_1.jpg" /> <img class="logo_img"
			src="<%=url%>/resources/img/logo.png"></img> </a>
		<div class="logo_font">教 材 重 用 管 理 系 统</div>
	</div>
	<br>

	<input type="button" value="返回" onClick="history.back(-1)">

	<!-- loginCheck -->
	<div style="float: right; margin-right: 3%; color: #01c5f6;">
		<c:if test="${sessionScope.currentUser==null}">
			<input type="button" value="登录 |"
				onclick="javascript:top.location.href='<%=url%>/login.jsp'">
		</c:if>
	</div>
	
	<!-- details -->
	<div class="mid">
		<table>
			<tr>
				<td rowspan="7" style="text-align: center; width: 330px; height: 500px;bottom: 0">
					<!-- 图片显示 --> 
					<span>
					<img id="pic" width="150px" height="200px" alt="封面" src="<%=url%>/${map['bookInfo'].picture_path}" style="margin:0; text-align: center;top:0px" /><br>
					</span>
					<br>
					<script type="text/javascript">
						$("#pic").mouseover(function() {
							$(this).width(329);
							$(this).height(450);
						}).mouseout(function() {
							$(this).width(150);
							$(this).height(200);
						});
					</script>
					<div>
					<input type="button" id="tsyy" value="预   约" /> 
					<input type="button" id="tssc" value="收   藏" style="margin-bottom: 8px"/></div>
				</td>

				<td width="80px">书&nbsp;&nbsp;&nbsp;名</td>
				<td>${map['bookInfo'].name}</td>
				<td  width="80px">书&nbsp;&nbsp;&nbsp;号</td>
				<td>${map['bookInfo'].book_id}</td>
				
			</tr>
			<tr>
				<td >联系人</td>
				<td>${map['pic'].name}</td>
				
				<td>地&nbsp;&nbsp;&nbsp;址</td>
				<td>${map['pic'].address} </td>
			</tr>
			
			<tr>
				<td>长&nbsp;&nbsp;&nbsp;号</td>
				<td>${map['pic'].lphone} </td>
				
				<td>短&nbsp;&nbsp;&nbsp;号</td>
				<td>${map['pic'].sphone} </td>
			</tr>
			

			<tr>
				<td >出版社</td>
				<td>${map['bookInfo'].publish} </td>
				
				<td>校&nbsp;&nbsp;&nbsp;区</td>
				<td>${map['bookInfo'].campus} </td>
			</tr>
			<tr>
				<td>学&nbsp;&nbsp;&nbsp;院</td>
				<td>${map['bookInfo'].academy} </td>
				
				<td>专&nbsp;&nbsp;&nbsp;业</td>
				<td>${map['bookInfo'].profession} </td>
			</tr>
			
			<tr>
				<td>提供者</td>
				<td>${map['bookInfo'].contributor} </td>
				
				<td>可借数</td>
				<td>还有<label id="borrow_num">${map['bookInfo'].borrow_num}</label> 本 </td>
			</tr>
		
			<tr height="65px">
				<td>备&nbsp;&nbsp;&nbsp;注</td>
				<td colspan="3" >${map['bookInfo'].book_comment}</td>
			</tr>
		</table>
	</div>

	<!-- footer -->
	<%@include file="../base/footer.jsp"%>

</body>
</html>