package com.bookbox.service.unifiedsearch.impl;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;

/**
 * @file com.bookbox.service.unifiedsearch.BookServiceImpl.java
 * @brief BookServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */

@Service("bookServiceImpl")
public class BookServiceImpl implements BookService {

	public BookServiceImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
	}

	@Override
	public void getBookList(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getBook(Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addBookReply(User user, Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addBookGrade(User user, Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addBookLike(User user, Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBookLike(User user, Book book) {
		// TODO Auto-generated method stub
		
	}

}
