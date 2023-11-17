package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminPointDAO;
import com.project.vodto.kkb.PointInfoResponse;
import com.project.vodto.kkb.PointListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminPointServiceImpl implements AdminPointService {

	private final AdminPointDAO adminPointRepository;
	
	@Override
	public Map<String, Object> getPointInfo(String memberId) throws Exception {
	
		PointInfoResponse pointInfo = adminPointRepository.findPointInfoById(memberId);
		List<PointListResponse> pointList = adminPointRepository.findPointListById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("pointInfo", pointInfo);
		result.put("pointList", pointList);
		
		return result;
	}

}
