package com.ggxytxh.jccy.common.vo;


public class News {
	private Integer newsid;// 消息ID
	private String user_id;// 用户帐号
	private String theme;// 主题
	private String content;//内容
	private String bgtime;// 开始时间
	private String endtime;//结束时间
	private String fqr;// 发起人
	private String zt;// 状态：2待处理，1已处理,0不使用
	private String ext1;// 没有使用字段
	private String ext2;//
	private String ext3;//


	
	public String getBgtime() {
		return bgtime;
	}
	public void setBgtime(String bgtime) {
		this.bgtime = bgtime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Integer getNewsid() {
		return newsid;
	}

	public void setNewsid(Integer newsid) {
		this.newsid = newsid;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFqr() {
		return fqr;
	}

	public void setFqr(String fqr) {
		this.fqr = fqr;
	}

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}

	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public String getExt3() {
		return ext3;
	}

	public void setExt3(String ext3) {
		this.ext3 = ext3;
	}

	@Override
	public String toString() {
		return "News [newsid=" + newsid + ", user_id=" + user_id + ", theme="
				+ theme + ", content=" + content + ", bgtime=" + bgtime
				+ ", endtime=" + endtime + ", fqr=" + fqr + ", zt=" + zt
				+ ", ext1=" + ext1 + ", ext2=" + ext2 + ", ext3=" + ext3 + "]";
	}

}
