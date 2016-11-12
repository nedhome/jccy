package com.ggxytxh.jccy.common.vo;

public class Contribution {

	private Integer id; //主键id
	private String user_id;//捐书者id
	private String book_id;//书号
	private String book_name;//书名
	private String book_publish;//出版社
	private String contributor_name;//捐书者名称
	private String on_time;//录入时间

	public String getBook_id() {
		return book_id;
	}

	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}

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

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public String getBook_publish() {
		return book_publish;
	}

	public void setBook_publish(String book_publish) {
		this.book_publish = book_publish;
	}

	public String getContributor_name() {
		return contributor_name;
	}

	public void setContributor_name(String contributor_name) {
		this.contributor_name = contributor_name;
	}

	public String getOn_time() {
		return on_time;
	}
	
	public void setOn_time(String on_time) {
		this.on_time = on_time;
	}
}
