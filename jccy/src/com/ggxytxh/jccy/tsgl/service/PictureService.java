package com.ggxytxh.jccy.tsgl.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

/** 
 * @author LinBinglong
 * @date 2016年3月2日
 * @version 1.0 
 */

public interface PictureService {

	/** 
	* @Description: 上传图片等待剪切
	* @param @return   
	* @return String 
	*/
	public String uploadPicture(MultipartFile pictureFile, HttpServletRequest request);
	

	/** 
    * @Description: 剪切图片进行保存
	* @param @param x
	* @param @param y
	* @param @param width
	* @param @param height
	* @param @param request
	* @param @return   
	* @return String 
	*/
	public String cutPicture(float x, float y, float width, float height, HttpServletRequest request,String oldPath);
}
