package com.ggxytxh.jccy.tsgl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ggxytxh.jccy.common.vo.Book;
import com.ggxytxh.jccy.common.vo.Borrow;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年2月27日
 * @version 1.0 
 */

public interface TsglService {
	
	/** 
	* @Description: 进行 预约图书 操作
	* @param @param book_id
	* @param @param user_id
	* @return String 
	*/
	public String yyts(String book_id, String user_id, HttpServletRequest request);
	
	/** 
	 * @Description: 进行 收藏图书 操作
	 * @param @param book_id
	 * @param @param user_id
	 * @return String 
	 */
	public String scts(String book_id, String user_id, HttpServletRequest request); 
	
	/** 
	* @Description: 负责人通过自己帐号查询自己帐号下的 图书预约列表
	* @param @param user_id
	* @return Page<HashMap<String,Object>> 
	*/
	public Page<HashMap<String, Object>> jylbGet(String user_id, String pic_id, int currentPage, int pageSize);

	/** 
	* @Description: 进行取书借阅操作
	* @param @param borrow
	* @param @return   
	* @return String 
	*/
	public String tsjyDo(Borrow borrow);
	
	/** 
	* @Description: 添加图书
	* @param @param book
	* @param @return   
	* @return String 
	*/
	public String bookAdd(Book book);
	
	
	/** 
	* @Description: 修改图书
	* @param @param book
	* @param @return   
	* @return String 
	*/
	public String tsglChange(Book book, HttpServletRequest request);
	
	/** 
	* @Description: 图书管理下的综合查询
	* @param @param book_id
	* @param @return   
	* @return String 
	*/
	public Book tsglZhcx(String book_id);
	
	
	/** 
	* @Description: 图书管理下的删除图书
	* @param @param book_id
	* @param @return   
	* @return String 
	*/
	public String deleteBook(String book_id, HttpServletRequest request);
	
	/**
	 * Description:通过账号查找名字
	 * @param user_id
	 * @param request
	 * @return
	 */
	public String  findUserName(String user_id, HttpServletRequest request) ;
	
	/**
	 * @Description: 获取该用户当前借阅的情况
	 * @param user_id
	 * @param book_id
	 * @return List<Map<String,Object>> 
	 */
	public List<Map<String, Object>> findBack(String user_id, String book_id, HttpServletRequest request);
	
	/**
	 * @Description: 归还图书
	 * @param user_id
	 * @param book_id
	 * @return List<Map<String,Object>> 
	 */
	public String  backBook(String back_id, String book_id, HttpServletRequest request);
}
