package com.bookbox.service.unifiedsearch.impl;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchServiceImpl.java
 * @brief UnifiedsearchServiceImpl
 * @detail
 * @author JJ
 * @date 2017.11.01
 */

@Service("unifiedsearchServiceImpl")
public class UnifiedsearchServiceImpl implements UnifiedsearchService {

	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	public UnifiedsearchServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void elasticInsert(Object object, Search search) throws Exception {
		unifiedsearchDAO.elasticInsert(compareToCategory(object, search));
	}

	@Override
	public void elasticUpdate(Object object, Search search) throws Exception {
		unifiedsearchDAO.elasticUpdate(compareToCategory(object, search));
	}

	@Override
	public void elasticDelete(Object object, Search search) throws Exception {
		unifiedsearchDAO.elasticDelete(compareToCategory(object, search));
	}

	@Override
	public String elasticSearch(Search search) throws Exception {
		return unifiedsearchDAO.elasticSearch(search);
	}

	public Map<String, Object> compareToCategory(Object object, Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();

		switch (search.getCategory()) {
		case 1:
			Creation creation = (Creation) object;

			obj.put("title", creation.getCreationTitle());
			obj.put("content", creation.getCreationIntro());
			obj.put("tag", creation.getTagList());
			obj.put("nick_name", creation.getCreationAuthor().getNickname());
			obj.put("reg_date", creation.getRegDate());

			map.put("category", "creation");
			map.put("id", creation.getCreationNo());
			map.put("json", obj);
			map.put("keyword", search.getKeyword());
			break;
		case 5:
			Posting posting = (Posting) object;

			obj.put("title", posting.getPostingTitle());
			obj.put("content", posting.getPostingContent());
			obj.put("tag", posting.getPostingTagList());
			obj.put("nick_name", posting.getUser().getNickname());
			obj.put("reg_date", posting.getPostingRegDate());

			map.put("category", "posting");
			map.put("id", posting.getPostingNo());
			map.put("json", obj);
			map.put("keyword", search.getKeyword());
			break;
		case 6:
			Board board = (Board) object;

			obj.put("title", board.getBoardTitle());
			obj.put("content", board.getBoardContent());
			obj.put("tag", board.getTagList());
			obj.put("nick_name", board.getWriter().getNickname());
			obj.put("reg_date", board.getBoardRegDate());

			map.put("category", "board");
			map.put("id", board.getBoardNo());
			map.put("json", obj);
			map.put("keyword", search.getKeyword());
			break;
		case 7:
			ChatRoom chatroom = (ChatRoom) object;

			obj.put("title", chatroom.getTitle());
			obj.put("content", chatroom.getContent());
			obj.put("nick_name", chatroom.getHost().getNickname());
			obj.put("reg_date", chatroom.getRegDate());

			map.put("category", "chatroom");
			map.put("id", chatroom.getRoomNo());
			map.put("json", obj);
			map.put("keyword", search.getKeyword());
			break;
		case 10:
			map.put("keyword", search.getKeyword());
			break;
		}
		return map;
	}
}
