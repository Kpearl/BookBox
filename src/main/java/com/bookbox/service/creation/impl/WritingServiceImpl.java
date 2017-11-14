package com.bookbox.service.creation.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationDAO;
import com.bookbox.service.creation.WritingDAO;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.service.creation.impl.WritingServiceImpl.java
 * @brief 창작글 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Service("writingServiceImpl")
public class WritingServiceImpl implements WritingService {

	/**
	 *@brief Field
	 */
	@Autowired
	@Qualifier("writingDAOImpl")
	private WritingDAO writingDAO;	
	
	@Autowired
	@Qualifier("creationDAOImpl")
	private CreationDAO creationDAO;
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;	
	
	/**
	 *@brief Constructor
	 */
	public WritingServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	
	/**
	 * @brief 창작글등록 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */	
	@Override
	public void addWriting(User user, Writing writing) throws Exception{
		
		writingDAO.addWriting(writing);

		List<UploadFile> uploadFileList = writing.getWritingFileList();
		
		for(UploadFile uploadFile : uploadFileList) {
			uploadFile.setCategoryNo(Const.Category.WRITING);
			uploadFile.setTargetNo(writing.getWritingNo());
		}
		
		System.out.println("addWriting :: "+uploadFileList+"\n");
		commonDAO.addUploadFile(uploadFileList);
	}

	/**
	 * @brief 창작글 수정 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */		
	@Override
	public void updateWriting(User user, Writing writing) throws Exception{
		
		List<UploadFile> uploadFileList = writing.getWritingFileList();
		
		for(UploadFile uploadFile : uploadFileList) {
			uploadFile.setCategoryNo(Const.Category.WRITING);
			uploadFile.setTargetNo(writing.getWritingNo());
		}
		
		System.out.println("updateWriting :: "+uploadFileList+"\n");
		commonDAO.updateUploadFile(uploadFileList);
		writingDAO.updateWriting(writing);
	}

	/**
	 * @brief 창작글 조회 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */		
	@Override
	public Writing getWriting(User user, Writing writing) throws Exception{
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.WRITING, writing.getWritingNo(),user);
		System.out.println("writingService :: getWriting :: map :: "+map);
		
		writing = writingDAO.getWriting(writing);
		writing.setGrade(commonDAO.getGrade(map));
		writing.setWritingFileList(commonDAO.getUploadFileList(map));
		writing.setReplyList(commonDAO.getReplyList(map));
		System.out.println("getWriting :: WritingFileList :: "+commonDAO.getUploadFileList(map));
		
		return writing;
	}
	
	/**
	 * @brief 창작글리스트, 창작글 총 개수
	 * @param Search 
	 * @throws Exception
	 * @return void
	 */	
	@Override
	public List<Writing> getWritingList(Map<String, Object> map) throws Exception{
		
		 commonDAO.getLike(map);
		
		if(map.get("page") != null) {
		Page page = (Page)map.get("page");
		page.setTotalCount(writingDAO.getTotalWritingCount((Creation)map.get("cration")));
		}
		List<Writing> writingList = writingDAO.getWritingList(map);
		map.put("categoryNo", Const.Category.WRITING);
		for(Writing writing : writingList) {
			map.put("targetNo", writing.getWritingNo());
			writing.setGrade(commonDAO.getGrade(map));
		}
		
		
		return writingList;
	}
	
	/**
	 * @brief 창작글 삭제 
	 * @param Writing
	 * @throws Exception
	 * @return void
	 */	
	@Override
	public void deleteWriting(Writing writing) throws Exception{
		
		writing.setActive(0);
		writingDAO.updateWriting(writing);
	}
	
	/**
	 * @brief  평점등록 
	 * @param Map<String,Object>
	 * @throws Exception
	 * @return void
	 */
	@Override
	public void addGrade(Map<String, Object> map) throws Exception{
		commonDAO.addGrade(map);
	}

	/**
	 * @brief  평점등록 
	 * @param Map<String,Object>
	 * @throws Exception
	 * @return void
	 */	
	@Override
	public void addReply(Map<String, Object> map) throws Exception {
		// TODO addReply
		commonDAO.addReply(map);
		
	}
	
	
	
}
