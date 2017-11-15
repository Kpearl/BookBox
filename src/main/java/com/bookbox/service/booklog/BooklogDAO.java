package com.bookbox.service.booklog;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

public interface BooklogDAO {

	public List<Booklog> getBooklogList(Map<String, Object> map);
	
	public Booklog getBooklog(Booklog booklog);
	
	public void updateBooklog(Booklog booklog);
	
	public int addBookmark(User user, Booklog booklog);
	
	public int deleteBookmark(User user, Booklog booklog);
	
	public boolean getBookmark(User user, Booklog booklog);

	public Map<String, String> getCounts(String email);
	
	public List<String> getBookLikeList(Map<String, Object> map);
	
}
