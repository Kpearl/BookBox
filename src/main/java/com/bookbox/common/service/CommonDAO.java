package com.bookbox.common.service;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.User;

public interface CommonDAO {

	/**
	 * @file com.bookbox.common.service.addLike.java
	 * @brief addLike
	 * @detail 좋아요 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addLike(User user, Map<String, Object> map);

	/**
	 * @file com.bookbox.common.service.deleteLike.java
	 * @brief deleteLike
	 * @detail 좋아요 취소
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteLike(User user, Map<String, Object> map);

	/**
	 * @file com.bookbox.common.service.getReplyList.java
	 * @brief getReplyList
	 * @detail 댓글 리스트 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public List<Reply> getReplyList(User user, Map<String, Object> map);
	
	/**
	 * @file com.bookbox.common.service.addReply.java
	 * @brief addReply
	 * @detail 댓글 추가
	 * @author JJ
	 * @date 2017.10.18
	 * 
	 * 
	 */
	public void addReply(User user, Map<String, Object> map);
	
	/**
	 * @file com.bookbox.common.service.deleteReply.java
	 * @brief deleteReply
	 * @detail 댓글 삭제
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteReply(User user, Map<String, Object> map);

	/**
	 * @file com.bookbox.common.service.addGrade.java
	 * @brief addGrade
	 * @detail 평점 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addGrade(User user, Map<String, Object> map);

	/**
	 * @file com.bookbox.common.service.getGrade.java
	 * @brief getGrade
	 * @detail 평점 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public Grade getGrade(User user, Map<String, Object> map);
	/**
	 * @file com.bookbox.common.service.getLike.java
	 * @brief getLike
	 * @detail 좋아요 조회
	 * @author JJ
	 * @date 2017.10.18
	 */
	public Like getLike(User user, Map<String, Object> map);
}
