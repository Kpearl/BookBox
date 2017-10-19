package com.bookbox.web.unifiedsearch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.service.CommonService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.BookService;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

/**
 * @file com.bookbox.web.unifiedsearch.UnifiredSearchCrontroller.java
 * @brief UnifiredSearchController
 * @detail
 * @author JJ
 * @date 2017.10.18
 */

@Controller
@RequestMapping("/unifiedsearch/*")
public class UnifiedsearchController {

	// Filed
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;

	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedsearchService unifiedsearchService;
	
	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	private Search search;

	// Constructor
	public UnifiedsearchController() {
		System.out.println("Constructor :: " + getClass().getName());
	}
	
	@RequestMapping(value = "getUnifiedsearchList", method = RequestMethod.GET)
	public String getunifiedsearchList(@RequestParam("keyword")String keyword) {
		System.out.println("/unifiedsearch/getUnifiedsearchList : GET");
		
		return "forward:/unifiedsearch/listUnifiedsearch.jsp";
	}
	
	@RequestMapping(value = "getBookList", method = RequestMethod.GET)
	public String getBookList(Model model, @RequestParam("keyword")String keyword) throws Exception {
		
		search = new Search();
		List<Book> bookList;
		search.setKeyword(keyword);
		search.setCategory(Const.Category.BOOK);
		
		System.out.println("/unifiedsearch/getBookList : GET");
		
		bookList = bookService.getBookList(search);
		
		model.addAttribute("bookList", bookList);
		
		return "forward:/unifiedsearch/listBook.jsp";
	}

	@RequestMapping(value = "getCreationList", method = RequestMethod.GET)
	public String getCreationList(Search search) {
		System.out.println("/unifiedsearch/getCreationList : GET");
		
		return "forward:/unifiedsearch/listCreation.jsp";
	}
	
	@RequestMapping(value = "getCommunityList", method = RequestMethod.GET)
	public String getCommunityList(Search search) {
		System.out.println("/unifiedsearch/getCommunityList : GET");
		
		return "forward:/unifiedsearch/listCommunity.jsp";
	}
	
	@RequestMapping(value = "getPostingList", method = RequestMethod.GET)
	public String getPostingList(Search search) {
		System.out.println("/unifiedsearch/getPostingList : GET");
		
		return "forward:/unifiedsearch/listPosting.jsp";
	}

	@RequestMapping(value = "getBook", method = RequestMethod.GET)
	public String getBook(Book book) {
		System.out.println("/unifiedsearch/getBook : GET");

		return "forward:/unifiedsearch/getBook.jsp";
	}
}
