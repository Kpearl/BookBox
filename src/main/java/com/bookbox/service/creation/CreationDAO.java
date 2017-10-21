package com.bookbox.service.creation;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.creationDAO.java
 * @brief 창작작품 DAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */

public interface CreationDAO {

	/**
	 * @brief INSERT/창작작품등록 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */	
	public void addCreation(Creation creation) throws Exception;
	
	/**
	 * @brief UPDATE/ 창작작품수정 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */		
	public void updateCreation(Creation creation) throws Exception;
	
	/**
	 * @brief 창작작품리스트
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */	
	public List<Creation> getCreationList(Search search) throws Exception;
	
	/**
	 * @brief 작품리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */
	public int getTotalCreationCount(Search search) throws Exception;
	
	/**
	 * @brief 구독작품리스트 
	 * @param User user
	 * @throws Exception
	 * @return List<Creation>
	 */	
	public List<Creation> getCreationSubscribeList(User user) throws Exception;
	
	/**
	 * @brief 작품구독신청
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public void addCreationSubscribe(Creation creation) throws Exception;
	
	/**
	 * @brief 작품구독취소 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public void deleteCreationSubscribe(User user,Creation creation) throws Exception;
	
}
