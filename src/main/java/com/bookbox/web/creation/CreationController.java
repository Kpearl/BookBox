package com.bookbox.web.creation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
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
//	@Autowired
//	@Qualifier("creationServiceImpl")
	private CreationService creationService;
	
//	@Autowired
//	@Qualifier("writingServiceImpl")
	private WritingService writingService;
	
//	@Autowired
//	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;

	
	/*@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;*/
	
	
	
	
	/**
	 * @brief  Constructor
	 */	
	public CreationController() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	/**
	  *@brief 메인화면 GET Method
	 * @author HJ
	 * @date 2017.10.13
	 * @return String "redirect:/creation/getCreationMain.jsp"
	 */
	@RequestMapping(value="getCreationMain", method=RequestMethod.GET)
	public String getCreationMain() throws Exception{
		
		System.out.println("/creation/getCreationMain : GET");
		
		return "redirect:/creation/getCreationMain.jsp";
	}
	
	public String addWriting(@ModelAttribute("writing")Writing writing, @ModelAttribute("creation")Creation creation) {
		
		return "forward:/creation/g+etWriting.jsp";
	}
	
	
	
}
