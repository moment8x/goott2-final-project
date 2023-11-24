package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminRewardDAO;
import com.project.vodto.kkb.RewardInfoResponse;
import com.project.vodto.kkb.RewardListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminRewardServiceImpl implements AdminRewardService {
	
	private final AdminRewardDAO adminRewardRepository;
	
	@Override
	public Map<String, Object> getRewardInfo(String memberId) throws Exception {
		
		RewardInfoResponse rewardInfo = adminRewardRepository.findRewardInfoById(memberId);
		List<RewardListResponse> rewardList = adminRewardRepository.findRewardListById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("rewardInfo", rewardInfo);
		result.put("rewardList", rewardList);
		
		return result;
	}

}
