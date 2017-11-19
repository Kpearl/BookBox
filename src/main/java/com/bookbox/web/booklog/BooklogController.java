package com.bookbox.web.booklog;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.LogService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;

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
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;
	
	//한페이지에 보여줄 갯수
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	/* Constructor */
	public BooklogController() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	/* Method */
	@RequestMapping( value="getBooklogMain", method=RequestMethod.GET )
	public String getBooklogMain(@ModelAttribute("search")Search search, Model model) {
		
		Page page = new Page();
		page.setPageSize(pageSize);
		page.setCurrentPage(1);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		Map<String, Object> postingListMap = postingService.getPostingList(map); 
		model.addAttribute("booklogList", booklogService.getBooklogList(map));
		model.addAttribute("postingList", postingListMap.get("postingList"));
		model.addAttribute("search", search);
		
		return "forward:../booklog/mainBooklog.jsp";
	}
	
	@RequestMapping( value="getBooklogList" )
	public String getBooklogList(@ModelAttribute("search")Search search, Model model) {

		Page page = new Page();
		page.setPageSize(pageSize);
		page.setCurrentPage(1);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		model.addAttribute("booklogList", booklogService.getBooklogList(map));
		model.addAttribute("search", search);
		
		return "forward:../booklog/listBooklog.jsp";
	}
	
	@RequestMapping( value="getBooklog", method=RequestMethod.GET )
	public String getBooklog(@ModelAttribute("booklog")Booklog booklog, 
								@ModelAttribute("search")Search search, Model model, HttpSession session) {
		User user = this.getUser(session);
		booklog = booklogService.getBooklog(user, booklog);
		User booklogUser = booklog.getUser();
		booklogUser.setActive(0);
		Page page = new Page();
		page.setCurrentPage(1);
		page.setPageSize(4);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("email", booklogUser.getEmail());
		
		model.addAttribute("booklog", booklog);
		model.addAttribute("search", search);
		model.addAttribute("logList", logService.getLogList(booklogUser));
		model.addAttribute("bookmark", booklogService.getBookmark(user, booklog));
		model.addAttribute("bookLikeList", booklogService.getBookLikeList(map));
		return "forward:../booklog/getBooklog.jsp";
	}
	
	
	@RequestMapping( value="addPosting", method=RequestMethod.GET )
	public String addPosting() {
		
		return "redirect:../booklog/addPostingView.jsp";
		
	}
	
	@RequestMapping( value="addPosting", method=RequestMethod.POST )
	public String addPosting(@ModelAttribute("posting")Posting posting, HttpServletRequest request,
													HttpServletResponse response, HttpSession session,
													@RequestParam(value="mainFile") MultipartFile multipartFile) throws Exception{

		User user = this.getUser(session);
		String[] tagArray = request.getParameterValues("tag");
		List<Tag> tagList = new ArrayList<Tag>();
		
		for(String tag : tagArray) {
			if(!tag.trim().equals("")) {
				tagList.add(new Tag(tag));
			}
		}
		
		List<UploadFile> postingFileList = new ArrayList<UploadFile>();
		for(Cookie cookie : request.getCookies()) {
			if(posting.getPostingContent().contains(cookie.getName())) {
				if(!cookie.getValue().equals(multipartFile.getOriginalFilename())) {
					postingFileList.add(new UploadFile(cookie.getName(), URLDecoder.decode(cookie.getValue(),"UTF-8").split(":")[1]));
				}
			}
			if(URLDecoder.decode(cookie.getValue(),"UTF-8").contains("file:")) {
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}
		
		if(!multipartFile.isEmpty()) {
			String originName = multipartFile.getOriginalFilename();
			String fileName = UUID.randomUUID().toString() + originName.substring(originName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			multipartFile.transferTo(new File(fileURL, fileName));
			
			UploadFile mainFile = new UploadFile(fileName, originName);
			mainFile.setMainFile(1);
			postingFileList.add(mainFile);
		}

		posting.setPostingTagList(tagList);
		posting.setUser(user);
		posting.setPostingFileList(postingFileList);
		postingService.addPosting(user, posting);
		
		return "redirect:../booklog/getPostingList?condition=booklog&keyword="+user.getEmail();
		
	}
	
	@RequestMapping( value="getPosting", method=RequestMethod.GET )
	public String getPosting(@ModelAttribute("posting")Posting posting, 
							@ModelAttribute("search")Search search,
							Model model, HttpSession session) {
		User user = this.getUser(session);
		posting = postingService.getPosting(user, posting);
		UploadFile mainFile = null;
		for(UploadFile uploadFile : posting.getPostingFileList()) {
			if(uploadFile.getMainFile() == 1) {
				mainFile = uploadFile;
				System.out.println(mainFile);
			}
		}

		model.addAttribute("posting", posting);
		model.addAttribute("search", search);
		model.addAttribute("mainFile", mainFile);
		return "forward:../booklog/getPosting.jsp";
	}

	@RequestMapping( value="getPostingList" )
	public String getPostingList(@ModelAttribute("search")Search search, Model model) {
		if(search.getCondition().equals("booklog")) {
			Booklog booklog = new Booklog();
			User booklogUser = new User();
			booklogUser.setEmail(search.getKeyword());
			booklog.setUser(booklogUser);
			model.addAttribute("booklog", booklogService.getBooklog(new User(), booklog));
		}
		
		Page page = new Page();
		page.setPageSize(pageSize);
		page.setCurrentPage(1);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		Map<String, Object> postingListMap = postingService.getPostingList(map); 
		model.addAttribute("postingList", postingListMap.get("postingList"));
		model.addAttribute("totalCount", (Integer)postingListMap.get("totalCount"));
		model.addAttribute("search", search);
		
		return "forward:../booklog/listPosting.jsp";
	}
	
	@RequestMapping( value="updatePosting", method=RequestMethod.GET )
	public String updatePosting(@ModelAttribute("posting")Posting posting, Model model, HttpServletResponse response) throws Exception {
		posting = postingService.getPosting(new User(), posting);
		
		for(UploadFile uploadFile : posting.getPostingFileList()) {
			Cookie cookie = new Cookie(uploadFile.getFileName(), URLEncoder.encode("file:"+uploadFile.getOriginName(), "UTF-8"));
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		
		UploadFile mainFile = null;
		for(UploadFile uploadFile : posting.getPostingFileList()) {
			if(uploadFile.getMainFile() == 1) {
				mainFile = uploadFile;
				System.out.println(mainFile);
			}
		}

		model.addAttribute("posting", posting);
		model.addAttribute("mainFile", mainFile);
		
		return "forward:../booklog/updatePostingView.jsp";
	}
	
	@RequestMapping( value="updatePosting", method=RequestMethod.POST )
	public String updatePosting(@ModelAttribute("posting")Posting posting, HttpServletRequest request,
														HttpServletResponse response, HttpSession session,
														@RequestParam(value="mainFile", required=false) MultipartFile multipartFile,
														@RequestParam("originFileName")String originFileName,
														@RequestParam("fileName")String fileName) throws Exception {
		User user = (User)session.getAttribute("user");
		String[] tagArray = request.getParameterValues("tag");
		List<Tag> tagList = new ArrayList<Tag>();
		
		for(String tag : tagArray) {
			if(!tag.trim().equals("")) {
				tagList.add(new Tag(tag));
			}
		}
		
		List<UploadFile> postingFileList = new ArrayList<UploadFile>();
		for(Cookie cookie : request.getCookies()) {
			if(posting.getPostingContent().contains(cookie.getName())) {
				postingFileList.add(new UploadFile(cookie.getName(), URLDecoder.decode(cookie.getValue(),"UTF-8").split(":")[1]));
			}
			if(URLDecoder.decode(cookie.getValue(),"UTF-8").contains("file:")) {
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}
		
		if(multipartFile != null && !multipartFile.isEmpty()) {
			String newOriginName = multipartFile.getOriginalFilename();
			String newFileName = UUID.randomUUID().toString() + newOriginName.substring(newOriginName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			multipartFile.transferTo(new File(fileURL, newFileName));
			
			UploadFile mainFile = new UploadFile(newFileName, newOriginName);
			mainFile.setMainFile(1);
			postingFileList.add(mainFile);
		}else {
			UploadFile mainFile = new UploadFile(fileName, originFileName);
			mainFile.setMainFile(1);
			postingFileList.add(mainFile);
		}

		posting.setPostingTagList(tagList);
		posting.setUser(user);
		posting.setPostingFileList(postingFileList);
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
									@RequestParam("file")MultipartFile file, HttpServletRequest request) throws Exception {
		if(!file.isEmpty()) {
			booklog.setBooklogImage(file.getOriginalFilename());
			file.transferTo(new File(request.getServletContext().getRealPath("/resources/upload_files/images/"),file.getOriginalFilename()));
		}
		booklogService.updateBooklog((User)session.getAttribute("user"), booklog);
		
		return "redirect:../booklog/getBooklog?booklogNo="+booklog.getBooklogNo();
	}
	
	@RequestMapping( value="getBookLikeList", method=RequestMethod.GET )
	public String getBookLikeList(@ModelAttribute User user, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", user.getEmail());
		map.put("user", session.getAttribute("user"));
		List<Book> bookList = booklogService.getBookLikeList(map);
		
		
		model.addAttribute("bookList", bookList);
		model.addAttribute("total", bookList.size());
		model.addAttribute("keyword", user.getNickname() + "님이 좋아하는 책");
		
		return "forward:../unifiedsearch/listBook.jsp";
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
