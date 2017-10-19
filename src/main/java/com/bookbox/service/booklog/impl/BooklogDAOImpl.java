package com.bookbox.service.booklog.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.domain.Booklog;
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
		return sqlSession.selectOne("BooklogMapper.getBooklog", booklog);
	}

	@Override
	public void updateBooklog(Booklog booklog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		
	}
	
	
}
