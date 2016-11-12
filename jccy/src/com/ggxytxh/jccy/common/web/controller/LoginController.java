package com.ggxytxh.jccy.common.web.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ggxytxh.jccy.base.interceptor.LoginInterceptor;
import com.ggxytxh.jccy.common.vo.User;

/** 
 * @author LinBinglong
 * @date 2016年1月10日
 * @version 1.0 
 */
@Controller
public class LoginController extends LoginInterceptor{

	@RequestMapping(value="/login.do")
	public String login(User user, @RequestParam String  validateCode, HttpServletRequest request) {
		String inmsg=this.loginCheck(user,validateCode);
		if ("success".equals(inmsg)) {
			return "redirect:index.jsp";
		}else{
			return "redirect:jccy/base/error.jsp";
		}
	}
	
	
	@RequestMapping(value="/logout.do")
	public String doLogOut() {
		String outmsg=this.logOut();
		if("success".equals(outmsg))
			return "redirect:index.jsp";
		else {
			return "redirect:jccy/base/error.jsp";
		}
	}

}
