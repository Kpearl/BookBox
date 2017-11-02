package com.bookbox.service.booklog.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.User;

@Repository("booklogDAOImpl")
public class BooklogDAOImpl implements BooklogDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public BooklogDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public List<Booklog> getBooklogList(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("BooklogMapper.getBooklogList", search);
	}

	@Override
	public Booklog getBooklog(Booklog booklog) {
		// TODO Auto-generated method stub
		booklog = sqlSession.selectOne("BooklogMapper.getBooklog", booklog);
		Map<String, Map<Object, Map<String,Object>>> statistics = new HashMap<String, Map<Object, Map<String,Object>>>();
		statistics.put("daily", sqlSession.selectMap("BooklogMapper.getDailyVisitors", booklog.getBooklogNo(), "num"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("value", booklog.getBooklogNo());
		map.put("interval", "week");
		statistics.put("weekly", sqlSession.selectMap("BooklogMapper.getVisitors", map, "num"));
		map.put("interval", "month");
		statistics.put("monthly", sqlSession.selectMap("BooklogMapper.getVisitors", map, "num"));
		booklog.setVisitorsStatistics(statistics);
		return booklog;
	}

	@Override
	public void updateBooklog(Booklog booklog) {
		// TODO Auto-generated method stub
		sqlSession.update("BooklogMapper.updateBooklog", booklog);
	}

	@Override
	public int addBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return sqlSession.insert("BooklogMapper.addBookmark", this.mappingUserBooklog(user, booklog));
	}

	@Override
	public int deleteBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return sqlSession.delete("BooklogMapper.deleteBookmark", this.mappingUserBooklog(user, booklog));
	}

	@Override
	public boolean getBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		String value = (String)sqlSession.selectOne("BooklogMapper.getBookmark", this.mappingUserBooklog(user, booklog));
		if(value == null) {
			return false;
		}else {
			return true;
		}
	}
	
	public Map<String, Object> mappingUserBooklog(User user, Booklog booklog){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("booklog", booklog);
		
		return map;
	}

	@Override
	public Funding test(Funding funding) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BooklogMapper.getFundingTest", funding);
	}
}
