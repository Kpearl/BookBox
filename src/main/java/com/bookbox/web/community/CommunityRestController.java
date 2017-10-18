package com.bookbox.web.community;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.web.community.CommunityRestCrontroller.java
 * @brief CommunityRestController
 * @detail 
 * @author HS
 * @date 2017.10.17
 */

@RestController
@RequestMapping("/community/rest/*")
public class CommunityRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	CommunityService communityServiceImpl;
	
	@RequestMapping(value="/addRecommend")
	public void addRecommend(HttpServletRequest request,@ModelAttribute("Recommend")Recommend recommend ) {
		
		//파라미터 확인용
	//	System.out.print("targetNo : "+request.getParameter("targetNo")+" ");
	//	System.out.print("category : "+request.getParameter("category")+" ");
	//	System.out.print("pref : "+request.getParameter("pref")+" ");
		System.out.println(recommend);
		//테스트용 유저
		User user=new User();
		user.setEmail("test@test.com");
		
		recommend.setEmail(user.getEmail());
			
		
		communityServiceImpl.addRecommend(recommend);
		
	}
	
	@RequestMapping(value="/addReport")
	public void addReport(@ModelAttribute("Report")Report report) {
		
		System.out.println(report);
		
	}
	
}
