package com.project.controller.kkb.admin;

import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminOrderService;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/orders")
public class AdminOrderController {
	
	private final AdminOrderService adminOrderService;
	
		// 전체 주문 조회
		@GetMapping("/search")
		public Map<String, Object> searchOrderInfo(@PathVariable("word") String word ) throws Exception {	
			
			return adminOrderService.getOrderInfo(word);
		}
}
