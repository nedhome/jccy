<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	 $(document).ready(function() {
		 $("#sy").click(function(){
			$("#currentPage").val("1");
			fenye();
		 });
		
		 $("#wy").click(function(){
			$("#currentPage").val(parseInt($("#totalPage").text()));
			fenye();
		});
			
		$("#syy").click(function(){
			if(parseInt($("#dqy").val())<=1){
				alert("请输入有效页码！");
				return false;
			}else{
				$("#currentPage").val(parseInt($("#dqy").val())-1);
				fenye();
			}
		});
			
		$("#xyy").click(function(){
			if(parseInt($("#dqy").val())>=parseInt($("#totalPage").text())){
				alert("请输入有效页码！");
				return false;
			}else{
				$("#currentPage").val(parseInt($("#dqy").val())+1);
				fenye();
			}
		});
			
		$("#tz").click(function(){
			if(parseInt($("#dqy").val())>parseInt($("#totalPage").text())||parseInt($("#dqy").val())<1){
				alert("请输入有效页码！");
				return false;
			}else{
				$("#currentPage").val(parseInt($("#dqy").val()));
				fenye();
			}
		});
		
		$(".show_table tr").click(function(){
			$("tr").css('background','');
			$(this).css('background','#99CCCC');
		});
		$("#feny_table").css('width',$(".show_table").width());
	});
</script>

<table id="feny_table">
	<tr>
		<td style="border: 0px; color: #00478e; font-size: 12px;float: left"> [共<span id="total" style="color: red"></span>条]</td>
		<td style="border: 0px; color: #00478e; font-size: 12px;float: right">
				<span id="sy">[ 首页</span>&nbsp; 
				<span id="syy">◀上一页</span>&nbsp;当前 
				<input type="text" id="dqy" style="height: 15px; width: 24px; font-size: 100%; color: red; border: 0px; background: #99CCCC;" onkeyup="this.value=this.value.replace(/\D/g,'')">
				/<span id="totalPage" style="cursor: auto;"></span>页 
				<span id="tz">跳转</span>
				<span id="xyy">下一页▶</span>&nbsp;
				<span id="wy">尾页 ]</span>
		</td>
	</tr>
</table>