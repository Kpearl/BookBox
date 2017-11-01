package com.bookbox.service.booklog;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.User;

public interface BooklogService {

	public List<Booklog> getBooklogList(Search search);
	
	public Booklog getBooklog(User user, Booklog booklog);
	
	public void updateBooklog(User user, Booklog booklog);
	
	public boolean addBooklogBookmark(User user, Booklog booklog);

	public boolean deleteBooklogBookmark(User user, Booklog booklog);
	
	public boolean getBookmark(User user, Booklog booklog);
	public Funding test(Funding funding);
}
