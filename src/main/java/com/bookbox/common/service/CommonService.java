package com.bookbox.common.service;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

@Service("CommonService")
public interface CommonService {

	public void addBookReply(User user, Book book);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.addBookGrade.java
	 * @brief addBookGrade
	 * @detail 도서 평점 추가
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void addBookGrade(User user, Book book);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.addBookLike.java
	 * @brief addBookLike
	 * @detail 도서 좋아요 추가
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void addBookLike(User user, Book book);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookLike.java
	 * @brief deleteBookLike
	 * @detail 도서 좋아요 취소
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void deleteBookLike(User user, Book book);
}
