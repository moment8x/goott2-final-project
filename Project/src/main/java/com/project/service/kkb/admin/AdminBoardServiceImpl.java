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
	
	private final AdminBoardDAO adminBoardRepository;
	
	@Override
	public Map<String, Object> getPostInfo(PostCondition postCond) throws Exception {
		List<PostResponse> postList = adminBoardRepository.findPostByInfo(postCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("postList", postList);
		
		return result;
	}
	
}
