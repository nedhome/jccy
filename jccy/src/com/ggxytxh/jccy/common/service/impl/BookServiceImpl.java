package com.ggxytxh.jccy.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggxytxh.jccy.common.service.BookService;
import com.ggxytxh.jccy.common.vo.Book;
import com.ggxytxh.jccy.common.vo.Contribution;
import com.ggxytxh.jccy.common.vo.Pic;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年1月5日
 * @version 1.0 
 */
@Service
public class BookServiceImpl extends QueryPageServiecImpl implements BookService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public Page<Book> bookFind(Book book, int currentPage, int pageSize) {
		String queryId="bookfind";
		return this.pagedQuery(queryId, book, currentPage, pageSize);
	}

	@Override
	public Map<String, Object> bookInfo(String book_id) {
		String queryId_1="bookinfo";
		String queryId_2="picinfo";
		Map<String, Object> map=new HashMap<String,Object>();
		Book book=sqlSession.selectOne(queryId_1, book_id);
		map.put("bookInfo", book);
		map.put("pic", (Pic)sqlSession.selectOne(queryId_2, book.getPic()));
		return map;
	}

	@Override
	public List<Contribution> contributionFind(int currentPage, int pageSize) {
		String queryId="contribution";
		return this.pagedQuery(queryId, new Contribution(), currentPage, pageSize);
	}

	@Override
	public Page<Book> bookSupperFind(Book book, int currentPage, int pageSize) {
		String queryId="booksupperfind";
		return this.pagedQuery(queryId, book, currentPage, pageSize);
	}

	@Override
	public HashMap<String, Object> getXtgg() {
		String xtggQuery="getxtgg";
		HashMap<String, Object> xtggMap=sqlSession.selectOne(xtggQuery, "bm");//bm预留字段
		return xtggMap;
	}
	
	
}
