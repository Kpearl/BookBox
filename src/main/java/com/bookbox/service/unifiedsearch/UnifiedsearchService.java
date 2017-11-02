package com.bookbox.service.unifiedsearch;

import java.util.Map;

import com.bookbox.common.domain.Search;

public interface UnifiedsearchService {

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticSearch.java
	 * @brief elasticSearch
	 * @detail Elastic Server 정보 검색
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public Map<String, Object> elasticSearch(Search search) throws Exception;
}
