package com.ggxytxh.jccy.grxx.web.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.common.vo.News;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.grxx.service.GrxxService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

/** 
 * @author LinBinglong
 * @date 2016年1月10日
 * @version 1.0 
 */

@Controller
@RequestMapping(value="/grxx")
public class GrxxController {

	@Autowired
	private GrxxService grxxService;
	/** 
	* @Description: 用户消息中心查询
	*/
	@ResponseBody
	@RequestMapping(value="/xxzx.do")
	public PageInfo<News> getNews(News news, @RequestParam int currentPage) {
		int pageSize=15;
		Page<News> newsPage=grxxService.newsGet(news, currentPage, pageSize);
		PageInfo<News> newsPageInfo=new PageInfo<News>(newsPage);
		return newsPageInfo;
	}
	
	/** 
	* @Description:用户基本信息修改 
	*/
	@ResponseBody
	@RequestMapping(value="/xxxg.do", produces="text/html;charset=UTF-8")
	public String updateUser(User user) {
		String xxxg_msg=grxxService.userUpdate(user);
		return xxxg_msg;
	}
	
	/** 
	* @Description: 密码修改
	*/
	@ResponseBody
	@RequestMapping(value="/mmxg.do", produces="text/html;charset=UTF-8")
	public String doChangePSD(@RequestParam String oldPSD, @RequestParam String newPSD) {
		String psd_msg=grxxService.ChangePSD(oldPSD, newPSD);
		return psd_msg;
	}
	
	/** 
	* @Description: 用户建议反馈
	*/
	@ResponseBody
	@RequestMapping(value="/grfk.do",produces="text/html;charset=UTF-8")
	public String grfk(@RequestParam String content, HttpServletRequest request) {
		String grfkMsg=grxxService.grfkDo(content, request);
		return grfkMsg;
	}
	

	/** 
	* @Description: 我的建议反馈
	*/
	@ResponseBody
	@RequestMapping(value="/myfk.do")
	public PageInfo<HashMap<String, Object>> getYhjy(@RequestParam int currentPage, HttpServletRequest request) {
		int pageSize=15;
		PageInfo<HashMap<String, Object>> yhjyPageInfo= new PageInfo<HashMap<String,Object>>(grxxService.getMyjy(currentPage, pageSize, request));
		return yhjyPageInfo; 
	}
	
}
