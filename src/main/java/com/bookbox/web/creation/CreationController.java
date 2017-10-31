package com.bookbox.web.creation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.TagService;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.web.creation.CreationCrontroller.java
 * @brief 창작작품 Controller
 * @detail
 * @author HJ
 * @date 2017.10.13
 */
@Controller
@RequestMapping("/creation/*")
public class CreationController {

	/**
	 * @brief  field
	 * @detail 창작작품, 창작글, 펀딩, 태그
	 */
	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;
	
	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
//	@Autowired
//	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;
	
	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	

	/**
	 * @brief  Constructor
	 */	
	public CreationController() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	/**
	 * @brief getCreationMain/ 창작글 메인화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redict"
	 */
	@RequestMapping(value="getCreationMain", method=RequestMethod.GET)
	public String getCreationMain() throws Exception{
		
		System.out.println("Creation Controller :: /creation/getCreationMain : GET");
		
		return "redirect:mainCreation.jsp";
	}
	
	/**
	 * @brief addWriting/ 창작글 등록화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "forward:addWritingView.jsp"
	 */
	@RequestMapping(value="addWriting", method=RequestMethod.GET)
	public String addWriting(HttpSession session, Model model) throws Exception{
		
		System.out.println("Creation Controller :: /creation/addWriting : GET");
		
		User user = (User)session.getAttribute("user");
		
		System.out.println("addWriting :: "+user.getEmail());
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", session.getAttribute("user"));
		List<Creation> creationList =creationService.getCreationList(map);
		
		model.addAttribute("creationList", creationList);
		
		
		return "forward:addWritingView.jsp";
	}
	
	
	/**
	 * @brief addWriting/ 창작글 등록
	 * @details POST
	 * @param Creation,Writing
	 * @throws Exception
	 * @return "forward:getListWriting"
	 */
	public String addWriting(@ModelAttribute("writing")Writing writing, 
													@ModelAttribute("tag")Tag tag,
													@ModelAttribute("uploadFile") UploadFile uploadFile,
													MultipartHttpServletRequest request,
													HttpSession session) throws Exception{
		// TODO addWriting
		System.out.println("Creation Controller :: /creation/addWriting : POST");
			
		User user =(User)session.getAttribute("user");
				
		List<MultipartFile> uploadFileName = request.getFiles("writingFile");
		List<UploadFile> writingFileList = new ArrayList<>();
	
		for (MultipartFile multipartFile : uploadFileName ) {

			writingFileList.add(creationService.saveFile(multipartFile,uploadDirResource));
		}
		
		writing.setWritingFileList(writingFileList);		

		writingService.addWriting(user, writing);
	
		return "forward:/creation/getWritingList?creationNo"+writing.getCreationNo();
	}
	
	
	/**
	 * @brief updateCreation/작품수정화면으로 이동
	 * @details GET 
	 * @param Creation creation
	 * @throws Exception
	 * @return "forward:updateUserView.jsp"
	 */
	@RequestMapping( value="updateCreation", method=RequestMethod.GET )
	public String updateCreation(@ModelAttribute("creation") Creation creation,
																Model model) throws Exception{
	
		System.out.println("UserController :: /creation/updateCreation : GET");
		//Business Logic
		
		creation = creationService.getCreation(creation);
				
		model.addAttribute("creation", creation);
		
		return "forward:updateCreationView.jsp";
	}
	
	/**
	 * @brief updateWriting/작품수정화면으로 이동
	 * @details GET 
	 * @param Writing 
	 * @throws Exception
	 * @return "forward:updateWritingView.jsp"
	 */
	@RequestMapping( value="updateWriting", method=RequestMethod.GET )
	public String updateWritng(@ModelAttribute("writing") Writing writing,
														HttpSession session, Model model) throws Exception{
	
		System.out.println("UserController :: /creation/updateCreation : GET");
		//Business Logic
		
		User user =(User)session.getAttribute("user");
		writingService.getWriting(user, writing);
		
		model.addAttribute("writing", writing);
		
		return "forward:updateWritingView.jsp";
	}
	
	/**
	 * @brief updateCreation/작품수정
	 * @details POST
	 * @param Creation creation
	 * @throws Exception
	 * @return "redirect:getWritingList?creationNo=creation.getCreaionNo()"
	 */
	@RequestMapping( value="updateCreation", method=RequestMethod.POST )
	public String updateCreation(@ModelAttribute("creation") Creation creation, HttpSession session) throws Exception{
		// TODO updateCreation
		System.out.println("CreationController :: /creation/updateCreation : POST");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
		creationService.updateCreation(user, creation);
		
		return "redirect:getWritingList?creationNo=creation.getCreaionNo()";
	}
	
	/**
	 * @brief updateWriting/ 작품글수정
	 * @details POST
	 * @param Writing 
	 * @throws Exception
	 * @return "forward:getWritingList"
	 */
	@RequestMapping( value="updateWriting", method=RequestMethod.POST )
	public String updateWriting(@ModelAttribute("writing") Writing writing, 
														HttpSession session, Model model) throws Exception{
		// TODO updateWriting
		System.out.println("CreationController :: /creation/updateWriting : POST");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
		writingService.updateWriting(user, writing);
		Creation creation = new Creation();
		creation.setCreationNo(writing.getCreationNo());
		creation = creationService.getCreation(creation);
		
		model.addAttribute("writing", writing);
		model.addAttribute("creation", creation);
		model.addAttribute("seach", new Search());
		model.addAttribute("page", new Page());
		
		return  "forward:getWritingList";
	}
	
	/**
	 * @brief getWriting/창작글 조회
	 * @details GET
	 * @param Writing, writing
	 * @throws Exception
	 * @return "forward:getUser.jsp"
	 */
	@RequestMapping( value="getWriting", method=RequestMethod.GET )
	public String getWriting( @ModelAttribute("writing") Writing writing ,
													HttpSession session,
													Model model ) throws Exception {
		// TODO getWriting
		System.out.println("CreationController :: /creation/getWriting : GET");

		System.out.println("CreationController :: getWriting :: "+writing);
		//Business Logic
		User user=(User)session.getAttribute("user");
		
		Creation creation = new Creation();
		creation.setCreationNo(writing.getCreationNo());
		
		creation = creationService.getCreation(creation);
		writing = writingService.getWriting(user, writing);
		
		// Model 과 View 연결
		model.addAttribute("writing", writing);
		model.addAttribute("creation", creation);
		
		return "forward:getWriting.jsp";
	}	
	
	/**
	 * @brief getCreationList/창작작품리스트 조회
	 * @details GET
	 * @param Creation
	 * @throws Exception
	 * @return "forward:getCreationList.jsp"
	 */
	@RequestMapping( value="getCreationList", method=RequestMethod.GET )
	public String getCreationList(@ModelAttribute("tag") Tag tag, 
															@ModelAttribute("search") Search search, 
															@ModelAttribute("page") Page page, Model model) throws Exception {
		// TODO getCreationList
		System.out.println("CreationController :: /creation/getCreationList : GET");

		//Business Logic
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		if(search.getCondition() ==null) {
			search.setCondition("0");
		}
		if(page.getPageSize() ==0) {
			page.setPageSize(pageSize);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(pageUnit);
		}
		System.out.println("getCreationList :: getSearch :: "+search+"/n");
		System.out.println("getCreationList :: getPage :: "+page+"/n");
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("page", page);
		
		List<Creation> creationList = creationService.getCreationList(map);
		System.out.println("getCreationList :: "+creationList+"/n");

		// Model 과 View 연결
		model.addAttribute("creationList", creationList);
		
		System.out.println("CreationController :: /creation/getCreationList : GET ===> END");
		return "forward:listCreation.jsp";
	}	
	
	/**
	 * @brief getWritingList/창작글 리스트 조회
	 * @details GET
	 * @param Creation
	 * @throws Exception
	 * @return "forward:getWritingList.jsp"
	 */
	@RequestMapping( value="getWritingList", method=RequestMethod.GET )
	public String getWritingList( @ModelAttribute("creation") Creation creation,
															@ModelAttribute("search") Search search, 
															@ModelAttribute("page") Page page, Model model) throws Exception {
		// TODO getWritingList
		System.out.println("CreationController :: /creation/getWritingList : GET  ===>START");

		
		//Business Logic
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		if(search.getCondition() ==null) {
			search.setCondition("0");
		}
		if(page.getPageSize() ==0) {
			page.setPageSize(pageSize);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(pageUnit);
		}
		
		System.out.println("getCreationList :: getSearch :: "+search+"/n");
		System.out.println("getCreationList :: getPage :: "+page+"/n");
		System.out.println("getCreationList :: getCreation :: "+creation+"/n");
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("page", page);
		map.put("creation", creation);
		
		creation = creationService.getCreation(creation);
		System.out.println("creation :: "+creation);
				
		List<Writing> writingList = writingService.getWritingList(map);
		System.out.println("getWritingList"+writingList+"/n");
		creation.setWritingList(writingList);
	
		// Model 과 View 연결
		model.addAttribute("creation", creation);
		
		System.out.println("CreationController :: /creation/getWritingList : GET ===> END");
		return "forward:listWriting.jsp";
	}	

	
	/**
	 * @brief deleteCreation/작품삭제
	 * @details GET
	 * @param Creation 
	 * @throws Exception
	 * @return 
	 */
	@RequestMapping( value="deleteCreation", method=RequestMethod.GET )
	public String deleteCreation(@ModelAttribute("creation") Creation creation,
																HttpSession session) throws Exception {
		// TODO deleteCreation
		System.out.println("CreationController :: /creation/deleteCreation : GET");
		
		User user = (User)session.getAttribute("user");
		creation.setCreationAuthor(user);
		
		creationService.deleteCreation(creation);
		
		return "forward:getCreationList?creationAuthor="+user.getNickname();
	}

	/**
	 * @brief deleteWriting/창작글 삭제
	 * @details GET
	 * @param Writing writing 
	 * @throws Exception
	 * @return "forward:getWritingList?creationNo=creation.getCreationNo()"
	 */
	@RequestMapping( value="deleteWriting", method=RequestMethod.GET )
	public String deleteWriting(@ModelAttribute("creation") Creation creation,
															HttpSession session) throws Exception {
		// TODO deleteWriting
		System.out.println("CreationController :: /creation/deleteWriting : GET");
	
		User user = (User)session.getAttribute("user");
			
		creationService.deleteCreation(creation);
		
		return "forward:getCreationList?creationAuthor="+user.getNickname();
	}	
	

}
