package com.bookbox.common.domain;

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
	private String logRegDate;
	private String targetName;
	private int categoryNo;
	private Object targetNo;
	private int behavior;
	private int addBehavior;


	public Log() {}
	

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getLogRegDate() {
		return logRegDate;
	}

	public void setLogRegDate(String logRegDate) {
		this.logRegDate = logRegDate;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
	
	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public Object getTargetNo() {
		return targetNo;
	}

	public void setTargetNo(Object targetNo) {
		this.targetNo = targetNo;
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

	@Override
	public String toString() {
		try {
			StringBuffer log = new StringBuffer();
			log.append(user.getNickname()+"님이 ")
				.append(CommonUtil.getConstProp().getProperty("C"+categoryNo)+" ")
				.append("'")
				.append(targetName+"'을(를) ");
			if(addBehavior != 0) {
				log.append(CommonUtil.getConstProp().getProperty("AB"+addBehavior)+"을(를) ");
			}
			log.append(CommonUtil.getConstProp().getProperty("B"+behavior)+"하였습니다.");
	
			return log.toString();
		}catch(Exception e) {
			return "Log [user=" + user + ", logRegDate=" + logRegDate + ", targetName=" + targetName + ", categoryNo="
					+ categoryNo + ", targetNo=" + targetNo + ", behavior=" + behavior + ", addBehavior=" + addBehavior
					+ "]";
		}
	}

	
}
