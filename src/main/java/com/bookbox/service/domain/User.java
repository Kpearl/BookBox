package com.bookbox.service.domain;

import java.sql.Date;

/**
 * @file com.bookbox.service.domain.User.java
 * @brief User domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 **/

public class User {
	
	///Field
	private String email;
	private String nickName;
	private String password;
	private boolean gender;
	private Date birth;
	private String role;
	private int outerAccount;
	private String outerToken;
	
	public User() {
		// TODO Auto-generated constructor stub
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getOuterAccount() {
		return outerAccount;
	}

	public void setOuterAccount(int outerAccount) {
		this.outerAccount = outerAccount;
	}

	public String getOuterToken() {
		return outerToken;
	}

	public void setOuterToken(String outerToken) {
		this.outerToken = outerToken;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", nickName=" + nickName + ", password=" + password + ", gender=" + gender
				+ ", birth=" + birth + ", role=" + role + ", outerAccount=" + outerAccount + ", outerToken="
				+ outerToken + "]";
	}
}