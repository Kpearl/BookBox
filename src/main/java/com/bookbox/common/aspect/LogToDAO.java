package com.bookbox.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Log;
import com.bookbox.common.service.LogService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.common.aspect.LogToDAO.java
 * @author JW
 * @date 2017.10.10
 * @brief 
 */
public class LogToDAO {
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;
	
	public LogToDAO() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	public Object logWrite(ProceedingJoinPoint joinPoint) throws Throwable{

		String methodName = joinPoint.getSignature().getName();
		int categoryNo = parseCategoryToInt(methodName);
		int behavior = parseBehaviorToInt(methodName);
		int addBehavior = parseAddBehaviorToInt(methodName);

		Object obj = this.invoke(joinPoint);
		
		if(categoryNo == Const.NONE ||
				behavior == Const.NONE ||
				behavior == Const.Behavior.LIST ) {
			System.out.println("Log :: "+ methodName + " 로그를 남기지 않는 method");
		}else if( ((User)joinPoint.getArgs()[0]).getEmail() == null ){
			System.out.println("Log :: 비회원 로그는 남기지 않음");
		}else {
			System.out.println("Log :: 로그를 남기는 method");
			Object targetNo = getTargetNo(joinPoint.getArgs()[1]);
			
			Log log = new Log();
			log.setUser((User)joinPoint.getArgs()[0]);
			log.setCategoryNo(categoryNo);
			log.setBehavior(behavior);
			log.setAddBehavior(addBehavior);
			log.setTargetNo(targetNo);
			
			logService.addLog(log);
		}
		
		return obj;
	}
	
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable{
		
		System.out.println("[Around before] " + 
						joinPoint.getTarget().getClass().getName() + "." + 
						joinPoint.getSignature().getName() + "()" );
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] return value : " + obj);
		
		return obj;
	}

	public int parseCategoryToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=1; i<=10; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_C"+i))) {
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	public int parseBehaviorToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=0; i<=8; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_B"+i))) {
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	public int parseAddBehaviorToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=1; i<=4; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_AB"+i))) {
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	public Object getTargetNo(Object target) {
		
		Object targetNo = null;
		
		if(target instanceof Creation) {
			targetNo = ((Creation)target).getCreationNo();
		}else if(target instanceof Writing) {
			targetNo = ((Writing)target).getWritingNo();
		}else if(target instanceof Funding) {
			targetNo = ((Funding)target).getFundingNo();
		}else if(target instanceof Booklog) {
			targetNo = ((Booklog)target).getBooklogName();
		}else if(target instanceof Posting) {
			targetNo = ((Posting)target).getPostingNo();
		}else if(target instanceof Board) {
			targetNo = ((Board)target).getBoardNo();
		}else if(target instanceof Book) {
			targetNo = ((Book)target).getIsbn();
		}
		
		return targetNo;
	}
	
}
