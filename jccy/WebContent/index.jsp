
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%String url = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="SHORTCUT ICON" href="<%=url%>/resources/img/favicon.ico">
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />

<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<style type="text/css">
body {
	vertical-align: middle;
	position: relative;
	color: #0066CC;
	font-size:15px;
}

.choose {
	text-align: center;
	height: auto;
	margin-bottom: 100px;
	
}

.find {
	text-align: center;
	margin-top: 40px;
	font-size: 16px;
}
.xtgg {

	display:none;
	box-shadow: 0 0 30px #000000;
	margin-top:150px;
	width:220px;
	height:550px;
	-moz-opacity:0.7;
	opacity:0.7; 
	-khtml-opacity: 0.7;
	position: absolute;
	
}
.showgg{
	border-radius: 2px;
	margin-top:170px;
	margin-left:0px;
	text-align:center;
	background:#lightblue;
	box-shadow: 0 0 3px #000000;
	width:20px;
	height:40px;
	position: absolute;
	
}

/* .showfx{
	border-radius: 2px;
	margin-top:250px;
	margin-left:0px;
	text-align:center;
	background:#lightblue;
	box-shadow: 0 0 3px #000000;
	width:20px;
	height:60px;
	position: absolute;
	
} */
 
.choose img {
	border-radius: 8px;
	box-shadow: 0 0 30px #000000;
	margin-right: 30px;
	-moz-opacity:0.7;
	opacity:0.7; 
	-khtml-opacity: 0.7;
	
}
.choose img:hover {
   -webkit-transform: scale(1.1);
   transform: scale(1.1);
   box-shadow: 0 0 30px #014b30;
}
.news{/* 消息 */
  	background:url(<%=url%>/resources/img/notice.gif) no-repeat left;
} 
</style>
<script type="text/javascript">
	window.onload=getGG;
	
	function getGG(){
		$.ajax({
			url:"<%=url%>/common/getxtgg.do",
			type:"post",
			success:function(data){
				$("#ggtitle").html(data.title);
				$("#ggcontent").html('&nbsp;&nbsp;'+data.content);
				$("#ggdate").html(data.date);
				var today = new Date().toLocaleDateString();
    			var ggDate = new Date(data.date).toLocaleDateString();
    			if(today === ggDate){showGg();}

			}
		})
	}

	function check() {
		if (document.getElementById("name").value == "") {
			alert("对不起，请输入关键字!");
			return false;
		}
	}
	
	function loginCheck(){
		if("${sessionScope.currentUser}"!=""){
			location.href="<%=url%>/jccy/base/users.jsp";
		}else{
			alert("你还没有登录！");
			location.href="<%=url%>/index.jsp";
		}
	}
	
	function showGg(){
		document.getElementById("xtgg").style.display='block';
		document.getElementById("showgg").style.display='none';
		document.getElementById("showfx").style.display='none';
	}
	function closeGg(){
		document.getElementById("xtgg").style.display='none';
		document.getElementById("showgg").style.display='block';
		document.getElementById("showfx").style.display='block';
	}
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

<title>首页</title>
</head>
<body>
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

		<div>
			<div class="xtgg" onmouseover="showGg()" onmouseout="closeGg()"
				id="xtgg">
				<h4 id="ggtitle" style="text-align: center;"></h4>
				<div id="ggcontent" style="height:70%; font-size: 15px; color: #010101;overflow: auto;"></div>
				<br>
				<div id="ggdate" style="float: right; margin-right: 15px;"></div>
				<br>
				<h5 id="ggpic" style="float: right; margin-right: 10px;">广工信宜同乡会</h5>
			</div>
			<div class="showgg" id="showgg" onmouseover="showGg()">公告</div>
		</div>
		
		<div id='logo'>
			<a href="javascript:top.location.href='/jccy/index.jsp';"><img class="indeximg_1" alt="信宜图书阁" src="<%=url%>/resources/img/index_1.jpg" />
			<img class="logo_img" src="<%=url%>/resources/img/logo.png"></img>
			</a><div class="logo_font">教 材 重 用 管 理 系 统</div>
		</div><br>
	

		<div style="float: right; margin-right: 3%; color: #01c5f6;">
			<c:if test="${sessionScope.currentUser==null}">
				<input type="button" value="登录 |"
					onclick="javascript:top.location.href='<%=url%>/login.jsp'">
			</c:if>
			
			<c:if test="${sessionScope.currentUser!=null}">
				<input type="button" class='xiaoxi'
					value="您有 （ 0 ）条信息"
					style=" width: 150px; background-color: transparent; box-shadow: 0 0 0px #ffffff;">
				
				<input type="button"
					value="${sessionScope.currentUser.getName()}"
					style=" width: 100px; background-color: transparent; box-shadow: 0 0 0px #ffffff;">
	
				<input type="button" value="退出 |"
					style="width: 40px; background-color: transparent; box-shadow: 0 0 0px #ffffff;"
					onclick="javascript:top.location.href='<%=url%>/logout.do'">
			</c:if>
		</div>
		
		<!-- 普通用户登录 -->
		<div id="afterlogin">
			<div class="find">
				<form action="<%=url%>/common/findbook.do" method="post" onSubmit="return check()">
					<div class="xiaoqu">
						<span>请选择校区： </span>
						<select id="xiaoqu_id" name="campus" style="margin-bottom:4px; background-color:#edfafe; height: 17px;border: 0;">
							<option value="1">全部</option>
							<option value="2">大学城校区</option>
							<option value="3">东风路校区</option>
							<option value="4">龙洞校区</option>
							<option value="5">番禺校区</option>
						</select>
					</div>
					<span>输入关键字: </span>
					<input type="text" id="name" name="name" maxlength="250" style="width:373px;" />&nbsp;&nbsp; 
					<input type="hidden" id="cpag" name="currentPage" value="1">
					<input type="submit" name="" value="查 找" /> 
					<input type="reset" name="reset" value="重 置" />
				</form>
			</div>
			<div class="choose">
				<br>
				<br> <a href="#"> <img
					class="txhjs" alt="同乡会介绍" onclick="javascript:alert('测试成功，敬请期待！');"
					src="<%=url%>/resources/img/jieshao.jpg">
				</a> <a href="<%=url%>/common/findcontribution.do?currentPage=1"> <img class="gxgrb" alt="贡献光荣榜"
					src="<%=url%>/resources/img/contribution.jpg">
				</a> <a href="<%=url%>/jccy/common/supperfindbook.jsp"> <img class="gjssq" alt="高级搜索区"
					src="<%=url%>/resources/img/supperfind.jpg">
				</a> <br><br>
				<br> <a href="#"> <img class="wdtsg" alt="我的图书馆" onclick="loginCheck()"
					src="<%=url%>/resources/img/myself.jpg">
				</a> <a href="#"> <img class="more" alt="更多选择项"
					src="<%=url%>/resources/img/more.jpg" onclick="javascript:alert('测试成功，敬请期待！');">
				</a><br> <br>
			</div>
		</div>
		
		<%@include file="../jccy/base/footer.jsp"%>
		
		
	</div>
	<div class="showfx" id="showfx">
		<script>
			window._bd_share_config = {
				"common" : {
					"bdSnsKey" : {},
					"bdText" : "图书阁",
					"bdMini" : "1",
					"bdMiniList" : [ "qzone", "tsina", "weixin", "sqq", "renren","douban", "fbook", "twi", "linkedin" ],
					"bdPic" : "",
					"bdStyle" : "0",
					"bdSize" : "16"
				},
				"slide" : {
					"type" : "slide",
					"bdImg" : "6",
					"bdPos" : "right",
					"bdTop" : "193.50262451171875"
				}
			};
			with (document)
				0[(getElementsByTagName('head')[0] || body)
						.appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='
						+ ~(-new Date() / 36e5)];
		</script>
	</div>
	<div style="display:none;"><script src="http://s95.cnzz.com/z_stat.php?id=1259269026&web_id=1259269026" language="JavaScript"></script></div>
</body>
</html>