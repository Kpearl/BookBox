package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

/**
 * @file com.bookbox.service.domain.Funding.java
 * @brief 펀딩 domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Funding {

	int funding;
	String fundingTitle;
	Creation creation;
	List<PayInfo> PayInfoList;
	String fundingIntro;
	Date fundingRegDate;
	Date fundingEndDate;
	int fundingTarget;
	int perFunding;
	String fundingImage;
	
		
	public Funding() {
		// TODO Auto-generated constructor stub
	}


	public int getFunding() {
		return funding;
	}


	public void setFunding(int funding) {
		this.funding = funding;
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
		return PayInfoList;
	}


	public void setPayInfoList(List<PayInfo> payInfoList) {
		PayInfoList = payInfoList;
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


	@Override
	public String toString() {
		return "Funding [funding=" + funding + ", fundingTitle=" + fundingTitle + ", creation=" + creation
				+ ", PayInfoList=" + PayInfoList + ", fundingIntro=" + fundingIntro + ", fundingRegDate="
				+ fundingRegDate + ", fundingEndDate=" + fundingEndDate + ", fundingTarget=" + fundingTarget
				+ ", perFunding=" + perFunding + ", fundingImage=" + fundingImage + "]";
	}

		
}
