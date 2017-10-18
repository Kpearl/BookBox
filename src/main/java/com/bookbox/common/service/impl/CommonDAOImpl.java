package com.bookbox.common.service.impl;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.unifiedsearch.BookDaoImpl.java
 * @brief BookDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */
@Service("bookDAOImpl")
public class CommonDAOImpl implements CommonDAO {

	@Override
	public void addLike(User user, Object obj) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteLike(User user, Object obj) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addReply(User user, Object object, Reply reply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReply(User user, Object obj, Reply reply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addGrade(User user, Object obj, Grade grade) {
		// TODO Auto-generated method stub
		
	}
}
