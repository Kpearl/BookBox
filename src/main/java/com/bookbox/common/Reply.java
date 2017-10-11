package com.bookbox.common;

import java.sql.Date;

import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.Reply.java
 * @brief 댓글 domain
 * @detail 창작글(writing), 책
 * @author HJ
 * @date 2017.10.11
 */

public class Reply {

	User user;
	Date regDate;
	String content;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Reply [user=" + user + ", regDate=" + regDate + ", content=" + content + "]";
	}

		
}
