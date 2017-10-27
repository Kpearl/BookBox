package com.bookbox.service.user.impl;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;

/**
 * 
 * @author JW
 *
 */
public class MailRunnableImpl implements Runnable {
	
	/* Field */
	private MailService mailService;
	private User user;
	
	/* Constructor */
	public MailRunnableImpl() {
		super();
	}
	
	public MailRunnableImpl(MailService mailService, User user) {
		this.mailService = mailService;
		this.user = user;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		while(true) {
			try {
				mailService.sendMail(user);
				break;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("메일전송실패! 재시도...");
			}
		}
	}

}
