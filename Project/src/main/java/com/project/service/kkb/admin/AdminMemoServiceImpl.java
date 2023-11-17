package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.project.dao.kkb.admin.AdminMemoDAO;
import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminMemoServiceImpl implements AdminMemoService {
	
	private final AdminMemoDAO adminMemoDAO;
	
	@Override
	public Map<String, Object> getMemoById(MemoCondition memoCond) throws Exception {
		
		List<MemoResponse> memoList = adminMemoDAO.findMemoById(memoCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("memoList", memoList);
		
		return result;
	}

}
