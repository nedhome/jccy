package com.ggxytxh.jccy.tsgl.service.impl;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ggxytxh.jccy.tsgl.service.PictureService;

/** 
 * @author LinBinglong
 * @date 2016年3月2日
 * @version 1.0 
 */

@Service
public class PictureServiceImpl implements PictureService {

	
	@Override
	public String uploadPicture(MultipartFile pictureFile, HttpServletRequest request) {
		String fileName = pictureFile.getOriginalFilename();//名字
		String filePath = request.getServletContext().getRealPath("/resources/img/book_img/");//容器路径+存储路径
		try {
			File file = new File(filePath,fileName);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			pictureFile.transferTo(file);//
			filePath=request.getContextPath()+"/resources/img/book_img/" + fileName;
			request.setAttribute("path", filePath);
			request.getSession().setAttribute("fileName", fileName);
			return "success";
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}

	}

	@Override
	public String cutPicture(float x, float y, float width, float height, HttpServletRequest request, String oldPath) {
		String savePath;// 最终保存路径
		String nextName = null;//nextName.jpg(文件名)
		Image img;
		ImageFilter cropFilter;
		
		//获取上传的文件
		String filePath = request.getServletContext().getRealPath("/resources/img/book_img/");
		String path=filePath+"\\"+(String)request.getSession().getAttribute("fileName");
		request.getSession().removeAttribute("fileName");
		File oldFileFile=new File(path);
		
		try {
			// 读取源图像
			BufferedImage bi = (BufferedImage)ImageIO.read(oldFileFile);
			int srcWidth = bi.getWidth(); // 源图宽度
			int srcHeight = bi.getHeight(); // 源图高度
			
			//剪切
			Image image = bi.getScaledInstance(srcWidth, srcHeight,Image.SCALE_DEFAULT);
			cropFilter = new CropImageFilter((int)x, (int)y, (int)width, (int)height);
			img = Toolkit.getDefaultToolkit().createImage(new FilteredImageSource(image.getSource(), cropFilter));
			BufferedImage tag = new BufferedImage((int)width, (int)height,BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			
			// 绘制缩小后的图
			g.drawImage(img, 0, 0, null); 
			g.dispose();
			
			//设置保存保存路径
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			savePath = filePath+"\\" + simpleDateFormat.format(new Date()).toString();
			File file = new File(savePath);
			
			// 多级目录，不能用mkdir()
			if (!file.exists()) {
				file.mkdirs();
			}
			
			//查找该路径下的最大文件名，i+1用于生产下一个文件名
			if(file.list().length>0){
				Arrays.sort(file.list());
				nextName=file.list()[file.list().length-1];
				nextName=String.valueOf((Integer.parseInt(nextName.substring(0, nextName.length()-4))+1));
			}else {
				nextName=1+"";
			}
			
			// 用于保存的图片，生成
			ImageIO.write(tag, "JPEG", new File(savePath+"\\"+nextName+".jpg"));
			
			// 整个路径包含文件名放在request中
			savePath="resources/img/book_img/"+simpleDateFormat.format(new Date()).toString()+"/"+nextName+".jpg";
			request.setAttribute("savePath", savePath);
			
			//删除原来文件
			oldFileFile.delete();
			
			//oldPath有两个作用，一个是指定路径，一个是添加图书（Length<=0）与修改封面(包含原来没有的就不跑方法，有的进行修改就删除)的区分标志
			if (null!=oldPath) {
				oldPath = request.getServletContext().getRealPath("//")+"\\"+oldPath.replace('/', '\\'); 
				return deleteOldPicture(oldPath);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}
	
	
	/** 
	* @Description: 更新封面时要把原来的删除
	* @param @param oldPath
	* @param @return   
	* @return String 
	*/
	private String deleteOldPicture(String oldPath) {
		File currentFile = new File(oldPath);
		if (!currentFile.exists()) {
			return "旧封面路径找不到！";
		}else {
			String parentPath = currentFile.getParent(); //获取父文件路径
			File parentFile =new File(parentPath);
			currentFile.delete();//删除当前文件
			if (parentFile.list().length<=0) {//说明空文件夹
				parentFile.delete();
			}
		}
		return "修改成功";
	}

}
