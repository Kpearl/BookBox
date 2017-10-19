package com.bookbox.service.booklog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.service.TagService;
import com.bookbox.service.booklog.PostingDAO;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

@Service("postingServiceImpl")
public class PostingServiceImpl implements PostingService {

	@Autowired
	@Qualifier("postingDAOImpl")
	private PostingDAO postingDAO;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Override
	public boolean addPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		postingDAO.addPosting(posting);
		tagService.addTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		return true;
	}

	@Override
	public Posting getPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		posting = postingDAO.getPosting(posting);
		posting.setPostingTagList(tagService.getTagGroupList(Const.Category.POSTING, posting.getPostingNo()));
		return posting;
	}

	@Override
	public List<Posting> getPostingList(Search search) {
		// TODO Auto-generated method stub
		List<Posting> postingList = postingDAO.getPostingList(search); 
		for(Posting posting : postingList) {
			posting.setPostingTagList(tagService.getTagGroupList(Const.Category.POSTING ,posting.getPostingNo()));
		}
		return postingList;
	}

	@Override
	public boolean updatePosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		postingDAO.updatePosting(posting);
		tagService.updateTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		return true;
	}

}
