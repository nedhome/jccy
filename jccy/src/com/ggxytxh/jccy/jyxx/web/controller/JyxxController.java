package com.ggxytxh.jccy.jyxx.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.common.vo.Contribution;
import com.ggxytxh.jccy.jyxx.service.JyxxService;
import com.github.pagehelper.PageInfo;


/** 
* @ClassName: JyxxController 
* @Description: TODO 
* @author LinBinglong
* @date 2016年1月25日
*  
*/
@Controller
@RequestMapping(value="/jyxx")
public class JyxxController {

	@Autowired
	private JyxxService jyxxService;
	
	
	/** 
	* @param @param user_id
	*/
	@ResponseBody
	@RequestMapping(value="/dqyy.do")
	public List<Map<String,Object>> getDqyy(@RequestParam String user_id) {
		List<Map<String,Object>> dqyyList=jyxxService.dqyyGet(user_id);
		return dqyyList;
	}
	
	/** 
	* @param @param dqyyId
	*/
	@ResponseBody 
	@RequestMapping(value="/deletedqyy.do",produces="text/html;charset=UTF-8")
	public String deleteDqyy(@RequestParam String dqyyId){
		String deleteDqyyMsg=jyxxService.dqyyDelete(dqyyId);
		return deleteDqyyMsg;
	}

	
	/** 
	* @param @param user_id
	*/
	@ResponseBody
	@RequestMapping(value="/dqjy.do")
	public List<Map<String,Object>> getDqjy(@RequestParam String user_id) {
		List<Map<String,Object>> dqjyList=jyxxService.dqjyGet(user_id);
		return dqjyList;
	}
	
	@ResponseBody
	@RequestMapping(value="/xujie.do", produces="text/html;charset=UTF-8")
	public String xuJie(@RequestParam String dqjyId) {
		String xuJieMsg=jyxxService.xuJieDo(dqjyId);
		return xuJieMsg;
	}

	
	/**
	 * @param user_id
	 */
	@ResponseBody
	@RequestMapping(value="/cqts.do")
	public List<Map<String,Object>> getCqts(@RequestParam String user_id) {
		List<Map<String,Object>> cqtsList=jyxxService.cqtsGet(user_id);
		return cqtsList;
	}

	/**
	 * @param user_id
	 * @param currentPage
	 */
	@ResponseBody
	@RequestMapping(value="/jsjl.do")
	public PageInfo<Contribution> getJsjl(@RequestParam String user_id, @RequestParam int currentPage) {
		int pageSize=15;
		PageInfo<Contribution> jsjlPage=new PageInfo<Contribution>(jyxxService.jsjlGet(user_id, currentPage, pageSize));
		return jsjlPage;
	}

	/**
	 * @param user_id
	 * @param currentPage
	 */
	@ResponseBody
	@RequestMapping(value="/jyls.do")
	public PageInfo<HashMap<String, Object>> getJyls(@RequestParam String user_id, @RequestParam int currentPage) {
		int pageSize=15;
		PageInfo<HashMap<String, Object>> jsjlPage=new PageInfo<HashMap<String, Object>>(jyxxService.jylsGet(user_id, currentPage, pageSize));
		return jsjlPage;
	}

	/**
	 * @param user_id
	 * @param currentPage
	 */
	@ResponseBody
	@RequestMapping(value="/scts.do")
	public PageInfo<HashMap<String, Object>> getScts(@RequestParam String user_id, @RequestParam int currentPage) {
		int pageSize=15;
		PageInfo<HashMap<String, Object>> sctsPage=new PageInfo<HashMap<String, Object>>(jyxxService.sctsGet(user_id, currentPage, pageSize));
		return sctsPage;
	}
	
	/**
	 * @param tsscId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/deletescts.do", produces="text/html;charset=UTF-8")
	public String deleteScts(@RequestParam String tsscId){
		String deletesctsMsg=jyxxService.sctsDelete(tsscId);
		return deletesctsMsg;
		
	}
	
	/**
	 * @param gsID
	 * @param book_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/guashi.do", produces="text/html;charset=UTF-8")
	public String guaShiBook(@RequestParam String gsID,@RequestParam String book_id, @RequestParam String name,HttpServletRequest request){
		HashMap<String, Object> sgMap=new HashMap<String, Object>();
		sgMap.put("borrow_id", gsID);
		sgMap.put("book_id", book_id);
		sgMap.put("book_name", name);
		String deletesctsMsg=jyxxService.bookGuaShi(sgMap,request);
		return deletesctsMsg;
		
	}
}




