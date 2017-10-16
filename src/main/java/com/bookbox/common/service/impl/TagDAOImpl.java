package com.bookbox.common.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;

@Repository("tagDAOImpl")
public class TagDAOImpl implements TagDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public TagDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public int addTag(Tag tag) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Tag> getTagList(Tag tag) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addTagGroup(int category, int target, List<Tag> tagList) {
		// TODO Auto-generated method stub
		return 15;
	}

	@Override
	public List<Tag> getTagGroupList(int category, int target) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteTagGroup(int category, int target, List<Tag> tagList) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
