package com.bookbox.service.unifiedsearch;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

@Service("bookDAO")
public interface BookDAO {

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookLike.java
	 * @brief addBookLike
	 * @detail 도서 좋아요 추가
	 * @author JJ
	 * @date 2017.10.17
	 */
	public void addBookLike(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookLike.java
	 * @brief deleteBookLike
	 * @detail 도서 좋아요 취소
	 * @author JJ
	 * @date 2017.10.17
	 */
	public void deleteBookLike(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookReply.java
	 * @brief addBookReply
	 * @detail 도서 댓글 추가
	 * @author JJ
	 * @date 2017.10.17
	 */
	public void addBookReply(User user, Book boo, Reply replyk);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookReply.java
	 * @brief deleteBookReply
	 * @detail 도서 댓글 삭제
	 * @author JJ
	 * @date 2017.10.17
	 */
	public void deleteBookReply(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookGrade.java
	 * @brief addBookGrade
	 * @detail 도서 평점 추가
	 * @author JJ
	 * @date 2017.10.17
	 */
	public void addBookGrade(User user, Book book);
}
