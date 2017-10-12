package com.bookbox.common.aspect;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import com.bookbox.common.domain.Const;
import com.bookbox.common.log.LogService;

/**
 * @file com.bookbox.common.aspect.LogToDAO.java
 * @author jw
 * @date 2017.10.10
 * @brief 
 */
public class LogToDAO {
	
	/**
	 * @brief Field
	 */
	
	@Autowired
	@Qualifier("logService")
	private LogService logService;
	

	/**
	 * @brief Constructor
	 */
	public LogToDAO() {
		System.out.println("\n"+this.getClass()+"\n");
	}
	
	
	/**
	 * @brief Method
	 */
	
	
	
}
