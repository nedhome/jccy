package com.ggxytxh.jccy.tsgl.service.impl;

import com.ggxytxh.jccy.common.service.impl.QueryPageServiecImpl;
import com.ggxytxh.jccy.common.vo.Book;
import com.ggxytxh.jccy.common.vo.Borrow;
import com.ggxytxh.jccy.common.vo.User;
import com.ggxytxh.jccy.jyxx.service.JyxxService;
import com.ggxytxh.jccy.tsgl.service.TsglService;
import com.github.pagehelper.Page;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


/**
 * @author LinBinglong
 * @date 2016年2月27日
 * @version 1.0
 */
@Service
public class TsglServiceImpl extends QueryPageServiecImpl implements TsglService {
    @Autowired
    private SqlSessionTemplate sqlSession;
    @Autowired
    JyxxService jyxxService;

    
    
    /** 
    * @Description: 用户进行预约图书
    */
    @Transactional
    @Override
    public String yyts(String book_id, String user_id, HttpServletRequest request) {
    	if ("".equals(user_id)|| null==user_id) {
			return "非法操作";
		}
        String yymsg = "预约失败！";
        if (jyxxService.cqtsGet(user_id).size() > 0) {
            yymsg = "你有超期图书没有归还喔！";
        } else {
        	List<Map<String, Object>> listMap = jyxxService.dqyyGet(user_id);
            if (listMap.size() > 15) {
                yymsg = "你已经预约了15本书了喔！";
            } else {
                //判断是否已经借阅这本书
                Boolean flag = true;
                for (int i = 0; i < listMap.size(); i++) {
                    String book_id_temp = (String) listMap.get(i).get("book_id");
                    if (book_id_temp.equals(book_id)) {
                        yymsg = "你已经预约了这本书！";
                        flag = false;break;
                    }
                }
                if (flag) {
                    Calendar currentTime = Calendar.getInstance();
                    Date borrow_time = currentTime.getTime();
                    currentTime.add(Calendar.DAY_OF_MONTH, 3); //3天后自动取消(预约期限)
                    Date gqsj = currentTime.getTime();

                    HashMap<String, Object> hashMap = new HashMap<String, Object>();
                    hashMap.put("user_id", user_id);
                    hashMap.put("book_id", book_id);
                    hashMap.put("yysj", borrow_time);
                    hashMap.put("gqsj", gqsj);
                    
					if (sqlSession.update("yyts_book", book_id) > 0)
						if (sqlSession.insert("yyts_borrow", hashMap) > 0) 
							yymsg = "预约成功！";
                }	
            }
        }
        return yymsg;
    }

	
    /** 
    * @Description: 用户进行收藏图书
    */
    @Transactional
    @Override
	public String scts(String book_id, String user_id,HttpServletRequest request) {
    	if ("".equals(user_id)|| null==user_id) {
			return "非法操作";
		}
    	String scmsg=null;
    	HashMap<String , Object> hashMap=new HashMap<String, Object>();
    	Calendar currentTime = Calendar.getInstance();
        Date scsj = currentTime.getTime();
    	hashMap.put("user_id", user_id);
    	hashMap.put("book_id", book_id);
    	hashMap.put("scsj", scsj);
    	if ( sqlSession.selectList("scts_check", hashMap).size()<=0 ){
    		if (sqlSession.insert("scts", hashMap) > 0) {
    			scmsg = "收藏成功!";
			}else {
				scmsg = "收藏失败!";
			}
    	}else {
			scmsg = "您已经收藏过这本书了";
		}
		return scmsg;
	}

	/** 
	* @Description: 负责人获取自己帐号下的预约情况列表
	*/
	@Override
	public Page<HashMap<String, Object>> jylbGet(String user_id, String pic_id, int currentPage, int pageSize) {
		String queryId="getjylb";
		HashMap<String, Object> hashMap=new HashMap<String, Object>();
		hashMap.put("user_id", user_id);
		hashMap.put("pic_id", pic_id);
		Page<HashMap<String, Object>> jylbPage=this.pagedQuery(queryId, hashMap, currentPage, pageSize);
		return jylbPage;
	}


	/** 
	* @Description: 取书操作  
	*/
	@Override
	public String tsjyDo(Borrow borrow) {
		String queryId="dotsjy";
		String tsjymsg=null;
		if (sqlSession.update(queryId, borrow)>0) {
			tsjymsg="取书成功！";
		}else {
			tsjymsg="取书失败！";
		}
		return tsjymsg;
		
	}


	/** 
	* @Description: 进行添加图书操作：借用book的cjsj(创建时间)字段传contributor 的名字
	*/
	@Transactional
	@Override
	public String bookAdd(Book book) {
		String addQueryId = "addbook";
		String getQueryId = "getbook_id";
		if("不存在这个账号".equals(book.getContributor_name())){return "提供者不存在";}
		
		HashMap<String, Object> hashMap = sqlSession.selectOne(getQueryId, book);
		if (hashMap==null||hashMap.get("pic")==null) {
			return "添加失败";
		}
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		String book_id = (String) hashMap.get("book_id");
		String dataID = simpleDateFormat.format(new Date()).toString();
		
		if (book_id == null) {//没有该负责人的记录
			book.setBook_id("P" + (String) hashMap.get("pic") + "M" + dataID + "001");
		} else {
			if (book_id.length() == 15) {
				if (!book_id.substring(4, 12).equals(dataID)) {
					book.setBook_id(book_id.substring(0, 4) + dataID + "001");
				} else {
					book.setBook_id(book_id.substring(0, 12) + // 负责人+日期
							String.format("%03d", (Integer.parseInt(book_id.substring(12, 15)) + 1)));// 后3位加1
				}
			}else {
				return "添加失败";
			}
		}
		book.setPic((String) hashMap.get("pic"));
		if (sqlSession.insert(addQueryId, book) > 0 ) {
			String ctbquery="insertContribution";
			if (sqlSession.insert(ctbquery, book)>0) {
				String msg="添加成功 [书号：" +book.getBook_id()+"]" ;
				return msg;
			}
		}
		return "添加失败";

	}


	/** 
	* @Description: 图书管理下的综合查询
	*/
	@Override
	public Book tsglZhcx(String book_id) {
		String zhcxquery="tsglzhcx";
		Book zhcxBook=sqlSession.selectOne(zhcxquery, book_id);
		if (null==zhcxBook) {
			zhcxBook=new Book();
		}
		return zhcxBook;
	}


	/** 
	* @Description: 图书管理下的修改图书
	*/
	@Override
	public String tsglChange(Book book, HttpServletRequest request) {
		String changequery="tsglchange";
		User user=(User)request.getSession().getAttribute("currentUser");
		String bookPic = ((Book)request.getSession().getAttribute("changeBook")).getPic();
		if (!user.getUser_id().equals(bookPic)) {
			return "无权限修改";
		}
		book.setPic(user.getUser_id());
		if (sqlSession.update(changequery, book) > 0) {
			request.getSession().removeAttribute("changeBook");
			return "修改成功";
		}
		return "修改失败";
	}


	/** 
	* @Description: 图书管理下的删除图书 
	*/
	@Override
	public String deleteBook(String book_id, HttpServletRequest request) {
		User user=(User)request.getSession().getAttribute("currentUser");
		String bookPic = ((Book)request.getSession().getAttribute("changeBook")).getPic();
		if (!user.getUser_id().equals(bookPic)) {
			return "无权限修改";
		}
		String deletequery="tsgldelete";
		if (sqlSession.delete(deletequery, book_id) > 0) {
			return "删除成功";
		}
		return "删除失败，这本书有人正在预约或借阅";
	}


	/**
	 * @param user_id
	 * @param request
	 * @return
	 */
	@Override
	public String findUserName(String user_id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		if (user_id==null || user_id=="") {return "非法操作";}
		int type_id=((User)request.getSession().getAttribute("currentUser")).getType_id();
		if (type_id==1 || type_id==2) {
			String userNameQuery="findUserName";
			String userName=sqlSession.selectOne(userNameQuery, user_id) ;
			return userName;
		}else{
			return "非法操作";
		}
		
	}


	/**
	 * @param user_id
	 * @param book_id
	 * @param request
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findBack(String user_id, String book_id, HttpServletRequest request) {
		User user=(User)request.getSession().getAttribute("currentUser");
		if (null==user) {
			return null;
		}
		String pic_id=user.getUser_id();
		String queryId="findback";
		Map<String, Object> backMap=new HashMap<String, Object>();
		backMap.put("user_id", user_id);
		backMap.put("book_id", book_id);
		backMap.put("pic_id", pic_id);
		List<Map<String, Object>> listMap=sqlSession.selectList(queryId, backMap);
		return listMap;
	}


	/**
	 * @param back_id
	 * @param book_id
	 * @param request
	 * @return
	 */
	@Transactional
	@Override
	public String  backBook(String back_id, String book_id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		String queryBorrow="backborrow";
		String queryBook="backbook";
		if (sqlSession.delete(queryBorrow,back_id)>0 && sqlSession.update(queryBook,book_id)>0) {
			return "归还成功";
		}
		return "归还失败";
	}


	

}










