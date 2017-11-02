package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

import com.bookbox.common.domain.Tag;

/**
 * @file com.bookbox.service.domain.ChatRoom.java
 * @brief ChatRoom domain
 * @detail
 * @author HS
 * @date 2017.10.12
 */

public class ChatRoom {
	
	//Field
	private String roomId;
	private String title;
	private String regDate;
	private String content;
	private int type;
	private int maxUser;
	private String image;
	private User host;
	private List<Tag> tagList;
	
	public ChatRoom() {
		// TODO Auto-generated constructor stub
	}

	
	public String getRoomId() {
		return roomId;
	}


	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
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

	public List getTagList() {
		return tagList;
	}

	public void setTagList(List tagList) {
		this.tagList = tagList;
	}


	@Override
	public String toString() {
		return "ChatRoom [roomId=" + roomId + ", title=" + title + ", regDate=" + regDate + ", content=" + content
				+ ", type=" + type + ", maxUser=" + maxUser + ", image=" + image + ", host=" + host + ", TagList="+ tagList+"]";
	}
}
