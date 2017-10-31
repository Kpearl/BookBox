package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

/**
 * @file com.bookbox.service.domain.Funding.java
 * @brief Funding domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Funding {

	//Field
	private int fundingNo;
	private String fundingTitle;
	private Creation creation;
	private List<PayInfo> payInfoList;
	private String fundingIntro;
	private Date fundingRegDate;
	private Date fundingEndDate;
	private int fundingTarget;
	private int perFunding;
	private String fundingImage;
	private int active;
	
	public Funding() {
		// TODO Auto-generated constructor stub
	}

	public int getFundingNo() {
		return fundingNo;
	}

	public void setFundingNo(int fundingNo) {
		this.fundingNo = fundingNo;
	}

	public String getFundingTitle() {
		return fundingTitle;
	}

	public void setFundingTitle(String fundingTitle) {
		this.fundingTitle = fundingTitle;
	}

	public Creation getCreation() {
		return creation;
	}

	public void setCreation(Creation creation) {
		this.creation = creation;
	}

	public List<PayInfo> getPayInfoList() {
		return payInfoList;
	}

	public void setPayInfoList(List<PayInfo> payInfoList) {
		this.payInfoList = payInfoList;
	}

	public String getFundingIntro() {
		return fundingIntro;
	}

	public void setFundingIntro(String fundingIntro) {
		this.fundingIntro = fundingIntro;
	}

	public Date getFundingRegDate() {
		return fundingRegDate;
	}

	public void setFundingRegDate(Date fundingRegDate) {
		this.fundingRegDate = fundingRegDate;
	}

	public Date getFundingEndDate() {
		return fundingEndDate;
	}

	public void setFundingEndDate(Date fundingEndDate) {
		this.fundingEndDate = fundingEndDate;
	}

	public int getFundingTarget() {
		return fundingTarget;
	}

	public void setFundingTarget(int fundingTarget) {
		this.fundingTarget = fundingTarget;
	}

	public int getPerFunding() {
		return perFunding;
	}

	public void setPerFunding(int perFunding) {
		this.perFunding = perFunding;
	}

	public String getFundingImage() {
		return fundingImage;
	}

	public void setFundingImage(String fundingImage) {
		this.fundingImage = fundingImage;
	}
			
	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "Funding [fundingNo=" + fundingNo + ", fundingTitle=" + fundingTitle + ", creation=" + creation
				+ ", PayInfoList=" + payInfoList + ", fundingIntro=" + fundingIntro + ", fundingRegDate="
				+ fundingRegDate + ", fundingEndDate=" + fundingEndDate + ", fundingTarget=" + fundingTarget
				+ ", perFunding=" + perFunding + ", fundingImage=" + fundingImage + ", active = "+active+"]";
	}
}
