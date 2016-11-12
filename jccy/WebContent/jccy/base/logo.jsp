<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String url = request.getContextPath();
	%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
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
<body style="margin:0 auto; background-color:lightblue;" >
	
	<div id="time" style="color: yellow; position: absolute; margin-left: 1%; margin-top: 6%; height: 30px;">
		<script>
			//setInterval("time.innerHTML='现在是:'+new Date().toLocaleString()");
			$(function(){
			    $('.indeximg_1').height(($(window).height()));
			    $('.indeximg_1').width($(window).width());
			});
		</script>
	</div> 
	
	<div id='logo'>
		<img class="indeximg_1" alt="信宜图书阁" src="<%=url%>/resources/img/index_1.jpg" />
		<div class="logo_font" style="position: absolute; top: 10px;left: 180px ;font-weight:bolder;color: #005CB9;font-family: 微软雅黑;font-size: 55px;">教 材 重 用 管 理 系 统</div>
		<img class="logo_img" src="<%=url%>/resources/img/logo.png" style="position: absolute; top:10px;left: 32px;width: 120px;height: 80px;" ></img>
	</div>

	<div class="flshTest" style="position: absolute;right:16%;top:0px;display:"> 
			<object  >
			  <param name="src" value="<%=url%>/resources/flash/16.swf" />
			  <embed src="<%=url%>/resources/flash/16.swf"></embed>
			  <param name="wmode" value="transparent">
			</object>
		</div>

	<div class="flshTestTwo" style="position: absolute;right:16%;top:0px;display:"> 
			<object  >
			  <param name="src" value="<%=url%>/resources/flash/5.swf"/>
			  <embed src="<%=url%>/resources/flash/5.swf"></embed>
			  <param name="wmode" value="transparent">
			</object>
	</div>
</body>
</html>