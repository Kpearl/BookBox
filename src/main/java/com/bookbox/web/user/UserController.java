package com.bookbox.web.user;

import java.util.HashMap;
import java.util.Map;

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

import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserService;


/**
 * @file com.bookbox.web.user.UserCrontroller.java
 * @brief 회원 Controller
 * @detail
 * @author HJ
 * @date 2017.10.13
 */

@Controller
@RequestMapping("/user/*")
public class UserController {

	
	/**
	 * @brief  field
	 */
		@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

		
		/**
		 * @brief  Constructor
		 */		
	public UserController() {
		System.out.println(this.getClass());
	}
	
	/**
	 * @brief addUser/회원가입화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:addUserView.jsp" 
	 */
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	/**
	 * @brief addUser/회원가입
	 * @details POST/ addUser 후 로그인 화면으로 이동
	 * @param User user
	 * @throws Exception
	 * @return "forward:loginView.jsp"
	 */
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "forward:loginView.jsp";
	}
	
	/**
	 * @brief getUser/로그인, 회원정보 조회
	 * @details GET
	 * @param User user(email)
	 * @throws Exception
	 * @return "forward:getUser.jsp"
	 */
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @ModelAttribute("user") User user , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User dbuser = userService.getUser(user);
		// Model 과 View 연결
		model.addAttribute("user", dbuser);
		
		return "forward:getUser.jsp";
	}
	
	/**
	 * @brief updateUser/회원정보수정화면으로 이동
	 * @details GET
	 * @param User user(email)
	 * @throws Exception
	 * @return "forward:updateUserView.jsp"
	 */
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @ModelAttribute("user") User user , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User dbuser = userService.getUser(user);
		// Model 과 View 연결
		model.addAttribute("user", dbuser);
		
		return "forward:updateUserView.jsp";
	}
	
	/**
	 * @brief updateUser/회원정보수정
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return "redirect:getUser?email=user.getEmail()"
	 */
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{
		
		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionEmail=((User)session.getAttribute("user")).getEmail();
		if(sessionEmail.equals(user.getEmail())){
			session.setAttribute("user", user);
		}
		
		return "redirect:getUser?email="+user.getEmail();
	}

	/**
	 * @brief login/로그인화면으로 이동                           
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:/user/loginView.jsp"
	 */
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/login : GET");
		
		return "redirect:loginView.jsp";
	}
	
	/**
	 * @brief login/로그인                           
	 * @details POST
	 * @param User user, HttpSession session
	 * @throws Exception
	 * @return "forward:../index.jsp"
	 */
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		
		//Business Logic
		User dbUser=userService.getUser(user);
		
		if( dbUser != null
				&&user.getPassword().equals(dbUser.getPassword())
				&& user.getOuterAccount()==dbUser.getOuterAccount()){
			session.setAttribute("user", dbUser);
		}
		
		return "forward:../index.jsp";
	}
	
	/**
	 * @brief logout/로그아웃                           
	 * @details GET
	 * @param HttpSession session
	 * @throws Exception
	 * @return "forward:../index.jsp"
	 */	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:../index.jsp";
	}
	
	/**
	 * @brief findPassword/비밀번호찾기 화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:findPassword.jsp"
	 */
	@RequestMapping( value="findPassword", method=RequestMethod.GET )
	public String findPassword() throws Exception {
		
		System.out.println("/user/findPassword : GET");
		
		return "redirect:findPassword.jsp";
	}
	
	/**
	 * @brief deleteUser/회원탈퇴
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:../index.jsp"
	 */
	@RequestMapping( value="deleteUser", method=RequestMethod.GET )
	public String deleteUser(HttpSession session) throws Exception {
		
		System.out.println("/user/deleteUser : GET");
		
		Map<String, Object> map = new HashMap<>();
		map.put("email",  ((User)session.getAttribute("user")).getEmail());
		map.put("active", 2);
		
		userService.updateActive(map);
		
		return "redirect:../index.jsp";
	}
	
	/**
	 * @brief activeUser/ 인증후 회원활성화
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:../index.jsp"
	 */
	@RequestMapping( value="activeUser", method=RequestMethod.GET )
	public String activeUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		
		System.out.println("/user/activeUser : GET");
		
		User dbuser = userService.getUser(user);
		
		Map<String, Object> map = new HashMap<>();
		map.put("email",  dbuser.getEmail());
		map.put("active", 1);
		
		userService.updateActive(map);
		
		System.out.println("Controller : activeUser :: "+dbuser);
		
		return "redirect:login?email="+dbuser.getEmail();
	}
	

	

	/////////////////////////////////////////////////////////////////////////////////////
////	/**
////	 * @brief updateUserCheck/회원정보수정인증 화면으로 이동
////	 * @details GET
////	 * @param 
////	 * @throws Exception
////	 * @return "forward:/user/updateUserCheckView.jsp"
////	 */
//	@RequestMapping( value="updateUserCheck", method=RequestMethod.GET )
//	public String updateUserCheck() throws Exception{
//
//		System.out.println("/user/updateUserCheck : GET");
//		
//		return "redirect:/user/updateUserCheckView.jsp";
//	}
//	
////	/**
////	 * @brief updateUserCheck/회원정보수정인증 
////	 * @details POST
////	 * @param User user
////	 * @throws Exception
////	 * @return "forward:/user/updateUserView.jsp"
////	 */
//	@RequestMapping( value="updateUserCheck", method=RequestMethod.POST )
//	public String updateUserCheck(@ModelAttribute("user") User user, 
//																	HttpSession session, Model model) throws Exception{
//
//		System.out.println("/user/updateUser : POST");
//		
//		User dbuser = (User)session.getAttribute("user");
//		
//		if(user.getPassword()==dbuser.getPassword()) {
//			return "forword:/user/updateUserView.jsp";
//		}
//			return "";	
//	}
////////////////////////////////////////////////////////////////////////////////////////

	
	
	
	/*

	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	
	@RequestMapping( value="kakaoLogin")
	public String kakaoLogin(@RequestParam("accessToken") String accessToken, Model model ) throws Exception
	{
		System.out.println("test token : "+accessToken);
		model.addAttribute("user", userService.getUser2(accessToken));
		
		return "forward:/user/updateUserView.jsp";
	}
	
	
	@RequestMapping( value="googleLogin")
	public String googleLogin(@RequestParam("googleToken") String accessToken, Model model ) throws Exception
	{
		System.out.println("test google token : "+accessToken);
		model.addAttribute("user", userService.getUser2(accessToken));
		
		return "forward:/user/updateUserView.jsp";
	}
		*/
	
		
	
	
}
