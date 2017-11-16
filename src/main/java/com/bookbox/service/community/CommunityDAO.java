package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

public interface CommunityDAO {
	
	public int addBorad(Board board);
	public Board getBoard(int boardNo);
	public int updateBoard(Board board);
	public int deleteBoard(int boardNo);
	public List getBoardList(Map map);
	public List getBoardListUserTagMapper(Map map);
	public int getBoardTotal(Map map);
	
	
	public int addComment(Comment comment);
	public Comment getComment(int commentNo);
	public int updateCommnet(Comment comment);
	public List<Comment> getCommentList(int boardNo);
	public int getCommentMaxLevel(int boardNo);
	
	public int addRecommend(Recommend recommed);
	public int getRecommend(Recommend recommend);
	public int addReport(Report report);
}
