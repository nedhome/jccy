package com.ggxytxh.jccy.rygl.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.rygl.service.RyglService;
import com.github.pagehelper.PageInfo;


/** 
 * @author LinBinglong
 * @date 2016年3月26日
 * @version 1.0 
 */
@Controller
@RequestMapping(value="/rygl")
public class RyglController {

	@Autowired
	private RyglService ryglSerivce;
	
	
	
	/** 
	* @Description: 人员管理下的综合管理
	*/
	@ResponseBody
	@RequestMapping(value="/zhgl.do")
	public PageInfo<User> getRyglZhgl(User user, @RequestParam int currentPage,HttpServletRequest request){
		int pageSize=15;
		user.setUser_pic( ((User) request.getSession().getAttribute("currentUser")).getUser_pic());
		PageInfo<User> zhglPageInfo=new PageInfo<User>(ryglSerivce.ryglZhgl(user, currentPage, pageSize));
		return zhglPageInfo;
	}
	
	
	/** 
	 * @Description: 人员管理下的更新
	 */
	@ResponseBody
	@RequestMapping(value="/ryglupdate.do", produces="text/html;charset=UTF-8")
	public String updateRygl(User user,HttpServletRequest request) {
		//user.setPhone(oldUser_id);//为了减少字段把旧user_id放到phone
		String ryglupdatemsg=ryglSerivce.ryglUpdate(user,request);
		return ryglupdatemsg;
	}
	
	/** 
	 * @Description: 人员管理下的删除
	 */
	@ResponseBody
	@RequestMapping(value="/rygldelete.do", produces="text/html;charset=UTF-8")
	public String deleteRygl(User user) {
		String ryglupdatemsg=ryglSerivce.ryglDelete(user);
		return ryglupdatemsg;
	}
	
	/** 
	 * @Description: 查询所有pic
	 */
	@ResponseBody
	@RequestMapping(value="/findallpic.do")
	public List<Map<String, Object>>  findAllPic(HttpServletRequest request) {
		List<Map<String, Object>>  picMap=ryglSerivce.findAllPic(request);
		return picMap;
	}
	
	/** 
	 * @Description: 添加普通用户
	 */
	@ResponseBody
	@RequestMapping(value="/adduser.do", produces="text/html;charset=UTF-8")
	public String   addUser(User user, HttpServletRequest request) {
		String addMsg=ryglSerivce.addUser(user,request);
		return addMsg;
	}
	
	/** 
	 * @Description: 变更负责人
	 */
	@ResponseBody
	@RequestMapping(value="/updatepic.do", produces="text/html;charset=UTF-8")
	public String updatePic(@RequestParam String oldID, @RequestParam String newID, HttpServletRequest request) {
		String picMsg=ryglSerivce.updatePic(oldID, newID,request);
		return picMsg;
	}
}
