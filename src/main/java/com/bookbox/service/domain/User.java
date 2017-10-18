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
	private String nickname;
	private String password;
	private String gender;
	private Date birth;
	private String role;
	private int outerAccount;
	private String outerToken;
	private int active;	
	
	public User() {
		// TODO Auto-generated constructor stub
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
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

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", nickname=" + nickname + ", password=" + password + ", gender=" + gender
				+ ", birth=" + birth + ", role=" + role + ", outerAccount=" + outerAccount + ", outerToken="
				+ outerToken + ", active="+active+"]";
	}
}