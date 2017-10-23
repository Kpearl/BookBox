package com.bookbox.web.booklog;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Search;
import com.bookbox.common.service.LogService;
import com.bookbox.common.service.TagService;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.web.booklog.BooklogController.java
 * @author JW
 * @date 2017.10.20
 * @brief BooklogController
 */
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
	@RequestMapping( value="getBooklogMain", method=RequestMethod.GET )
	public String getBooklogMain(@ModelAttribute("search")Search search, Model model) {
		
		model.addAttribute("booklogList", booklogService.getBooklogList(search));
		model.addAttribute("postingList", postingService.getPostingList(search));
		model.addAttribute("search", search);
		
		return "forward:../booklog/mainBooklog.jsp";
	}
	
	@RequestMapping( value="getBooklogList" )
	public String getBooklogList(@ModelAttribute("search")Search search, Model model) {

		model.addAttribute("booklogList", booklogService.getBooklogList(search));
		model.addAttribute("search", search);
		
		return "forward:../booklog/listBooklog.jsp";
	}
	
	@RequestMapping( value="getBooklog", method=RequestMethod.GET )
	public String getBooklog(@ModelAttribute("booklog")Booklog booklog, 
								@ModelAttribute("search")Search search, Model model, HttpSession session) {
		User user = this.getUser(session);
		
		model.addAttribute("booklog", booklogService.getBooklog(user, booklog));
		model.addAttribute("search", search);
		return "forward:../booklog/getBooklog.jsp";
	}
	
	
	public String getBookLikeList() {
		return null;
	}
	
	@RequestMapping( value="addPosting", method=RequestMethod.GET )
	public String addPosting() {
		
		return "redirect:../booklog/addPostingView.jsp";
		
	}
	
	@RequestMapping( value="getPosting", method=RequestMethod.GET )
	public String getPosting(@ModelAttribute("posting")Posting posting, 
							@ModelAttribute("search")Search search,
							Model model, HttpSession session) {
		User user = this.getUser(session);
		model.addAttribute("posting", postingService.getPosting(user, posting));
		model.addAttribute("search", search);	
		return "forward:../booklog/getPosting.jsp";
	}

	@RequestMapping( value="getPostingList" )
	public String getPostingList(@ModelAttribute("search")Search search, Model model) {
		model.addAttribute("postingList", postingService.getPostingList(search));
		model.addAttribute("search", search);
		
		return "forward:../booklog/listPosting.jsp";
	}
	
	@RequestMapping( value="updatePosting", method=RequestMethod.GET )
	public String updatePosting(@ModelAttribute("posting")Posting posting, Model model) {
		model.addAttribute("posting", postingService.getPosting(new User(), posting));
		
		return "forward:../booklog/updatePostingView.jsp";
	}
	
	@RequestMapping( value="updatePosting", method=RequestMethod.POST )
	public String updatePosting(@ModelAttribute("posting")Posting posting, HttpSession session) {
		User user = (User)session.getAttribute("user");
		postingService.updatePosting(user, posting);
		
		return "redirect:../booklog/getPostingList?condition=booklog&keyword="+user.getEmail();
	}
	
	@RequestMapping( value="updateBooklog", method=RequestMethod.GET )
	public String updateBooklog(@ModelAttribute("booklog")Booklog booklog, Model model) {
		model.addAttribute("booklog", booklogService.getBooklog(new User(), booklog));
		
		return "forward:../booklog/updateBooklogView.jsp";
	}
	
	@RequestMapping( value="updateBooklog", method=RequestMethod.POST )
	public String updateBooklog(@ModelAttribute("booklog")Booklog booklog, HttpSession session,
									@RequestParam("file")MultipartFile file) {
		if(!file.isEmpty()) {
			booklog.setBooklogImage(file.getOriginalFilename());
		}
		booklogService.updateBooklog((User)session.getAttribute("user"), booklog);
		
		return "redirect:../booklog/getBooklog?booklogNo="+booklog.getBooklogNo();
	}
	
	public String getLogList() {
		return null;
	}
	
	public String getSubscribeList() {
		return null;
	}
	
	
	
	
	/**
	 * @brief session에 user가 있는지 없는지 확인
	 * @param session
	 * @return 있으면 session user, 없으면 빈 user를 return
	 */
	public User getUser(HttpSession session) {
		User user = new User();
		if( (User)session.getAttribute("user") != null ) {
			user = (User)session.getAttribute("user");
		}
		return user;
	}
	
}
