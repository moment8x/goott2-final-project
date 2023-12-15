package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminBoardDAO;
import com.project.vodto.kkb.PostCondition;
import com.project.vodto.kkb.PostResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminBoardServiceImpl implements AdminBoardService {
	
	private final AdminBoardDAO adminBoardDao;
	
	@Override
	public Map<String, Object> getPostInfo(PostCondition postCond) {
		List<PostResponse> postList = adminBoardDao.findPostByInfo(postCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("postList", postList);
		
		return result;
	}
	
}
