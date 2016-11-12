package com.ggxytxh.jccy.base.exception;


/** 
 * @author LinBinglong
 * @date 2016年3月6日
 * @version 1.0 
 */

public class parentException  extends RuntimeException {

	private static final long serialVersionUID = 1L;
	String date=null;
	Exception exception=null;
	
	
	public parentException() {
		// TODO Auto-generated constructor stub
	}
	
	public parentException(String date, Exception ex) {
		// TODO Auto-generated constructor stub
		this.date=date;
		this.exception=ex;
		allException();
	}



	public void allException() {
		 //做处理
		throw new parentException();
	}
}
