package com.bookbox.service.unifiedsearch;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

@Service("bookService")
public interface BookService {
	
	/**
	 * @file com.bookbox.service.unifiedsearch.getBookList.java
	 * @brief getBookList
	 * @detail 키워드가 포한된 도서 리스트 정보를 KAKAO API를 이용하여 출력
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getBookList(Search search);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.getBook.java
	 * @brief getBook
	 * @detail 사용자가 선택한 도서 정보를 KAKAO API를 이용하여 출력
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getBook(Book book);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.addBookReply.java
	 * @brief addBookReply
	 * @detail 도서에 댓글 추가
	 * @author JJ
	 * @date 2017.10.16
	 */
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
