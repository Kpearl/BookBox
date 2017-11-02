package com.bookbox.service.booklog;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.User;

public interface BooklogDAO {

	public List<Booklog> getBooklogList(Search search);
	
	public Booklog getBooklog(Booklog booklog);
	
	public void updateBooklog(Booklog booklog);
	
	public int addBookmark(User user, Booklog booklog);
	
	public int deleteBookmark(User user, Booklog booklog);
	
	public boolean getBookmark(User user, Booklog booklog);
	public Funding test(Funding funding);
}
