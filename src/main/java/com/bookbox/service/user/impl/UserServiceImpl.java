package com.bookbox.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserDAO;
import com.bookbox.service.user.UserService;


/**
 * @file com.bookbox.service.user.impl.UserServieceImpl.java
 * @brief 회원 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.14
 */

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO =userDAO;
	}
	
	/**
	 * @brief Constructor
	 */			
	public UserServiceImpl() {
		System.out.println("Constructor :: "+this.getClass());
	}

	/**
	 * @brief 회원가입/INSERT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void addUser(User user) throws Exception{
		System.out.println("UserServiceImpl : userDAO.addUser(user)");
		userDAO.addUser(user);
		System.out.println("UserServiceImpl : userDAO.addUser(user)");
	}

	/**
	 * @brief 회원정보수정/UPDATE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public void updateUser(User user) throws Exception{
		userDAO.updateUser(user);
	}

	/**
	 * @brief 내정보확인/로그인/SELECT ONE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		return userDAO.getUser(user);
	}
	
	/**
	 * @brief 메일인증 후 회원활성화코드 변경/ 회원탈퇴
	 * @param User user
	 * @throws Exception
	 * @return 
	 */
	public void updateActive(Map<String, Object> map) throws Exception{
		userDAO.updateActive(map);
	}
	

	/**
	 * @brief 회원정보리스트/SELECT LIST
	 * @param Search search
	 * @throws Exception
	 * @return List<User>
	 */
	public Map<String, Object> getUserList(Search search) throws Exception{
		
		List<User> list = userDAO.getUserList(search);
		int totalCount = userDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}
	
	/**
	 * @brief 이메일 중복체크 
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkEmailValidation(User user) throws Exception{
		
		boolean result = true;
		
		if(userDAO.getUser(user).getEmail() != null) {
			result =false;
		}
		return result;
	}
	
	/**
	 * @brief 닉네임중복체크
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkNicknameValidation(User user) throws Exception{
		
		boolean result = true;
		
		if(userDAO.getUser(user).getNickname() != null) {
			result =false;
		}
		return result;
	}
	


}
