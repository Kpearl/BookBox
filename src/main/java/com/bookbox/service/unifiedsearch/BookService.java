package com.bookbox.service.unifiedsearch;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;

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
}
