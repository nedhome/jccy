package com.ggxytxh.jccy.base.aspects;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ggxytxh.jccy.base.exception.parentException;
/** 
 * @Description:日志切面和异常统一处理
 * @author LinBinglong
 * @date 2016年3月6日
 * @version 1.0 
 */

@Component

@Aspect
public class allAspect{

	@Autowired
	HttpServletRequest request;
	
	
	/**
	 * @param j
	 * @param ex
	 * @throws parentException 
	 */
	@AfterThrowing(pointcut="execution(* com.ggxytxh.jccy.*.service.impl.*.*(..))",throwing="ex")
	public void allException(JoinPoint j,Exception  ex) {
		
		
		Signature menthodName=j.getSignature();
		String arg="";
		for (int i = 0; i < j.getArgs().length; i++) {  
	          arg+=(j.getArgs()[i])+",";  
	    }  
		
		Logger logger = Logger.getLogger(allAspect.class);  
		String requestUrl = request.getRequestURI(); 
		String ip = request.getRemoteHost();
		logger.error("[IP:"+ ip+"]-[URL:"+requestUrl+"]-[MENTHOD:"+menthodName+"_("+arg.toString()+")]-throw "+ex.getMessage(),ex);
		
	    throw new parentException("[" + ip + "]", ex);
	}
	
}











