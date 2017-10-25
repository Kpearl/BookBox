package com.bookbox.service.booklog.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Location;
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
//		if(posting.getPostingFileList() != null && posting.getPostingFileList().size() != 0) {
//			Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.POSTING, posting.getPostingNo());
//			map.put("originName", posting.getPostingFileList().get(0));
//			map.put("fileName", Calendar.getInstance().getTimeInMillis());
//			commonDAO.addUploadFile(user, map);
//				sqlSession.insert("PostingMapper.addPostingFile", posting);
//		}
//		addPostingLocation(posting);
		return true;
	}

	@Override
	public Posting getPosting(Posting posting) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PostingMapper.getPosting", posting);
	}

	@Override
	public List<Posting> getPostingList(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PostingMapper.getPostingList", search);
	}

	@Override
	public boolean updatePosting(Posting posting) {
		// TODO Auto-generated method stub
		sqlSession.update("PostingMapper.updatePosting", posting);
		sqlSession.delete("PostingMapper.deletePostingLocation", posting);
		addPostingLocation(posting);
		return true;
	}
	
	public void addPostingLocation(Posting posting) {
		if(posting.getPostingLocationList() != null && posting.getPostingLocationList().size() != 0) {
			for(Location location : posting.getPostingLocationList()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("postingNo", posting.getPostingNo());
				map.put("locationName", location.getLocationName());
				map.put("locationLatitude", location.getLocationLatitude());
				map.put("locationLongitude", location.getLocationLongitude());
				sqlSession.insert("PostingMapper.addPostingLocation", map);
			}
		}
	}
}
