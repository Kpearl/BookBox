package com.bookbox.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;
/**
 * @file com.bookbox.common.service.impl.TagDAOImpl.java
 * @brief Tag DAO Implement
 * @detail Tag DAO Implement
 * @author JW
 * @date 2017.10.16
 */

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
		int result = 0;
		try {
			result = sqlSession.insert("TagMapper.addTag", tag);
		}catch(DuplicateKeyException dke) {
			System.out.println("이미 존재하는 tag : " + tag.getTagName());
			tag.setTagNo( ((Tag)sqlSession.selectOne("TagMapper.getTag", tag)).getTagNo() );
			result = 1;
		}
		return result;
	}

	@Override
	public List<Tag> getTagList(Tag tag) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("TagMapper.getTagList", tag);
	}

	@Override
	public int addTagGroup(int category, int target, List<Tag> tagList) {
		// TODO Auto-generated method stub
		int result = 0;
		Map<String, Object> tagMap = null;
		for(Tag tag : tagList) {
			tagMap = this.mappingCategoryTarget(category, target);
			tagMap.put("tagNo", tag.getTagNo());
			result += sqlSession.insert("TagMapper.addTagGroup", tagMap);
		}
		
		return result;
	}

	@Override
	public List<Tag> getTagGroupList(int category, int target) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("TagMapper.getTagGroupList", this.mappingCategoryTarget(category, target));
	}

	@Override
	public int deleteTagGroup(int category, int target) {
		// TODO Auto-generated method stub
		return sqlSession.delete("TagMapper.deleteTagGroup", this.mappingCategoryTarget(category, target));
	}
	
	/**
	 * @brief category와 target을 Map에 넣어주는 method
	 * @param category
	 * @param target
	 * @return categoryNo와 targetNo를 포함한 Map
	 */
	public Map<String, Object> mappingCategoryTarget(int category, int target){
		Map<String, Object> tagMap = new HashMap<String, Object>();
		tagMap.put("categoryNo", category);
		tagMap.put("targetNo", target);
		
		return tagMap;
	}
	
}
