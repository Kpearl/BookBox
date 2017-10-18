package com.bookbox.service.booklog.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.PostingDAO;
import com.bookbox.service.domain.Posting;

@Repository("postingDAOImpl")
public class PostingDAOImpl implements PostingDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	@Override
	public boolean addPosting(Posting posting) {
		// TODO Auto-generated method stub
		sqlSession.insert("PostingMapper.addPosting", posting);
		if(posting.getPostingFileList() != null && posting.getPostingFileList().size() != 0) {
//				sqlSession.insert("PostingMapper.addPostingFile", posting);
		}
		if(posting.getPostingLocationList() != null && posting.getPostingLocationList().size() != 0) {
//				sqlSession.insert("PostingMapper.addPostingLocation", posting);
		}
		return true;
	}

	@Override
	public Posting getPosting(Posting posting) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Posting> getPostingList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updatePosting(Posting posting) {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
