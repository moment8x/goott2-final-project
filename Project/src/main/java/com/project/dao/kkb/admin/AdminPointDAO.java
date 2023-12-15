package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.PointInfoResponse;
import com.project.vodto.kkb.PointListResponse;

public interface AdminPointDAO {
	
	/* 포인트 정보 */
	PointInfoResponse findPointInfoById(String memberId);
	
	/* 포인트 내역 */
	List<PointListResponse> findPointListById(String memberId);

}
