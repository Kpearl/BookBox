package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

public interface CommunityService {

	public int addBoard(User user,Board board) throws Exception;
	public Board getBoard(User user,Board board);
	public int deleteBoard(int boardNo) throws Exception;
	public int updateBoard(Board board) throws Exception;
	public List<Board> getBoardList(Map map);
	public List<Board> getBoardListUserTagMapper(Map map);
	
	public int addRecommend(User user,Recommend recommend);
	public List getCommentList(int boardNo);
	public int addReport(Report report);
	public int addComment(Comment comment);
}
