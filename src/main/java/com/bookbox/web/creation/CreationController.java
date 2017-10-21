package com.bookbox.web.creation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Tag;
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
	
//	@Autowired
//	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;

	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	

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
	public String addWriting() throws Exception{
		
		System.out.println("Creation Controller :: /creation/addWriting : GET");
		
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
													@ModelAttribute("creation")Creation creation,
													@ModelAttribute("tag")Tag tag,
													HttpSession session) throws Exception{
		// TODO addWriting
		System.out.println("Creation Controller :: /creation/addWriting : POST");
		
		User user =(User)session.getAttribute("user");
		
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag =  tag.getTagName().split("#");
		
		for (int i = 0; i < dbTag.length; i++) {
			tagList.add(new Tag(dbTag[i]));
		}	
		creation.setTagList(tagList);
		creationService.addCreation(user, creation);
		writingService.addWriting(user, writing);
	
		return "forward:/creation/getWritingList.jsp";
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
														HttpSession session, Model model) throws Exception{
	
		System.out.println("UserController :: /creation/updateCreation : GET");
		//Business Logic
		
		User user =(User)session.getAttribute("user");
		creationService.updateCreation(user, creation);
		
		model.addAttribute("user", user);
		model.addAttribute("creation", creation);
		
		return "forward:updateUserView_Test.jsp";
	}
	
	/**
	 * @brief updateWriting/작품수정화면으로 이동
	 * @details GET 
	 * @param Writing writing
	 * @throws Exception
	 * @return "forward:updateWritingView.jsp"
	 */
	@RequestMapping( value="updateWriting", method=RequestMethod.GET )
	public String updateWritng(@ModelAttribute("writing") Writing writing,
														HttpSession session, Model model) throws Exception{
	
		System.out.println("UserController :: /creation/updateCreation : GET");
		//Business Logic
		
		User user =(User)session.getAttribute("user");
//		WritingService.updateWriting(user, writing);
		
		model.addAttribute("user", user);
		model.addAttribute("creation", writing);
		
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
	 * @param Writing writing
	 * @throws Exception
	 * @return ""
	 */
	@RequestMapping( value="updateWriting", method=RequestMethod.POST )
	public String updateWriting(@ModelAttribute("writing") Writing writing, HttpSession session) throws Exception{
		// TODO updateWriting
		System.out.println("CreationController :: /creation/updateWriting : POST");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
//		writingService.updateWriting(user, writing);
		
		return "";
	}
	
	/**
	 * @brief getWriting/창작글 조회
	 * @details GET
	 * @param Writing, writing
	 * @throws Exception
	 * @return "forward:getUser.jsp"
	 */
	@RequestMapping( value="getWriting", method=RequestMethod.GET )
	public String getUser( @ModelAttribute("Writing") Writing writing , Model model ) throws Exception {
		// TODO getWriting
		System.out.println("CreationController :: /creation/getWriting : GET");
		//Business Logic
		
		// Model 과 View 연결
		
		
		return "forward:getwriting.jsp";
	}	

	
	/**
	 * @brief deleteCreation/작품삭제
	 * @details GET
	 * @param Creation creation 
	 * @throws Exception
	 * @return "forward:getCreationList?creationAuthor=creationAuthor"
	 */
	@RequestMapping( value="deleteCreation", method=RequestMethod.GET )
	public String deleteCreation(@ModelAttribute("creation") Creation creation,
																HttpSession session) throws Exception {
		// TODO deleteCreation
		System.out.println("CreationController :: /creation/deleteCreation : GET");
		
		User user = (User)session.getAttribute("user");
		creation.setCreationAuthor(user.getNickname());
		
		creationService.updateCreation(user, creation);
		
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
	public String deleteWriting(@ModelAttribute("creation") Creation creation, @ModelAttribute("writing") Writing writing,
																HttpSession session) throws Exception {
		// TODO deleteWriting
		System.out.println("CreationController :: /creation/deleteWriting : GET");
		
//		writingService.updateWriting(User, writing);
		
		User user = (User)session.getAttribute("user");
		creation.setCreationAuthor(user.getNickname());
		
		creationService.updateCreation(user, creation);
		
		return "forward:getCreationList?creationAuthor="+user.getNickname();
	}	
	

}
