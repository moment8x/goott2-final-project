package com.project.controller.kkb.admin;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminOrderService;
import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CardCancelCondition;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.ProductCancelRequest;

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
			@RequestParam String paymentTimeEnd) {	

		OrderCondition orderCond = OrderCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
		
		return adminOrderService.getOrderInfo(orderCond);
	}
	
	/* 주문 상세 정보 */
	@GetMapping("/{orderNo}")
	public Map<String, Object> checkOrderDetail(@PathVariable("orderNo") String orderNo) {	
		return adminOrderService.getOrderDetailInfo(orderNo);
	}
	
	
	/* 주문 상세 정보 (입금전 처리 [결제완료 -> 입금전] ) 
	 * 배송 준비중 관리 (입금전 처리[결제완료 -> 입금전] */
	@PutMapping("/pending")
	public ResponseEntity<String> setPendingPayment(@RequestBody List<String> orderNoList) {	
		int result = adminOrderService.editPendingPayment(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Pending payment Processing Update Successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	} 
	
	/* 입금 전 관리 (조회) */
	@GetMapping("/pending")
	public Map<String, Object> searchPendingInfo(
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
			@RequestParam String confirmDateEnd) {	
	
		PendingCondition pendingCond = PendingCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, confirmDateStart, confirmDateEnd);
				
		return adminOrderService.getPendingInfo(pendingCond);
	}
	
	/* 입금 전 관리 (입금 확인 [입금전 -> 결제완료] ) 
	 * 배송 준비중 관리 (결제완료 처리[출고완료 -> 결제완료]) */
	@PutMapping("/PreShipped")
	public ResponseEntity<String> setPreShipped(@RequestBody List<String> orderNoList) {	
		int result = adminOrderService.editPreShipped(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Deposit confirmation update successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	} 
	
	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	@PutMapping("/PreShipped/o/cancel")
	public ResponseEntity<String> setPendingOrderCancel(
			@RequestBody List<String> orderNoList) {	
		
		int result = adminOrderService.editPendingOrderCancel(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Order cancellation update successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	} 
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	@PutMapping("/PreShipped/p/cancel")
	public ResponseEntity<String> setPendingProductCancel(
			@RequestBody List<ProductCancelRequest> productOrderNoList) {	
		
		int result = adminOrderService.editPendingProductCancel(productOrderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Order cancellation by item update successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	} 
	
	/* 배송 준비중 관리 (조회) */
	@GetMapping("/preparation")
	public Map<String, Object> searchPreparationInfo(
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
			@RequestParam String paymentTimeEnd) {	
		
		OrderCondition preparationCond = OrderCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
		
		return adminOrderService.getPreparationInfo(preparationCond);
	}
	
	/* 배송 준비중 관리 (송장번호 저장) */
	@PutMapping("/invoice")
	public ResponseEntity<String> setInvoiceNumber(@RequestBody List<InvoiceCondition> invoiceCondList) {	
		int result = adminOrderService.editInvoiceNumber(invoiceCondList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Invoice number update successful", HttpStatus.CREATED);
	    } else {
	    	return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	}
	
	/* 배송 준비중 관리 (출고완료 처리[결제완료 -> 출고완료]) 
	 * 배송 중 관리 (배송 준비중 처리[배송중 -> 출고완료]) */
	@PutMapping("/shipped")
	public ResponseEntity<String> setShipped(@RequestBody List<String> orderNoList) {	
		
		int result = orderNoList.get(0).contains("-") 
				? adminOrderService.editShippedByProductNo(orderNoList)
				: adminOrderService.editShippedByNo(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Shipment Processing Successful", HttpStatus.CREATED);
	    } else {
	    	return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	}
	
	/* 배송 준비중 관리 (배송중 처리[출고완료 -> 배송중]) */
	@PutMapping("/in-transit")
	public ResponseEntity<String> setInTransit(@RequestBody List<String> orderNoList) {	
		
		int result = orderNoList.get(0).contains("-") 
				? adminOrderService.editInTransitByProductNo(orderNoList)
				: adminOrderService.editInTransitByNo(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("in-transit Processing Successful", HttpStatus.CREATED);
	    } else {
	    	return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	}
	
	/* 배송 중 관리 (조회) */
	@GetMapping("/in-transit")
	public Map<String, Object> searchInTransitInfo(
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
			@RequestParam String paymentTimeEnd) {	
		
		OrderCondition inTransitCond = OrderCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
		
		return adminOrderService.getInTransitInfo(inTransitCond);
	}
	
	/* 배송 중 관리 (배송완료 처리[배송중 -> 배송완료]) */
	@PutMapping("/delivered")
	public ResponseEntity<String> setDelivered(@RequestBody List<String> orderNoList) {	

		int result = orderNoList.get(0).contains("-") 
				? adminOrderService.editDeliveredByProductNo(orderNoList)
				: adminOrderService.editDeliveredByNo(orderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Shipment Processing Successful", HttpStatus.CREATED);
	    } else {
	    	return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	}
	
	/* 배송 완료 조회 (조회) */
	@GetMapping("/delivered")
	public Map<String, Object> searchDeliveredInfo(
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
			@RequestParam String paymentTimeEnd) {	
		
		OrderCondition deliveredCond = OrderCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
		
		return adminOrderService.getDeliveredInfo(deliveredCond);
	}
	
	/* 입금 전 취소 관리 (조회) */
	@GetMapping("/cancel-deposit")
	public Map<String, Object> searchPendingCancelInfo(
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
			@RequestParam String orderTimeEnd) {	
	
		PendingCancelCondition pendingCancelCond = PendingCancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd);
				
		return adminOrderService.getPendingCancelInfo(pendingCancelCond);
	}
	
	/* 취소 관리 (조회) */
	@GetMapping("/cancel")
	public Map<String, Object> searchCancelInfo(
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
			@RequestParam String requestTimeStart,
			@RequestParam String requestTimeEnd,
			@RequestParam String completionTimeStart,
			@RequestParam String completionTimeEnd) {	
	
		CancelCondition cancelCond = CancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, requestTimeStart, requestTimeEnd, 
				completionTimeStart, completionTimeEnd);
				
		return adminOrderService.getCancelInfo(cancelCond);
	}
	
	/* 취소 처리 상세정보 */
	@GetMapping("/cancel/{productOrderNo}")
	public Map<String, Object> checkCancelDetail(@PathVariable("productOrderNo") String productOrderNo) {	
		return adminOrderService.getCancelDetailInfo(productOrderNo);
	}
	
	/* 주문 상세 정보(주문 취소) */
	@PutMapping("/cancel")
	public ResponseEntity<String> setProductCancel(
			@RequestBody List<ProductCancelRequest> productOrderNoList) {	
		
		int result = adminOrderService.getOrdersByStatus(productOrderNoList);
		
		if (result > 0) {
	        return new ResponseEntity<>("Order cancellation by item update successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("No orders were found to update", HttpStatus.NOT_FOUND);
	    }
	}  
	
	
	/* 교환 관리 (조회) */
	@GetMapping("/exchanges")
	public Map<String, Object> searchExchangeInfo(
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
			@RequestParam String requestTimeStart,
			@RequestParam String requestTimeEnd,
			@RequestParam String completionTimeStart,
			@RequestParam String completionTimeEnd) {	
	
		CancelCondition exchangeCond = CancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, requestTimeStart, requestTimeEnd, 
				completionTimeStart, completionTimeEnd);
				
		return adminOrderService.getExchangeInfo(exchangeCond);
	}
	
	/* 반품 관리 (조회) */
	@GetMapping("/returns")
	public Map<String, Object> searchReturnInfo(
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
			@RequestParam String requestTimeStart,
			@RequestParam String requestTimeEnd,
			@RequestParam String completionTimeStart,
			@RequestParam String completionTimeEnd) {	
	
		CancelCondition returnCond = CancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, requestTimeStart, requestTimeEnd, 
				completionTimeStart, completionTimeEnd);
				
		return adminOrderService.getReturnInfo(returnCond);
	}
	
	/* 환불 관리 (조회) */
	@GetMapping("/refunds")
	public Map<String, Object> searchRefundInfo(
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
			@RequestParam String requestTimeStart,
			@RequestParam String requestTimeEnd,
			@RequestParam String completionTimeStart,
			@RequestParam String completionTimeEnd) {	
	
		CancelCondition refundCond = CancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, requestTimeStart, requestTimeEnd, 
				completionTimeStart, completionTimeEnd);
				
		return adminOrderService.getRefundInfo(refundCond);
	}
	
	/* 카드 취소 조회 (조회) */
	@GetMapping("/card")
	public Map<String, Object> searchCardCancelInfo(
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
			@RequestParam String requestTimeStart,
			@RequestParam String requestTimeEnd,
			@RequestParam String completionTimeStart,
			@RequestParam String completionTimeEnd) {	
	
		CardCancelCondition cardCancelCond = CardCancelCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, requestTimeStart, requestTimeEnd, 
				completionTimeStart, completionTimeEnd);
				
		return adminOrderService.getCardCancelInfo(cardCancelCond);
	}
}
