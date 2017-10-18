package com.bookbox.common.service;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.User;

@Service("CommonDAO")
public interface CommonDAO {

	/**
	 * @file com.bookbox.common.service.addLike.java
	 * @brief addLike
	 * @detail 좋아요 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addLike(User user, Object obj);

	/**
	 * @file com.bookbox.common.service.deleteLike.java
	 * @brief deleteLike
	 * @detail 좋아요 취소
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteLike(User user, Object obj);

	/**
	 * @file com.bookbox.common.service.addReply.java
	 * @brief addReply
	 * @detail 댓글 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addReply(User user, Object object, Reply reply);
	
	/**
	 * @file com.bookbox.common.service.deleteReply.java
	 * @brief deleteReply
	 * @detail 댓글 삭제
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void deleteReply(User user, Object obj, Reply reply);

	/**
	 * @file com.bookbox.common.service.addGrade.java
	 * @brief addGrade
	 * @detail 평점 추가
	 * @author JJ
	 * @date 2017.10.18
	 */
	public void addGrade(User user, Object obj, Grade grade);
}
