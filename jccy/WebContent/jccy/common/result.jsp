<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.ggxytxh.jccy.common.vo.Book"%>
	
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<title>搜索结果</title>
<style type="text/css">
span {
	cursor: pointer;
}

span:hover {
	color: #ff0000;
}
</style>
 <script type="text/javascript">
	$(document).ready(function() {
		$("#showtable tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
		$("#sy").click(function(){
			$("#dqy").val("1");
			$("#myform").submit();
		});
		$("#wy").click(function(){
			$("#dqy").val("${bookPage.getPages()}");
			$("#myform").submit();
		});
		$("#syy").click(function(){
			if(parseInt($("#dqy").val())<=1){
				alert("请输入有效页码！");
				return false;
			}else{
				$("#dqy").val($("#dqy").val()-1);
				$("#myform").submit();
			}
		});
		$("#xyy").click(function(){
			if(parseInt($("#dqy").val())>="${bookPage.getPages()}"){
				alert("请输入有效页码！");
				return false;
			}else{
				$("#dqy").val(parseInt($("#dqy").val())+1);
				$("#myform").submit();
			}
		});
		
		$("#tz").click(function(){
			if(parseInt($("#dqy").val())>"${bookPage.getPages()}"||$("#dqy").val()<1){
				alert("请输入有效页码！");
				return false;
			}else{
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
</head>
<!-- 
	* Page的属性有
	* pageNum：当前页
	* pages:总页数
	* pageSize:每页数量
	* total:总数
-->

<body style="vertical-align: middle;margin: 0 auto;background-color: #808080;">
	<div class="linear">
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
			<a href="javascript:top.location.href='/jccy/index.jsp';"><img class="indeximg_1" alt="信宜图书阁" src="<%=url%>/resources/img/index_1.jpg" />
			<img class="logo_img" src="<%=url%>/resources/img/logo.png"></img>
			</a><div class="logo_font">教 材 重 用 管 理 系 统</div>
		</div><br>
		<c:if test="${bookPage.getTotal()==0}">
			<script language="javascript">
				alert("噢!冇有列，矛使放弃");
				window.onload = function() {
					href = history.go(-1);
				}
			</script>
			<%if(true)return;%>
		</c:if>
		
		<input type="submit" class="btn_grey" value="返回"onClick="history.back(-1)"><br><br>
		<div align="center">
			<table id="showtable" class="showtable" style="width: 88%">
				<tr bgcolor="" height="20px">
					<th width="40px">序号</th>
					<th width="160px">书号</th>
					<th width="160px">书名</th>
					<th width="130px">校区</th>
					<th width="150px">出版社</th>
					<th width="105px">负责人</th>
					<th width="55px">可借数</th>
					<th>备注</th>
				</tr>
				<c:forEach items="${bookPage}" var="book" varStatus="bookindex">
				
					<tr>
					
						<td >${bookPage.getPageSize()*bookPage.getPageNum()+bookindex.index-bookPage.getPageSize()+1}</td>
						<td title="${book.book_id}">${book.book_id}</td>
						<td title="${book.name}">
						 <a href="<%=url%>/common/infobook.do?book_id=${book.book_id}"> ${book.name} </a>
						</td>
						<td title="${book.campus}">${book.campus}</td>
						<td title="${book.publish}">${book.publish}</td>
						<td title="${book.pic}">${book.pic}</td>
						<td title="${book.borrow_num}">${book.borrow_num}</td>
						<td title="${book.book_comment}">${book.book_comment}</td>
						
					</tr>
				</c:forEach>
			</table>
		
			 <table style="width:88%">
			 	
				<tr>
					
					
					<td style="border: 0px; color: #00478e; font-size: 12px;float: left"> [共<span style="color: red">${bookPage.getTotal()}</span>条]</td>
					<td style="border: 0px; color: #00478e; font-size: 12px;float: right">
						<form id="myform" method="post" action="findbook.do">
							<span id="sy">[ 首页</span>&nbsp; 
							<span
							id="syy">◀上一页</span>&nbsp;
							当前 
							<input type="text" name="currentPage" id="dqy" value="${bookPage.getPageNum()}"
							style="width: 28px; color: red; background: #89CCCC;" onkeyup="this.value=this.value.replace(/\D/g,'')">
							/${bookPage.getPages()}页 
							<span id="tz"> 跳转</span>
							<span id="xyy">下一页▶</span>&nbsp;
							<span id="wy">尾页 ]</span>
							<input type="hidden" id="campus" name="campus" value="${book.getCampus()}">
							<input type="hidden" id="name" name="name" value="${book.getName()}">
						</form>
					</td>
				</tr>
			</table> 
			<%-- <%@include file="../base/fenye.jsp"%> --%>
		</div>
		<br><br><br>
		<%@include file="../base/footer.jsp"%>
	</div>
</body>
</html>