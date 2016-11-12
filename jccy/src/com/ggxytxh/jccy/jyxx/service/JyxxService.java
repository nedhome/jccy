package com.ggxytxh.jccy.jyxx.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ggxytxh.jccy.common.vo.Contribution;
import com.github.pagehelper.Page;



/** 
* @ClassName: JyxxService 
* @Description: TODO 
* @author LinBinglong
* @date 2016年1月25日
*  
*/
public interface JyxxService {

	
	/** 
	* @Description: 通过用户的id获取该用户当前预约的情况
	* @param @param user_id 
	* @return List<Map<String,Object>> 
	*/
	public List<Map<String, Object>> dqyyGet(String user_id);
	
	/** 
	* @Description: 通过预约的id获取该用户当前预约的情况
	* @param @param dqyyId
	* @param @return   
	* @return String 
	*/
	public String dqyyDelete(String dqyyId) ;
	
	/**
	 * @Description: 通过用户的id获取该用户当前借阅的情况
	 * @param user_id
	 * @return List<Map<String,Object>> 
	 */
	public List<Map<String, Object>> dqjyGet(String user_id);
	
	
	/** 
	* @Description: 通过借阅表的id续借对应记录
	* @param @param dqjyId
	* @return String 
	*/
	public String xuJieDo(String dqjyId) ;
	
	/** 
	* @Description: 通过用户的id获取该用户借阅图书超期没有归还情况
	* @param @param user_id
	* @return List<Map<String,Object>> 
	*/
	public List<Map<String, Object>> cqtsGet(String user_id);
	
	
	/**
	 * @Description: 通过用户的id获取该用户捐书记录的情况,要进行分页
	 * @param user_id
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Contribution> jsjlGet(String user_id, int currentPage, int 	pageSize);

	
	/**
	 * @Description: 通过用户的id获取该用户所有的借阅记录的情况,要进行分页
	 * @param user_id
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<HashMap<String, Object>> jylsGet(String user_id, int currentPage, int 	pageSize);

	
	/**
	 * @Description: 通过用户的id获取该用户所有收藏图书的情况,要进行分页
	 * @param user_id
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<HashMap<String, Object>> sctsGet(String user_id, int currentPage, int 	pageSize);


	/** 
	* @Description: 通过收藏表的id删除对于删除记录
	* @param @param tsscId
	* @param @return   
	* @return String 
	*/
	public String sctsDelete(String tsscId);
	
	
	/**
	 * @Description: 挂失图书
	 * @param gsMap
	 * @param request
	 * @return
	 */
	public String  bookGuaShi(Map<String,Object> gsMap, HttpServletRequest request) ;

}
