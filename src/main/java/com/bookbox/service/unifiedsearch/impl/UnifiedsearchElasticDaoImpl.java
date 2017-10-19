package com.bookbox.service.unifiedsearch.impl;

import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchElasticDaoImpl.java
 * @brief UnifiedsearchElasticDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.16
 */

@Service("unifiedsearchElasticDAOImpl")
public class UnifiedsearchElasticDaoImpl implements UnifiedsearchDAO {

	public UnifiedsearchElasticDaoImpl() {
		System.out.println("Constructor :: "+ this.getClass().getName());
	}

	@Override
	public void getCommunity(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getCreation(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getUnifiedsearchList(Search search) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getPosting(Search search) {
		// TODO Auto-generated method stub
		
	}

}
