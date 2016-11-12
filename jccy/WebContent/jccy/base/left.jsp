<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String url = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<title>left</title>
<style type="text/css">
body{
	background-color:#808080;
	margin: 0px;
	padding: 0;
	width: 100%;
}

a, img {
	border: 0;
	text-decoration: none;
}



div.sdmenu {
	width: 100%;
	margin: 0 auto;
	
	padding-bottom: 10px;
	color: #fff;
}

div.sdmenu div {
	background: url(${pageContext.request.contextPath}/resources/img/users/left/title.gif) repeat-x;
	overflow: hidden;
}


div.sdmenu div.collapsed {
	height: 25px;
}

div.sdmenu div span {
	display: block;
	height: 15px;
	line-height: 15px;
	overflow: hidden;
	padding: 5px 25px;
	color: white;
	background: url(${pageContext.request.contextPath}/resources/img/users/left/expanded.gif) no-repeat 10px center;
	cursor: pointer;
	
}

div.sdmenu div.collapsed span {
	background-image: url(${pageContext.request.contextPath}/resources/img/users/left/collapsed.gif);
}

div.sdmenu div a {
	padding: 2% 16%;
	
	display: block;
	border-bottom: 1px solid #D0D3D9;
	color: #066;
}

div.sdmenu div a.current {
	background: #77adb0;
}

div.sdmenu div a:hover {
	background: #066 url(${pageContext.request.contextPath}/resources/img/users/left/linkarrow.gif) no-repeat right
		center;
	color: #fff;
	text-decoration: none;
}
.caidan{
	background-color: #86D9E6;
	height: 23px;
	color:red;
	
	
}
</style>
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
	var myMenu;
	window.onload = function() {
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	function SDMenu(id) {
		if (!document.getElementById || !document.getElementsByTagName)
			return false;
		this.menu = document.getElementById(id);

		this.submenus = this.menu.getElementsByTagName("div");

		this.remember = false;
		this.speed = 2;
		this.markCurrent = true;
		this.oneSmOnly = false;
	}
	SDMenu.prototype.init = function() {
		var mainInstance = this;

		for (var i = 0; i < this.submenus.length; i++)
			this.submenus[i].getElementsByTagName("span")[0].onclick = function() {
				mainInstance.toggleMenu(this.parentNode);

			};
		if (this.markCurrent) {
			var links = this.menu.getElementsByTagName("a");
			for (var i = 0; i < links.length; i++)
				if (links[i].href == document.location.href) {
					links[i].className = "current";
					break;
				}
		}
		if (this.remember) {
			var regex = new RegExp("sdmenu_" + encodeURIComponent(this.menu.id)
					+ "=([01]+)");
			var match = regex.exec(document.cookie);
			if (match) {
				var states = match[1].split("");
				for (var i = 0; i < states.length; i++)
					this.submenus[i].className = (states[i] == 0 ? "collapsed"
							: "");
			}
		}
	};
	SDMenu.prototype.toggleMenu = function(submenu) {
		if (submenu.className == "collapsed")
			this.expandMenu(submenu);
		else
			this.collapseMenu(submenu);
	};
	SDMenu.prototype.expandMenu = function(submenu) {
		var fullHeight = submenu.getElementsByTagName("span")[0].offsetHeight;
		var links = submenu.getElementsByTagName("a");
		for (var i = 0; i < links.length; i++)
			fullHeight += links[i].offsetHeight;
		var moveBy = Math.round(this.speed * links.length);

		var mainInstance = this;
		var intId = setInterval(function() {
			var curHeight = submenu.offsetHeight;
			var newHeight = curHeight + moveBy;
			if (newHeight < fullHeight)
				submenu.style.height = newHeight + "px";
			else {
				clearInterval(intId);
				submenu.style.height = "";
				submenu.className = "";
				mainInstance.memorize();
			}
		}, 30);
		this.collapseOthers(submenu);
	};
	SDMenu.prototype.collapseMenu = function(submenu) {
		var minHeight = submenu.getElementsByTagName("span")[0].offsetHeight;
		var moveBy = Math.round(this.speed
				* submenu.getElementsByTagName("a").length);
		var mainInstance = this;
		var intId = setInterval(function() {
			var curHeight = submenu.offsetHeight;
			var newHeight = curHeight - moveBy;
			if (newHeight > minHeight)
				submenu.style.height = newHeight + "px";
			else {
				clearInterval(intId);
				submenu.style.height = "";
				submenu.className = "collapsed";
				mainInstance.memorize();
			}
		}, 30);
	};
	SDMenu.prototype.collapseOthers = function(submenu) {
		if (this.oneSmOnly) {
			for (var i = 0; i < this.submenus.length; i++)
				if (this.submenus[i] != submenu
						&& this.submenus[i].className != "collapsed")
					this.collapseMenu(this.submenus[i]);
		}
	};
	SDMenu.prototype.expandAll = function() {
		var oldOneSmOnly = this.oneSmOnly;
		this.oneSmOnly = false;
		for (var i = 0; i < this.submenus.length; i++)
			if (this.submenus[i].className == "collapsed")
				this.expandMenu(this.submenus[i]);
		this.oneSmOnly = oldOneSmOnly;
	};
	SDMenu.prototype.collapseAll = function() {
		for (var i = 0; i < this.submenus.length; i++)
			if (this.submenus[i].className != "collapsed")
				this.collapseMenu(this.submenus[i]);
	};
	SDMenu.prototype.memorize = function() {
		if (this.remember) {
			var states = new Array();
			for (var i = 0; i < this.submenus.length; i++)
				states.push(this.submenus[i].className == "collapsed" ? 0 : 1);
			var d = new Date();
			d.setTime(d.getTime() + (30 * 24 * 60 * 60 * 1000));
			document.cookie = "sdmenu_" + encodeURIComponent(this.menu.id)
					+ "=" + states.join("") + "; expires=" + d.toGMTString()
					+ "; path=/";
		}
	};
	/* 消息中心 */
	 $(document).ready(function(){
	        $("#xxzx").click(function(){
	        	window.top.frames['main'].addtab("消息中心","<%=url%>/jccy/grxx/xxzx.jsp","xxzx");
	        	window.top.frames['main'].iframe_xxzx.onload = function() {
	        		window.top.frames['main'].iframe_xxzx.getNews();
	        	}
	        });
	        
	        $("#xxxg").click(function(){
	        	window.top.frames['main'].addtab("信息修改","<%=url%>/jccy/grxx/xxxg.jsp","xxxg");
	        }); 
	        
	        $("#mmxg").click(function(){
	        	window.top.frames['main'].addtab("密码修改","<%=url%>/jccy/grxx/mmxg.jsp","mmxg");
	        }); 
	        
	        $("#grfk").click(function(){
	        	window.top.frames['main'].addtab("问题反馈","<%=url%>/jccy/grxx/grfk.jsp","grfk");
	        	window.top.frames['main'].iframe_grfk.onload = function() {
	        		window.top.frames['main'].iframe_grfk.getMyjy();
	        	}
	        }); 
	        
	        $("#dqyy").click(function(){
	        	window.top.frames['main'].addtab("当前预约","<%=url%>/jccy/jyxx/dqyy.jsp","dqyy");
	        	window.top.frames['main'].iframe_dqyy.onload = function() {
	        		window.top.frames['main'].iframe_dqyy.getDqyy();
	        	}
	        });
	        
	        $("#dqjy").click(function(){
	        	window.top.frames['main'].addtab("当前借阅","<%=url%>/jccy/jyxx/dqjy.jsp","dqjy");
	        	window.top.frames['main'].iframe_dqjy.onload = function() {
	        		window.top.frames['main'].iframe_dqjy.getDqjy();
	        	}
	        });
	        
	        $("#cqts").click(function(){
	        	window.top.frames['main'].addtab("超期图书","<%=url%>/jccy/jyxx/cqts.jsp","cqts");
	        	window.top.frames['main'].iframe_cqts.onload = function() {
	        		window.top.frames['main'].iframe_cqts.getCqts();
	        	}
	        }); 
	        
	        $("#jyls").click(function(){
	        	window.top.frames['main'].addtab("借阅历史","<%=url%>/jccy/jyxx/jyls.jsp","jyls");
	        	window.top.frames['main'].iframe_jyls.onload = function() {
	        		window.top.frames['main'].iframe_jyls.getJyls();
	        	}
	        }); 
	        
	        $("#jsjl").click(function(){
	        	window.top.frames['main'].addtab("捐书记录","<%=url%>/jccy/jyxx/jsjl.jsp","jsjl");
	        	window.top.frames['main'].iframe_jsjl.onload = function() {
	        		window.top.frames['main'].iframe_jsjl.getJsjl();
	        	}
	        });
	        
	        $("#scts").click(function(){
	        	window.top.frames['main'].addtab("收藏图书","<%=url%>/jccy/jyxx/scts.jsp","scts");
	        	window.top.frames['main'].iframe_scts.onload = function() {
	        		window.top.frames['main'].iframe_scts.getScts();
	        	}
	        }); 
	  
	        
	        $("#tsgl_jygl").click(function(){
	        	window.top.frames['main'].addtab("借阅管理","<%=url%>/jccy/tsgl/jygl.jsp","jygl");
	        	window.top.frames['main'].iframe_jygl.onload = function() {
	        		window.top.frames['main'].iframe_jygl.getJygl();
	        	}
	        }); 
	        
	        $("#tsgl_tjts").click(function(){
	        	window.top.frames['main'].addtab("添加图书","<%=url%>/jccy/tsgl/add.jsp","add");
	        }); 
	        
	        $("#tsgl_zhcx").click(function(){
	        	window.top.frames['main'].addtab("综合查询","<%=url%>/jccy/tsgl/zhcx.jsp","zhcx");
	        	window.top.frames['main'].iframe_zhcx.onload = function() {
	        		window.top.frames['main'].iframe_zhcx.getZhcx();
	        	}
	        }); 
	        
	        $("#tsgl_back").click(function(){
	        	window.top.frames['main'].addtab("归还图书","<%=url%>/jccy/tsgl/back.jsp","back");
	        }); 
	        
	        
	        $("#rygl_zhgl").click(function(){/* 综合管理 */
	        	window.top.frames['main'].addtab("人员信息","<%=url%>/jccy/rygl/zhgl.jsp","zhgl");
	        	
	        }); 
	        
	        
	        $("#rygl_tjry").click(function(){/* 综合管理 */
	        	window.top.frames['main'].addtab("添加人员","<%=url%>/jccy/rygl/tjry.jsp","tjry");
	        	window.top.frames['main'].iframe_tjry.onload = function() {
	        		window.top.frames['main'].iframe_tjry.findAllPic();
	        	}
	        }); 
	        
	        $("#xtwh_qxgl").click(function(){
	        	window.top.frames['main'].addtab("权限管理","<%=url%>/jccy/xtwh/qxgl.jsp","qxgl");
	        	
	        }); 
	        $("#xtwh_xtgg").click(function(){
	        	window.top.frames['main'].addtab("系统公告","<%=url%>/jccy/xtwh/xtgg.jsp","xtgg");
	        	window.top.frames['main'].iframe_xtgg.onload = function() {
	        		window.top.frames['main'].iframe_xtgg.getGG();
	        	}
	        }); 
	        $("#xtwh_yhjy").click(function(){
	        	window.top.frames['main'].addtab("用户建议","<%=url%>/jccy/xtwh/yhjy.jsp","yhjy");
	        	window.top.frames['main'].iframe_yhjy.onload = function() {
	        		window.top.frames['main'].iframe_yhjy.getYhjy();
	        	}
	        }); 
	   });
</script>

</head>
<body marginheight="0" marginwidth="0" style="position: absolute;">
	<div class="linear">
		<c:if test="${sessionScope.currentUser==null}">
				<div class="caidan" style="text-align: center;" onclick="javascript:top.location.href='<%=url%>/login.jsp'"> <span >[请登录]</span></div>
		</c:if>
		
		<c:if test="${sessionScope.currentUser!=null}">
			<div class="caidan"> <span  style="margin-left: 12px;">[菜单]</span></div>
		</c:if>
		
		<div id="my_menu" class="sdmenu">		
			<c:if test="${sessionScope.currentUser!=null}">
			
				<div><!-- class="collapsed" -->
					<span>个人信息</span>
					<a href="#" id="xxzx" target="left">❶消息中心</a> 
					<a href="#" id="xxxg" target="left"> ❷信息修改</a> 
					<a href="#" id="mmxg" target="left"> ❸密码修改</a>
					<a href="#" id="grfk" target="left"> ❹问题反馈</a>
				</div>
				<c:if test="${sessionScope.currentUser.getType_id()==1 ||sessionScope.currentUser.getType_id()==0}">
				
					<div >
						<span>借阅信息</span> 
							<a href="#" id="dqyy" target="left"> ❶当前预约</a> 
							<a href="#" id="dqjy" target="left"> ❷当前借阅</a> 
							<a href="#" id="cqts" target="left"> ❸超期图书</a> 
							<a href="#" id="jyls" target="left"> ❹借阅历史</a> 
							<a href="#" id="jsjl" target="left"> ❺捐书记录</a> 
							<a href="#" id="scts" target="left"> ❻收藏图书</a> 
					</div>
				</c:if>
				<c:if test="${sessionScope.currentUser.getType_id()==1}">
					<div id="left_tsgl" >
						<span>图书管理</span>
							
							<a href="#" id="tsgl_jygl" target="left"> ❶借阅管理</a>      
							<a href="#" id="tsgl_tjts" target="left"> ❷添加图书</a> 
							<a href="#" id="tsgl_zhcx" target="left"> ❸综合查询</a> 
							<a href="#" id="tsgl_back" target="left"> ❹归还图书</a> 
					</div>	
				</c:if>
				<c:if test="${sessionScope.currentUser.getType_id()==1 ||sessionScope.currentUser.getType_id()==2}">
					<div>
						<span>人员管理</span>
							<a href="#" id="rygl_zhgl" target="left"> ❶人员信息</a> 
							<c:if test="${sessionScope.currentUser.getType_id()==2}">
								<a href="#" id="rygl_tjry" target="left"> ❷添加人员</a> 
							</c:if>
					</div>
				</c:if>
				<c:if test="${sessionScope.currentUser.getType_id()==2}">
					<div>
						<span>系统维护</span>
							<a href="#" id="xtwh_yhjy" target="left"> ❶用户建议</a> 
							<a href="#" id="xtwh_xtgg" target="left"> ❷系统公告</a> 
					</div>
				</c:if>
			</c:if>	
		</div>
	</div>
<script type="text/javascript">
$(function(){
    $('#my_menu').width($(window).width());
});
</script>
</body>
</html>