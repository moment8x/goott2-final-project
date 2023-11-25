package com.project.controller.kkb.admin;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminOrderService;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/orders")
public class AdminOrderController {
	
	private final AdminOrderService adminOrderService;
	
		/* 전체 주문 조회 */
		@GetMapping("/search")
		public Map<String, Object> searchOrderInfo(
				@RequestParam String orderNo,
				@RequestParam String productOrderNo,
				@RequestParam String invoiceNumber,
				@RequestParam String name,
				@RequestParam String memberId,
				@RequestParam String email,
				@RequestParam String cellPhoneNumber,
				@RequestParam String phoneNumber,
				@RequestParam String payerName,
				@RequestParam String recipientName,
				@RequestParam String recipientPhoneNumber,
				@RequestParam String shippingAddress,
				@RequestParam String productName,
				@RequestParam String productId,
				@RequestParam String categoryKey,
				@RequestParam String orderTimeStart,
				@RequestParam String orderTimeEnd,
				@RequestParam String paymentTimeStart,
				@RequestParam String paymentTimeEnd) throws Exception {	

			OrderCondition orderCond = OrderCondition.create(
					orderNo,productOrderNo, invoiceNumber, name, memberId, 
					email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
					recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
					orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
			
			return adminOrderService.getOrderInfo(orderCond);
		}
		
		/* 입금 전 관리 */
		@GetMapping("/deposit")
		public Map<String, Object> searchDepositInfo(
				@RequestParam String orderNo,
				@RequestParam String productOrderNo,
				@RequestParam String invoiceNumber,
				@RequestParam String name,
				@RequestParam String memberId,
				@RequestParam String email,
				@RequestParam String cellPhoneNumber,
				@RequestParam String phoneNumber,
				@RequestParam String payerName,
				@RequestParam String recipientName,
				@RequestParam String recipientPhoneNumber,
				@RequestParam String shippingAddress,
				@RequestParam String productName,
				@RequestParam String productId,
				@RequestParam String categoryKey,
				@RequestParam String orderTimeStart,
				@RequestParam String orderTimeEnd,
				@RequestParam String confirmDateStart,
				@RequestParam String confirmDateEnd) throws Exception {	
		
			DepositCondition depositCond = DepositCondition.create(
					orderNo,productOrderNo, invoiceNumber, name, memberId, 
					email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
					recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
					orderTimeStart, orderTimeEnd, confirmDateStart, confirmDateEnd);
					
			return adminOrderService.getDepositInfo(depositCond);
		}
		
		/* 배송 준비중 관리 */
		@PostMapping("/ready")
		public Map<String, Object> searchReadyInfo(
				@RequestParam String orderNo,
				@RequestParam String productOrderNo,
				@RequestParam String invoiceNumber,
				@RequestParam String name,
				@RequestParam String memberId,
				@RequestParam String email,
				@RequestParam String cellPhoneNumber,
				@RequestParam String phoneNumber,
				@RequestParam String payerName,
				@RequestParam String recipientName,
				@RequestParam String recipientPhoneNumber,
				@RequestParam String shippingAddress,
				@RequestParam String productName,
				@RequestParam String productId,
				@RequestParam String categoryKey,
				@RequestParam String orderTimeStart,
				@RequestParam String orderTimeEnd,
				@RequestParam String paymentTimeStart,
				@RequestParam String paymentTimeEnd) throws Exception {	
			
			OrderCondition readyCond = OrderCondition.create(
					orderNo,productOrderNo, invoiceNumber, name, memberId, 
					email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
					recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
					orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
			
			return adminOrderService.getReadyInfo(readyCond);
		}
		
		/* 배송 준비중 관리 (송장번호 저장)*/
		@PutMapping("/invoice")
		public ResponseEntity<String> modifyInvoiceNumber(@RequestBody List<InvoiceCondition> invoiceCondList) throws Exception {	
			int result = adminOrderService.editInvoiceNumber(invoiceCondList);
			
			if (result > 0) {
		        return new ResponseEntity<>("Invoice number update successful", HttpStatus.CREATED);
		    } else {
		        return new ResponseEntity<>("Invoice number update failed", HttpStatus.BAD_REQUEST);
		    }
		}
}
