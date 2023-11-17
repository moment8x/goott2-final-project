package com.project.service.kym.admin;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;


import com.project.dao.kym.admin.AdminProductDAO;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kym.ProductsKym;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminProductServiceImpl implements AdminProductService {

	private final AdminProductDAO adminProductDAO;
	private final ProductCountListener ProductCount;
	private final ApplicationEventPublisher publisher;
	
	@Override
	public Map<String, Object> getTotalProductCount() throws Exception {
		int totalCount = 0;
		if(ProductCount.getCurrentCount() > 0) {
			// TotalMemberCountEvent에 저장해둔 값 가져옴
			System.out.println("이벤트 객체에서 전체 상품 조회");
			totalCount = ProductCount.getCurrentCount(); 
		} else {
			System.out.println("DB에서 전체 상품 조회");
			totalCount = adminProductDAO.countAll();	
			publisher.publishEvent(new TotalProductCountEvent(totalCount));
		}
		Map<String, Object> result = new HashMap<>();
		result.put("total", totalCount);
	
		
		return result;
	}

	@Override
	public Map<String, Object> getProductInfo(ProductsKym productList) {
		// TODO Auto-generated method stub
		return null;
	}


	
}
