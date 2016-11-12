package com.ggxytxh.jccy.common.vo;



public class Book {

	private Integer id;// 书的编号
	private String book_id;// 在借阅表的编号
	private String name;// 书名
	private String picture_path;// 图片路径
	private String publish;// 出版社
	private String campus;// 校区
	private String academy;// 学院
	private String profession;// 专业
	private String pic;// 负责人
	private String cjsj;// 创建时间
	private String contributor;// 提供者
	private String contributor_name;
	private Integer borrow_num;// 可借数
	private String book_comment;// 备注
    
    public String getContributor_name() {
		return contributor_name;
	}
    public void setContributor_name(String contributor_name) {
		this.contributor_name = contributor_name;
	}

	public String getCjsj() {
		return cjsj;
	}
	public void setCjsj(String cjsj) {
		this.cjsj = cjsj;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBook_id() {
		return book_id;
	}

	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture_path() {
		return picture_path;
	}

	public void setPicture_path(String picture_path) {
		this.picture_path = picture_path;
	}

	public String getPublish() {
		return publish;
	}

	public void setPublish(String publish) {
		this.publish = publish;
	}

	public String getCampus() {
		return campus;
	}

	public void setCampus(String campus) {
		this.campus = campus;
	}

	public String getAcademy() {
		return academy;
	}

	public void setAcademy(String academy) {
		this.academy = academy;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getContributor() {
		return contributor;
	}

	public void setContributor(String contributor) {
		this.contributor = contributor;
	}

	public Integer getBorrow_num() {
		return borrow_num;
	}

	public void setBorrow_num(Integer borrow_num) {
		this.borrow_num = borrow_num;
	}

	public String getBook_comment() {
		return book_comment;
	}
	
	public void setBook_comment(String book_comment) {
		this.book_comment = book_comment;
	}

	
	
	
}
