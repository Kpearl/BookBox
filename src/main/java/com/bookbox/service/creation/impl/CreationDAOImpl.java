package com.bookbox.service.creation.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.util.CommonUtil;
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
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	/**
	 * @brief  Constructor
	 */		
	public CreationDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	public void addCreation(Creation creation) throws Exception{
		sqlSession.insert("CreationMapper.addCreation", creation);
	}
	
	public Creation getCreation(Creation creation) throws Exception{
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo());
		creation.setGrade(commonDAO.getAvgGrade(map));
		
		return sqlSession.selectOne("CreationMapper.getCreation", creation);
	}
	
	public void updateCreation(Creation creation) throws Exception{
		sqlSession.update("CreationMapper.updateCreation", creation);
	}
	
	public List<Creation> getCreationList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("CreationMapper.getCreationList", map);
	}
	
	public int getTotalCreationCount(Search search) throws Exception{
		return sqlSession.selectOne("CreationMapper.getTotalCreationCount", search);
	}
	
	public List<Creation> getCreationSubscribeList(User user) throws Exception{
		return sqlSession.selectList("CreationMapper.getCreationList", user);
	}
	
	public void addCreationSubscribe(Map<String, Object> map) throws Exception{
		sqlSession.insert("CreationMapper.addCreationSubscibe", map);
	}
	
	public void deleteCreationSubscribe(Map<String, Object> map) throws Exception{
		sqlSession.delete("CreationMapper.deleteCreationSubscibe", map);
	}
	
}
