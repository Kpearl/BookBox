package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Reply;


/**
 * @file com.bookbox.service.domain.Writing.java
 * @brief 창작글 domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Writing {

	int writingNo;
	String writingTitle;
	String writingContent;
	Date regDate;
	Date updateDate;
	List<Reply> replyList;
	Grade grade;
	List<String> writingImageList;
	int viewCount;
	
	
	public Writing() {
		// TODO Auto-generated constructor stub
	}


	public int getWritingNo() {
		return writingNo;
	}


	public void setWritingNo(int writingNo) {
		this.writingNo = writingNo;
	}


	public String getWritingTitle() {
		return writingTitle;
	}


	public void setWritingTitle(String writingTitle) {
		this.writingTitle = writingTitle;
	}


	public String getWritingContent() {
		return writingContent;
	}


	public void setWritingContent(String writingContent) {
		this.writingContent = writingContent;
	}


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public List<Reply> getReplyList() {
		return replyList;
	}


	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}


	public Grade getGrade() {
		return grade;
	}


	public void setGrade(Grade grade) {
		this.grade = grade;
	}


	public List<String> getWritingImageList() {
		return writingImageList;
	}


	public void setWritingImageList(List<String> writingImageList) {
		this.writingImageList = writingImageList;
	}


	public int getViewCount() {
		return viewCount;
	}


	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}


	@Override
	public String toString() {
		return "Writing [writingNo=" + writingNo + ", writingTitle=" + writingTitle + ", writingContent="
				+ writingContent + ", regDate=" + regDate + ", updateDate=" + updateDate + ", replyList=" + replyList
				+ ", grade=" + grade + ", writingImageList=" + writingImageList + ", viewCount=" + viewCount + "]";
	}

		
}
