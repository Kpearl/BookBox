package com.bookbox.web.booklog;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Log;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.LogService;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@RestController
@RequestMapping("booklog/rest/*")
public class BooklogRestController {
	
	@Autowired
	@Qualifier("booklogServiceImpl")
	private BooklogService booklogService;
	
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;
	
	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource fsr;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;

	//한페이지에 보여줄 갯수
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public BooklogRestController() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}

	@RequestMapping( value="uploadFile", method=RequestMethod.POST )
	public void uploadFile(@RequestParam("upload")MultipartFile file, 
							@RequestParam(value="CKEditor", required=false)String CKEditor,
							@RequestParam(value="CKEditorFuncNum", required=false)String CKEditorFuncNum,
							HttpServletRequest request,
							HttpServletResponse response) throws Exception{
		
		if(file != null) {
		
			String originName = file.getOriginalFilename();
			String fileName = UUID.randomUUID().toString() + originName.substring(originName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			String callbackURL = new StringBuilder()
								.append("<script type='text/javascript'>")
								.append("window.parent.CKEDITOR.tools.callFunction(")
								.append(CKEditorFuncNum)
								.append(",")
								.append("'../resources/upload_files/images/"+fileName+"'")
								.append(",")
								.append("'Upload Success!')</script>").toString();
			file.transferTo(new File(fileURL, fileName));
			
			Cookie cookie = new Cookie(fileName, URLEncoder.encode("file:"+originName,"UTF-8"));
			cookie.setPath("/");
			response.addCookie(cookie);
			
			System.out.println(callbackURL);
			
			PrintWriter printWriter = response.getWriter();
			printWriter.println(callbackURL);
			printWriter.flush();
			printWriter.close();
			
		}else {
			System.out.println("hi");
			
		}
		
	}
	
	
	@RequestMapping( value="uploadFileDragAndDrop", method=RequestMethod.POST )
	public String uploadFileDragAndDrop(@RequestParam("upload")MultipartFile file, 
							HttpServletRequest request,
							HttpServletResponse response) throws Exception{

		JSONObject jsonObject = new JSONObject();
		
		if(file != null) {
		
			String originName = file.getOriginalFilename();
			String fileName = UUID.randomUUID().toString() + originName.substring(originName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			file.transferTo(new File(fileURL, fileName));
			
			Cookie cookie = new Cookie(fileName, URLEncoder.encode("file:"+originName,"UTF-8"));
			cookie.setPath("/");
			response.addCookie(cookie);
			
			jsonObject.put("uploaded", 1);
			jsonObject.put("fileName", fileName);
			jsonObject.put("url", "../resources/upload_files/images/"+fileName);
			
		}else {
			System.out.println("hi");
			
		}
		
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}

	@RequestMapping( value="tag", method=RequestMethod.POST )
	public List<String> getTagList(@RequestParam("tagName") String tagName) {
		
		List<Tag> tagList = tagService.getTagList(new Tag(tagName)); 
		List<String> stringTagList = new ArrayList<String>();
		for(Tag tag : tagList) {
			stringTagList.add(tag.getTagName());
		}
		
		return stringTagList;
	}
	
	@RequestMapping( value="addBookmark/{email}/{booklogNo}", method=RequestMethod.GET )
	public boolean addBookmark(@PathVariable("email") String email, @PathVariable("booklogNo") int booklogNo, HttpSession session) {
		User targetUser = new User();
		Booklog booklog = new Booklog();
		targetUser.setEmail(email);
		booklog.setBooklogNo(booklogNo);
		booklog.setUser(targetUser);
		
		User user = (User)session.getAttribute("user");
		
		return booklogService.addBooklogBookmark(user, booklog);
	}
	
	@RequestMapping( value="deleteBookmark/{email}/{booklogNo}", method=RequestMethod.GET )
	public boolean deleteBookmark(@PathVariable("email") String email, @PathVariable("booklogNo") int booklogNo, HttpSession session) {
		User targetUser = new User();
		Booklog booklog = new Booklog();
		targetUser.setEmail(email);
		booklog.setBooklogNo(booklogNo);
		booklog.setUser(targetUser);
		
		User user = (User)session.getAttribute("user");
		
		return booklogService.deleteBooklogBookmark(user, booklog);
	}
	
	@RequestMapping( value="getLogList/{email}/{active}", method=RequestMethod.GET )
	public List<Log> getLogList(@PathVariable("email") String email, @PathVariable("active") int active){
		User booklogUser = new User();
		booklogUser.setEmail(email);
		booklogUser.setActive(active * 10);
		
		return logService.getLogList(booklogUser);
	}
	
	@RequestMapping( value="getCounts/{id}/{domain}/{dot}/{index}", method=RequestMethod.GET )
	public Map<String, String> getCounts(@PathVariable("id") String id, @PathVariable("domain") String domain,
											@PathVariable("dot") String dot, @PathVariable("index") int index,
											HttpSession session){
		String email = id+"@"+domain+"."+dot;
		Map<String, String> map = booklogService.getCounts(email);
		map.put("index", index+"");
		Booklog booklog= new Booklog();
		User booklogUser = new User();
		booklogUser.setEmail(email);
		booklog.setUser(booklogUser);
		User user = (User)session.getAttribute("user");
		map.put("bookmark", booklogService.getBookmark(user, booklog) + "");
		return map;
	}
	
	@RequestMapping( value="getBooklogList/{currentPage}" )
	public Map<String, Object> getBooklogList(@RequestBody Search search, @PathVariable int currentPage) {

		Page page = new Page();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		map.put("booklogList", booklogService.getBooklogList(map));
		
		return map;
	}
	
	@RequestMapping( value="getPostingList/{currentPage}" )
	public Map<String, Object> getPostingList(@RequestBody Search search, @PathVariable int currentPage) {

		Page page = new Page();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		Map<String, Object> postingListMap = postingService.getPostingList(map); 
		map.put("postingList", postingListMap.get("postingList"));
		
		return map;
	}
	
	@RequestMapping( value="updateBooklog", method=RequestMethod.POST )
	public boolean updateBooklog(@RequestParam("booklog") String json, HttpSession session,
									@RequestParam(value = "file", required = false)MultipartFile file, HttpServletRequest request) throws Exception {
		
		Booklog booklog = new ObjectMapper().readValue(json.toString(), Booklog.class);
		if(file != null && !file.isEmpty()) {
			file.transferTo(new File(request.getServletContext().getRealPath("/resources/upload_files/images/"),file.getOriginalFilename()));
			booklog.setBooklogImage(file.getOriginalFilename());
		}
		booklogService.updateBooklog((User)session.getAttribute("user"), booklog);
		
		return true;
	}
}
