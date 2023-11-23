package com.project.controller.kkb.admin;

import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminOrderService;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.OrderCondition;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/orders")
public class AdminOrderController {
	
	private final AdminOrderService adminOrderService;
	
		/* 전체 주문 조회 */
		@PostMapping("/search")
		public Map<String, Object> searchOrderInfo(@RequestBody OrderCondition orderCond) throws Exception {	
			return adminOrderService.getOrderInfo(orderCond);
		}
		
		/* 입금 전 관리 */
		@PostMapping("/deposit ")
		public Map<String, Object> searchDepositInfo(@RequestBody DepositCondition depositCond) throws Exception {	
			return adminOrderService.getDepositInfo(depositCond);
		}
}
