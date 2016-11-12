package com.ggxytxh.jccy.tsgl.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ggxytxh.jccy.tsgl.service.PictureService;

/** 
 * @author LinBinglong
 * @date 2016年3月3日
 * @version 1.0 
 */
@Controller
@RequestMapping(value="/tsgl")
public class PictureController {

	@Autowired
	private PictureService pictureService;
	

	/**
	 * 图片上传预览等待切割
	 * */
	@RequestMapping(value="/uploadpictue.do")
	public String uploadBookPicture( HttpServletRequest request,
			@RequestParam(required=false) String xgbj, @RequestParam MultipartFile pictureFile){
		pictureService.uploadPicture(pictureFile, request);
		if (xgbj!=null && xgbj.equals("T")) {
			return "/jccy/tsgl/zhcx";
		}else {
			return "/jccy/tsgl/add";		
		}
	}
	
	/**
	 * 图片剪切(添加)
	 * */
	@RequestMapping(value="/cutpicture.do")
	public String getCutBookPicturePath(@RequestParam float x, @RequestParam float y, @RequestParam float width, @RequestParam float height, 
			@RequestParam(required=false) String oldPath, HttpServletRequest request) {
		pictureService.cutPicture(x, y, width, height, request, oldPath);
		if (null==oldPath) {
			return "/jccy/tsgl/add";	
		}else  {
			return "/jccy/tsgl/zhcx";
		}
	}
	
	
	/**
	 * 图片剪切（修改）
	 * *//*
	@RequestMapping(value="/zhcxcutpicture.do")
	public String changeBookPicture(@RequestParam float x, @RequestParam float y,
			@RequestParam float width, @RequestParam float height, @RequestParam String oldPath, HttpServletRequest request) {
		oldPath=(null==oldPath || oldPath.length()<20)?"oldnull":oldPath;
		pictureService.cutPicture(x, y, width, height, request, oldPath);
			
	}*/

}
