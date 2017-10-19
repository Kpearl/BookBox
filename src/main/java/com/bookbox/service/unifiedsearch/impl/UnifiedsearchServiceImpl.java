package com.bookbox.service.unifiedsearch.impl;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchServiceImpl.java
 * @brief UnifiedsearchServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */

@Service("unifiedsearchServiceImpl")
public class UnifiedsearchServiceImpl implements UnifiedsearchService{

	public UnifiedsearchServiceImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
	}
	
	@Override
	public void getCommunityList(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getCreationList(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getUnifiedsearchList(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getPostingList(Search search) {
		// TODO Auto-generated method stub
		
	}

}
