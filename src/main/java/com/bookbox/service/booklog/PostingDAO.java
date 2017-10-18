package com.bookbox.service.booklog;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Posting;

public interface PostingDAO {

	public boolean addPosting(Posting posting);
	
	public Posting getPosting(Posting posting);
	
	public List<Posting> getPostingList(Search search);
	
	public boolean updatePosting(Posting posting);
	
}
