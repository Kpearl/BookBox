package com.bookbox.common.service.impl;

import java.util.List;
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
	public void addReply(User user, Map<String, Object> map, Reply reply) {

		this.map = map;
		this.map.put("reply", reply);

		commonDAO.addReply(user, this.map);
	}

	@Override
	public void deleteReply(User user, Map<String, Object> map, Reply reply) {

		this.map = map;
		this.map.put("reply", reply);

		commonDAO.deleteReply(user, this.map);
	}

	@Override
	public List<Reply> getReplyList(User user, Map<String, Object> map) {
		
		this.map = map;
		
		return commonDAO.getReplyList(user, this.map);
	}

	@Override
	public void addGrade(User user, Map<String, Object> map, Grade grade) {

		this.map = map;
		this.map.put("grade", grade);

		commonDAO.addGrade(user, this.map);
	}

	@Override
	public Grade getGrade(User user, Map<String, Object> map) {

		this.map = map;
		
		return commonDAO.getGrade(user, this.map);
	}

	@Override
	public void addLike(User user, Map<String, Object> map, Like like) {

		this.map = map;
		this.map.put("like", like);

		commonDAO.addLike(user, this.map);
	}

	@Override
	public void deleteLike(User user, Map<String, Object> map) {

		this.map = map;

		commonDAO.deleteLike(user, this.map);
	}

	@Override
	public Like getLike(User user, Map<String, Object> map) {
		
		this.map = map;
		
		return commonDAO.getLike(user, this.map);
	}
}
