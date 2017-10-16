package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;

public interface CommunityDAO {
	
	int addBorad(Board board);
	Board getBoard(int boardNo);
	int updateBoard(Board board);
	int deleteBoard(int boardNo);
	List getBoardList(Map map);
	
	int addComment(Comment comment);
	List<Comment> getCommentList(int boardNo);
}
