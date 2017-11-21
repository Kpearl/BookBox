package com.bookbox.service.creation.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
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
		PayInfo payInfo = new PayInfo();
		payInfo.setFundingNo(funding.getFundingNo());
		payInfo.setUser(user);
		
		funding = fundingDAO.getFunding(funding);
		
		if(fundingDAO.getPayInfo(payInfo) != null) {
			 funding.setDoFunding(true);
		}
		
		return funding;
	}

	@Override
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		Search search =(Search)map.get("search");
		int condition = Integer.parseInt(search.getCondition());
		
		Page page=(Page)map.get("page");
		page.setTotalCount(fundingDAO.getTotalFundingCount(map));
		System.out.println("getFundingList :: getTotalFundingCount ::"+page.getTotalCount());
			
		List<Funding> sendFundingList =new ArrayList<>();
		List<Funding> fundingList =fundingDAO.getFundingList(map);
		
		switch(condition) {
			case 3 : 
					for(Funding funding : fundingList) {
						map.put("targetNo", funding.getCreation().getCreationNo());
						funding.setCreation(creationDAO.getCreation(map));
						map.put("fundingNo", funding.getFundingNo());
						funding = this.getFunding((User)map.get("user"), funding);
						if (funding.isDoFunding()==true) {
							sendFundingList.add(funding);
						}
					}
				break;
			
			default :
				for(Funding funding : fundingList) {
					map.put("targetNo", funding.getCreation().getCreationNo());
					funding.setCreation(creationDAO.getCreation(map));
					map.put("fundingNo", funding.getFundingNo());
					funding.setPayInfoList(fundingDAO.getFundingUserList(map));
				}
				sendFundingList =fundingList;
				break;
		}
		return sendFundingList;
	}

	@Override
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		Page page=(Page)map.get("page");
		if (page != null) {
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

	@Override
	@Scheduled(cron="00 05 18 * * *")
	public void cancelFunding() throws Exception {
		// TODO Auto-generated method stub
		List<Funding> cancelFundingList = fundingDAO.getCancelFundingList();
		
		for(Funding funding: cancelFundingList) {
			//펀딩 달성율
			int percent = (funding.getPerFunding()*funding.getPayInfoList().size())/funding.getFundingTarget()*100;
			
			if(percent == 100) {//달성율100% 펀딩성공, active 값만 비활성화
				funding.setActive(0);
				fundingDAO.updateFunding(funding);
			
			}else {//펀딩실패
			fundingDAO.cancelFunding(funding);//펀딩참여자들 결제취소
			funding.setActive(0);//펀딩 active 비활성화 set
			fundingDAO.updateFunding(funding);
			List<PayInfo> payInfoList = fundingDAO.getFunding(funding).getPayInfoList();
			System.out.println("===========취소되는...펀딩참여자들...  "+payInfoList);
			
				for(PayInfo payInfo : payInfoList) {//펀딩참여자들 PayInfo delete
				fundingDAO.deletePayInfo(payInfo);
				}
			}
		}
		
		
		
	}
	
	

}
