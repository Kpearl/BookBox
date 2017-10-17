package com.bookbox.web.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.service.community.CommunityService;

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
	
	@RequestMapping(value="/addRecommend/{boardNo}")
	public void addRecommend(@PathVariable int boardNo) {
		
		
		
	}
	
}
