package com.project.service.kkb.admin;

import java.util.Map;

public interface AdminRewardService {

	/* 적립금 정보 및 내역 */
	Map<String, Object> getRewardInfo(String memberId);
}
