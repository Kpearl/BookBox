package com.bookbox.service.creation.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationDAO;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;

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
	@Qualifier("creationDAOImpl")
	private CreationDAO creationDAO;
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	
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
	}
	
	/**
	 * @brief 창작작품리스트, 작품리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */	
	public Map<String, Object> getCreationList(Search search) throws Exception{
		
		Map<String, Object> map = new HashMap<>(); 
		
		return map;
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
	public void addCreationSubscribe(User user, Creation creation) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		map.put("email", user.getEmail());
		map.put("creationNo", creation.getCreationNo());
		
		creation.setDoSubscription(true);
		creationDAO.addCreationSubscribe(map);
	}
	
	/**
	 * @brief 작품구독취소 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public void deleteCreationSubscribe(User user,Creation creation) throws Exception{
		
		Map<String, Object> map = new HashMap<>();
		map.put("email", user.getEmail());
		map.put("creationNo", creation.getCreationNo());
		
		creation.setDoSubscription(false);
		creationDAO.deleteCreationSubscribe(map);
	}


}
