package com.bookbox.service.unifiedsearch;

import java.util.Map;

import com.bookbox.common.domain.Search;

public interface UnifiedsearchDAO {
	/**
	 * @file com.bookbox.service.unifiedsearch.elasticInsert.java
	 * @brief elasticInsert
	 * @detail Elastic Server 에 데이터 입력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public void elasticInsert(Map<String, Object> map) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticUpdate.java
	 * @brief elasticUpdate
	 * @detail Elastic Server 에 데이터 수정
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public void elasticUpdate(Map<String, Object> map) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticDelete.java
	 * @brief elasticDelete
	 * @detail Elastic Server 에 데이터 삭제
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.16
	 */
	public void elasticDelete(Map<String, Object> map) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.elasticSearch.java
	 * @brief elasticSearch
	 * @detail Elastic Server 에 데이터 검색
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.01
	 */
	public String elasticSearch(Search search) throws Exception;
}
