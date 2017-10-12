package com.bookbox.common;

/**
 * @file com.bookbox.common.Grade.java
 * @brief 평점 domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Grade {
	
	int average;
	int userCount;
	boolean doGrade;
	

	public Grade() {
		// TODO Auto-generated constructor stub
	}


	public int getAverage() {
		return average;
	}


	public void setAverage(int average) {
		this.average = average;
	}


	public int getUserCount() {
		return userCount;
	}


	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}


	public boolean isDoGrade() {
		return doGrade;
	}


	public void setDoGrade(boolean doGrade) {
		this.doGrade = doGrade;
	}


	@Override
	public String toString() {
		return "Grade [average=" + average + ", userCount=" + userCount + ", doGrade=" + doGrade + "]";
	}
	
}
