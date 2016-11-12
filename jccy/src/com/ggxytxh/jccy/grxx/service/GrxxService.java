package com.ggxytxh.jccy.grxx.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.ggxytxh.jccy.common.vo.News;
import com.ggxytxh.jccy.common.vo.User;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年1月10日
 * @version 1.0 
 */

public interface GrxxService {

	
	/** 
	* @Description: 获取个人消息
	* @param @param news
	* @param @param currentPage
	* @param @param pageSize
	* @return Page<News> 
	*/
	public Page<News> newsGet(News news, int currentPage, int pageSize);
	
	/** 
	* @Description: 用户更新信息，通过session里面读用户的ID
	* 				把传入进来的User进行更新，重新放到session中。
	* 				修改是否成功看返回的String内容。
	* @param @param user
	* @param @return   
	* @return String 
	*/
	public String userUpdate(User user);
	
	/** 
	* @Description: 密码修改
	* @param @param oldPSD
	* @param @param newPSD
	* @param @return   
	* @return String 
	*/
	public String ChangePSD(String oldPSD, String newPSD);
	
	/** 
	* @Description: 个人反馈
	* @param @param content
	* @param @param request
	* @param @return   
	* @return String 
	*/
	public String grfkDo(String content,HttpServletRequest request); 
	
	/** 
	* @Description: 获取我都的建议
	* @param @return   
	* @return PageInfo<Map<String,Object>> 
	*/
	public Page<HashMap<String, Object>> getMyjy(int currentPage, int pageSize, HttpServletRequest request);
}
