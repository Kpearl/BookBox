package com.bookbox.common.aspect;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

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
	
	@Value("#{categoryProperties['creation']")
	private int creation;
	
	@Value("#{categoryProperties['writing']")
	private int writing;
	
	@Value("#{categoryProperties['funding']")
	private int funding;
	
	@Value("#{categoryProperties['booklog']")
	private int booklog;
	
	@Value("#{categoryProperties['posting']")
	private int posting;
	
	@Value("#{categoryProperties['board']")
	private int board;
	
	@Value("#{categoryProperties['camChat']")
	private int camChat;
	
	@Value("#{categoryProperties['cast']")
	private int cast;
	
	@Value("#{categoryProperties['book']")
	private int book;
	
	@Value("#{categoryProperties['unifiedSearch']")
	private int unifiedSearch;
	
	@Value("#{behaviorProperties['get']")
	private int get;
	
	@Value("#{behaviorProperties['join']")
	private int join;
	
	@Value("#{behaviorProperties['pay']")
	private int pay;
	
	@Value("#{behaviorProperties['add']")
	private int add;
	
	@Value("#{behaviorProperties['search']")
	private int search;
	
	@Value("#{behaviorProperties['update']")
	private int update;
	
	@Value("#{behaviorProperties['recommend']")
	private int recommend;
	
	@Value("#{behaviorProperties['delete']")
	private int delete;
	
	@Value("#{addBehaviorProperties['like']")
	private int like;
	
	@Value("#{addBehaviorProperties['subscribe']")
	private int subscribe;
	

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
