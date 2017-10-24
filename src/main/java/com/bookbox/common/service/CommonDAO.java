package com.bookbox.common.service;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.service.domain.User;

public interface CommonDAO {

	/**
	  * @brief addLike
	 * @detail 좋아요 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addLike(User user, Map<String, Object> map);

	/**
	 * @brief deleteLike
	 * @detail 좋아요 취소
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteLike(User user, Map<String, Object> map);

	/**
	 * @brief getReplyList
	 * @detail 댓글 리스트 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public List<Reply> getReplyList(User user, Map<String, Object> map);
	
	/**
	 * @brief addReply
	 * @detail 댓글 추가
	 * @author JJ
	 * @date 2017.10.18
	 * 
	 * 
	 */
	public void addReply(User user, Map<String, Object> map);
	
	/**
	 * @brief deleteReply
	 * @detail 댓글 삭제
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteReply(User user, Map<String, Object> map);

	/**
	 * @brief addGrade
	 * @detail 평점 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addGrade(User user, Map<String, Object> map);

	/**
	 * @brief getGrade
	 * @detail 평점 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public Grade getGrade(User user, Map<String, Object> map);
	
	/**
	 * @brief getLike
	 * @detail 좋아요 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public Like getLike(User user, Map<String, Object> map);
	
	/**
	 * @brief addUploadFile
	 * @detail 파일업로드
	 * @author HJ
	 * @date 2017.10.23
	 */
	public void addUploadFile(List<UploadFile> list) ;
	
	/**
	 * @brief updateUploadFile
	 * @detail 업로드파일 수정
	 * @author HJ
	 * @date 2017.10.23
	 */
	public void updateUploadFile(List<UploadFile> list);
	
	/**
	 * @brief updateUpload
	 * @detail 업로드한 파일 조회 
	 * @author HJ
	 * @date 2017.10.23
	 */
	public List<UploadFile> getUploadFileList(Map<String, Object> map);
	
	
	/**
	 * @brief deleteUploadFile
	 * @detail 업로드파일 삭제 
	 * @author HJ
	 * @date 2017.10.23
	 */
	public void deleteUploadFile(List<UploadFile> list);
	
}
