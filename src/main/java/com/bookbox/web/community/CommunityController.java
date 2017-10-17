package com.bookbox.web.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.User;
import com.mysql.fabric.xmlrpc.base.Value;

import sun.print.resources.serviceui;

/**
 * @file com.bookbox.web.community.CommunityCrontroller.java
 * @brief CommunityController
 * @detail 
 * @author HS
 * @date 2017.10.16
 */

@Controller
@RequestMapping("/community/*")
public class CommunityController {

	@Autowired
	@Qualifier("communityServiceImpl")
	CommunityService communityServiceImpl;
	
	public CommunityController() {
		System.out.println("Constructor::"+this.getClass().getName());
	}
	
	
	/**
	 * @brief getCommunityMain
	 * @detail 커뮤니티 메인으로 네비게이션 
	 * @param Search search 검색조건 도메인
	 * @return forward:/community/mainCommunity.jsp
	 */
	
	@RequestMapping(value="/getCommunityMain")
	public String getCommunityMain(
									//@RequestParam(value="condition")String Condition,
									//@RequestParam(value="keyword")String ketword
									@ModelAttribute("search")Search search ,Model model) {
		System.out.println("[Community.getCommunityMain() start...]");
		
		//서치 키워드가 null일 경우 nullString 으로 초기화
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		
		Map map=new HashMap<String,Object>();
		
		Page page=new Page();
		page.setCurrentPage(1);
		page.setPageSize(5);
		
		map.put("search",search);
		map.put("page", page);
		
		List<Board> boardList;
		boardList=communityServiceImpl.getBoardList(map);
		//확인용
		for(Board b: boardList) {
			System.out.println(b);
		}
		model.addAttribute("boardList", boardList);
		//
		return "forward:/community/mainCommunity.jsp";
	}
	
	/**
	 * @brief addBoard
	 * @detail 게시글 추가 
	 * @param Board board 게시글 도메인
	 * @return forward:/community/mainCommunity.jsp
	 */
	
	@RequestMapping(value="/addBoard")
	public String addBoard(@ModelAttribute("Board")Board board) {
		
		//테스트용 유저정보//
		User user=new User();
		user.setEmail("test@test.com");
		board.setWriter(user);
		System.out.println(board);
		communityServiceImpl.addBoard(board);
		
		return "redirect:/community/getBoard?boardNo="+board.getBoardNo();
	}
	
	@RequestMapping(value="/getBoard")
	public String getBoard(@RequestParam("boardNo")int boardNo,Model model) {
		
		Board board;
		board=communityServiceImpl.getBoard(boardNo);
		model.addAttribute("board",board);
		
		return "forward:/community/getBoard.jsp";
	}
}
