package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Tag;

public interface TagService {

	public List<Tag> getTagList(Tag tag);
	
	public int addTagGroup(int category, int target, List<Tag> tagList);
	
	public List<Tag> getTagGroupList(int category, int target);
	
	public int updateTagGroup(int category, int target, List<Tag> tagList);
	
}
