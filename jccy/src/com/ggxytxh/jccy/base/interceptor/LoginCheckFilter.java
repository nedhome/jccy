package com.ggxytxh.jccy.base.interceptor;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.web.filter.OncePerRequestFilter;

import com.ggxytxh.jccy.common.vo.User;

/** 
 * @author LinBinglong
 * @date 2016年3月6日
 * @version 1.0 
 */

public class LoginCheckFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		
        
		String requestUrl = request.getRequestURI();   // 请求的uri 
        
        User user = (User) request.getSession().getAttribute("currentUser");
        
		if (null == user) {//非登录拦截,请求只有登陆和系统公告请求通过和贡献榜/jccy/common/findcontribution
				if ( requestUrl.matches(".*/login.do")|| requestUrl.matches(".*/jccy/common/.*")) {
					filterChain.doFilter(request, response); 
					return;
				}
				isAjax(request,response,"/jccy/login.jsp");
		} else {//登录状态
			int userType=user.getType_id();
			switch (userType) {
				case 0://一般用户非法访问：*/jccy/rygl*、*/jccy/tsgl*/、*/jccy/xtwh*
					if( requestUrl.matches(".*/jccy/tsgl/tsyy.do") || requestUrl.matches(".*/jccy/tsgl/tssc.do") ){
						break;
					}
					if ( requestUrl.matches(".*/jccy/rygl.*") ||  requestUrl.matches(".*/jccy/tsgl.*") ||  requestUrl.matches(".*/jccy/xtwh.*") ) {
						isAjax(request,response,"/jccy/index.jsp");
						return;
					}
					break;
				case 1://负责人非法访问：*/jccy/xtwh*
					if (requestUrl.matches(".*/jccy/xtwh.*") ||requestUrl.matches(".*/jccy/rygl/tjry.*")) {
						isAjax(request,response,"/jccy/index.jsp");
						return;
					}
					break;
					
				case 2://管理员非法访问：*/jccy/xtwh*、预约jccy/tsgl/tsyy.do和收藏图书/jccy/tsgl/tssc.do
					if (requestUrl.matches(".*/jccy/tsgl/findUserName.*") ){
						break;
					}
					if (requestUrl.matches(".*/jccy/tsgl.*")|| requestUrl.matches(".*/jccy/tsgl/tsyy.*")||requestUrl.matches(".*/jccy/tsgl/tssc.*")) {
						isAjax(request,response,"/jccy/index.jsp");
						return;
					}
					break;
	
				default://非法类型
					{isAjax(request,response,"/jccy/index.jsp");return;}
			}
			//正常访问
			filterChain.doFilter(request, response); 
			return;
		}
	}
	
	
	private void isAjax(HttpServletRequest request,HttpServletResponse response,String url) throws IOException{
		String header = request.getHeader("X-Requested-With"); // ajax 传送的一种编码
		boolean isAjaxRequest=( header != null && "XMLHttpRequest".equals(header) ) ? true : false;
		if (isAjaxRequest) {
			response.sendRedirect("/jccy/jccy/base/illegal.txt");
		}else{
			response.sendRedirect(url);
		}
	}
}
