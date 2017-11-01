package com.bookbox.service.booklog;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

public interface PostingService {

	public boolean addPosting(User user, Posting posting) throws Exception;
	
	public Posting getPosting(User user, Posting posting);
	
	public List<Posting> getPostingList(Search search);
	
	public boolean updatePosting(User user, Posting posting) throws Exception;
	
}
