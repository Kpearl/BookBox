package com.bookbox.service.creation.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Page;
import com.bookbox.service.creation.CreationDAO;
import com.bookbox.service.creation.FundingDAO;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.impl.fundgingServiceImpl.java
 * @brief 펀딩 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Service("fundingServiceImpl")
public class FundingServiceImpl implements FundingService {
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("fundingDAOImpl")
	private FundingDAO fundingDAO;
	
	@Autowired
	@Qualifier("creationDAOImpl")
	private CreationDAO creationDAO;
	
	
	
	
	/**
	 * @brief Constructor
	 */
	public FundingServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public void addFunding(User user, Funding funding) throws Exception {
		// TODO Auto-generated method stub
		fundingDAO.addFunding(funding);		
	}

	@Override
	public void updateFunding(User user, Funding funding) throws Exception {
		// TODO Auto-generated method stub
		fundingDAO.addFunding(funding);		
	}

	@Override
	public Funding getFunding(User user, Funding funding) throws Exception {
		// TODO Auto-generated method stub
		funding = fundingDAO.getFunding(funding);
		
		return fundingDAO.getFunding(funding);
	}

	@Override
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		if (map.get("page") != null) {
			
			Page page=(Page)map.get("page");
			page.setTotalCount(fundingDAO.getTotalFundingCount(map));
			System.out.println("getFundingList :: getTotalFundingCount ::"+page.getTotalCount());
			}
		
		List<Funding> fundingList =fundingDAO.getFundingList(map);
		for(Funding funding : fundingList) {
			funding.setCreation(creationDAO.getCreation(map));	
		}

		return fundingList;
	}

	@Override
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		if (map.get("page") != null) {
			
			Page page=(Page)map.get("page");
			page.setTotalCount(fundingDAO.getTotalFundingUserCount(map));
			System.out.println("getFundingUserList :: getTotalFundingUserCount ::"+page.getTotalCount());
			}
							
		List<PayInfo> fundingUserList =fundingDAO.getFundingUserList(map);
		
		return fundingUserList;
	}

	@Override
	public void addPayInfo(User user, PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		fundingDAO.addPayInfo(payInfo);
	}

	@Override
	public void updatePayInfo(User user, PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		fundingDAO.updatePayInfo(payInfo);
	}

	@Override
	public PayInfo getPayInfo(User user, PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		return fundingDAO.getPayInfo(payInfo);
	}

}
