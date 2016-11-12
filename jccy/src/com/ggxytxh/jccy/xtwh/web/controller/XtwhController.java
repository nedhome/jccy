package com.ggxytxh.jccy.xtwh.web.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.xtwh.service.XtwhService;
import com.github.pagehelper.PageInfo;

/** 
 * @author LinBinglong
 * @date 2016年4月2日
 * @version 1.0 
 */
@Controller
@RequestMapping(value="/xtwh")
public class XtwhController {

	@Autowired
	private XtwhService xtwhService;
	
	/** 
	* @Description: 设置系统公告	
	* */
	@ResponseBody
	@RequestMapping(value="/xtgg.do", produces="text/html;charset=UTF-8")
	public String updateGg(@RequestParam String title, @RequestParam String content, HttpServletRequest  request) {
		HashMap<String, Object> ggMap=new HashMap<String, Object>();
		ggMap.put("content", content);
		ggMap.put("title", title);
		String ggmsg=xtwhService.setXtGg(ggMap, request);
		return ggmsg;
	}
	
	/** 
	* @Description:获取用户建议	
	* */
	@ResponseBody
	@RequestMapping(value="/yhjy.do")
	public PageInfo<HashMap<String, Object>> getYhjy(@RequestParam int currentPage, HttpServletRequest request) {
		int pageSize=15;
		PageInfo<HashMap<String, Object>> yhjyPageInfo= new PageInfo<HashMap<String,Object>>(xtwhService.getYhjy(currentPage, pageSize, request));
		return yhjyPageInfo; 
	}
	
}
