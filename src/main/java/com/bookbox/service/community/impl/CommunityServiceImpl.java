package com.bookbox.service.community.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;
import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	@Qualifier("communityDAOImpl")
	CommunityDAO communityDAOImple;

	@Autowired
	@Qualifier("tagDAOImpl")
	TagDAO tagDAOImpl;

	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	public CommunityServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public int addBoard(User user, Board board) throws Exception {

		int result = communityDAOImple.addBorad(board);

		if (board.getTagList() != null) {
			for (Tag tag : board.getTagList()) {
				tagDAOImpl.addTag(tag);
			}
			tagDAOImpl.addTagGroup(6, board.getBoardNo(), board.getTagList());
		}
		unifiedsearchDAO.elasticInsert(board);
		return result;
	}

	@Override
	public Board getBoard(User user, Board board) {

		board = communityDAOImple.getBoard(board.getBoardNo());

		// List tagList=tagDAOImpl.getTagGroupList(Const.Category.BOARD,
		// board.getBoardNo());
		// board.setTagList(tagList);
		return board;
	}

	@Override
	public int deleteBoard(int boardNo) throws Exception {
		Board board = new Board();
		board.setBoardNo(boardNo);
		
		unifiedsearchDAO.elasticDelete(board);
		return 0;
	}

	@Override
	public int updateBoard(Board board) throws Exception {
		
		int result = communityDAOImple.updateBoard(board);

		tagDAOImpl.deleteTagGroup(6, board.getBoardNo());
		if (board.getTagList() != null) {
			for (Tag tag : board.getTagList()) {
				tagDAOImpl.addTag(tag);
			}
			tagDAOImpl.addTagGroup(6, board.getBoardNo(), board.getTagList());
		}
		
		unifiedsearchDAO.elasticUpdate(board);
		return result;
	}

	@Override
	public List<Board> getBoardList(Map map) {
		// System.out.println("[communityServiceImpl.getBoardList() start...]");
		((Page)map.get("page")).setTotalCount(communityDAOImple.getBoardTotal(map));
		return communityDAOImple.getBoardList(map);

	}

	@Override
	public List<Board> getBoardListUserTagMapper(Map map) {
		// TODO Auto-generated method stub
		return communityDAOImple.getBoardListUserTagMapper(map);
	}

	@Override
	public int addRecommend(Recommend recommed) {
		// 게시글 추천일때
		if (recommed.getCategory().equals("board")) {
			recommed.setCategoryNo(Const.Category.BOARD);

			if (recommed.getPref().equals("up")) {

				Board board = communityDAOImple.getBoard(recommed.getTargetNo());
				board.setRecommend(board.getRecommend() + 1);
				communityDAOImple.updateBoard(board);
			}

			else {

			}
			return communityDAOImple.getBoard(recommed.getTargetNo()).getRecommend();
		}
		// 댓글 추천일때
		else if (recommed.getCategory().equals("comment")) {
			// recommed.setCategoryNo(Const.Category.);

			if (recommed.getPref().equals("up")) {

			} else {

			}
		}

		return communityDAOImple.addRecommend(recommed);
	}

	@Override
	public int addReport(Report report) {

		if (report.getCategory().equals("board")) {
			report.setCategoryNo(Const.Category.BOARD);

			Board board = communityDAOImple.getBoard(report.getTargetNo());
			board.setReport(board.getReport() + 1);
			communityDAOImple.updateBoard(board);

		} else if (report.getCategory().equals("comment")) {
			report.setCategoryNo(Const.AddBehavior.COMMENT);

			Comment comment = communityDAOImple.getComment(report.getTargetNo());
			comment.setReportCount(comment.getReportCount() + 1);
			communityDAOImple.updateCommnet(comment);
		}

		return communityDAOImple.addReport(report);
	}

	@Override
	public int addComment(Comment comment) {

		return communityDAOImple.addComment(comment);
	}

	@Override
	public List getCommentList(int boardNo) {

		List<Comment> commentList = communityDAOImple.getCommentList(boardNo);

		if (commentList == null) {
			return null;
		}
		int maxLevel = communityDAOImple.getCommentMaxLevel(boardNo) + 1;

		List<Comment>[] commentArray = new List[maxLevel];
		for (int i = 0; i < maxLevel; i++) {
			commentArray[i] = new ArrayList();
		}

		// 댓글 레벨별 정리
		int level = 0;
		for (Comment comment : commentList) {
			// 블라인드 체크
			if (comment.getReportCount() > 50) {
				comment.setBlind(true);
			}

			level = comment.getLevel();
			commentArray[level].add(comment);
		}

		for (int i = 1; i < maxLevel; i++) {
			for (int j = 0; j < commentArray[i].size(); j++) {
				Comment childComment = commentArray[i].get(j);
				int seniorNo = childComment.getSeniorCommentNo();
				for (int k = 0; k < commentArray[i - 1].size(); k++) {
					Comment seniorComment = commentArray[i - 1].get(k);
					if (seniorComment.getCommentNo() == seniorNo) {
						if (seniorComment.getComment() == null) {
							seniorComment.setComment(new ArrayList());
						}
						seniorComment.getComment().add(childComment);
					}
				}

			}

		}

		return commentArray[0];
		// return communityDAOImple.getCommentList(boardNo);
	}

}
