package com.project.controller.ksh;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.ksh.payment.OrderService;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;

@Controller
@RequestMapping(value = "/order/*")
public class OrderController {

	int count = 0;
	
	@Inject
	private PaymentController pc;

	@Inject
	private OrderService os;

	// 회원인지 비회원인지 조회
	public void identifyMember() {
		// 회원 주문 페이지 or 비회원 주문 페이지 or 로그인 창 띄우기

	}

	@RequestMapping(value = "memberOrder", method = RequestMethod.GET)
	public String memberOrder() {
		return "/order/memberOrder";
	}

	@RequestMapping(value = "nonMemberOrder", method = RequestMethod.POST)
	public String nonMemberOrder(Model model, @RequestParam String orderId, @RequestParam String orderItem) {
		
		// 결제페이지로 보내야함
		System.out.println(orderId);
		System.out.println(orderItem);
		
		if(orderItem != null ) {
			
			if(orderItem.contains(",")) {
				
			 String[] product_id = orderItem.split(",");
			 List<Product> productInfos = os.getProductInfo(product_id);
			 // 장바구니에서 넘어오게되면 객체를 받아서 상품테이블 조회
			 System.out.println(productInfos.toString());
			} 
		}
		model.addAttribute("impKey", "imp77460302");
		
		return "order/requestOrder";
	}
	
	
	

	
	
	

	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> orderComplete(NonOrderHistory noh, Model model) {

		// 비회원 주문 결제 완료하고 주문 내역 창 띄우기
		
		
		System.out.println("결제 완료하고 주문 내역 저장하기");
		System.out.println(noh.toString());

		PaymentDTO pd = pc.pdto;
		List<DetailOrderItem> itemList = pc.itemListdto;

		System.out.println(pd.toString());
		System.out.println(itemList.toString());
		if (pd.getPayment_method() != null) {
			if (pd.getPayment_method().equals("bkt")) {
				noh.setDelivery_status("입금확인중");
				pd.setPayment_method("무통장입금");
			}
		}
		
		try {
			// 주문내역 테이블 저장
			if(os.saveOrderHistory(noh)) {
				// 결제랑 주문상세 조회
				os.getPaymentDetail(noh.getNon_order_no());
				// 상품 재고 차감
				
				// 포인트랑 적립금이랑 쿠폰 차감은 어디서할지?
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return null;
		
	}

	@RequestMapping(value = "get/", method = RequestMethod.GET)
	public void getOrderHistory(@RequestParam("orderId") String orderId) {
		System.out.println("주문 내역 창 띄우기");
		try {
//			os.getOrderHistory();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
