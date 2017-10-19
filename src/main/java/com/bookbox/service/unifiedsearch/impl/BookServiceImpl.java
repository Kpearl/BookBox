package com.bookbox.service.unifiedsearch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;
import com.bookbox.service.unifiedsearch.BookService;

/**
 * @file com.bookbox.service.unifiedsearch.impl.BookServiceImpl.java
 * @brief BookServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.18
 */

@Service("bookServiceImpl")
public class BookServiceImpl implements BookService {

	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;

	public BookServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {
		return bookSearchDAO.getBookList(search);
	}

	@Override
	public void getBook(User user, Book book) throws Exception {
		bookSearchDAO.getBook(book);
	}

	@Override
	public void getRecommendBookList() throws Exception {
		bookSearchDAO.getRecommendBookList();		
	}
}
