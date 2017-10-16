package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Tag;

public interface TagDAO {

	public int addTag(Tag tag);
	
	public List<Tag> getTagList(Tag tag);
	
	public int addTagGroup(int category, int target, List<Tag> tagList);
	
	public List<Tag> getTagGroupList(int category, int target);
	
	public int deleteTagGroup(int category, int target, List<Tag> tagList);
	
}
