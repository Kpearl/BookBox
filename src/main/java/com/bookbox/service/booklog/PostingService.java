package com.bookbox.service.booklog;

import java.util.Map;

import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

public interface PostingService {

	public boolean addPosting(User user, Posting posting) throws Exception;
	
	public Posting getPosting(User user, Posting posting);
	
	public Map<String, Object> getPostingList(Map<String, Object> map);
	
	public boolean updatePosting(User user, Posting posting) throws Exception;
	
}
