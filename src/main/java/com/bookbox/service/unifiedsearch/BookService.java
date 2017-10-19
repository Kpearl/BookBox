package com.bookbox.service.unifiedsearch;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

public interface BookService {

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookList.java
	 * @brief getBookList
	 * @detail 키워드가 포한된 도서 리스트 정보를 KAKAO API를 이용하여 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.16
	 */
	public List<Book> getBookList(Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getBook.java
	 * @brief getBook
	 * @detail 사용자가 선택한 도서 정보를 KAKAO API를 이용하여 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.16
	 */
	public void getBook(User user, Book book) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getRecommendBookList.java
	 * @brief getRecommendBookList
	 * @detail AladinAPI를 이용하여 추천도서, 베스트셀러 리스트 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.18
	 */
	
	public void getRecommendBookList() throws Exception;
}
