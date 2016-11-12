package com.ggxytxh.jccy.xtwh.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import com.github.pagehelper.Page;


/** 
 * @author LinBinglong
 * @date 2016年4月2日
 * @version 1.0 
 */

public interface XtwhService {

	/** 
	* @Description: 设置系统公告，内容存在dm表中的备注中
	* @param @param content
	* @param @param request
	* @param @return   
	* @return String 
	*/
	public String setXtGg(HashMap<String, Object> GG, HttpServletRequest request);
	
	
	/** 
	* @Description: 获取用户的建议
	* @param @return   
	* @return PageInfo<Map<String,Object>> 
	*/
	public Page<HashMap<String, Object>> getYhjy(int currentPage, int pageSize, HttpServletRequest request);
	
	


}
