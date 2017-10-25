package com.bookbox.web.creation;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagService;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;


/**
 * @file com.bookbox.web.creation.CreationRestController.java
 * @brief 창작공간 RestController
 * @detail
 * @author HJ
 * @date 2017.10.24
 */
@RestController
@RequestMapping("/creation/rest/*")
public class CreationRestController {

	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	/**
	 * @brief Constructor
	 */
	public CreationRestController() {
		System.out.println("CreationRestController :: "+getClass().getName());
	}
	
	
	/**
	 * @brief addCreationSubscribe/구독신청                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="addCreationSubscribe", method=RequestMethod.POST )
	public void addCreationSubscribe(@RequestBody Creation creation,
																		HttpSession session) throws Exception {
		
		creationService.addCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief deleteCreationSubscribe/구독신청 취소                          
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="deleteCreationSubscribe", method=RequestMethod.POST )
	public void deleteCreationSubscribe(@RequestBody Creation creation,
																		HttpSession session) throws Exception {
		
		creationService.deleteCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief getTag/태그자동완성                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="getTagList", method=RequestMethod.POST )
	public List<Tag> getTag(@RequestBody Tag tag,
																		HttpSession session) throws Exception {
		
		tagService.getTagList(tag);
		
		return null;
	}
	
	
	
	
}
