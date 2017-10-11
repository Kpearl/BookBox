package com.bookbox.service.domain;

import java.sql.Date;

/**
 * @file com.bookbox.service.domain.PayInfo.java
 * @brief 펀딩결제 domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class PayInfo {
	
	int payInfoNo;
	User user;
	int tid;
	String userName;	
	String addr;
	Date regDate;

	public PayInfo() {
		// TODO Auto-generated constructor stub
	}

	public int getPayInfoNo() {
		return payInfoNo;
	}

	public void setPayInfoNo(int payInfoNo) {
		this.payInfoNo = payInfoNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "PayInfo [payInfoNo=" + payInfoNo + ", user=" + user + ", tid=" + tid + ", userName=" + userName
				+ ", addr=" + addr + ", regDate=" + regDate + "]";
	}
	

}
