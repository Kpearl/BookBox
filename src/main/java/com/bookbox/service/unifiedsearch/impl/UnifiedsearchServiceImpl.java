package com.bookbox.service.unifiedsearch.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Unifiedsearch;
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
	public Map<String, Object> elasticSearch(Search search) throws Exception {
		return convertToMap(unifiedsearchDAO.elasticSearch(search));
	}

	public Map<String, Object> convertToMap(JSONObject jsonObject) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Unifiedsearch unifiedsearch = null;

		JSONObject object = (JSONObject)jsonObject.get("hits");		
		JSONArray jsonArray = (JSONArray)object.get("hits");

		map.put("total", object.get("total"));
		
		for(int i = 0; i < jsonArray.size(); i++) {
			JSONObject jo = (JSONObject)jsonArray.get(i);
			JSONObject lastJo = (JSONObject)jo.get("_source");
			unifiedsearch = new Unifiedsearch();
			
			unifiedsearch.setContent(lastJo.get("content").equals(null) ? "" : lastJo.get("content").toString());
			unifiedsearch.setTitle(lastJo.get("title").equals(null) ? "" : lastJo.get("title").toString());
			unifiedsearch.setNick_name(lastJo.get("nick_name").equals(null) ? "" : lastJo.get("nick_name").toString());
			unifiedsearch.setId(jo.get("_id").equals(null) ? "" : jo.get("_id").toString());
			unifiedsearch.setCategory(jo.get("_type").toString());
			//unifiedsearch.setReg_date(lastJo.get("reg_date").equals("null") ? "" : lastJo.get("reg_date").toString());
			unifiedsearch.setTag((List<String>)lastJo.get("tag"));
			
			map.put(i+"", unifiedsearch);
		}
		
		return map;
	}
}
