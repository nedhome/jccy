package com.ggxytxh.jccy.tsgl.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.common.vo.Book;
import com.ggxytxh.jccy.common.vo.Borrow;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.tsgl.service.TsglService;
import com.github.pagehelper.PageInfo;

/** 
 * @author LinBinglong
 * @date 2016年2月27日
 * @version 1.0 
 */
@Controller
@RequestMapping(value="/tsgl")
public class TsglController {

	@Autowired
	TsglService tsglService;
	
	
	
	/** 
	* @Description: 图书预约
	*/
	@ResponseBody
	@RequestMapping(value="/tsyy.do", produces="text/html;charset=UTF-8")
	public String tsyy(@RequestParam String book_id, @RequestParam String user_id, HttpServletRequest request) {
		String tsyymsg=tsglService.yyts(book_id, user_id, request);
		return tsyymsg;
	}
	
	/** 
	* @Description: 图书收藏
	*/
	@ResponseBody
	@RequestMapping(value="/tssc.do", produces="text/html;charset=UTF-8")
	public String tssc(@RequestParam String book_id, @RequestParam String user_id, HttpServletRequest request) {
		String tsscmsg=tsglService.scts(book_id, user_id, request);
		return tsscmsg;
	}
	
	
	/** 
	* @Description: 负责人获取借阅列表
	*/
	@ResponseBody
	@RequestMapping(value="/jylb.do")
	public  PageInfo<HashMap<String, Object>> getJylb(@RequestParam(required = false)String user_id, @RequestParam String pic_id, @RequestParam int currentPage) {
		int pageSize=15;
		PageInfo<HashMap<String, Object>> jylbPage=new PageInfo<HashMap<String, Object>>(tsglService.jylbGet(user_id, pic_id, currentPage, pageSize));
		return jylbPage;
	}
	
	/** 
	* @Description: 进行取书操作
	*/
	@ResponseBody
	@RequestMapping(value="/jyts.do", produces="text/html;charset=UTF-8")
	public String doTsjy(Borrow borrow){
		String tsjyMsg=tsglService.tsjyDo(borrow);
		return tsjyMsg;
	}
	
	/** 
	* @Description: 进行添加图书操作
	*/
	@ResponseBody
	@RequestMapping(value="/addbook.do", produces="text/html;charset=UTF-8")
	public String doAddBook(Book book) {
		String addmsg=tsglService.bookAdd(book);
		return addmsg;
	}
	
	/** 
	* @Description: 图书管理下的综合查询
	*/
	@RequestMapping(value="/zhcx.do")
	public String getTsglZhcx(@RequestParam String book_id,HttpServletRequest request) {
		if (book_id==null|| book_id=="") {
			request.getSession().setAttribute("changeBook", null);
			return "/jccy/tsgl/zhcx";
		}
		Book zhcxresult=tsglService.tsglZhcx(book_id);
		request.getSession().setAttribute("changeBook", zhcxresult);
		request.setAttribute("savePath", zhcxresult.getPicture_path());
		return "/jccy/tsgl/zhcx";
	}
	
	
	/** 
	* @Description: 图书管理下的图书修改
	*/
	@ResponseBody
	@RequestMapping(value="/tsglchange.do", produces="text/html;charset=UTF-8")
	public String tsglBookChange(Book book, HttpServletRequest request){
		String  changemsg=tsglService.tsglChange(book,request);
		return changemsg;
	}
	
	/** 
	* @Description: 图管理下的删除图书
	*/
	@ResponseBody
	@RequestMapping(value="/tsgldelete.do", produces="text/html;charset=UTF-8")
	public String tsglDeleteBook(@RequestParam String book_id, HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("currentUser");
		int type_id=user.getType_id();
		if (type_id==1||type_id==2) {
			String deletebookmsg=tsglService.deleteBook(book_id,request);
			return deletebookmsg;
		}else{
			return "没有权限修改";
		}
	}
	
	/** 
	* @Description: 查找用户名字
	*/
	@ResponseBody
	@RequestMapping(value="/findUserName.do", produces="text/html;charset=UTF-8")
	public String  findUserName(@RequestParam String user_id,HttpServletRequest request) {
		String userName=tsglService.findUserName(user_id, request);
		return userName;
	}
	

	@ResponseBody
	@RequestMapping(value="/findback.do")
	public List<Map<String,Object>> findBack(@RequestParam String user_id, @RequestParam String book_id, HttpServletRequest request) {
		List<Map<String,Object>> backList=tsglService.findBack(user_id,book_id,request);
		return backList;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/back.do", produces="text/html;charset=UTF-8")
	public String  backBook(@RequestParam String back_id,@RequestParam String book_id, HttpServletRequest request) {
		String backMSG=tsglService.backBook(back_id,book_id, request);
		return backMSG;
	}
}










