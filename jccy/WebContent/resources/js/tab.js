function addtab(title, url,id) {
		var len = $("#tab_title li").length + 1;
		var flag=checkOpen(id,len);
		if(flag){return;}
		if(len>9) {alert("打开的菜单已经多于8个!");return;}
		var titleadd = "<li id='title_"+len+"'>&nbsp;"+title+"<span id='tab_span_"+id+"'> ×</span></li>";
		var contentadd = "<li id='content_"+len+"'><iframe frameborder='0' scrolling='auto' onload='Javascript:SetWinHeight(this)' style='width:100%;' src="
				+ url + "  name='iframe_"+id+"'></iframe></li>";
		$("#tab_title").append(titleadd);
		$("#tab_content").append(contentadd);

		/* 新添加的显示 */
		$("#title_"+len).attr("class", "on");
		$("#content_"+len).css('display', 'block');
		/* 所有旧的隐藏 */
		for (var i = 1; i < len; i++) {
			$("#title_"+i).attr("class", "");
			$("#content_"+i).css('display', 'none');
		}
		
		work_tab();
		return "success";
	};

	function work_tab() {
		$("#tab_title li span").unbind().click(function() {
			var close_index=$(this).parent().index();
			
			/* 如果最右一个删除  和 当前选中的一个删除*/
			if(close_index==$("#tab_title li").length||$(this).parent().attr("class")!=""){
				$("#title_" + close_index).attr("class", "on");
				$("#content_" + close_index).css('display', 'block'); 
			}
			
			/* 删除title */
			$(this).parent().remove();
			/* 删除对应的content */
			$("#content_" + (close_index+1)).remove();
			
			/* 更新右侧的calss */
			for(var i =(close_index+2); i <= $("#tab_title li").length+1; i++) {
				$("#title_"+i).attr("id", "title_"+(i-1));
				$("#content_"+i).attr("id", "content_"+(i-1));
			}
		});
		
		
		$("#tab_title li").click(function() {
			var selected_index=$(this).index()+1;
			var len=$("#tab_title li").length;
			choose(selected_index,len);
		});
	}
	
	
	/*当前被选中*/
	function choose(selected_index,len){
		/* 选中的显示 */
		$("#title_" + selected_index).attr("class", "on");
		$("#content_" + selected_index).css('display', 'block');
		/* 非选中的隐藏 */
		for (var i = 1; i <= len ; i++) {
			if (i!=selected_index) {
				$("#title_"+i).attr("class", "");
				$("#content_"+i).css('display', 'none');
			}
		}
	}
	
	/*检查是否打开*/
	function checkOpen(title,len){
		var tab_span_id="#tab_span_"+title;
		if($(tab_span_id).length>0){
			var spanIndex=$(tab_span_id).parent().index();
			choose(spanIndex+1,len);
			return true;
		}
		else
			return false;
	}
	

	function SetWinHeight(obj) { 
		var win=obj; 
		if (document.getElementById) { 
			if (win && !window.opera) { 
			if (win.contentDocument && win.contentDocument.body.offsetHeight) 
				win.height = win.contentDocument.body.offsetHeight; 
			else if(win.Document && win.Document.body.scrollHeight) 
				win.height = win.Document.body.scrollHeight; 
			} 
		} 
	} 
	
	