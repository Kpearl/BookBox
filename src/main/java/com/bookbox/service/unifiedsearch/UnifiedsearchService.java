package com.bookbox.service.unifiedsearch;

import com.bookbox.common.domain.Search;

public interface UnifiedsearchService {

	/**
	 * @file com.bookbox.service.unifiedsearch.getCommunityList.java
	 * @brief getCommunityList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getCommunityList(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getCreationList.java
	 * @brief getCreationList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getCreationList(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getUnifiedsearchList.java
	 * @brief getUnifiedsearchList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getUnifiedsearchList(Search search);

	/**
	 * @file com.bookbox.service.unifiedsearch.getPostingList.java
	 * @brief getPostingList
	 * @detail
	 * @author JJ
	 * @date 2017.10.16
	 */
	public void getPostingList(Search search);
}
