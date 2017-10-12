package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.Like.java
 * @brief 좋아요 domain
 * @detail 책,창작작품(creation)
 * @author HJ
 * @date 2017.10.11
 */

public class Like {

	int totalLike;
	boolean doLike;
	
	public Like() {
		// TODO Auto-generated constructor stub
	}

	public int getTotalLike() {
		return totalLike;
	}

	public void setTotalLike(int totalLike) {
		this.totalLike = totalLike;
	}

	public boolean isDoLike() {
		return doLike;
	}

	public void setDoLike(boolean doLike) {
		this.doLike = doLike;
	}

	@Override
	public String toString() {
		return "Like [totalLike=" + totalLike + ", doLike=" + doLike + "]";
	}
	
	
}
