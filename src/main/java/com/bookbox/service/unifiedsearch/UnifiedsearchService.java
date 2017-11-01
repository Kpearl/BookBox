package com.bookbox.service.unifiedsearch;

import com.bookbox.common.domain.Search;

public interface UnifiedsearchService {
	/**
	 * @file com.bookbox.service.unifiedsearch.elasticInsert.java
	 * @brief elasticInsert
	 * @detail Elastic Server에 정보 입력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public void elasticInsert(Object object, Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticUpdate.java
	 * @brief elasticUpdate
	 * @detail Elastic Server에 정보 수정
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public void elasticUpdate(Object object, Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticDelete.java
	 * @brief elasticDelete
	 * @detail Elastic Server에서 정보 삭제
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public void elasticDelete(Object object, Search search) throws Exception;

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
