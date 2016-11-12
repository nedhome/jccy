package com.ggxytxh.jccy.common.vo;

import java.util.Date;

public class Collect {
	private Integer id;
	private String user_id;
	private String book_id;
	private Date sc_time;
	private String book_name;// 书名
	private String book_pubish;// 出版社

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

	public Date getSc_time() {
		return sc_time;
	}

	public void setSc_time(Date sc_time) {
		this.sc_time = sc_time;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public String getBook_pubish() {
		return book_pubish;
	}

	public void setBook_pubish(String book_pubish) {
		this.book_pubish = book_pubish;
	}

}
