package com.project.service.kkb.admin;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminOrderDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderRepository;
	
	@Override
	public Map<String, Object> getOrderInfo(String word) throws Exception {
		
		return null;
	}

}
