package com.project.controller.kym.admin;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kym.admin.AdminProductService;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kym.ProductsKym;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/admin/products")
public class AdminProductContoller {

	@Inject
	private AdminProductService adminProductService;
	

	@RequestMapping(value = "/count", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> countTotalProduct() throws Exception {
		System.out.println("상품전체");

		HttpHeaders header = new HttpHeaders();
		header.add("content-type", "application/json; charset=UTF-8");

		ResponseEntity<Map<String, Object>> result = null;

		try {
			Map<String, Object> map = adminProductService.getTotalProductCount();
			System.out.println(map);
			result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			// 예외가 발생하면 json으로 응답할 객체가 없기 때문에 상태코드만 전송
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	// 회원 정보 조회
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Map<String, Object> searchMemberInfo(@RequestBody ProductsKym productList) throws Exception {
		System.out.println("product:" + productList.toString());		

		return adminProductService.getProductInfo(productList);
	}
}