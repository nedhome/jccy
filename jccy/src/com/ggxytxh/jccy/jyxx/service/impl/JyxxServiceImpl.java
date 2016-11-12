package com.ggxytxh.jccy.jyxx.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggxytxh.jccy.common.service.impl.QueryPageServiecImpl;
import com.ggxytxh.jccy.common.vo.Contribution;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.jyxx.service.JyxxService;
import com.github.pagehelper.Page;

/** 
 * @author LinBinglong
 * @date 2016年3月26日
 * @version 1.0 
 */
@Service
public class JyxxServiceImpl extends QueryPageServiecImpl implements JyxxService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	

	@Override
	public List<Map<String, Object>> dqyyGet(String user_id) {
		String queryId="getdqyy";
		List<Map<String, Object>> listMap=sqlSession.selectList(queryId, user_id);
		return listMap;
	}
	
	@Override
	public String dqyyDelete(String dqyyId){
		String queryId = "deletedqyy";
		if (sqlSession.delete(queryId, dqyyId) > 0) {
			return "删除成功";
		}
		return "删除失败";
	}

	@Override
	public List<Map<String, Object>> dqjyGet(String user_id) {
		String queryId="getdqjy";
		List<Map<String, Object>> listMap=sqlSession.selectList(queryId, user_id);
		return listMap;
	}

	@Override
	public String xuJieDo(String dqjyId){
		String queryId="xuejie";
		if (sqlSession.update(queryId, dqjyId) > 0) {
			return "续借成功";
		}
		return "续借失败";
	}
	
	@Override
	public List<Map<String, Object>> cqtsGet(String user_id) {
		String queryId="getcqts";
		List<Map<String, Object>> listMap=sqlSession.selectList(queryId, user_id);
		return listMap;
	}

	@Override
	public Page<Contribution> jsjlGet(String user_id, int currentPage, int pageSize) {
		String queryId="getjsjl";
		Contribution contribution=new Contribution();
		contribution.setUser_id(user_id);
		Page<Contribution> contributionPage=this.pagedQuery(queryId, contribution, currentPage, pageSize);
		return contributionPage;
	}

	@Override
	public Page<HashMap<String, Object>> jylsGet(String user_id, int currentPage, int pageSize) {
		String queryId="getjyls";
		Page<HashMap<String, Object>> jylsPage=this.pagedQuery(queryId, user_id, currentPage, pageSize);
		return jylsPage;
	}

	@Override
	public Page<HashMap<String, Object>> sctsGet(String user_id, int currentPage, int pageSize) {
		String queryId="getscts";
		Page<HashMap<String, Object>> sctsPage=this.pagedQuery(queryId, user_id, currentPage, pageSize);
		return sctsPage;
	}  
	
	@Override
	public String sctsDelete(String tsscId){
		String querySctsDelete="deletescts";
		if (sqlSession.delete(querySctsDelete, tsscId) > 0) {
			return "取消成功";
		}
		return "取消失败";
	}

	@Transactional
	@Override
	public String bookGuaShi(Map<String, Object> gsMap, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String user_id=((User)request.getSession().getAttribute("currentUser")).getUser_id();
		if (null==user_id || user_id.equals("")) {
			return "非法操作";
		}
		gsMap.put("user_id", user_id);
		//borrow 挂失标志,user备注不良记录由触发器完成
		String queryGS="gtsginsert";
		if (sqlSession.insert(queryGS,gsMap) > 0) {
			return "挂失操作完成，挂失有不良记录，请保管好图书！";
		}
		
		return "挂失操作失败";
	}
	

}
