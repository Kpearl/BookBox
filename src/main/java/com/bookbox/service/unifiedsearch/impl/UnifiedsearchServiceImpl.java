package com.bookbox.service.unifiedsearch.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
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
	public void elasticInsert(Object object) throws Exception {
		unifiedsearchDAO.elasticInsert(compareToCategory(object));
	}

	@Override
	public void elasticUpdate(Object object) throws Exception {
		unifiedsearchDAO.elasticUpdate(compareToCategory(object));
	}

	@Override
	public void elasticDelete(Object object) throws Exception {
		unifiedsearchDAO.elasticDelete(compareToCategory(object));
	}

	@Override
	public String elasticSearch(Search search) throws Exception {
		return unifiedsearchDAO.elasticSearch(search);
	}

	public Map<String, Object> compareToCategory(Object object) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();

		switch (object.getClass().getSimpleName()) {
		case "Creation":
			Creation creation = (Creation) object;

			obj.put("title", creation.getCreationTitle());
			obj.put("content", creation.getCreationIntro());
			obj.put("tag", tagParse(creation.getTagList()));
			obj.put("nick_name", creation.getCreationAuthor().getNickname());
			obj.put("reg_date", creation.getRegDate());

			map.put("category", "creation");
			map.put("id", creation.getCreationNo());
			map.put("json", obj);
			break;
		case "Posting":
			Posting posting = (Posting) object;

			obj.put("title", posting.getPostingTitle());
			obj.put("content", posting.getPostingContent());
			obj.put("tag", tagParse(posting.getPostingTagList()));
			obj.put("nick_name", posting.getUser().getNickname());
			obj.put("reg_date", posting.getPostingRegDate());

			map.put("category", "posting");
			map.put("id", posting.getPostingNo());
			map.put("json", obj);
			break;
		case "Board":
			Board board = (Board) object;

			obj.put("title", board.getBoardTitle());
			obj.put("content", board.getBoardContent());
			obj.put("tag", tagParse(board.getTagList()));
			obj.put("nick_name", board.getWriter().getNickname());
			obj.put("reg_date", board.getBoardRegDate());

			map.put("category", "board");
			map.put("id", board.getBoardNo());
			map.put("json", obj);
			break;
		case "ChatRoom":
			ChatRoom chatroom = (ChatRoom) object;

			obj.put("title", chatroom.getTitle());
			obj.put("content", chatroom.getContent());
			obj.put("nick_name", chatroom.getHost().getNickname());
			obj.put("reg_date", chatroom.getRegDate());

			map.put("category", "chatroom");
			map.put("id", chatroom.getRoomNo());
			map.put("json", obj);
			break;
		}
		return map;
	}

	public List<String> tagParse(List<Tag> tagList) {
		List<String> list = new ArrayList<String>();

		if (!tagList.isEmpty()) {			
			for (Tag tag : tagList) {
				list.add(tag.getTagName());
			}
		}
		return list;
	}
}
