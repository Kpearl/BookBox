package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

/**
 * @file com.bookbox.service.domain.Comment.java
 * @brief Comment domain
 * @detail
 * @author HS
 * @date 2017.10.12
 */

public class Comment {
	
	//Field
	private int commentNo;
	private User writer;
	private String content;
	private Date regDate;
	private int level;
	private List<Comment> comment;
	private boolean blind;
	
	public Comment() {
		// TODO Auto-generated constructor stub
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public User getWriter() {
		return writer;
	}

	public void setWriter(User writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public List<Comment> getComment() {
		return comment;
	}

	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}

	public boolean isBlind() {
		return blind;
	}

	public void setBlind(boolean blind) {
		this.blind = blind;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", writer=" + writer + ", content=" + content + ", regDate="
				+ regDate + ", level=" + level + ", comment=" + comment + ", blind=" + blind + "]";
	}
}
