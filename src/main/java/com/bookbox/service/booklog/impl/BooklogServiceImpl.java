package com.bookbox.service.booklog.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Posting;
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
	public List<Booklog> getBooklogList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return booklogDAO.getBooklogList(map);
	}

	@Override
	public Booklog getBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		booklog = booklogDAO.getBooklog(booklog);
		for(Posting posting : booklog.getPostingList()) {
			StringBuffer content = new StringBuffer();
			for(String seq : posting.getPostingContent().split("<")) {
				if(seq.indexOf(">") != -1) {
					content.append(seq.substring(seq.indexOf(">")+1));
				}else {
					content.append(seq);
				}
			}
			posting.setPostingContent(content.toString());
		}
		return booklog;
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

	@Override
	public Map<String, String> getCounts(String email) {
		// TODO Auto-generated method stub
		return booklogDAO.getCounts(email);
	}


}
