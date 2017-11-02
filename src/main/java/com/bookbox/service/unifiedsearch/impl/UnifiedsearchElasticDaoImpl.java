package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchElasticDaoImpl.java
 * @brief UnifiedsearchElasticDaoImpl
 * @detail
 * @author JJ
 * @date 2017.11.01
 */

@Service("unifiedsearchElasticDAOImpl")
public class UnifiedsearchElasticDaoImpl implements UnifiedsearchDAO {
	
	private String url = "http://192.168.0.37:9200/bookbox/";

	public UnifiedsearchElasticDaoImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
	}

	@Override
	public void elasticInsert(Object object) throws Exception {
		 Map<String, Object> map = compareToCategory(object);
		
		String query = url + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "POST");
	}

	@Override
	public void elasticUpdate(Object object) throws Exception {
		Map<String, Object> map = compareToCategory(object);
		
		String query = url + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "PUT");		
	}

	@Override
	public void elasticDelete(Object object) throws Exception {
		Map<String, Object> map = compareToCategory(object);
		
		String query = url + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "DELETE");	
	}

	@Override
	public JSONObject elasticSearch(Search search) throws Exception {
		String query = url + "/_search";
		String json = "{\"query\":{\"multi_match\":{ \"fields\":[\"title\", \"content\"], \"query\":\"" + search.getKeyword() + "\"}}}";
		
		if(!(search.getCategory() == 10)) {
			if(search.getCategory() == 1)
				query = url + "creation/_search";
			if(search.getCategory() == 5)
				query = url + "posting/_search";
			if(search.getCategory() == 6)
				query = url + "board/_search";
			if(search.getCategory() == 7)
				query = url + "chatroom/_search";
			if(search.getCategory() == 11)
				json ="{\"query\":{\"multi_match\":{ \"fields\":[\"tag\"], \"query\":\"" + search.getKeyword() + "\"}}}";
		}
					
		System.out.println("Elastic search :: " + sendToElastic(query, json, "POST").toString());
		
		return sendToElastic(query, json, "POST");
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
			//map.put("id", chatroom.get());
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
	
	public JSONObject sendToElastic(String query, String json, String type) throws Exception {
		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod(type);

		OutputStream os = conn.getOutputStream();
		os.write(json.getBytes("UTF-8"));
		os.close();

		// read the response
		InputStream in = new BufferedInputStream(conn.getInputStream());
		JSONParser jsonParser = new JSONParser();
		//String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = (JSONObject)jsonParser.parse(IOUtils.toString(in, "UTF-8"));
		
		//JSONObject jsonObject7;

		in.close();
		conn.disconnect();
		
		return jsonObject;
	}
}
