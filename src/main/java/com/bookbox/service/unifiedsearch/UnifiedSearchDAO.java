package com.bookbox.service.unifiedsearch;

import com.bookbox.common.domain.Search;

public interface UnifiedSearchDAO {

	/**
	 * @file com.bookbox.service.unifiedsearch.getCommunity.java
	 * @brief getCommunity
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getCommunity(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getCreation.java
	 * @brief getCreation
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getCreation(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getUnifiedSearchList.java
	 * @brief getUnifiedSearchList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getUnifiedSearchList(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getPosting.java
	 * @brief getPosting
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getPosting(Search search);
}
