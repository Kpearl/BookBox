package com.bookbox.service.booklog.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

@Service("postingServiceImpl")
public class PostingServiceImpl implements PostingService {

	@Override
	public boolean addPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Posting getPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Posting> getPostingList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updatePosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		return false;
	}

}
