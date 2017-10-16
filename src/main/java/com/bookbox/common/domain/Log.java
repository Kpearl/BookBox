package com.bookbox.common.domain;

import java.sql.Date;

import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.domain.Log.java
 * @brief Log Domain
 * @detail
 * @author jw
 * @date 2017.10.11
 */

public class Log {
	
	/**
	 * @detail user : 누가, logRegDate : 언제, targetName : 어디서, behavior : 무엇을
	 */
	private User user;
	private Date logRegDate;
	private String targetName;
	private int behavior;
	private int addBehavior;
	private String log;


	public Log() {}
	
	public Log(User user, Date logRegDate, String targetName, int addBehavior, int behavior) {
		StringBuffer log = new StringBuffer();
		log.append(user.getNickname()+"님이 ")
			.append("")
			.append(targetName+"을(를) ");
		if(addBehavior != 0) {
			log.append(CommonUtil.getConstProp().getProperty("AB"+addBehavior)+"을(를) ");
		}
		log.append(CommonUtil.getConstProp().getProperty("B"+behavior)+"하였습니다.");
		
		this.log = log.toString();
	}


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

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
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
	
	public String getLog() {
		return log;
	}

	@Override
	public String toString() {
		return log;
	}
	
	
}
