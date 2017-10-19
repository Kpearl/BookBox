package com.bookbox.service.user.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.service.user.impl.MailServiceImpl.java
 * @brief 메일 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Service("mailServiceImpl")
public class MailServiceImpl implements MailService {

	@Value("#mail.properties['accountMail']")
	String accountMail;
	
	@Autowired
	@Qualifier("javaMailSenderImplGoogle")
	private 		JavaMailSender javaMailSender;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private 		UserService userService;	
	
	/**
	 * @brief sendMail/ 인증메일보내기
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void sendMail(User user) throws Exception{
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		
		//mimeMessage.setFrom(new InternetAddress("pmjahy@gmail.com"));
		//mimeMessage.addRecipient(RecipientType.TO, new InternetAddress("받는사람@naver.com"));

		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String certificationNo = String.valueOf(ran);
        
        Map<String, Object> map = new HashMap<>();
        map.put("certificationNo", certificationNo);
        map.put("email", user.getEmail());
        map.put("active", user.getActive());
        System.out.println("active 확인 :: "+user.getActive());
        System.out.println("email 확인 :: "+user.getEmail());
        System.out.println("certificationNo 확인 :: "+certificationNo);
        
        userService.updateActive(map);
       
        System.out.println("테스트No :: "+certificationNo);
		
		String mailText="<p>BookBox 홈페이지 인증번호 확인</p><p><br></p>";
					mailText +="<p>인증번호<br></p>";
					mailText +="<a href='http://127.0.0.1:8080/BookBox/user/checkCertNo?";
					mailText += "email="+user.getEmail();
					mailText += "&active=1&certificationNo="+certificationNo;
					mailText += "'>"+certificationNo+"</a>";
		
		System.out.println((int)Math.random()*10);
					
		mimeMessage.setFrom(new InternetAddress("hjryu124@gmail.com"));
		System.out.println("From :: "+mimeMessage.getFrom()[0]);
		mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(user.getEmail()));
		System.out.println("Recipient :: "+mimeMessage.getAllRecipients()[0]);
		mimeMessage.setSubject("BookBox 홈페이지 가입 인증메일입니다.","utf-8");
		System.out.println("Subject :: "+mimeMessage.getSubject().toString());
		mimeMessage.setText(mailText,"utf-8","html");
		System.out.println("Text :: "+mimeMessage.getContent());
		
		javaMailSender.send(mimeMessage);
		
		System.out.println("send MimeMessage");
	}
	
}
