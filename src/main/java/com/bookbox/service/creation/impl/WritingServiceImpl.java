package com.bookbox.service.creation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
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
	public void addWriting(User user, Writing writing) throws Exception{
		
		writingDAO.addWriting(writing);

		List<UploadFile> uploadFileList = writing.getWritingFileList();
		
		for(UploadFile uploadFile : uploadFileList) {
			uploadFile.setCategoryNo(Const.Category.CREATION);
			uploadFile.setTargetNo(writing.getWritingNo());
		}
		
		System.out.println("addWriting :: "+uploadFileList);
		commonDAO.addUploadFile(uploadFileList);
	}

	/**
	 * @brief 창작글 수정 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */		
	public void updateWriting(User user, Writing writing) throws Exception{
		
		List<UploadFile> uploadFileList = writing.getWritingFileList();
		
		for(UploadFile uploadFile : uploadFileList) {
			uploadFile.setCategoryNo(Const.Category.CREATION);
			uploadFile.setTargetNo(writing.getWritingNo());
		}
		
		System.out.println("updateWriting :: "+uploadFileList);
		commonDAO.updateUploadFile(uploadFileList);
		writingDAO.updateWriting(writing);
	}

	/**
	 * @brief 창작글 조회 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */		
	public Writing getWriting(User user, Writing writing) throws Exception{
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.WRITING, writing.getWritingNo());
		
		writing.setGrade(commonDAO.getGrade(user, map));
		System.out.println("getWriting :: Grade :: "+commonDAO.getGrade(user, map));
		writing.setWritingFileList(commonDAO.getUploadFileList(map));
		System.out.println("getWriting :: WritingFileList :: "+commonDAO.getUploadFileList(map));
		
		Creation creation = creationDAO.getCreation(user,writing.getCreation());
		System.out.println("getWriting :: Creation :: "+writing.getCreation());
		
		
		creation.setLike(commonDAO.getLike(user, map));
		System.out.println("getWriting :: Like :: "+commonDAO.getLike(user, map));
		creation.setGrade(commonDAO.getGrade(user, map));
		System.out.println("getWriting :: CreationGrade :: "+commonDAO.getGrade(user, map));
		writing.setCreation(creation);
		System.out.println("getWriting :: Creation :: "+creation);
		
		System.out.println("getWriting :: Writing ::"+writing);
		return writingDAO.getWriting(writing);
	}
	
	/**
	 * @brief 창작글리스트, 창작글 총 개수
	 * @param Search 
	 * @throws Exception
	 * @return void
	 */	
	public Map<String, Object> getWritingList(Search search) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		
		return map;
	}
	
}
