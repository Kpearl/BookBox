package com.bookbox.web.booklog;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagService;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@RestController
@RequestMapping("booklog/rest/*")
public class BooklogRestController {
	
	@Autowired
	@Qualifier("booklogServiceImpl")
	private BooklogService booklogService;
	
	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource fsr;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
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
	
	
}
