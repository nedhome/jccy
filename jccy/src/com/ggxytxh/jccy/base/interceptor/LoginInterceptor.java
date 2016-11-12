package com.ggxytxh.jccy.base.interceptor;

import java.util.Date;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.ggxytxh.jccy.common.vo.User;
import com.google.code.kaptcha.Constants;



/** 
 * @author LinBinglong
 * @date 2016年1月11日
 * @version 1.0 
 */

public class LoginInterceptor {
	
	@Autowired  
	private  HttpServletRequest request;  
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String login_message=null;

	/** 
	* @Description: 对外登录入口
	* @param @param arg
	* @param @return   
	* @return String 
	*/
	public String loginCheck(Object arg,String validateCode ) {
		String codeMSG=checkCode(validateCode ,request);
		if ("success".equals(codeMSG)) {
			checkLoginLog((User)arg);
		}else{
			login_message="验证码错误";
		}
		request.getSession().setAttribute("login_message", login_message);
		return login_message;
	}
	
	private String checkCode(String validateCode, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String makeValidateCode = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		if (validateCode != null && makeValidateCode != null) {
			if (makeValidateCode.equalsIgnoreCase(validateCode)){
				return "success";
			}
		}
		return "failed";
	}
	
	/** 
	* @Description: 登录方法
	* @param @param user
	* @param @return   
	* @return User 
	*/
	private User login(User user) {
		String queryId="login"; 
		User usertemp=sqlSession.selectOne(queryId, user);
		if (usertemp==null) {
			login_message="登录用户账户或密码错误!";
		}else{
			request.getSession().setAttribute("currentUser", usertemp);
			login_message="success";
		}
		return usertemp;
	}
	
	/** 
	* 获取登录者的IP
	* @param @return   
	* @return String 
	*/
	private String getIP() {
		String IP=request.getRemoteHost();//获取用户的IP
		return IP;
	}
	
	/** 
	* 首次记录帐号登录信息和更新重置
	* @param    
	* @return void 
	*/
	private void firstLoginLog(User user, int num) {
		String queryId="firstloginlog";
		HashMap<String, Object> hashMap=new HashMap<String, Object>();
		hashMap.put("ip", getIP());
		hashMap.put("time", new java.sql.Timestamp(new java.util.Date().getTime()));
		hashMap.put("number", 0);
		hashMap.put("flag", 1);
		hashMap.put("user_id", user.getUser_id());
		if (num==0) {
			sqlSession.insert(queryId+"_1", hashMap);//首次写入
		}else{
			sqlSession.update(queryId+"_2", hashMap);//更新重置	
		}
		if(num!=3){login(user);}
	}
	
	/** 
	* 更新登录日志
	* @param    
	* @return void 
	*/
	private void updateLoginLog(HashMap<String, Object> hashMap, User user) {
		String queryId="updataloginlog";
		Date nowTime=new java.sql.Timestamp(new java.util.Date().getTime());
		long diff = nowTime.getTime() - ((Date) hashMap.get("time")).getTime();//这样得到的差值是微秒级别
		
		if (diff>180000) {//更新重置
			firstLoginLog(user, 1);
		}else {
			/****************  已经上锁状态   ******************/
			if ((int)hashMap.get("flag")==0) {
				login_message="登录过于频繁，请"+(180-diff/1000)+"秒后再尝试!";
				return;
			}
			/****************  没有上锁状态   ******************/
			if (login(user)!=null) {//登录成功
				firstLoginLog(user, 3);
				return;
			}
			int number=1+(int)hashMap.get("number");
			if (number<4) {//错误次数没有+1前小于 3 次
				login_message="您3分钟内已连续错误登录"+(number)+"次!";
				hashMap.put("number", number);//错误次数+1
				sqlSession.update(queryId+"_1", hashMap);	
				if (number==3) {//错误次数已达3次，进行上锁
					hashMap.put("flag", 0);
					sqlSession.update(queryId+"_2", hashMap);
				}
			}
		}		
	}
	
	/** 
	* 登录监控
	* @param    
	* @return void 
	*/
	private void checkLoginLog(User user) {
		String queryId="loginprotect";
		HashMap<String, Object> hashMap=sqlSession.selectOne(queryId, user.getUser_id());
		if (hashMap==null) {
			firstLoginLog(user, 0);//首次登录添加日志
			
		}else{
			updateLoginLog(hashMap, user);//更新日志
		}
	}
	
	
	/** 
	* 退出系统
	* @param    
	* @return void 
	*/
	public String logOut() {
		request.getSession().removeAttribute("currentUser");
		return "success";
	}
	
	
}



















