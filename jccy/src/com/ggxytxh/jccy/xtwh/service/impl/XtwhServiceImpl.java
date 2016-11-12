package com.ggxytxh.jccy.xtwh.service.impl;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.ggxytxh.jccy.common.service.impl.QueryPageServiecImpl;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.xtwh.service.XtwhService;
import com.github.pagehelper.Page;

/**
 * @author LinBinglong
 * @date 2016年4月2日
 * @version 1.0
 */

public class XtwhServiceImpl extends QueryPageServiecImpl implements XtwhService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * @Description: 设置系统公告
	 */
	@Override
	public String setXtGg(HashMap<String, Object> GG, HttpServletRequest request) {
		String ggquery = "setxtgg";
		int user_type = getUserType(request).getType_id();
		if (user_type != 2) {
			return "没有权限";
		}
		if (((String)GG.get("title")).length() > 25) {
			return "标题过长，请设置在25个字以内";
		}
		if (((String)GG.get("content")).length() > 300) {
			return "内容过长，请设置在300个字以内";
		}
		if (sqlSession.insert(ggquery, GG) > 0) {
			return "设置成功";
		}
		return "设置失败";
	}

	/** 
	* @Description: 获取用户的建议列表
	*/
	@Override
	public Page<HashMap<String, Object>> getYhjy(int currentPage, int pageSize, HttpServletRequest request) {
		String yhjyquery = "xtwhyhjy";
		int user_type = getUserType(request).getType_id();
		if (user_type ==1 || user_type == 2 ) {	
			Page<HashMap<String, Object>> yhyjPage=this.pagedQuery(yhjyquery, user_type, currentPage, pageSize);
			return yhyjPage;
		}else {
			return null;
		}
	}
	
	
	/** 
	* @Description: 获取当前登录用户（私有方法）
	*/
	private User getUserType(HttpServletRequest request){
		return (User) request.getSession().getAttribute("currentUser");
	}

}
