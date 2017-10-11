package com.bookbox.common;

import java.sql.Date;

/**
 * @file com.bookbox.common.Log
 * @author jw
 * @brief Log Domain
 */
public class Log {
	
	/**
	 * @brief field
	 */
	private User user;
	private Date logRegDate;
	private int category;
	private int behavior;
	private int addBehavior;
	
	/**
	 * @brief constructor
	 */
	public Log() {
	}

	/**
	 * @brief method
	 */
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getLogRegDate() {
		return logRegDate;
	}

	public void setLogRegDate(Date logRegDate) {
		this.logRegDate = logRegDate;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getBehavior() {
		return behavior;
	}

	public void setBehavior(int behavior) {
		this.behavior = behavior;
	}

	public int getAddBehavior() {
		return addBehavior;
	}

	public void setAddBehavior(int addBehavior) {
		this.addBehavior = addBehavior;
	}
	
	
}
