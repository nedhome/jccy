package com.ggxytxh.jccy.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ggxytxh.jccy.common.vo.Book;
import com.ggxytxh.jccy.common.vo.Contribution;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年1月5日
 * @version 1.0 
 */

public interface BookService {

	
	/** 
	* @Description: 
	* 通过 book.getName()和book.getCampus() 查询图书
	* @return Page<Book> 
	*/
	public Page<Book> bookFind(Book book, int currentPage, int pageSize);

	
	/** 
	 * @Description: 
	 * 通过 book.getName()和book.getCampus() 查询图书
	 * @return Page<Book> 
	 */
	public Page<Book> bookSupperFind(Book book, int currentPage, int pageSize);
	
	
	/** 
	* @Description: 
	* 通过book的id查询图书详情
	* @return Book 
	*/
	public Map<String, Object> bookInfo(String book_id); 
	
	
	/** 
	* @Description: 
	* 查询图书捐赠详情
	* @return Contribution 
	*/
	public List<Contribution> contributionFind(int currentPage, int pageSize);
	
	
	/** 
	 * @Description: 
	 * 获取系统公告内容
	 * @return Contribution 
	 */
	public HashMap<String, Object> getXtgg() ;

}
