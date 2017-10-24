package com.bookbox.common.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.impl.CommonDaoImpl.java
 * @brief CommonDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.20
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
		
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addLike", map);
	}

	@Override
	public void deleteLike(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		sqlSession.delete("CommonMapper.deleteLike", map);
	}

	@Override
	public Like getLike(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		return sqlSession.selectOne("CommonMapper.getLike", map);
	}

	@Override
	public void addReply(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addReply", map);
	}

	@Override
	public void deleteReply(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		sqlSession.delete("CommonMapper.deleteReply", map);
	}

	@Override
	public List<Reply> getReplyList(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		return sqlSession.selectList("CommonMapper.getReplyList", map);
	}

	@Override
	public void addGrade(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		sqlSession.insert("CommonMapper.addGrade", map);
	}

	@Override
	public Grade getGrade(User user, Map<String, Object> map) {
		
		map.put("user", user);
		
		return sqlSession.selectOne("CommonMapper.getGrade", map);
	}
	
	@Override
	public Grade getAvgGrade(Map<String, Object> map) {
		
		return sqlSession.selectOne("CommonMapper.getAvgGrade", map);
	}

	@Override
	public void addUploadFile(List<UploadFile> list) {
		sqlSession.insert("CommonMapper.addUploadFile", list);
	
	}

	@Override
	public List<UploadFile> getUploadFileList(Map<String, Object> map) {
	
		return sqlSession.selectList("CommonMapper.getUploadFileList", map);
	}

	@Override
	public void updateUploadFile(List<UploadFile> list) {
		sqlSession.delete("CommonMapper.deleteUploadFile", list.get(0));
		sqlSession.insert("CommonMapper.addUploadFile", list);
	}

	@Override
	public void deleteUploadFile(List<UploadFile> list) {
		sqlSession.delete("CommonMapper.deleteUploadFile",list);
	}

	@Override
	public List<Map<String, Integer>> getBookStatics(Map<String, Object> map) {
		return sqlSession.selectList("CommonMapper.getBookStatics", map);
	}	
}
