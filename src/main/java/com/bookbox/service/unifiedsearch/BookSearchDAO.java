package com.bookbox.service.unifiedsearch;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;

public interface BookSearchDAO {

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookList.java
	 * @brief getBookList
	 * @detail
	 * @author JJ
	 * @return 
	 * @date 2017.10.16
	 */
	public void getBookList(Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getBook.java
	 * @brief getBook
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getBook(Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.getRecommendBookList.java
	 * @brief getRecommendBookList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getRecommendBookList();
}
