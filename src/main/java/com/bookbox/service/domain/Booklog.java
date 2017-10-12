package com.bookbox.service.domain;

import java.util.List;

/**
 * @file com.bookbox.service.domain.Booklog.java
 * @brief Booklog domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Booklog {
	
	//Field
	private User user;
	private String booklogName;
	private List<Posting> postingList;
	private String booklogImage;
	private List<User> bookmarkList;
	private String booklogIntro;
	
	public Booklog() {
		// TODO Auto-generated constructor stub
	}

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	public String getBooklogName() {
		return booklogName;
	}
	
	public void setBooklogName(String booklogName) {
		this.booklogName = booklogName;
	}
	
	public List<Posting> getPostingList() {
		return postingList;
	}
	
	public void setPostingList(List<Posting> postingList) {
		this.postingList = postingList;
	}
	
	public String getBooklogImage() {
		return booklogImage;
	}
	
	public void setBooklogImage(String booklogImage) {
		this.booklogImage = booklogImage;
	}
	
	public List<User> getBookmarkList() {
		return bookmarkList;
	}
	
	public void setBookmarkList(List<User> bookmarkList) {
		this.bookmarkList = bookmarkList;
	}
	
	public String getBooklogIntro() {
		return booklogIntro;
	}
	
	public void setBooklogIntro(String booklogIntro) {
		this.booklogIntro = booklogIntro;
	}
	
	@Override
	public String toString() {
		return "Booklog [user=" + user + ", booklogName=" + booklogName + ", postingList=" + postingList
				+ ", booklogImage=" + booklogImage + ", bookmarkList=" + bookmarkList + ", booklogIntro=" + booklogIntro
				+ "]";
	}
}
