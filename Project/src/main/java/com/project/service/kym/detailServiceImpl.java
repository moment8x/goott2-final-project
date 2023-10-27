package com.project.service.kym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kym.DetailDAO;
import com.project.vodto.Product;

@Service  // 아래의 객체가 Service 객체임을 명시
public class detailServiceImpl implements detailService {
	
	@Inject
	private DetailDAO Ddao;


	@Override
	public Map<String, Object> getProductId(String productId, String ipAddr) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Product product = Ddao.selectDetailNO(productId);
//		System.out.println(product);
		
		result.put("product", product);

		return result;
		
	}
	
	

}
