package com.bookbox.web.community;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserService;
import com.bookbox.service.user.impl.UserServiceImpl;

import sun.util.resources.CalendarData;


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
	
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userServiceImpl;
	
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
									@ModelAttribute("search")Search search ,Model model) throws Exception {
		System.out.println("[Community.getCommunityMain() start...]");
	
		
		System.out.println(search);
		//서치 키워드가 null일 경우 nullString 으로 초기화
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		if(search.getCondition()==null) {
			search.setCondition("0");
		}
		if(search.getOrder()==null) {
			search.setOrder("0");
		}
		
		Page page=new Page();
		page.setCurrentPage(1);
		page.setPageSize(10);
		
		if(page.getPageUnit()==0) {
			page.setPageUnit(5);
		}
		
		Map map=new HashMap<String,Object>();
		
		
		
		map.put("search",search);
		map.put("page", page);
		
		
		List<Board> boardList;
		boardList=communityServiceImpl.getBoardList(map);
		//확인용
		//for(Board b: boardList) {
		//	System.out.println(b);
		//}
		
		//===========채팅방 목록조회============
		List<ChatRoom> camChatList=new ArrayList<ChatRoom>(); 

		for(Map.Entry<String, ChatRoom> elem: ChatRoom.camChatMap.entrySet()) {
			camChatList.add(elem.getValue());
		}
	
		//========방송 목록조회============
		List<ChatRoom> castList=new ArrayList<ChatRoom>(); 
		
		//
		for(Map.Entry<String, ChatRoom> elem: ChatRoom.castMap.entrySet()) {
			castList.add(elem.getValue());
		}
		
		
		
		
		
		model.addAttribute("castList",castList);
		model.addAttribute("camChatList",camChatList);
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
	public String addBoard() throws Exception{
		
		return "redirect:addBoardView.jsp";
	}
	
	/**
	 * @brief addBoard
	 * @detail 게시글 추가 
	 * @param Board board 게시글 도메인
	 * @return redirect:getBoard?boardNo="+board.getBoardNo()
	 */
	
	@RequestMapping(value="/addBoard",method=RequestMethod.POST)
	public String addBoard(@ModelAttribute("Board")Board board, HttpServletRequest request,HttpSession session) throws Exception {
		
		System.out.println(board);
		//태그추가
		String tagNames[]= request.getParameterValues("tagNames");
		if(tagNames!=null) {
			List<Tag> tagList=new ArrayList<Tag>();
			for(int i=0; i<tagNames.length;i++) {
				System.out.println(tagNames[i]);
				Tag tag=new Tag();
				tag.setTagName(tagNames[i]);
				tagList.add(tag);
			}
			board.setTagList(tagList);
		}
		
		
		User user=(User)session.getAttribute("user");
		//테스트용 유저정보//
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		
		board.setWriter(user);
		System.out.println(board);
		communityServiceImpl.addBoard(user,board);
		
		return "redirect:getBoard?boardNo="+board.getBoardNo();
	}
	
	
	@RequestMapping(value="/getBoard")
	public String getBoard(@RequestParam("boardNo")int boardNo,Model model,HttpSession session) throws Exception {
		
		User user=(User)session.getAttribute("user");
		//테스트용 유저정보//
		if(user==null) {
			user=new User();
		}
		
		Board board=new Board();

		board.setBoardNo(boardNo);
		board=communityServiceImpl.getBoard(user,board);
		
		boolean enableUpdate=false;

		if(user.getEmail()!=null&&user.getEmail().equals(board.getWriter().getEmail())) {
			enableUpdate=true;
		}
		
		model.addAttribute("board",board);
		model.addAttribute("enableUpdate",enableUpdate);
		
		return "forward:getBoard.jsp";
	}
	
	
	/**
	 * @brief getBoardList
	 * @detail 게시글 목록 조회 
	 * @param Search search
	 * @return forward:listBoard.jsp
	 */
	@RequestMapping(value="/getBoardList")
	public String getBoardList(@ModelAttribute("Search")Search search,
								@ModelAttribute("Page")Page page,Model model) throws Exception{
		
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		if(search.getCondition()==null) {
			search.setCondition("0");
		}
		if(search.getOrder()==null) {
			search.setOrder("0");
		}
		
		if(page.getCurrentPage()==0) {
			page.setCurrentPage(1);
		}
		if(page.getPageSize()==0) {
			page.setPageSize(5);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(5);
		}
	//	System.out.println(page);
		
		Map map=new HashMap<String,Object>();
		map.put("search", search);
		map.put("page", page);
		
		
		List boardList;
		//boardList=communityServiceImpl.getBoardList(map);
		boardList=communityServiceImpl.getBoardList(map);
		System.out.println(boardList.size());
		
		model.addAttribute("boardList",boardList);
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		return "forward:listBoard.jsp";
	}
	
	/**
	 * @brief 
	 * @detail 게시글 업데이트 뷰 네비게이션 
	 * @param 
	 * @return forward:listBoard.jsp
	 */
	@RequestMapping(value="updateBoard",method=RequestMethod.GET)
	public String updateBoard(@RequestParam("boardNo")int boardNo, HttpSession session,Model model) {
		
		User user=(User)session.getAttribute("user");
		//임시 유저
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user.setNickname("훔바훔바");
		}
		Board board=new Board();
		board.setBoardNo(boardNo);
		
		board=communityServiceImpl.getBoard(user, board);
		model.addAttribute("board",board);
		
		return "forward:updateBoardView.jsp";
	}
	
	/**
	 * @brief updateBoard
	 * @detail 게시글 수정 
	 * @param Board board 게시글 도메인
	 * @return redirect:getBoard?boardNo="+board.getBoardNo()
	 */
	
	@RequestMapping(value="/updateBoard",method=RequestMethod.POST)
	public String updateBoard(@ModelAttribute("Board")Board board, HttpServletRequest request,HttpSession session) throws Exception {
		
		//태그추가
		String tagNames[]= request.getParameterValues("tagNames");
		if(tagNames!=null) {
			List<Tag> tagList=new ArrayList<Tag>();
			for(int i=0; i<tagNames.length;i++) {
				Tag tag=new Tag();
				tag.setTagName(tagNames[i]);
				tagList.add(tag);
			}
			board.setTagList(tagList);
		}
		
		System.out.println(board);
		User user=new User();
		user=communityServiceImpl.getBoard(user, board).getWriter();
		board.setWriter(user);
		
		communityServiceImpl.updateBoard(board);
		
		return "redirect:getBoard?boardNo="+board.getBoardNo();
	}
	
	/**
	 * @brief uploadCKEditor
	 * @detail CKEditor 이미지 업로드 
	 * @param MultipartFile file 이미지 파일
	 * @return forward:uploadCKEditor.jsp
	 */
	@RequestMapping(value="uploadCKEditor")
	public String uploadCKEditor(HttpServletRequest request,
									@RequestParam("upload")MultipartFile file,
									Model model) throws Exception{
		
		String originName=file.getOriginalFilename();
		int beginIndex=originName.lastIndexOf(".");
		int endIndex=originName.length();
		
		
		String CKEditor=request.getParameter("CKEditor");
		int CKEditorFuncNum=Integer.parseInt(request.getParameter("CKEditorFuncNum"));
		
		String url=request.getRealPath("resources/upload_files/images/");
		
		String fileName=UUID.randomUUID().toString()+originName.substring(beginIndex, endIndex);
		String originFileName=file.getOriginalFilename();
		
		File toFile=new File(url+"/"+fileName);
		
		//System.out.println(file.getOriginalFilename()+file.getSize());
		file.transferTo(toFile);
		
		
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		model.addAttribute("url", "../resources/upload_files/images/"+fileName);
		model.addAttribute("fileName",fileName);
		model.addAttribute("originFileName",originFileName);
		System.out.println(url);
		
		
		return "forward:uploadCKEditor.jsp";
	}
	
	
	//==========================채팅방 ==================================
	/**
	 * @brief addChatRoom
	 * @detail 채팅방생성으로 단순 네비게이션 
	 * @param 
	 * @return redirect:addChatRoom.jsp
	 */
	@RequestMapping(value="/addChatRoom" ,method=RequestMethod.GET)
	public String addChatRoom() throws Exception{
		return "redirect:addChatRoomView.jsp";
	}

	/**
	 * @brief addChatRoom
	 * @detail 채팅방생성 
	 * @param 
	 * @return redirect:addChatRoom.jsp
	 */
	//static Map<String, ChatRoom> camChatMap=Collections.synchronizedMap(new HashMap<String, ChatRoom>());;
	//static Map<String, ChatRoom> castMap=Collections.synchronizedMap(new HashMap<String, ChatRoom>());
	
	@RequestMapping(value="addChatRoom" ,method=RequestMethod.POST)
	public String addChatRoom(HttpServletRequest request,HttpSession session,
								@ModelAttribute("ChatRoom")ChatRoom chatRoom,@RequestParam("file")MultipartFile file,
								Model model) throws Exception{
		
		User user=(User)session.getAttribute("user");
		
		///////////////테스트 유저///////////////////////////////////
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		///////////////////////////////////////////////////
		//태그 추가
		String []tagNames=request.getParameterValues("tagNames");
		if(tagNames!=null) {
		List tagList=new ArrayList<Tag>();
			for(String tagName:tagNames) {
				Tag tag=new Tag();
				tag.setTagName(tagName);
				tagList.add(tag);
			}
			chatRoom.setTagList(tagList);
		}
		//

		//이미지업로드
		if(!file.isEmpty()) {
			String originName=file.getOriginalFilename();
			int beginIndex=originName.lastIndexOf(".");
			int endIndex=originName.length();
			
			String uploadName=UUID.randomUUID().toString()+originName.substring(beginIndex, endIndex);
			
			String path=request.getRealPath("resources/upload_files/images");
			File uploadFile=new File(path+"/"+uploadName);
			//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+uploadFile.getPath());
			file.transferTo(uploadFile);
			chatRoom.setImage("../resources/upload_files/images/"+uploadName);
		}
		//
		chatRoom.setHost(user);
		chatRoom.setRoomId(UUID.randomUUID().toString());
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String regDate=format.format(new Date());
		chatRoom.setRegDate(regDate);
		
		System.out.println(chatRoom);
		
		
		
		if(chatRoom.getType()==0) {
			ChatRoom.camChatMap.put(chatRoom.getRoomId(), chatRoom);
			return "redirect:getCamChat?roomId="+chatRoom.getRoomId();			
		}
		else if(chatRoom.getType()==1) {
			ChatRoom.castMap.put(chatRoom.getRoomId(), chatRoom);
			return "redirect:getCast?roomId="+chatRoom.getRoomId();
		}
		return "redirect:../";
	}
	
	
	/**
	 * @brief getCamChat
	 * @detail 화상채팅방 조회
	 * @param String rooId
	 * @return 
	 */
	@RequestMapping(value="/getCamChat")
	public String getCamChat(@RequestParam("roomId")String roomId,HttpSession session ,Model model) throws Exception{
		System.out.println("[getCamChat() start...]");
		User user=(User)session.getAttribute("user");
		/////테스트유저/////////////////////////////////////////////////////나중에 지울것
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		//////////////////////////////////////////////////////////////////
		
		//방정보 탐색
		ChatRoom chatRoom=ChatRoom.camChatMap.get(roomId);
		if(chatRoom==null) {
			System.out.println("채팅방 탐색실패");
			return "redirect:getCommunityMain";
		}
		//방정보
		model.addAttribute("chatRoom",chatRoom);
		//유저정보
		model.addAttribute("user",user);
		return "forward:getCamChat.jsp";
	}
	
	/**
	 * @brief getCast
	 * @detail 방송 조회
	 * @param String rooId
	 * @return 
	 */
	@RequestMapping(value="/getCast")
	public String getCast(@RequestParam("roomId")String roomId,HttpSession session ,Model model) throws Exception{
		
		User user=(User)session.getAttribute("user");
		/////테스트유저/////////////////////////////////////////////////////나중에 지울것
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		//////////////////////////////////////////////////////////////////
		
		//방정보 탐색
		ChatRoom chatRoom=ChatRoom.castMap.get(roomId);
		if(chatRoom==null) {
			System.out.println("채팅방 탐색실패");
			return "redirect:getCommunityMain";
		}
		//방정보
		model.addAttribute("chatRoom",chatRoom);
		//유저정보
		model.addAttribute("user",user);
		return "forward:getCast.jsp";
	}
	
	/**
	 * @brief getCamChatList
	 * @detail 화상채팅방 목록조회
	 * @param 
	 * @return List ChatRoom 
	 */
	@RequestMapping(value="/getCamChatList")
	public String getCamChatList(Model model) throws Exception{
		
		List<ChatRoom> camChatList=new ArrayList<ChatRoom>(); 
		
		//
		for(Map.Entry<String, ChatRoom> elem: ChatRoom.camChatMap.entrySet()) {
			camChatList.add(elem.getValue());
		}
		
		model.addAttribute("camChatList",camChatList);
		
		return "forward:listCamChat.jsp";
	}
	
	/**
	 * @brief getCastList
	 * @detail 방송 목록조회
	 * @param 
	 * @return List ChatRoom 
	 */
	@RequestMapping(value="/getCastList")
	public String getCastList(Model model) throws Exception{
		
		List<ChatRoom> castList=new ArrayList<ChatRoom>(); 
		
		for(Map.Entry<String, ChatRoom> elem: ChatRoom.castMap.entrySet()) {
			castList.add(elem.getValue());
		}
		
		model.addAttribute("castList",castList);
		
		return "forward:listCast.jsp";
	}
	
	
}
