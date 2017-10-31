package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import org.springframework.core.io.FileSystemResource;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.UploadFile;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.creationService.java
 * @brief 창작작품 Service
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */
public interface CreationService {

	/**
	 * @brief 창작작품등록 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */	
	public void addCreation(User user, Creation creation) throws Exception;
	
	/**
	 * @brief 창작작품수정 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return void
	 */		
	public void updateCreation(User user, Creation creation) throws Exception;
	
	/**
	 * @brief 창작작품 가져오기 
	 * @param Creation 
	 * @throws Exception
	 * @return Creation
	 */		
	public Creation getCreation(Creation creation) throws Exception;

	/**
	 * @brief 창작작품리스트, 작품리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */	
	public List<Creation> getCreationList(Map<String, Object> map) throws Exception;

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
	public void addCreationSubscribe(User user,Creation creation) throws Exception;

	/**
	 * @brief 작품구독취소 
	 * @param User user, Creation creation
	 * @throws Exception
	 * @return 
	 */	
	public void deleteCreationSubscribe(User user,Creation creation) throws Exception;
	
	/**
	 * @brief 작품삭제
	 * @param User, Creation
	 * @throws Exception
	 * @return 
	 */	
	public void deleteCreation(Creation creation) throws Exception;
	
	
	/**
	 * @brief saveFile/파일저장
	 * @param MultipartFile
	 * @throws Exception
	 * @return UploadFile
	 */
	public UploadFile saveFile(MultipartFile multipartFile,
														FileSystemResource uploadDirResource) throws Exception;
}
