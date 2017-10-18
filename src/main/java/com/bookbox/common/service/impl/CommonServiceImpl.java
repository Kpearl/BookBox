package com.bookbox.common.service.impl;

import org.springframework.stereotype.Service;

import com.bookbox.common.service.CommonService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.unifiedsearch.BookServiceImpl.java
 * @brief BookServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */

@Service("bookServiceImpl")
public class CommonServiceImpl implements CommonService {

	public CommonServiceImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
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
