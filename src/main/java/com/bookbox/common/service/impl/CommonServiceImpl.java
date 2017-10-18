package com.bookbox.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.CommonService;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.impl.CommonServiceImpl.java
 * @brief CommonServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.18
 */

@Service("commonServiceImpl")
public class CommonServiceImpl implements CommonService {

	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;

	private Map<String, Object> map;

	public CommonServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void addReply(User user, Object no, int category_no, Reply reply) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);
		map.put("reply", reply);

		commonDAO.addReply(user, map);
	}

	@Override
	public void deleteReply(User user, Object no, int category_no, Reply reply) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);
		map.put("reply", reply);

		commonDAO.deleteReply(user, map);
	}

	@Override
	public Object getReplyList(User user, Object no, int category_no) {
		
		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);
		
		return commonDAO.getReplyList(user, map);
	}

	@Override
	public void addGrade(User user, Object no, int category_no, Grade grade) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);
		map.put("grade", grade);

		commonDAO.addGrade(user, map);
	}

	@Override
	public Object getGrade(User user, Object no, int category_no) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);

		return commonDAO.getGrade(user, map);
	}

	@Override
	public void addLike(User user, Object no, int category_no, Like like) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);
		map.put("like", like);

		commonDAO.addLike(user, map);
	}

	@Override
	public void deleteLike(User user, Object no, int category_no) {

		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);

		commonDAO.deleteLike(user, map);
	}

	@Override
	public Object getLike(User user, Object no, int category_no) {
		
		map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("category", category_no);

		return commonDAO.getLike(user, map);
	}
}
