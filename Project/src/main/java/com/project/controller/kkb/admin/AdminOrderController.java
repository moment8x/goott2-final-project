package com.project.controller.kkb.admin;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminOrderService;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositProductCancelRequest;
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
		
		/* 입금 전 관리 (입금 확인 버튼)*/
		@PutMapping("/confirm")
		public ResponseEntity<String> setDepositConfirm(@RequestBody List<String> orderNoList) throws Exception {	
			int result = adminOrderService.editDepositConfirm(orderNoList);
			
			if (result > 0) {
		        return new ResponseEntity<>("Deposit confirmation update successful", HttpStatus.CREATED);
		    } else {
		        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
		    }
		} 
		
		/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
		@PutMapping("/cancel/order")
		public ResponseEntity<String> setDepositOrderCancel(
				@RequestBody List<String> orderNoList) throws Exception {	
			
			int result = adminOrderService.editDepositOrderCancel(orderNoList);
			
			if (result > 0) {
		        return new ResponseEntity<>("Order cancellation update successful", HttpStatus.CREATED);
		    } else {
		        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
		    }
		} 
		
		/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
		@PutMapping("/cancel/product")
		public ResponseEntity<String> setDepositProductCancel(
				@RequestBody List<DepositProductCancelRequest> productOrderNoList) throws Exception {	
			
			int result = adminOrderService.editDepositProductCancel(productOrderNoList);
			
			if (result > 0) {
		        return new ResponseEntity<>("Order cancellation by item update successful", HttpStatus.CREATED);
		    } else {
		        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
		    }
		} 
		
		/* 배송 준비중 관리 */
		@GetMapping("/ready")
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
		public ResponseEntity<String> setInvoiceNumber(@RequestBody List<InvoiceCondition> invoiceCondList) throws Exception {	
			int result = adminOrderService.editInvoiceNumber(invoiceCondList);
			
			if (result > 0) {
		        return new ResponseEntity<>("Invoice number update successful", HttpStatus.CREATED);
		    } else {
		    	return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
		    }
		}
}
