package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

public interface CommunityService {

	public int addBoard(Board board);
	public Board getBoard(int boardNo);
	public int deleteBoard(int boardNo);
	public int updateBoard(Board board);
	public List<Board> getBoardList(Map map);
	
	public int addRecommend(Recommend recommed);
	public int addReport(Report report);
}
