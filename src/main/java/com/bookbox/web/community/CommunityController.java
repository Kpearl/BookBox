package com.bookbox.web.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.User;

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
		System.out.println("Constructor :: "+this.getClass().getName());
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
									//@RequestParam(value="keyword")String keyword,
									@ModelAttribute("search")Search search ,Model model) {
		System.out.println("[Community.getCommunityMain() start...]");
	
		
		System.out.println(search);
		//서치 키워드가 null일 경우 nullString 으로 초기화
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		if(search.getCondition()==null) {
			search.setCondition("0");
		}
		
		Map map=new HashMap<String,Object>();
		
		Page page=new Page();
		page.setCurrentPage(1);
		page.setPageSize(10);
		
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
		return "forward:mainCommunity.jsp";
	
	}
	/**
	 * @brief addBoard
	 * @detail 게시글 쓰기 뷰로 네비게이션 
	 * @param 
	 * @return rediect:addBoardView.jsp
	 */
	
	@RequestMapping(value="/addBoard",method=RequestMethod.GET)
	public String addBoard() {
		
		return "redirect:addBoardView.jsp";
	}
	
	/**
	 * @brief addBoard
	 * @detail 게시글 추가 
	 * @param Board board 게시글 도메인
	 * @return redirect:getBoard?boardNo="+board.getBoardNo()
	 */
	
	@RequestMapping(value="/addBoard",method=RequestMethod.POST)
	public String addBoard(@ModelAttribute("Board")Board board) {
		
		//테스트용 유저정보//
		User user=new User();
		user.setEmail("test@test.com");
		board.setWriter(user);
		System.out.println(board);
		communityServiceImpl.addBoard(user,board);
		
		return "redirect:getBoard?boardNo="+board.getBoardNo();
	}
	
	@RequestMapping(value="/getBoard")
	public String getBoard(@RequestParam("boardNo")int boardNo,Model model) {
		
		//테스트 유저
		User user=new User();
		user.setEmail("test@test.com");
		
		Board board=new Board();
		board.setBoardNo(boardNo);
		board=communityServiceImpl.getBoard(user,board);
		model.addAttribute("board",board);
		
		return "forward:getBoard.jsp";
	}
	
	@RequestMapping(value="/getBoardList")
	public String getBoardList(@ModelAttribute("Search")Search search,
								@ModelAttribute("Page")Page page,Model model) {
		
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		if(search.getCondition()==null) {
			search.setCondition("0");
		}
		if(page.getCurrentPage()==0) {
			page.setCurrentPage(1);
		}
		if(page.getPageSize()==0) {
			page.setPageSize(5);
		}
	//	System.out.println(page);
		
		Map map=new HashMap<String,Object>();
		map.put("search", search);
		map.put("page", page);
		
		
		List boardList;
		boardList=communityServiceImpl.getBoardList(map);
		System.out.println(boardList.size());
		
		model.addAttribute(boardList);
		
		return "forward:listBoard.jsp";
	}
}
