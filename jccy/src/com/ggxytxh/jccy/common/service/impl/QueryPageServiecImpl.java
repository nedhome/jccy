package com.ggxytxh.jccy.common.service.impl;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.ggxytxh.jccy.common.service.QueryPageService;
import com.github.pagehelper.Page;

/**
 * @author LinBinglong
 * @date 2016年1月5日
 * @version 1.0
 */

public class QueryPageServiecImpl implements QueryPageService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/** 
	* Page的属性有
	* pageNum：当前页
	* pages:总页数
	* pageSize:每页数量
	* total:总数
	*/
	@SuppressWarnings("unchecked")
	@Override
	public <T> Page<T> pagedQuery(String key, Object vo, int currentPage, int pageSize) {
		return (Page<T>) sqlSession.selectList(key, vo, new RowBounds(currentPage, pageSize));
	}

}
