package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import com.project.dao.kkb.admin.AdminMemoDAO;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoInfoCondition;
import com.project.vodto.kkb.MemoListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminMemoServiceImpl implements AdminMemoService {
	
	private final AdminMemoDAO adminMemoDAO;
	
	@Override
	public Map<String, Object> getMemoById(MemoInfoCondition memoInfoCond) {
		
		List<MemoListResponse> memoList = adminMemoDAO.findMemoById(memoInfoCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("memoList", memoList);
		
		return result;
	}

	@Override
	public int addMemberMemo(MemoCondition memoCond, HttpServletRequest req) {
		Memberkjy member = (Memberkjy) req.getSession().getAttribute("loginMember");
		
		if(member.getPermission().equals("ROLE_ADMIN")) {
			memoCond.setAdminId(member.getMemberId());
		} else {
			req.getSession().invalidate();
			throw new RuntimeException("권한 없음");
		}
		memoCond.setAdminId(member.getMemberId());
		int result = adminMemoDAO.saveMemberMemo(memoCond);
		
		return result;
	}

}
