package com.project.controller.ksh;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.ksh.payment.OrderService;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderInfo;
import com.project.vodto.OrderInfo2;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;

@Controller
@RequestMapping(value = "/order/*")
public class OrderController {

	@Inject
	private OrderService os;

	// 회원인지 비회원인지 조회
	public void identifyMember() {
		// 회원 주문 페이지 or 비회원 주문 페이지 or 로그인 창 띄우기

	}

	@RequestMapping(value = "requestOrder", method = RequestMethod.GET)
	public String memberOrder(@RequestParam String orderId,
			@RequestParam String nonOrder) {

		
		return "/order/requestOrder";
	}

	@RequestMapping(value = "requestOrder", method = RequestMethod.POST)
	public String nonMemberOrder(Model model, OrderInfo2 items, @RequestParam String orderId,
			@RequestParam String nonOrder) {
		

		items.setNon_order_no(orderId);

//		if (orderId.contains("N") && nonOrder.equals("false")) {
//			// 로그인 회원가입 페이지로 보내기
//			model.addAttribute("orderItem", orderItem);
//			return "/order/loginOrRegister";
//		} else {
		// 비회원 주문
		// 결제페이지로 보내야함
		System.out.println("items : " + items.toString());

		List<OrderInfo> productInfos = new ArrayList<OrderInfo>();

		try {
		
			// 결제 페이지에 뿌려줄 상품 정보 가져오기
			productInfos = os.getProductInfo(items.getProduct_id()); // current_quantity 변경 예정(구매하려는 수량으로)
			
			int index = 0;
			
			// 재고 조회
			for(OrderInfo i : productInfos) {
				if(i.getCurrent_quantity() < items.getProduct_quantity().get(index)) {
					i.setAdequacy("N");
				} else {
					i.setAdequacy("Y");
				}
				i.setProduct_quantity(items.getProduct_quantity().get(index));
				i.setCalculated_price(i.getProduct_quantity()*i.getSelling_price());
				index++;
			}
			System.out.println("productInfos : " +productInfos.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		model.addAttribute("impKey", "imp77460302");
		model.addAttribute("orderId", orderId);
		model.addAttribute("nonOrder", nonOrder);
		model.addAttribute("productInfos", productInfos);
		// }

		return "/order/requestOrder";
	}

	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
	public void orderComplete(NonOrderHistory noh, Model model) {

		// 비회원 주문 결제 완료하고 주문 내역 창 띄우기

		System.out.println("결제 완료하고 주문 내역 저장하기");
		System.out.println(noh.toString());

//		System.out.println(pd.toString());
//		System.out.println(itemList.toString());
//		if (pd.getPayment_method() != null) {
//			if (pd.getPayment_method().equals("bkt")) {
//				noh.setDelivery_status("입금확인중");
//				pd.setPayment_method("무통장입금");
//			}
//		}

		try {
			// 주문내역 테이블 저장
			if (os.saveOrderHistory(noh)) {
//				 결제랑 주문상세 조회
				Map<String, Object> paymentDetail = os.getPaymentDetail(noh.getNon_order_no());
				System.out.println("paymentDetail 조회 - " + paymentDetail.toString());
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

	}

//	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> orderComplete(NonOrderHistory noh, Model model) {
//
//		// 비회원 주문 결제 완료하고 주문 내역 창 띄우기
//		
//		
//		System.out.println("결제 완료하고 주문 내역 저장하기");
//		System.out.println(noh.toString());
//
//
//
////		System.out.println(pd.toString());
////		System.out.println(itemList.toString());
////		if (pd.getPayment_method() != null) {
////			if (pd.getPayment_method().equals("bkt")) {
////				noh.setDelivery_status("입금확인중");
////				pd.setPayment_method("무통장입금");
////			}
////		}
//		
//		try {
//			// 주문내역 테이블 저장
//			if(os.saveOrderHistory(noh)) {
//				
//				// 결제랑 주문상세 조회
//				//os.getPaymentDetail(noh.getNon_order_no());
//				// 상품 재고 차감
//				
//				// 포인트랑 적립금이랑 쿠폰 차감은 어디서할지?
//			}
//			
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			
//		}
//		
//		return orderComplete;
//		
//	}

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
