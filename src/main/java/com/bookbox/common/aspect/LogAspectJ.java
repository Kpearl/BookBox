package com.bookbox.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public class LogAspectJ {
	
	public LogAspectJ() {
	}

	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable{
		
		System.out.println("\n[Around before] " + 
						joinPoint.getTarget().getClass().getName() + "." + 
						joinPoint.getSignature().getName() + "()" );
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] return value : " + obj + "\n");
		
		return obj;
	}
}
