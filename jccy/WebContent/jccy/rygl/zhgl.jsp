<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%String url=request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=url%>/resources/css/all.same.css" type="text/css" />
<script src="<%=url%>/resources/js/jquery-1.9.1.js" type="text/javascript"></script>
<script src="<%=url%>/resources/cj/rlcj/laydate.js" type="text/javascript"></script>
<style type="text/css">
#ryglchange td {
	height: 40px;
	border: 0px;
	text-align:left;
	color:#2E3E3E;
	font-size: 15px;

}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#feny_table").hide();
		 getZhgl();
	});
	
	/* 请求函数 */
	function getZhgl(){
		$.ajax({
	        url:'<%=url%>/rygl/zhgl.do',
			data : $("#zhgl_myform").serialize(),
			type : 'post',
			success : function(data) {
				$("#zhgl_show tr:gt(0)").remove();
		   		$("#dqy").val(data.pageNum);
		   		$("#totalPage").html(data.pages);
		   		$("#total").html(data.total);
				if(data.total==0){
					$("#feny_table").hide();
					$("#zhgl_show").append("<tr><td colspan='11'>没有结果</td></tr>");
					alert("没有查询到相关信息");
				}else{
					$("#feny_table").show();
					show(data);			
				} 
			}
		});
	}
	
	
	
	/* 查询有结果是显示函数 */
	function show(data){
		var zhgljsp="";
		var userType={"0":"普通用户","1":"负责人","2":"管理员"}
   		$(data.list).each(function(id,zhgl){ 
   			zhgljsp+= '<tr><td>'+(data.pageSize*(data.pageNum-1)+(id+1))+'</td><td title='+zhgl.name+'><span>'+zhgl.name+'</span></td>'
   					+'<td title='+zhgl.user_id+'>'+zhgl.user_id+'</td>'
   					+'<td title='+userType[zhgl.type_id]+'>'+userType[zhgl.type_id]+'</td>'
   					+'<td title='+zhgl.campus+'>'+zhgl.campus+'</td>'
   					+'<td title='+zhgl.academy+'>'+zhgl.academy+'</td>'
   					+'<td title='+zhgl.profession+'>'+zhgl.profession+'</td>'
   					+'<td title='+zhgl.email+'>'+zhgl.email+'</td>'
   					+'<td title='+zhgl.phone+'>'+zhgl.phone+'</td>'
   					+'<td title='+zhgl.comment+'>'+zhgl.comment+'</td>'
   					+'<td ><a onclick=\"jyts(\''+zhgl.name+'\',\''+zhgl.user_id+'\',\''+zhgl.campus+'\',\''+zhgl.academy+'\',\''+zhgl.type_id+'\',\''+zhgl.profession+'\',\''+zhgl.comment+'\')\">修改信息</a></td></tr>';
     	});        
   		$("#zhgl_show").append(zhgljsp);
   		$("#zhgl_show tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#53aca4');
		});
	}
	
	
	
	function jyts(name, user_id, campus, academy,type_id, profession, comment){
		findAllPic();
		$("#ryglchange input[name='name']").val(name);
		$("#ryglchange input[name='user_id']").val(user_id);
		$("#ryglchange input[name='oldUser_id']").val(user_id);
		$("#oldcampus").text("[旧:"+campus+"]");
		$("#pic_no").show();
		$("#oldacademy").text("[旧:"+academy+"]");
		if(type_id!="0")	$("#pic_no").hide();
		$("#ryglchange input[name='profession']").val(profession);
		$("#changediv").show();
		$("#findresult").hide();
	
		$("#chakan").hide();
		$("#comment").val(comment);
	}
	
	function findAllPic(){
		$("#user_pic").empty();
		$.ajax({
	        url:'<%=url%>/rygl/findallpic.do',
			data : {},
			type : 'post',
			success : function(data) {
				var picjsp="<option value=''></option>";
				$(data).each(function(id,pic){ 
					picjsp+="<option value='"+pic.bm+"'>"+pic.academy+"</option>";
				});		
				$("#user_pic").append(picjsp);
			}
		});
		
	}
	
	
	/* 返回操作 */
	function goBack(){
		$("#changediv").hide();
		$("#findresult").show();
		$("#chakan").show();
	}
	
	function updatery(){
		if($("#user_pic").val()!="") $("#newacademy").val($("#user_pic").find("option:selected").text());
		if(confirm("你确定要更新这个用户的信息吗？")) {
			$.ajax({
		        url:'<%=url%>/rygl/ryglupdate.do',
				data : $("#updateform").serialize(),
				type : 'post',
				success : function(data) {
					alert(data);
					window.location.reload();
				}
			});
		}	
	}
	
	function deletery(){
		if(confirm("您确定要删除这个用户吗吗？")){
			if(confirm("您操作的不是一般操作，而是删除用户，你确定继续操作？？？？")){
				$.ajax({
			        url:'<%=url%>/rygl/rygldelete.do',
					data : $("#updateform").serialize(),
					type : 'post',
					success : function(data) {
						alert(data);
						window.location.reload();
					}
				});
			}
		}
	}
	
	/* 分页时调用请求函数 */
	function fenye(){
		getZhgl();
	}
</script>
<title>人员信息</title>
</head>
<body>
	
	<div class="linear" id="zhglliner">
		
		<div class="login_out" >
			<c:if test="${sessionScope.currentUser==null}">
				<script type="text/javascript">
				window.onload=function() {
					alert("你还没有登录！");
						top.location.href="<%=url%>/index.jsp";
					}
				</script>
			</c:if>
		</div>
		<br>
		<div id="findresult">
			<form id="zhgl_myform"  method="post">
				<span style="margin-left: 3%">用户帐号:</span> 
				<input type="text" id="user_id" name="user_id" size="10px"> 
				<span>用户姓名:</span> 
				<input type="text" id="name" name="name" size="10px"> 
				<span>所属校区:</span> 
				<select id="xiaoquname" name="campus">
						<option value="1"></option>
						<option value="2">大学城校区</option>
						<option value="3">东风路校区</option>
						<option value="4">龙洞校区</option>
						<option value="5">番禺校区</option>
				</select><span> 所属学院:</span> 
				<input type="text" id="cacademy" name="academy" size="10px"> 
				<span>所属专业:</span> 
				<input type="text" id="profession" name="profession" size="10px"> 
				<input type="hidden" id="currentPage" name="currentPage" value="1">
				
				<input type="button" id="rygl_zhgl" value="查询" onclick="getZhgl()">
				<input type="reset" value="重置">
			</form>
		</div>
		<div id="chakan" style="width: 96%;">
			<br> <br>
			<table id="zhgl_show" class="show_table" style="word-break: break-all; word-wrap: break-word; width: 100%">
				<tr bgcolor="#ff0000" id="dd">
					<th width="30px">序号</th>
					<th width="100px">姓名</th>
					<th width="100px">帐号</th>
					<th width="100px">类型</th>
					<th width="100px">校区</th>
					<th width="100px">学院</th>		
					<th width="100px">专业</th>		
					<th width="100px">邮件</th>		
					<th width="100px">电话</th>		
					<th width="100px">备注</th>		
					<th width="100px">操作</th>
				</tr>
			</table>
			<%@include file="../base/fenye.jsp"%>
		</div>
		 <div id="changediv" style="display: none">
			<form id="updateform">
			<table id="ryglchange">
			<tr>
					<td>校 区</td>
					<td>:</td>
					<td> 
					<select id="changecapus" name="campus">
							<option value="1"></option>
							<option value="2">大学城校区</option>
							<option value="3">东风路校区</option>
							<option value="4">龙洞校区</option>
							<option value="5">番禺校区</option>
					</select>
					<span id="oldcampus" style="color:#808080;font-size: 10px"></span>
					</td>
				</tr>
				<tr>
					<td>姓 名</td>
					<td>:</td>
					<td><input type="text" size="35px" name="name"
						value="name"></td>
				</tr>
				<tr>
					<td>帐 号</td>
					<td>:</td>
					<td><input type="text" id="user_id" size="35px" name="user_id"
						value="">
						<input type="hidden" id="oldUser_id" name="oldUser_id">
						</td>
				</tr>
				
				<tr id="pic_no">
					<td>学 院</td>
					<td>:</td>
					<td>
						<select id="user_pic" name="user_pic"></select>
						<span id="oldacademy" style="color:#808080;font-size: 10px"></span>
						<input type="hidden" id="newacademy" name="academy" />
						</td>
				</tr>
				<tr>
					<td>专 业</td>
					<td>:</td>
					<td><input type="text" size="35px" name="profession"
						value=""></td>
				</tr>
				
				<tr>
					<td>备 注</td>
					<td>:</td>
					<td><textarea id="comment" name="comment" cols=80 rows=2></textarea></td>
				</tr>
				<tr>
					<td><input type="button" onclick="goBack()" value="返回" style="margin-left: 0;width: 60px"></td>
					<td colspan="2"><input id="qdsg" type="button" value="确定修改" onclick="updatery()" style="margin-left: 30px;width: 80px"> 
					<input id="qdsc" type="button" value="删除用户" onclick="deletery()" style="margin-left: 60px;width: 80px"> </td>
				</tr>
			</table>
			</form>
		</div>
	</div> 
	<script>
		var bodyWidth = $(window).width();
		if(bodyWidth<910){
			$(".linear").width("1110px");
		}
	</script>
</body>
</html>