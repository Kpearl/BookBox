package com.bookbox.service.creation.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.creation.FundingDAO;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;

/**
 * @file com.bookbox.service.creation.impl.fundingDAOImpl.java
 * @brief 펀딩 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("fundingDAOImpl")
public class FundingDAOImpl implements FundingDAO {

	/**
	 * Field
	 */
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	/**
	 * Constructor
	 */
	public FundingDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public void addFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FundingMapper.addFunding", funding);
	}

	@Override
	public void updateFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FundingMapper.updateFunding", funding);
	}

	@Override
	public Funding getFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getFunding", funding);
	}

	@Override
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FundingMapper.getFundingList", map);
	}

	@Override
	public int getTotalFundingCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getTotalFundingCount", search);
	}

	@Override
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getTotalFundingUserCount", map);
	}

	@Override
	public int getTotalFundingUserCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getTotalFundingUserCount", search);
	}

	@Override
	public void addPayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FundingMapper.addPayInfo", payInfo);
	}

	@Override
	public void updatePayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FundingMapper.updatePayInfo", payInfo);
	}

	@Override
	public PayInfo getPayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getPayInfo", payInfo);
	}

	
}
