package com.bookbox.web.booklog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookbox.common.service.CommonService;
import com.bookbox.common.service.LogService;
import com.bookbox.common.service.TagService;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.booklog.PostingService;

@Controller
@RequestMapping("booklog/*")
public class BooklogController {
	
	/* Field */
	@Autowired
	@Qualifier("booklogServiceImpl")
	private BooklogService booklogService;
	
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService	postingService;
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;
	
//	@Autowired
//	@Qualifier("bookServiceImpl")
//	private BookService bookService;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	/* Constructor */
	public BooklogController() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	/* Method */
	public String getBooklogMain() {
		return null;
	}
	
	public String getBooklogList() {
		return null;
	}
	
	public String getBooklog() {
		return null;
	}
	
	public String getBookLikeList() {
		return null;
	}
	
	public String getBookmarkList() {
		return null;
	}
	
	public String addPosting() {
		return null;
	}
	
	public String getPosting() {
		return null;
	}
	
	public String getPostingList() {
		return null;
	}
	
	public String updatePosting() {
		return null;
	}
	
	public String updateBooklog() {
		return null;
	}
	
	public String getLogList() {
		return null;
	}
	
	public String getSubscribeList() {
		return null;
	}
	
}
