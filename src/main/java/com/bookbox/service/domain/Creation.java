package com.bookbox.service.domain;

import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Subscription;

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
	private String creationAuthor;
	private String creationHead;
	private String creationImage;
	private String creationContent;
	private List<Writing> writingList;
	private boolean doFunding;
	private Grade grade;
	private Like like;
	private Subscription subscription;
	
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

	public String getCreationAuthor() {
		return creationAuthor;
	}

	public void setCreationAuthor(String creationAuthor) {
		this.creationAuthor = creationAuthor;
	}

	public String getCreationHead() {
		return creationHead;
	}

	public void setCreationHead(String creationHead) {
		this.creationHead = creationHead;
	}

	public String getCreationImage() {
		return creationImage;
	}

	public void setCreationImage(String creationImage) {
		this.creationImage = creationImage;
	}

	public String getCreationContent() {
		return creationContent;
	}

	public void setCreationContent(String creationContent) {
		this.creationContent = creationContent;
	}

	public List<Writing> getWritingList() {
		return writingList;
	}

	public void setWritingList(List<Writing> writingList) {
		this.writingList = writingList;
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

	@Override
	public String toString() {
		return "Creation [creationNo=" + creationNo + ", creationTitle=" + creationTitle + ", creationInto="
				+ creationInto + ", creationAuthor=" + creationAuthor + ", creationHead=" + creationHead
				+ ", creationImage=" + creationImage + ", creationContent=" + creationContent + ", writingList="
				+ writingList + ", doFunding=" + doFunding + ", grade=" + grade + ", like=" + like + ", subscription="
				+ subscription + "]";
	}
}
