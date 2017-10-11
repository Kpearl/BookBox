package com.bookbox.service.domain;

import java.sql.Date;



public class User {
	
	///Field
	private String email;
	private String nickName;
	private String password;
	private boolean gender;
	private Date birth;
	private Date regDate;
	private String role;
	
	
	///Constructor
	public User(){
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


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	@Override
	public String toString() {
		return "User [email=" + email + ", nickName=" + nickName + ", password=" + password + ", gender=" + gender
				+ ", birth=" + birth + ", regDate=" + regDate + ", role=" + role + "]";
	}
	
	
	
	
}