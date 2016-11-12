package com.ggxytxh.jccy.common.web.controller;


import java.util.HashMap;
import java.util.Map;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.common.service.BookService;
import com.ggxytxh.jccy.common.vo.Book;

/** 
 * @author LinBinglong
 * @date 2016年1月3日
 * @version 1.0 
 */

@Controller
@RequestMapping(value="/common")
public class BookController {

	@Autowired
	private BookService bookService;

	
	/**
	 * 查询图书信息
	 */
	@RequestMapping(value="/findbook.do")
	public String findBook(ModelMap map, Book book, @RequestParam int currentPage/*@RequestParam int pageSize*/) {
		int pageSize=15;
		map.put("book", book);
		map.put("bookPage", bookService.bookFind(book, currentPage, pageSize));
		return "jccy/common/result";
	}
	
	/** 
	*图书详情
	*/
	@RequestMapping(value="/infobook.do", params="book_id")
	public String infoBook(Map<String, Object> map, @RequestParam String book_id) {
		map.put("map", bookService.bookInfo(book_id));
		return "jccy/common/bookinfo";
	}
	
	/** 
	 *高级查询
	 */
	@RequestMapping(value="/supperfindbook.do")
	public String supperFindBook(ModelMap map, Book book, @RequestParam int currentPage) {
		int pageSize=15;
		map.put("bookPage", bookService.bookSupperFind(book, currentPage, pageSize));
		return "jccy/common/result";
	}
	
	/** 
	 *捐赠
	 */
	@RequestMapping(value="/findcontribution.do")
	public String findContribution(ModelMap map, @RequestParam int currentPage) {
		int pageSize=15;
		map.put("contributionPage", bookService.contributionFind(currentPage, pageSize));
		return "jccy/common/contribution";
		
	}
	
	
	/** 
	 *获取系统公告
	 */
	@ResponseBody
	@RequestMapping(value="/getxtgg.do")
	public HashMap<String, Object> getXtgg(){
		return bookService.getXtgg();
	}

}
