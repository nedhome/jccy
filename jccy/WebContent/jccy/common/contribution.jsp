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
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css"
	type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js"
	type="text/javascript"></script>
<style type="text/css">
span {
	cursor: pointer;
}

span:hover {
	color: #ff0000;
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#showtable tr").click(function() {
							$("tr").css('background', '');
							$(this).css('background', '#53aca4');
						});
						$("#sy").click(function() {
							$("#dqy").val("1");
							$("#myform").submit();
						});
						$("#wy").click(function() {
							$("#dqy").val("${contributionPage.getPages()}");
							$("#myform").submit();
						});
						$("#syy").click(function() {
							if (parseInt($("#dqy").val()) <= 1) {
								alert("请输入有效页码！");
								return false;
							} else {
								$("#dqy").val($("#dqy").val() - 1);
								$("#myform").submit();
							}
						});
						$("#xyy")
								.click(
										function() {
											if (parseInt($("#dqy").val()) >= "${contributionPage.getPages()}") {
												alert("请输入有效页码！");
												return false;
											} else {
												$("#dqy").val(
														parseInt($("#dqy")
																.val()) + 1);
												$("#myform").submit();
											}
										});

						$("#tz")
								.click(
										function() {
											if (parseInt($("#dqy").val()) > "${contributionPage.getPages()}"
													|| $("#dqy").val() < 1) {
												alert("请输入有效页码！");
												return false;
											} else {
												$("#myform").submit();
											}
										});
					})
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>贡献光荣榜</title>
</head>
<body style="background-color: #808080; margin: 0 auto;">
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
	<div class="linear">
		<div id='logo'>
			<a href="javascript:top.location.href='/jccy/index.jsp';"><img
				class="indeximg_1" alt="信宜图书阁"
				src="<%=url%>/resources/img/index_1.jpg" /> <img class="logo_img"
				src="<%=url%>/resources/img/logo.png"></img> </a>
			<div class="logo_font">教 材 重 用 管 理 系 统</div>
		</div>
		<br>
		<input type="button" value="返&nbsp;&nbsp;回" onClick="history.back(-1)">
		<br>
		<!-- 表格区 -->
		<div
			style="margin-right: 8%; margin-left: 8%; box-shadow: 0 0 18px #029afb; text-align: center;">
			<br> <br>
			<table id="showtable" style="width: 96%">

				<tr style="height: 30px;">
					<th width="40px">序号</th>
					<th>捐赠者</th>
					<th>书名</th>
					<th>书号</th>
					<th>出版社</th>
					<th>捐赠日期</th>
				</tr>

				<!-- 没有结果 -->
				<c:if test="${contributionPage.getTotal()==0}">
					<tr>
						<td colspan="6">没有记录</td>
					</tr>
					<tr>
						<td colspan="6" style="border: 0; text-align: right;"><span
							style="color: red" onClick="history.back(-1)">[&nbsp;返&nbsp;回&nbsp;]&nbsp;</span>
						</td>
					</tr>
					<!-- 停止网页渲染 -->
					<%
						if (true)
								return;
					%>
				</c:if>
				<!-- 遍历List -->

				<c:forEach items="${contributionPage}" var="contribution"
					varStatus="contributionindex">
					<tr>
						<td title="${contribution.id}">${contributionPage.getPageSize()*contributionPage.getPageNum()+contributionindex.index-contributionPage.getPageSize()+1}</td>
						<td title="${contribution.contributor_name}">${contribution.contributor_name}</td>
						<td title="${contribution.book_name}"><a
							href="<%=url%>/common/infobook.do?book_id=${contribution.book_id}">
								${contribution.book_name} </a></td>
						<td title="${contribution.book_id}">${contribution.book_id}</td>
						<td title="${contribution.book_publish}">${contribution.book_publish}</td>
						<td title="${contribution.on_time}">${contribution.on_time}</td>
					</tr>
				</c:forEach>
			</table>
			<table style="width: 96%;">
				<tr>
					<td
						style="border: 0px; color: #00478e; font-size: 12px; float: left">
						[共<span style="color: red">${contributionPage.getTotal()}</span>条]
					</td>
					<td
						style="border: 0px; color: #00478e; font-size: 12px; float: right">
						<form id="myform" method="post" action="findcontribution.do">
							<span id="sy">[ 首页</span>&nbsp; <span id="syy">◀上一页</span>&nbsp;
							当前 <input type="text" name="currentPage" id="dqy"
								value="${contributionPage.getPageNum()}"
								style="font-size: 2px; width: 28px; color: red; background: #89CCCC;" onkeyup="this.value=this.value.replace(/\D/g,'')">
							/ ${contributionPage.getPages()} 页 <span id="tz"> 跳转</span> <span
								id="xyy">下一页▶</span>&nbsp; <span id="wy">尾页 ]</span>
						</form>
					</td>
				</tr>
			</table>
			<br>
		</div>
		<br>
		<%@include file="../base/footer.jsp"%>
	</div>
</body>
</html>