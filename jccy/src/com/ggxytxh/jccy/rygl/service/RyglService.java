package com.ggxytxh.jccy.rygl.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ggxytxh.jccy.common.vo.User;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年3月26日
 * @version 1.0 
 */

public interface RyglService {

	/** 
	* @Description: 人员管理下的综合管理，用于更正用户信息
	* @param @param user
	* @param @return   
	* @return Page<User> 
	*/
	public Page<User> ryglZhgl(User user, int currentPage, int pageSize);
	
	/** 
	* @Description: 人员管理下的更新操作
	* @param @param user
	* @param @return   
	* @return String 
	*/
	public String ryglUpdate(User user,HttpServletRequest request);
	
	/** 
	 * @Description: 人员管理下的删除操作
	 * @param @param user
	 * @param @return   
	 * @return String 
	 */
	public String ryglDelete(User user);
	
	/** 
	 * @Description: 查找所有pic
	 * @param @param user
	 * @param @return   
	 * @return String 
	 */
	public List<Map<String, Object>> findAllPic(HttpServletRequest request);
	
	/** 
	 * @Description: 添加普通用户
	 * @param @param user
	 * @param @return   
	 * @return String 
	 */
	public String addUser(User user, HttpServletRequest request);
	
	/** 
	 * @Description: 查找所有pic
	 * @param @param user
	 * @param @return   
	 * @return String 
	 */
	public String updatePic(String oldID, String newID, HttpServletRequest request);
	
}
