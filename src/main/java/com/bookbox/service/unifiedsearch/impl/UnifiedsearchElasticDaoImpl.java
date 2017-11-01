package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
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

	public UnifiedsearchElasticDaoImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
	}

	@Override
	public void elasticInsert(Map<String, Object> map) throws Exception {
		String query = "http://localhost:9200/bookbox/" + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "POST");
	}

	@Override
	public void elasticUpdate(Map<String, Object> map) throws Exception {
		String query = "http://localhost:9200/bookbox/" + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "PUT");		
	}

	@Override
	public void elasticDelete(Map<String, Object> map) throws Exception {
		String query = "http://localhost:9200/bookbox/" + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "DELETE");	
	}

	@Override
	public String elasticSearch(Search search) throws Exception {
		String query = "http://localhost:9200/bookbox/_search";
		String json = "{\"query\":{\"multi_match\":{ \"fields\":[\"title\", \"content\"], \"query\":\"" + search.getKeyword() + "\"}}}";
		
		if(!(search.getCategory() == 10)) {
			if(search.getCategory() == 1)
				query = "http://localhost:9200/bookbox/creation/_search";
			if(search.getCategory() == 5)
				query = "http://localhost:9200/bookbox/posting/_search";
			if(search.getCategory() == 6)
				query = "http://localhost:9200/bookbox/board/_search";
			if(search.getCategory() == 7)
				query = "http://localhost:9200/bookbox/chatroom/_search";
			if(search.getCategory() == 11)
				json ="{\"query\":{\"multi_match\":{ \"fields\":[\"tag\"], \"query\":\"" + search.getKeyword() + "\"}}}";
		}
					
		System.out.println("Elastic search :: " + sendToElastic(query, json, "POST").toString());
		
		return sendToElastic(query, json, "POST").toString();
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
		String result = IOUtils.toString(in, "UTF-8");
		JSONObject jsonObject = new JSONObject(result);

		in.close();
		conn.disconnect();
		
		return jsonObject;
	}
}
