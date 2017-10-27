package com.bookbox.web.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagService;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Comment;
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
	
	@Autowired
	@Qualifier("tagServiceImpl")
	TagService tagServiceImpl;
	
	
	public CommunityRestController() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	@RequestMapping(value="/addRecommend")
	public void addRecommend(HttpServletRequest request,@ModelAttribute("Recommend")Recommend recommend,HttpSession session ) {
		
		//파라미터 확인용
	//	System.out.print("targetNo : "+request.getParameter("targetNo")+" ");
	//	System.out.print("category : "+request.getParameter("category")+" ");
	//	System.out.print("pref : "+request.getParameter("pref")+" ");
		System.out.println(recommend);
		
		User user=(User)session.getAttribute("user");
		
		//테스트용 유저정보////////////////////////////
		if(user==null) {
			user=new User();
			user.setEmail("test@test.com");
		}
		
		recommend.setEmail(user.getEmail());
			
		
		communityServiceImpl.addRecommend(recommend);
		
	}
	
	/**
	 * @brief 댓글게시판 , 댓글 신고
	 * @param Comment
	 * @return 
	 */
	@RequestMapping(value="/addReport")
	public void addReport(@ModelAttribute("Report")Report report,HttpSession session) {
		
		System.out.println("addReport() Reprot= "+report);
		
		User user=(User)session.getAttribute("user");
		//////////////테스트용 유저정보/////////////////////
		if(user==null) {
			user=new User();
			user.setEmail("test@test.com");
		}
		
		report.setEmail(user.getEmail());
		
		communityServiceImpl.addReport(report);
	}
	
	
	/**
	 * @brief 댓글게시판 댓글 추가
	 * @param Comment
	 * @return 
	 */
	@RequestMapping(value="/addComment")
	public void addComment(@RequestBody Comment comment,HttpSession session) {
		
	
		User user=(User)session.getAttribute("user");
		//테스트용 유저정보//
		if(user==null) {
			user=new User();
			user.setEmail("test@test.com");
		}
		
		
		comment.setWriter(user);
		System.out.println(comment);
		
		communityServiceImpl.addComment(comment);
		
	}
	
	/**
	 * @brief 댓글게시판 댓글 리스트 조회
	 * @param int boardNo
	 * @return List<Comment> 
	 */
	@RequestMapping(value="/getCommentList/{boardNo}")
	public List getCommentList(@PathVariable("boardNo")int boardNo) {
		
		//나중에 주석
		System.out.println("[getCommentList] boardNo= "+boardNo);
		
		List<Comment> commentList;
		commentList=communityServiceImpl.getCommentList(boardNo);
		
		return commentList;
	}
	
	/**
	 * @brief 태그입력시 자동완선을 위한 태그목록 호출
	 * @param String tagName
	 * @return 태그이름 리스트
	 */
	@RequestMapping(value="/getTagNameList")
	public List getTagList(@RequestParam("tagName")String tagName){
		
		Tag tag=new Tag();
		tag.setTagName(tagName);
		List<Tag> tagList=tagServiceImpl.getTagList(tag);
		List<String> tagNameList=new ArrayList<String>();
		for(Tag t: tagList) {
			tagNameList.add(t.getTagName());
		}
		return  tagNameList;
	}
	
	
	
	
	
}
