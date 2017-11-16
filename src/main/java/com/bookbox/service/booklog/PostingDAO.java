package com.bookbox.service.booklog;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Posting;

public interface PostingDAO {

	public boolean addPosting(Posting posting);
	
	public Posting getPosting(Posting posting);
	
	public List<Posting> getPostingList(Map<String, Object> map);
	
	public boolean updatePosting(Posting posting);
	
	public int getPostingCount(Search search);
}
