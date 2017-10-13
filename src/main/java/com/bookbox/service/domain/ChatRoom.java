package com.bookbox.service.domain;

import java.sql.Date;

/**
 * @file com.bookbox.service.domain.ChatRoom.java
 * @brief ChatRoom domain
 * @detail
 * @author HS
 * @date 2017.10.12
 */

public class ChatRoom {
	
	//Field
	private int roomNo;
	private String title;
	private Date regDate;
	private String content;
	private int type;
	private int maxUser;
	private String image;
	private User host;
	
	public ChatRoom() {
		// TODO Auto-generated constructor stub
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getMaxUser() {
		return maxUser;
	}

	public void setMaxUser(int maxUser) {
		this.maxUser = maxUser;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public User getHost() {
		return host;
	}

	public void setHost(User host) {
		this.host = host;
	}

	@Override
	public String toString() {
		return "ChatRoom [roomNo=" + roomNo + ", title=" + title + ", regDate=" + regDate + ", content=" + content
				+ ", type=" + type + ", maxUser=" + maxUser + ", image=" + image + ", host=" + host + "]";
	}
}
