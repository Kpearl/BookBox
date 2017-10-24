package com.bookbox.service.community.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;
import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	@Qualifier("communityDAOImpl")
	CommunityDAO communityDAOImple;
	
	@Autowired
	@Qualifier("tagDAOImpl")
	TagDAO tagDAOImpl;

	public CommunityServiceImpl() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	@Override
	public int addBoard(User user,Board board) {
		
	int result=communityDAOImple.addBorad(board);
		for(Tag tag: board.getTagList()) {
			tagDAOImpl.addTag(tag);
		}
		tagDAOImpl.addTagGroup(6, board.getBoardNo(), board.getTagList());
		
		return result;
	}

	@Override
	public Board getBoard(User user,Board board) {
		
		board= communityDAOImple.getBoard(board.getBoardNo());
		
		List tagList=tagDAOImpl.getTagGroupList(Const.Category.BOARD, board.getBoardNo());
		board.setTagList(tagList);
		
		return board;
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
		//System.out.println("[communityServiceImpl.getBoardList() start...]");
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

	@Override
	public int addComment(Comment comment) {
		
		return communityDAOImple.addComment(comment);
	}

	@Override
	public List getCommentList(int boardNo) { 
		
		List<Comment> commentList=communityDAOImple.getCommentList(boardNo);
		
		if (commentList==null) {
			return null;
		}
		int maxLevel=communityDAOImple.getCommentMaxLevel(boardNo)+1;
		
		List<Comment>[] commentArray=new List[maxLevel];
		for(int i=0; i<maxLevel; i++) {
			commentArray[i]=new ArrayList();
		}
		
		//댓글 레벨별 정리
		int level=0;
		for(Comment comment: commentList) {
			level=comment.getLevel();
			commentArray[level].add(comment);
		}
		
		for(int i=1;i<maxLevel;i++) {
			for(int j=0;j<commentArray[i].size();j++) {
				Comment childComment=commentArray[i].get(j);
				int seniorNo=childComment.getSeniorCommentNo();
				for(int k=0;k<commentArray[i-1].size();k++) {
					Comment seniorComment=commentArray[i-1].get(k);
					if(seniorComment.getCommentNo()==seniorNo) {
						if(seniorComment.getComment()==null) {
							seniorComment.setComment(new ArrayList());
						}
						seniorComment.getComment().add(childComment);
					}
				}
				
			}
			
		}
		
		return commentArray[0];
		//return communityDAOImple.getCommentList(boardNo);
	}
	
	
	
	

	
}
