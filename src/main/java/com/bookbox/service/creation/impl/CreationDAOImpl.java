package com.bookbox.service.creation.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.creation.CreationDAO;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.impl.CreationDAOImpl.java
 * @brief 창작작품 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("creationDAOImpl")
public class CreationDAOImpl implements CreationDAO {

	/**
	 * @brief  Field
	 */
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	/**
	 * @brief  Constructor
	 */		
	public CreationDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	public void addCreation(Creation creation) throws Exception{
		sqlSession.insert("CreationMapper.addCreation", creation);
	}
	
	public void updateCreation(Creation creation) throws Exception{
		sqlSession.update("CreationMapper.updateCreation", creation);
	}
	
	public List<Creation> getCreationList(Search search) throws Exception{
		return sqlSession.selectList("CreationMapper.getCreationList", search);
	}
	
	public int getTotalCreationCount(Search search) throws Exception{
		return sqlSession.selectOne("CreationMapper.getTotalCount", search);
	}
	
	public List<Creation> getCreationSubscribeList(User user) throws Exception{
		return sqlSession.selectList("CreationMapper.getCreationList", user);
	}
	
	public void addCreationSubscribe(Creation creation) throws Exception{
		sqlSession.insert("CreationMapper.addCreationSubscibe", creation);
	}
	
	public void deleteCreationSubscribe(User user,Creation creation) throws Exception{
		sqlSession.delete("CreationMapper.deleteCreationSubscibe", creation);
	}
	
}
