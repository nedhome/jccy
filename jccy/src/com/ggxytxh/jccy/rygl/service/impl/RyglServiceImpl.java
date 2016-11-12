package com.ggxytxh.jccy.rygl.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggxytxh.jccy.common.service.impl.QueryPageServiecImpl;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.rygl.service.RyglService;
import com.github.pagehelper.Page;


/** 
 * @author LinBinglong
 * @date 2016年3月26日
 * @version 1.0 
 */

@Service
public class RyglServiceImpl extends QueryPageServiecImpl implements RyglService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	/** 
	* @Description:人员管理下的综合查询
	*/
	@Override
	public Page<User> ryglZhgl(User user, int currentPage, int pageSize) {
		String zhglquery="ryglzhgl";
		Page<User> zhglPage=this.pagedQuery(zhglquery, user, currentPage, pageSize);
		return zhglPage;
	}

	
	/** 
	* @Description: 人员管理用户 更新
	*/
	@Override
	public String ryglUpdate(User user,HttpServletRequest request) {
		if((!"".equals(user.getUser_pic()))&&( null!=user.getUser_pic())){
			if (!check(request)) {
				return "非法操作";
			}
		}
		String ryglUpdateQuery="ryglupdate";
		if (sqlsession.update(ryglUpdateQuery, user) > 0) {
			return "修改成功";
		}
		return "修改失败";
	}


	/** 
	 * @Description: 人员管理用户 删除
	 */
	@Transactional
	@Override
	public String ryglDelete(User user) {
		String ryglDeleteQuery="rygldelete";
		if (sqlsession.update(ryglDeleteQuery, user) > 0) {
			return "删除成功";
		}
		return "删除失败";
	}


	/** 
	 * @Description: 查询所有pic
	 */
	@Override
	public List<Map<String, Object>>  findAllPic(HttpServletRequest request) {
		/*if (!check(request)) {
			return null;
		}*/
		String findallpicquery="findallpic";
		List<Map<String, Object>>  picMap = sqlsession.selectList(findallpicquery);
		return picMap;
	}

	@Transactional
	@Override
	public String addUser(User user, HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		String addquery="adduser";
		if (sqlsession.insert(addquery,user) >0) {
			return "添加成功";
		}
		return "添加失败";
	}


	@Transactional
	@Override
	public String updatePic(String oldID, String newID, HttpServletRequest request) {
		if (!check(request)) {
			return "非法操作";
		}
		// TODO Auto-generated method stub
		String picquery="picupdate";
		HashMap<String, Object> picMap= new HashMap<String ,Object>();
		picMap.put("oldID", oldID);
		picMap.put("newID", newID);
		if (sqlsession.update(picquery,picMap)>0) {
			String oldqury="updatepicolduser";
			String newqury="updatepicnewuser";
			if (sqlsession.update(oldqury,picMap) > 0 && sqlsession.update(newqury,picMap)>0) {
				String dmquery="updatedm";
				if (sqlsession.update(dmquery,picMap) > 0) {
					return "更新成功";
				}
			}
		}
		return "更新失败";
	}
	
	private Boolean check(HttpServletRequest request){
		int type_id = ((User) request.getSession().getAttribute("currentUser")).getType_id();
		if (type_id!=2) {
			return false;
		}
		return true;
	}

}






