package com.bookbox.common.service.impl;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.service.CommonDAO;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.impl.CommonDaoImpl.java
 * @brief CommonDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.18
 */

@Service("commonDAOImpl")
public class CommonDAOImpl implements CommonDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	private Map<String, Object> map;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CommonDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void addLike(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addLike", map);
	}

	@Override
	public void deleteLike(User user, Map<String, Object> map) {
		
		this.map = map;
		map.put("user", user);
		
		sqlSession.delete("CommonMapper.deleteLike", map);
	}

	@Override
	public Object getLike(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		return sqlSession.selectOne("CommonMapper.getLike", map);
	}

	@Override
	public void addReply(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addReply", map);
	}

	@Override
	public void deleteReply(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		sqlSession.delete("CommonMapper.deleteReply", map);
	}

	@Override
	public Object getReplyList(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		return sqlSession.selectList("CommonMapper.getReplyList", map);
	}

	@Override
	public void addGrade(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addGrade", map);
	}

	@Override
	public Object getGrade(User user, Map<String, Object> map) {

		this.map = map;
		map.put("user", user);
		
		return sqlSession.selectOne("CommonMapper.getGrade", map);
	}
}
