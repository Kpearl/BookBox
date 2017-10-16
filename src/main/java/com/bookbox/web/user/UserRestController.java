package com.bookbox.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.web.user.UserRestController.java
 * @brief 회원 RestController
 * @detail
 * @author HJ
 * @date 2017.10.16
 */
@RestController
@RequestMapping("/user/rest/*")
public class UserRestController {
	
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	/**
	 * @brief Constructor
	 */		
	public UserRestController(){
		System.out.println("Constructor :: "+this.getClass());
	}
	
	/**
	 * @brief login/로그인                           
	 * @details POST
	 * @param User user, HttpSession session
	 * @throws Exception
	 * @return User/ dbUser
	 */	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/rest/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user);
		
		if( dbUser != null
				&&user.getPassword().equals(dbUser.getPassword())
				&& user.getOuterAccount()==dbUser.getOuterAccount()){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	/**
	 * @brief checkEmailValidation/ 이메일중복체크                           
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return boolean result
	 */	
	@RequestMapping(value="checkEmailValidation", method=RequestMethod.POST)
	public boolean checkEmailValidation(@RequestBody User user) throws Exception{
		System.out.println("/user/rest/checkEmailValidation : POST");
		
		//Business Logic
		boolean result = userService.checkEmailValidation(user); 
		 
		System.out.println("user/rest/checkEmailValidation :: "+result);
		 
		return result;
	}

	/**
	 * @brief checkNicknameValidation/ 닉네임중복체크                           
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return boolean result
	 */
	@RequestMapping(value="checkNicknameValidation", method=RequestMethod.POST)
	public boolean checkNicknameValidation(@RequestBody User user) throws Exception{
		System.out.println("/user/rest/checkNicknameValidation : POST");
		
		//Business Logic
		boolean result = userService.checkNicknameValidation(user); 
		 
		System.out.println("user/rest/checkEmailValidation :: "+result);
		 
		return result;
	}
	
	/**
	 * @brief findPassword/비밀번호찾기
	 * @details POST
	 * @param User user, HttpSession session
	 * @throws Exception
	 * @return boolean result
	 */
	@RequestMapping( value="findPassword", method=RequestMethod.POST )
	public boolean findPassword(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("/user/rest/findPassword : POST");
	
		boolean result=true;
		
		User dbUser = (User)session.getAttribute("user");
		
		if(user.getPassword().equals(dbUser.getEmail()) 
				&& user.getBirth().equals(dbUser.getBirth())) {
			 result = true;
		}else {
			 result=false;
		}	
		
		return result;
	}
	


}