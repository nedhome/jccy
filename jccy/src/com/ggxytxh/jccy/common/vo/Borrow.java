package com.ggxytxh.jccy.common.vo;

import java.util.Date;

public class Borrow {

	private Integer id;// borrow的ID
	private String user_id;// 用户帐号
	private String book_id;// 图书书号
	private String yysj;// 预约时间
	private Date ghsj;// 归还时间（实际）
	private Integer ifback;// 是否归还，“1” 已经归还或者还没取书（也就是预约）
	private Integer jybj;// 借阅标志
	private Integer xjbj;// 续借标志
	private Date gqsj;// 预约过期时间
	private Date jysj;// 借阅时间
	private Integer cqbj;// 超期标志
	private Date dqsj;// 借阅后到期时间
	private Integer gs_key;// 挂失标志
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBook_id() {
		return book_id;
	}
	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}
	public String getYysj() {
		return yysj;
	}
	public void setYysj(String yysj) {
		this.yysj = yysj;
	}
	public Date getGhsj() {
		return ghsj;
	}
	public void setGhsj(Date ghsj) {
		this.ghsj = ghsj;
	}
	public Integer getIfback() {
		return ifback;
	}
	public void setIfback(Integer ifback) {
		this.ifback = ifback;
	}
	public Integer getJybj() {
		return jybj;
	}
	public void setJybj(Integer jybj) {
		this.jybj = jybj;
	}
	public Integer getXjbj() {
		return xjbj;
	}
	public void setXjbj(Integer xjbj) {
		this.xjbj = xjbj;
	}
	public Date getGqsj() {
		return gqsj;
	}
	public void setGqsj(Date gqsj) {
		this.gqsj = gqsj;
	}
	public Date getJysj() {
		return jysj;
	}
	public void setJysj(Date jysj) {
		this.jysj = jysj;
	}
	public Integer getCqbj() {
		return cqbj;
	}
	public void setCqbj(Integer cqbj) {
		this.cqbj = cqbj;
	}
	public Date getDqsj() {
		return dqsj;
	}
	public void setDqsj(Date dqsj) {
		this.dqsj = dqsj;
	}
	public Integer getGs_key() {
		return gs_key;
	}
	public void setGs_key(Integer gs_key) {
		this.gs_key = gs_key;
	}
	
	
	
}
