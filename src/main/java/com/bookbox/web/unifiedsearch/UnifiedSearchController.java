package com.bookbox.web.unifiedsearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookbox.common.domain.Search;
import com.bookbox.common.service.CommonService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.UnifiedSearchService;

/**
 * @file com.bookbox.web.unifiedsearch.UnifiredSearchCrontroller.java
 * @brief UnifiredSearchController
 * @detail
 * @author JJ
 * @date 2017.10.18
 */

@Controller
@RequestMapping("/unifiedsearch/*")
public class UnifiedSearchController {

	// Filed
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;

	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedSearchService unifiedsearchService;

	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;

	// Constructor
	public UnifiedSearchController() {
		System.out.println("Constructor :: " + getClass().getName());
	}

	@RequestMapping(value = "/getBookList", method = RequestMethod.GET)
	public String getBookList(Search search) {
		System.out.println("/unifiedSearch/getBookList : GET");

		return "forward:/unifiedSearch/listBook.jsp";
	}

	public String getBook(Book book) {
		System.out.println("/unifiedSearch/getBook : GET");

		return "forward:/unifiedSearch/getBook.jsp";
	}

	public String getCommunityList(Search search) {
		System.out.println("/unifiedSearch/getCommunityList : GET");

		return "forward:/unifiedSearch/listCommunity.jsp";
	}

	public String getunifiedSearchList(Search search) {
		System.out.println("/unifiedSearch/getunifiedSearchList : GET");

		return "forward:/unifiedSearch/listUnifiredSearch.jsp";
	}

	public String getCreationList(Search search) {
		System.out.println("/unifiedSearch/getCreationList : GET");

		return "forward:/unifiedSearch/listCreation.jsp";
	}

	public String getPostingList(Search search) {
		System.out.println("/unifiedSearch/getPostingList : GET");

		return "forward:/unifiedSearch/listPosting.jsp";
	}
}
