package com.bookbox.service.domain;

import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Subscription;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;

/**
 * @file com.bookbox.service.domain.Creation.java
 * @brief Creation domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Creation {
	
	//Field
	private int creationNo;
	private String creationTitle;
	private String creationInto;
	private User creationAuthor;
	private String creationHead;
	private UploadFile creationFile;
	private String creationIntro;
	private List<Writing> writingList;
	private List<Tag> tagList;
	private boolean doFunding;
	private Grade grade;
	private Like like;
	private Subscription subscription;
	private int active;
	
	public Creation() {
		// TODO Auto-generated constructor stub
	}

	public int getCreationNo() {
		return creationNo;
	}

	public void setCreationNo(int creationNo) {
		this.creationNo = creationNo;
	}

	public String getCreationTitle() {
		return creationTitle;
	}

	public void setCreationTitle(String creationTitle) {
		this.creationTitle = creationTitle;
	}

	public String getCreationInto() {
		return creationInto;
	}

	public void setCreationInto(String creationInto) {
		this.creationInto = creationInto;
	}

	public User getCreationAuthor() {
		return creationAuthor;
	}

	public void setCreationAuthor(User creationAuthor) {
		this.creationAuthor = creationAuthor;
	}

	public String getCreationHead() {
		return creationHead;
	}

	public void setCreationHead(String creationHead) {
		this.creationHead = creationHead;
	}

	public UploadFile getCreationFile() {
		return creationFile;
	}

	public void setCreationFile(UploadFile creationFile) {
		this.creationFile = creationFile;
	}

	public String getCreationIntro() {
		return creationIntro;
	}

	public void setCreationIntro(String creationIntro) {
		this.creationIntro = creationIntro;
	}

	public List<Writing> getWritingList() {
		return writingList;
	}

	public void setWritingList(List<Writing> writingList) {
		this.writingList = writingList;
	}

	public List<Tag> getTagList() {
		return tagList;
	}

	public void setTagList(List<Tag> tagList) {
		this.tagList = tagList;
	}

	public boolean isDoFunding() {
		return doFunding;
	}

	public void setDoFunding(boolean doFunding) {
		this.doFunding = doFunding;
	}

	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public Like getLike() {
		return like;
	}

	public void setLike(Like like) {
		this.like = like;
	}

	public Subscription getSubscription() {
		return subscription;
	}

	public void setSubscription(Subscription subscription) {
		this.subscription = subscription;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "Creation [creationNo=" + creationNo + ", creationTitle=" + creationTitle + ", creationInto="
				+ creationInto + ", creationAuthor=" + creationAuthor + ", creationHead=" + creationHead
				+ ", creationFile=" + creationFile + ", creationIntro=" + creationIntro + ", writingList="
				+ writingList + "tagList"+tagList+", doFunding=" + doFunding + ", grade=" + grade + ", like=" + like + ", subscription="
				+ subscription + "active"+active+"]";
	}
}
