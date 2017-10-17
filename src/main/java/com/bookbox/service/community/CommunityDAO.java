package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;

public interface CommunityDAO {
	
	public int addBorad(Board board);
	public Board getBoard(int boardNo);
	public int updateBoard(Board board);
	public int deleteBoard(int boardNo);
	public List getBoardList(Map map);
	
	public int addComment(Comment comment);
	public List<Comment> getCommentList(int boardNo);
	
	public int addRecommend(int boardNo);
	public int addReport(int boardNo);
}
