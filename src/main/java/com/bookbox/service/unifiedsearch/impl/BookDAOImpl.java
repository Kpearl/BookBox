package com.bookbox.service.unifiedsearch.impl;

import org.springframework.stereotype.Service;

import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookDAO;

/**
 * @file com.bookbox.service.unifiedsearch.BookDaoImpl.java
 * @brief BookDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */
@Service("bookDAOImpl")
public class BookDAOImpl implements BookDAO {

	public BookDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addBookList(Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBookLike(User user, Book book) {
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

}
