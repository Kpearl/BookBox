package com.bookbox.service.unifiedsearch;

import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

public interface BookDAO {

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookList.java
	 * @brief addBookList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void addBookList(Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.deleteBookLike.java
	 * @brief deleteBookLike
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void deleteBookLike(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookReply.java
	 * @brief addBookReply
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void addBookReply(User user, Book book);

	/**
	 * @file com.bookbox.service.unifiedsearch.addBookGrade.java
	 * @brief addBookGrade
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void addBookGrade(User user, Book book);
}
