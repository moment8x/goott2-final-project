package com.project.service.kkb.admin;

import java.util.Map;

public interface AdminPointService {

	/* 포인트 정보 및 내역 */
	Map<String, Object> getPointInfo(String memberId);

}
