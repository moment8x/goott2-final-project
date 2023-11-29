package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.RewardInfoResponse;
import com.project.vodto.kkb.RewardListResponse;

public interface AdminRewardDAO {
	
	/* 적립금 정보 */
	RewardInfoResponse findRewardInfoById(String memberId);
	
	/* 적립금 내역 */
	List<RewardListResponse> findRewardListById(String memberId);
}
