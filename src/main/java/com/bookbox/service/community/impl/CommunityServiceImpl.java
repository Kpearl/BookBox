package com.bookbox.service.community.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.User;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	@Qualifier("communityDAOImpl")
	CommunityDAO communityDAOImple;

	public CommunityServiceImpl() {
		System.out.println("Constructor:: "+this.getClass().getName());
	}
	
	@Override
	public int addBoard(Board board) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Board getBoard(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBoard(Board board) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Board> getBoardList(Map map) {
		System.out.println("[communityServiceImpl.getBoardList() start...]");
		return communityDAOImple.getBoardList(map);
		
	}
	
	

	
}
