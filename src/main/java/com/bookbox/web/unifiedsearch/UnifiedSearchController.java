package com.bookbox.web.unifiedsearch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.BookService;
import com.bookbox.service.unifiedsearch.UnifiedSearchService;

@Controller
@RequestMapping("unifiedsearch/*")
public class UnifiedSearchController {
	
	//Filed
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;
/*
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;*/
	/*
	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;
	*/
	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedSearchService unifiedsearchService;

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;
	
	//Constructor
	public UnifiedSearchController() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	public void getBookList(Search search) {
	}
	
	public void getBook(Book book) {
	}
	
	public void getCommunityList(Search search) {
	}
	
	public void getunifiedSearchList(Search search) {
	}

	public void getCreationList(Search search) {
	}
	
	public void getPostingList(Search search) {
	}
}
