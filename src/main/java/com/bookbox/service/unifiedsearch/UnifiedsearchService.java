package com.bookbox.service.unifiedsearch;

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
	public String elasticSearch(Search search) throws Exception;
}
