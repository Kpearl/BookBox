package com.bookbox.service.booklog;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

public interface BooklogService {

	public List<Booklog> getBooklogList(Search search);
	
	public Booklog getBooklog(User user, Booklog booklog);
	
	public void updateBooklog(User user, Booklog booklog);
	
	public List<Booklog> getBookmarkList(User user);
	
	public void addBookmark(User user, Booklog booklog);

}
