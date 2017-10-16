package com.bookbox.service.booklog.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@Service("booklogServiceImpl")
public class BooklogServiceImpl implements BooklogService {

	@Override
	public List<Booklog> getBooklogList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Booklog getBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return null;
	}

}
