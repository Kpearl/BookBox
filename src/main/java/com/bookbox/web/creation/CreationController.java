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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Funding;
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
	
	@Autowired
	@Qualifier("fundingServiceImpl")
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
	@RequestMapping(value="addWriting", method=RequestMethod.POST)
	public String addWriting(@ModelAttribute("writing")Writing writing,
													HttpServletRequest request,
													HttpSession session, Model model) throws Exception{
		// TODO addWriting
		System.out.println("Creation Controller :: /creation/addWriting : POST");
			
		User user =(User)session.getAttribute("user");
		
		List<UploadFile> uplodFileList =new ArrayList<>();
		String[] writingFileNames = request.getParameterValues("writingFileName");
		String[] writingOriginNames = request.getParameterValues("writingOriginName");
		
		for (int i = 0; i < writingOriginNames.length; i++) {
				uplodFileList.add(new UploadFile(writingFileNames[i],writingOriginNames[i]));
		} 
		
		writing.setWritingFileList(uplodFileList);		

		writingService.addWriting(user, writing);
		System.out.println("addWriting :: writing :: "+writing);
		
		model.addAttribute("writing",writing);
	
		return "redirect:/creation/getWritingList?creationNo="+writing.getCreationNo();
	}
	
	/**
	 * @brief uploadWritingCKEditor
	 * @details CKEditer 업로드이미지 저장
	 * @param HttpSevletRequest, MultipartFile
	 * @throws Exception
	 * @return "forward:getListWriting"
	 */
	@RequestMapping(value="uploadCKEditorFile", method = RequestMethod.POST)
	public String uploadWritingCKEditor(HttpServletRequest request,
																			@RequestParam("upload")MultipartFile file,
																			Model model) throws Exception{
		System.out.println("Creation Controller :: /creation/uploadCKEditorFile ===> SRART");
		//String CKEditor=request.getParameter("CKEditor");
		int CKEditorFuncNum=Integer.parseInt(request.getParameter("CKEditorFuncNum"));
		System.out.println("Creation Controller :: uploadCKEditorFile 확인 :: "+CKEditorFuncNum);
		
		String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
		
		UploadFile uploadFile = creationService.saveFile(file, path);
				
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		model.addAttribute("url", "../resources/upload_files/images/"+uploadFile.getFileName());
		model.addAttribute("fileName",uploadFile.getFileName());
		model.addAttribute("originName",uploadFile.getOriginName());
		
		System.out.println("Creation Controller :: /creation/uploadCKEditorFile ===> END\n");
				
		return "forward:uploadWritingCKEditor.jsp";
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
																HttpSession session,
																Model model) throws Exception{
	
		System.out.println("UserController :: /creation/updateCreation : GET");
		//Business Logic
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(), (User)session.getAttribute("user"));
		creation = creationService.getCreation(map);
				
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

		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, writing.getCreationNo(), (User)session.getAttribute("user"));
		Creation creation = new Creation();
		creation.setCreationNo(writing.getCreationNo());
		
		writing = writingService.getWriting((User)session.getAttribute("user"), writing);
		creation = creationService.getCreation(map);
		
		model.addAttribute("writing", writing);
		model.addAttribute("creation", creation);
		
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
	public String updateCreation(@ModelAttribute("creation") Creation creation, 
																HttpServletRequest request,
																@RequestParam("file")MultipartFile multipartFile,
																HttpSession session) throws Exception{
		// TODO updateCreation
		System.out.println("CreationController :: /creation/updateCreation : POST ===> START");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
		System.out.println("updateCreation :: "+creation+"\n");
		
		String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
		
		UploadFile uploadFile = creationService.saveFile(multipartFile, path);
		creation.setCreationFileName(uploadFile.getFileName());
		creation.setCreationOriginName(uploadFile.getOriginName());
		
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag = request.getParameterValues("tag");
		
		for (String tag : dbTag) {
			if (!tag.equals("")) {
				tagList.add(new Tag(tag));
			}
		}	
		
		creation.setTagList(tagList);
		creation.setCreationAuthor(user);
		
		creationService.updateCreation(user, creation);
		
		System.out.println("CreationController :: /creation/updateCreation : POST ===> END");
		
		return "redirect:getWritingList?creationNo="+creation.getCreationNo();
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
															HttpServletRequest request,
														HttpSession session, Model model) throws Exception{
		// TODO updateWriting
		System.out.println("CreationController :: /creation/updateWriting : POST ===> START\n");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
		
		List<UploadFile> uplodFileList =new ArrayList<>();
		String[] writingFileNames = request.getParameterValues("writingFileName");
		String[] writingOriginNames = request.getParameterValues("writingOriginName");
		
		for (int i = 0; i < writingOriginNames.length; i++) {
				uplodFileList.add(new UploadFile(writingFileNames[i],writingOriginNames[i]));
		} 
		writing.setWritingFileList(uplodFileList);		
		
		writingService.updateWriting(user, writing);

		System.out.println("CreationController :: /creation/updateWriting : POST ===> END\n\n");
		
		return  "redirect:getWritingList?creationNo="+writing.getCreationNo();
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
		System.out.println("CreationController :: /creation/getWriting : GET ===> START\n");

		//Business Logic
		Creation creation = new Creation();
	
		writing = writingService.getWriting((User)session.getAttribute("user"), writing);
		System.out.println("CreationController :: getWriting :: "+writing+"\n");
		
		creation.setCreationNo(writing.getCreationNo());
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(),(User)session.getAttribute("user"));
		creation = creationService.getCreation(map);
		
		// Model 과 View 연결
		model.addAttribute("writing", writing);
		model.addAttribute("creation", creation);
		
		System.out.println("CreationController :: /creation/getWriting : GET ===> END\n\n");
		
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
															@ModelAttribute("page") Page page, 
															HttpSession session, Model model) throws Exception {
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
		
		System.out.println("getCreationList :: getSearch :: "+search+"\n");
		System.out.println("getCreationList :: getPage :: "+page+"\n");
		System.out.println("getCreationList :: getCreation :: "+creation+"\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(),(User)session.getAttribute("user"));
		map.put("search", search);
		map.put("page", page);
		map.put("creation", creation);
		
		creation = creationService.getCreation(map);
		System.out.println("creation :: "+creation);
				
		List<Writing> writingList = writingService.getWritingList(map);
//		System.out.println("getWritingList"+writingList+"\n");
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
		System.out.println("CreationController :: /creation/deleteCreation : GET ===> START\n");
		
		User user = (User)session.getAttribute("user");
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(),user);
		creation = creationService.getCreation(map);
		
		map.put("creation", creation);
		writingService.getWritingList(map);
		
		creation.setWritingList(writingService.getWritingList(map));
		creationService.deleteCreation(creation);
		
		System.out.println("CreationController :: /creation/deleteCreation : GET ===> END\n\n");
		
		return "redirect:getCreationList?email="+user.getEmail();
	}

	/**
	 * @brief deleteWriting/창작글 삭제
	 * @details GET
	 * @param Writing writing 
	 * @throws Exception
	 * @return "forward:getWritingList?creationNo=creation.getCreationNo()"
	 */
	@RequestMapping( value="deleteWriting", method=RequestMethod.GET )
	public String deleteWriting(@ModelAttribute("writing") Writing writing,
															HttpSession session) throws Exception {
		// TODO deleteWriting
		System.out.println("CreationController :: /creation/deleteWriting : GET");
		
//		User user = (User)session.getAttribute("user");
			
		writingService.deleteWriting(writing);
		
		return "redirect:getWritingList?creationNo="+writing.getCreationNo();
	}	
	
	/**
	 * @brief addFunding/ 펀딩등록화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "forward:addFundingView.jsp"
	 */
	@RequestMapping(value="addFunding", method=RequestMethod.GET)
	public String addFunding(@ModelAttribute Creation creation,
														HttpSession session, Model model) throws Exception{
		// TODO addFunding
		System.out.println("Creation Controller :: /creation/addFunding : GET ===> START");
		
		//Business Logic
		User user = (User)session.getAttribute("user");
		
		System.out.println("addWriting :: "+user.getEmail());
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", session.getAttribute("user"));
		List<Creation> creationList =creationService.getCreationList(map);
		
		model.addAttribute("creationList", creationList);
		
		System.out.println("Creation Controller :: /creation/addFunding : GET ===> END");
	
		return "forward:addFundingViewTest.jsp";
	}
	
	/**
	 * @brief addFunding/ 펀딩글 등록
	 * @details POST
	 * @param Funding
	 * @throws Exception
	 * @return "forward:getFunding"
	 */
	@RequestMapping(value="addFunding", method=RequestMethod.POST)
	public String addFunding(@ModelAttribute("Funding") Funding funding,
													HttpServletRequest request, @RequestParam("file")MultipartFile multipartFile,
													HttpSession session, Model model) throws Exception{
		// TODO addWriting
		System.out.println("Creation Controller :: /creation/addWriting : POST");
			
		User user = (User)session.getAttribute("user");
//		System.out.println("addCreation :: "+user.getEmail());
	
		String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
		
		UploadFile uploadFile = creationService.saveFile(multipartFile, path);
		funding.setFundingFileName(uploadFile.getFileName());
		funding.setFundingOriginName(uploadFile.getOriginName());
		
		fundingService.addFunding(user, funding);
	
		return "redirect:/creation/getFunding?fundingNo="+funding.getFundingNo();
	}
	
	/**
	 * @brief getFunding/펀딩글 조회
	 * @details GET
	 * @param Funding
	 * @throws Exception
	 * @return "forward:getFunding.jsp"
	 */
	@RequestMapping( value="getFunding", method=RequestMethod.GET )
	public String getFunding( @ModelAttribute("funding") Funding funding ,
													HttpSession session,
													Model model ) throws Exception {
		// TODO getWriting
		System.out.println("CreationController :: /creation/getFunding : GET ===> START\n");

		//Business Logic
		funding = fundingService.getFunding((User)session.getAttribute("user"), funding);
		Creation creation = funding.getCreation();
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creation.getCreationNo(),(User)session.getAttribute("user"));
		creation = creationService.getCreation(map);
		funding.setCreation(creation);
				
		// Model 과 View 연결
		model.addAttribute("funding", funding);
				
		System.out.println("CreationController :: /creation/getFunding : GET ===> END\n\n");
		
		return "forward:getFundingTest.jsp";
	}		
	
	/**
	 * @brief getFundingList/펀딩글리스트 조회
	 * @details GET
	 * @param Creation
	 * @throws Exception
	 * @return "forward:getFundingList.jsp"
	 */
	@RequestMapping( value="getFundingList", method=RequestMethod.GET )
	public String getFundingList(@ModelAttribute("creation") Creation creation,
															@ModelAttribute("search") Search search,
															@ModelAttribute("page") Page page, Model model) throws Exception {
		// TODO getFundingList
		System.out.println("CreationController :: /creation/getFundingList : GET\n");

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
		System.out.println("getFundingList :: getSearch :: "+search+"n");
		System.out.println("getFundingList :: getPage :: "+page+"\n");
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("page", page);
		map.put("targetNo", creation.getCreationNo());
		
		List<Funding> fundingList = fundingService.getFundingList(map);
		System.out.println("getFundingList :: "+fundingList+"/n");

		// Model 과 View 연결
		model.addAttribute("fundingList", fundingList);
		
		System.out.println("CreationController :: /creation/getFundingList : GET ===> END\n\n");
		return "forward:listFundingTest.jsp";
	}	
	

}
