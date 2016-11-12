package com.ggxytxh.jccy.grxx.service.impl;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggxytxh.jccy.common.service.impl.QueryPageServiecImpl;
import com.ggxytxh.jccy.common.vo.News;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.grxx.service.GrxxService;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年3月26日
 * @version 1.0 
 */
@Service
public class GrxxServiceImpl extends QueryPageServiecImpl implements GrxxService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired  
	private  HttpServletRequest request;  
	
	
	@Override
	public Page<News> newsGet(News news, int currentPage, int pageSize) {
		String queryId="getnews";
		User user=(User)request.getSession().getAttribute("currentUser");
		if(news.getUser_id()==null)
			news.setUser_id(user.getUser_id());
		Page<News> newsPage=this.pagedQuery(queryId, news, currentPage, pageSize);
		return newsPage;
	}

	@Transactional
	@Override
	public String userUpdate(User user) {
		String queryuserId="updateuser";
		String querypicId="updatepic";
		User usertemp=(User)request.getSession().getAttribute("currentUser");
		user.setUser_id(usertemp.getUser_id());
		
		if (usertemp.getType_id()!=0) {
			if(0>=sqlSession.update(querypicId, user)){
				return "修改失败！";
			}
			user.setPhone(user.getLphone());
			usertemp.setLphone(user.getLphone());
			usertemp.setSphone(user.getSphone());
			usertemp.setAddress(user.getAddress());

		}
		if(0<sqlSession.update(queryuserId, user)){
			if (!user.getName().equals(usertemp.getName())) {
				String contributionquery="updatename";
				sqlSession.update(contributionquery,user);
				String updatecontributornamequery="updatecontributorname";
				sqlSession.update(updatecontributornamequery,user);
			}
			
			usertemp.setName(user.getName());
			usertemp.setEmail(user.getEmail());
			
			usertemp.setProfession(user.getProfession());
			usertemp.setPhone(user.getPhone());
			request.getSession().setAttribute("currentUser", usertemp);
			return "修改成功";
		}else{
			return "修改失败！";
		}
		
	}
	
	@Transactional
	@Override
	public String ChangePSD(String oldPSD, String newPSD) {
		String queryId="changepsd";
		User user=(User)request.getSession().getAttribute("currentUser");
		user.setPassword(oldPSD);
		if(null!=sqlSession.selectOne(queryId+"_1",user)){
			user.setPassword(newPSD);
			sqlSession.update(queryId+"_2", user);
			return "修改成功";
		}else{
			return "修改失败！";
		}
	}


	/***
	 * 个人反馈
	 * 
	 * */
	@Transactional
	@Override
	public String grfkDo(String content, HttpServletRequest request) {
		String querygrfk="grfk";
		User userTemp=(User) request.getSession().getAttribute("currentUser");
		HashMap< String, Object> GRFK=new HashMap<String, Object>();
		GRFK.put("user_id", userTemp.getUser_id());
		GRFK.put("content", content);
		if ( sqlSession.insert(querygrfk, GRFK) > 0) {
			return "提交成功";
		}
		return "提交失败";
	}

	/** 
	* @Description: 获取用户的建议列表
	*/
	@Override
	public Page<HashMap<String, Object>> getMyjy(int currentPage, int pageSize, HttpServletRequest request) {
		String yhjyquery = "myfk";
		String user_id = ((User) request.getSession().getAttribute("currentUser")).getUser_id();
		
		Page<HashMap<String, Object>> yhyjPage=this.pagedQuery(yhjyquery, user_id, currentPage, pageSize);
		return yhyjPage;
		
	}
}
