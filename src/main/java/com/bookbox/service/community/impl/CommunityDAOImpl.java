package com.bookbox.service.community.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;

@Repository("communityDAOImpl")
public class CommunityDAOImpl implements CommunityDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public CommunityDAOImpl() {
		System.out.println("Constructor:"+ this.getClass().getSimpleName());
	}
	
	@Override
	public int addBorad(Board board) {
		
		return sqlSession.insert("CommunityMapper.addBoard",board);
	}

	@Override
	public Board getBoard(int boardNo) {
		
		return sqlSession.selectOne("CommunityMapper.getBoard",boardNo);
		
	}

	@Override
	public int updateBoard(Board board) {
		
		return sqlSession.update("CommunityMapper.updateBoard",board);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return sqlSession.delete("CommunityMapper.deleteBoard",boardNo);
	}

	@Override
	public List getBoardList(Map map) {
		return sqlSession.selectList("CommunityMapper.getBoardList",map);
	}

	@Override
	public int addComment(Comment comment) {

		return sqlSession.insert("CommunityMapper.addComment",comment);
	}

	@Override
	public List<Comment> getCommentList(int boardNo) {
		
		return sqlSession.selectList("CommunityMapper.getCommentList",boardNo);
	}
 
		
}
