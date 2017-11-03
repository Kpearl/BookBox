package com.bookbox.service.unifiedsearch;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

public interface BookService {

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookList.java
	 * @brief getBookList
	 * @detail 키워드가 포한된 도서 리스트 정보를 조회하여 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.16
	 */
	public List<Book> getBookList(Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getBook.java
	 * @brief getBook
	 * @detail 사용자가 선택한 도서 정보를 조회하여 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.20
	 */
	public Book getBook(User user, Book book) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getRecommendBookList.java
	 * @brief getRecommendBookList
	 * @detail AladinAPI를 이용하여 추천도서, 베스트셀러 리스트 출력
	 * @author JJ
	 * @return 
	 * @throws Exception 
	 * @date 2017.10.18
	 */
	public List<String> getRecommendBookList() throws Exception;
	
	/**
	 * @file com.bookbox.service.unifiedsearch.addBookLike.java
	 * @brief addBookLike
	 * @detail 좋아요 추가
	 * @author JJ
	 * @date 2017.10.20
	 */
	public void addBookLike(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookLike.java
	 * @brief deleteBookLike
	 * @detail 좋아요 취소
	 * @author JJ
	 * @date 2017.10.20
	 */
	public void deleteBookLike(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookReplyList.java
	 * @brief getBookReplyList
	 * @detail 댓글 리스트 조회
	 * @author JJ
	 * @date 2017.10.20
	 */
	public List<Reply> getBookReplyList(User user, Book book);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.addBookReply.java
	 * @brief addBookReply
	 * @detail 댓글 추가
	 * @author JJ
	 * @date 2017.10.20 
	 */
	public void addBookReply(User user, Book book, Reply reply);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookReply.java
	 * @brief deleteBookReply
	 * @detail 댓글 삭제
	 * @author JJ
	 * @date 2017.10.20
	 */
	public void deleteBookReply(User user, Book book, Reply reply);

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookGrade.java
	 * @brief addBookGrade
	 * @detail 평점 추가
	 * @author JJ
	 * @date 2017.10.20
	 */
	public void addBookGrade(User user, Book book, Grade grade);

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookGrade.java
	 * @brief getBookGrade
	 * @detail 평점 조회
	 * @author JJ
	 * @date 2017.10.20
	 */
	public Grade getBookGrade(Book book, User user);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.getBookLike.java
	 * @brief getBookLike
	 * @detail 좋아요 조회
	 * @author JJ
	 * @date 2017.10.20
	 */
	public Like getBookLike(Book book, User user);
	
	/**
	 * @file com.bookbox.service.unifiedsearch.getBookStatics.java
	 * @brief getBookStatics
	 * @detail 통계 조회
	 * @author JJ
	 * @date 2017.10.24
	 */
	public Map<String,  Map<String, Integer>> getBookStatistics(Book book);
}
