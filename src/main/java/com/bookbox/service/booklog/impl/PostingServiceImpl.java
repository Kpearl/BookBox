package com.bookbox.service.booklog.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
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
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	@Override
	public boolean addPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		postingDAO.addPosting(posting);
		if(posting.getPostingTagList() != null && posting.getPostingTagList().size() != 0) {
			tagService.addTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		}
		this.insertPostingNoIntoUploadFileList(posting);
		commonDAO.addUploadFile(posting.getPostingFileList());
		return true;
	}

	@Override
	public Posting getPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		return postingDAO.getPosting(posting);
	}

	@Override
	public List<Posting> getPostingList(Search search) {
		// TODO Auto-generated method stub
		return postingDAO.getPostingList(search);
	}

	@Override
	public boolean updatePosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		postingDAO.updatePosting(posting);
		if(posting.getPostingTagList() != null && posting.getPostingTagList().size() != 0) {
			tagService.updateTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		}
		this.insertPostingNoIntoUploadFileList(posting);
		if(posting.getPostingFileList() != null && posting.getPostingFileList().size() != 0) {
			commonDAO.updateUploadFile(posting.getPostingFileList());
		}else {
			Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.POSTING, posting.getPostingNo());
			commonDAO.deleteUploadFile(map);
		}
		return true;
	}
	
	public void insertPostingNoIntoUploadFileList(Posting posting) {
		for(UploadFile uploadFile : posting.getPostingFileList()) {
			uploadFile.setCategoryNo(Const.Category.POSTING);
			uploadFile.setTargetNo(posting.getPostingNo());
		}
	}

}
