package com.ggxytxh.jccy.common.service;

import com.github.pagehelper.Page;


/** 
 * @author LinBinglong
 * @date 2016年1月5日
 * @version 1.0 
 */

public interface QueryPageService {

	
	/** 
	* @Description: TODO
	* @param @param key :SQL 的id
	* @param @param vo :传入要分页查询的对象
	* @param @param indexPage :当前页
	* @param @param pageSize ：每页大小
	* @param @return   
	* @return Page<T> 
	*/
	public <T> Page<T> pagedQuery(String key, Object vo, int indexPage, int pageSize) ;

}
