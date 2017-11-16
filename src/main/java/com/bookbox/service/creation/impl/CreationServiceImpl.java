package com.bookbox.service.creation.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationDAO;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingDAO;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.service.creation.impl.CreationServieceImpl.java
 * @brief 창작작품 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Service("creationServiceImpl")
public class CreationServiceImpl implements CreationService {
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private	UserService userService;
	
	@Autowired
	@Qualifier("creationDAOImpl")
	private CreationDAO creationDAO;

	@Autowired
	@Qualifier("fundingDAOImpl")
	private FundingDAO fundingDAO;
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchElasticDAO;
	
	/**
	 * @brief Constructor
	 */
	public CreationServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	/**
	 * @brief 창작작품등록 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */
	public void addCreation(User user, Creation creation) throws Exception{
		
		creationDAO.addCreation(creation);		
		tagService.addTagGroup(Const.Category.CREATION, creation.getCreationNo(), creation.getTagList());
		unifiedsearchElasticDAO.elasticInsert(creation);
	}
	
	/**
	 * @brief 창작작품수정 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */	
	public void updateCreation(User user, Creation creation) throws Exception{
		
		creationDAO.updateCreation(creation);
		tagService.updateTagGroup(Const.Category.CREATION, creation.getCreationNo(), creation.getTagList());
		unifiedsearchElasticDAO.elasticUpdate(creation);
	}
	
	@Override
	public Creation getCreation(Map<String, Object> map) throws Exception {
		// TODO getCreation
		Creation creation = creationDAO.getCreation(map);
		
		creation.setCreationAuthor(userService.getUser(creation.getCreationAuthor()));
		System.out.println("==============================creationAuthor:: "+creation.getCreationAuthor());
		creation.setGrade(commonDAO.getAvgGrade(map));
		creation.setLike(commonDAO.getLike(map));
		creation.setWritingList(writingService.getWritingList(map));
		
		if (creationDAO.getCreationSubscribe(map) !=0) {
			creation.setDoSubscription(true);
		}
		if (fundingDAO.getDoFunding(map) !=0) {
			creation.setDoFunding(true);
		}
		
		return creation;
	}

	/**
	 * @brief 창작작품리스트, 작품리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return List<Creation>
	 */	
	public List<Creation> getCreationList(Map<String, Object> map) throws Exception{
		Page page=(Page)map.get("page");
		System.out.println("========================MAP=========="+map);
		if (page != null) {
			
		page.setTotalCount(creationDAO.getTotalCreationCount((Search)map.get("search")));
		System.out.println("getCreationList :: getTotalCount ::"+page.getTotalCount());
		}
		
		List<Creation> creationList = creationDAO.getCreationList(map);
		System.out.println("======================getCreationList :: "+creationList);
		List<Creation> addFundingCreationList = new ArrayList<>();
		
		if (page == null) {
		
			for(Creation creation : creationList) {
				int count = fundingDAO.getDoFunding(map);

				map.put("targetNo", creation.getCreationNo());
				creation.setGrade(commonDAO.getAvgGrade(map));
				
				if (count == 0) {
					addFundingCreationList.add(creation);	
				}
			}
		}
	
		if (page != null) {
			for(Creation creation : creationList) {
				map.put("targetNo", creation.getCreationNo());
				creation.setGrade(commonDAO.getAvgGrade(map));
				System.out.println("=================22222 "+creationList);
			}
			return creationList;
		}else {
			System.out.println("=================33333333 "+creationList);
		return addFundingCreationList;
		}
	}
	
	/**
	 * @brief 구독작품리스트 
	 * @param User user
	 * @throws Exception
	 * @return List<Creation>
	 */	
	public List<Creation> getCreationSubscribeList(User user) throws Exception{
		
		List<Creation> list = new ArrayList<>(); 
		
		return list;
	}
	
	/**
	 * @brief 작품구독신청
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public boolean doCreationSubscribe(User user, Creation creation) throws Exception{
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(), user);
		
		creationDAO.doCreationSubscribe(map);

		return true; 
	}
	
	/**
	 * @brief 작품구독취소 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public boolean deleteCreationSubscribe(User user,Creation creation) throws Exception{
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(), user);
		creationDAO.deleteCreationSubscribe(map);
		
		return true;
	}
	
	/**
	 * @brief 작품삭제
	 * @param Creation
	 * @throws Exception
	 * @return 
	 */	
	public int deleteCreation(Creation creation) throws Exception{
		
		creation.setActive(0);
		
		Writing writing = new Writing();
		for (int i = 0; i < creation.getWritingList().size(); i++) {
			writing = creation.getWritingList().get(i);
			writing.setActive(0);
			writingService.deleteWriting(writing);
		}
		
		creationDAO.updateCreation(creation);
		unifiedsearchElasticDAO.elasticDelete(creation);		
		
		return 1;
	}
	
	/**
	 * @brief saveFile/파일저장
	 * @param MultipartFile
	 * @throws Exception
	 * @return UploadFile
	 */
	public UploadFile saveFile(MultipartFile multipartFile, String path) throws Exception{
		
		UploadFile uploadFile = new UploadFile();
		
		String originName = multipartFile.getOriginalFilename();
		String fileName = UUID.randomUUID().toString()
																		+originName.substring(originName.lastIndexOf("."));
		//System.out.println(fileName);
		File  target = new File(path,fileName);
		multipartFile.transferTo(target);
		
		uploadFile.setFileName(fileName);
		uploadFile.setOriginName(originName);
		
		System.out.println("target :: "+target);

		return uploadFile;
	}

	/**
	 * @brief addCreationLike
	 * @param User, Creation
	 * @throws Exception
	 * @return boolean
	 */
	@Override
	public boolean addCreationLike(User user, Creation creation) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(), user);
		
		commonDAO.addLike(map);
			
		return true;
	}

	/**
	 * @brief deleteCreationLike
	 * @param User, Creation
	 * @throws Exception
	 * @return boolean
	 */
	@Override
	public boolean deleteCreationLike(User user, Creation creation) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(), user);
		
		commonDAO.deleteLike(map);
				
		return true;
	}

}
