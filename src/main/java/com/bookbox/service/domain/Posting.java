package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

import com.bookbox.common.domain.Location;
import com.bookbox.common.domain.Tag;

/**
 * @file com.bookbox.service.domain.Posting.java
 * @brief Posting domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Posting {

	//Field
	private int postingNo;
	private User user;
	private String postingTitle;
	private String postingContent;
	private List<String> postingFileList;
	private Date postingRegDate;
	private Date postingUpdateDate;
	private List<Location> postingLocationList;
	private List<Tag> postingTagList;
	
	public Posting() {
		// TODO Auto-generated constructor stub
	}

	public int getPostingNo() {
		return postingNo;
	}

	public void setPostingNo(int postingNo) {
		this.postingNo = postingNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getPostingTitle() {
		return postingTitle;
	}

	public void setPostingTitle(String postingTitle) {
		this.postingTitle = postingTitle;
	}

	public String getPostingContent() {
		return postingContent;
	}

	public void setPostingContent(String postingContent) {
		this.postingContent = postingContent;
	}

	public List<String> getPostingFileList() {
		return postingFileList;
	}

	public void setPostingFileList(List<String> postingFileList) {
		this.postingFileList = postingFileList;
	}

	public Date getPostingRegDate() {
		return postingRegDate;
	}

	public void setPostingRegDate(Date postingRegDate) {
		this.postingRegDate = postingRegDate;
	}

	public Date getPostingUpdateDate() {
		return postingUpdateDate;
	}

	public void setPostingUpdateDate(Date postingUpdateDate) {
		this.postingUpdateDate = postingUpdateDate;
	}

	public List<Location> getPostingLocationList() {
		return postingLocationList;
	}

	public void setPostingLocationList(List<Location> postingLocationList) {
		this.postingLocationList = postingLocationList;
	}

	public List<Tag> getPostingTagList() {
		return postingTagList;
	}

	public void setPostingTagList(List<Tag> postingTagList) {
		this.postingTagList = postingTagList;
	}

	@Override
	public String toString() {
		return "Posting [postingNo=" + postingNo + ", user=" + user + ", postingTitle=" + postingTitle
				+ ", postingContent=" + postingContent + ", postingFileList=" + postingFileList + ", postingRegDate="
				+ postingRegDate + ", postingUpdateDate=" + postingUpdateDate + ", postingLocationList="
				+ postingLocationList + ", postingTagList=" + postingTagList + "]";
	}

}
