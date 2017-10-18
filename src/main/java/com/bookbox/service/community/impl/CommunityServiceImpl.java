package com.bookbox.service.community.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
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
		
		return communityDAOImple.addBorad(board);
	}

	@Override
	public Board getBoard(int boardNo) {
		// TODO Auto-generated method stub
		return communityDAOImple.getBoard(boardNo);
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

	@Override
	public int addRecommend(Recommend recommed) {
		//게시글 추천일때
		if(recommed.getCategory().equals("board")) {
			recommed.setCategoryNo(Const.Category.BOARD);
			
			if(recommed.getPref().equals("up")) {
		
			Board board=communityDAOImple.getBoard(recommed.getTargetNo());
			board.setRecommend(board.getRecommend()+1);
			communityDAOImple.updateBoard(board);
			}
			
			else {
				
			}
			return communityDAOImple.getBoard(recommed.getTargetNo()).getRecommend();
		}
		//댓글 추천일때
		else if(recommed.getCategory().equals("comment")) {
		//	recommed.setCategoryNo(Const.Category.);
			
			if(recommed.getPref().equals("up")) {
				
			}
			else {
				
			}
		}
		
		return communityDAOImple.addRecommend(recommed);
	}

	@Override
	public int addReport(Report report) {
		
		if(report.getCategory().equals("board")) {
			report.setCategoryNo(Const.Category.BOARD);
			
			Board board=communityDAOImple.getBoard(report.getTargetNo());
			board.setReport(board.getReport()+1);
			communityDAOImple.updateBoard(board);
		
		}
		else if(report.getCategory().equals("comment")) {
			
		}
		
		
		return communityDAOImple.addReport(report);
	}
	
	

	
}
