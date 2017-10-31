package com.bookbox.service.booklog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@Service("booklogServiceImpl")
public class BooklogServiceImpl implements BooklogService {

	@Autowired
	@Qualifier("booklogDAOImpl")
	private BooklogDAO booklogDAO;
	
	public BooklogServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	@Override
	public List<Booklog> getBooklogList(Search search) {
		// TODO Auto-generated method stub
		return booklogDAO.getBooklogList(search);
	}

	@Override
	public Booklog getBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return booklogDAO.getBooklog(booklog);
	}

	@Override
	public void updateBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		booklogDAO.updateBooklog(booklog);
	}

	@Override
	public boolean addBooklogBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		if(booklogDAO.addBookmark(user, booklog) > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean deleteBooklogBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		if(booklogDAO.deleteBookmark(user, booklog) > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean getBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return booklogDAO.getBookmark(user, booklog);
	}

}
