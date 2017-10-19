package com.bookbox.service.unifiedsearch;

import com.bookbox.common.domain.Search;

public interface UnifiedsearchDAO {

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
	 * @file com.bookbox.service.unifiedsearch.getUnifiedsearchList.java
	 * @brief getUnifiedsearchList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getUnifiedsearchList(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getPosting.java
	 * @brief getPosting
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getPosting(Search search);
}
