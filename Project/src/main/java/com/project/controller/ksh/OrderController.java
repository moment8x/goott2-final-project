package com.project.controller.ksh;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.ksh.payment.OrderService;
import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.Member;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderHistory;
import com.project.vodto.OrderInfo;
import com.project.vodto.OrderInfo2;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;

@Controller
@RequestMapping(value = "/order/*")
public class OrderController {

	@Inject
	private OrderService os;

	// 회원인지 비회원인지 조회
	public void identifyMember() {
		// 회원 주문 페이지 or 비회원 주문 페이지 or 로그인 창 띄우기

	}

//	@RequestMapping(value = "requestOrder", method = RequestMethod.GET)
//	public String memberOrder(@RequestParam String orderId,
//			@RequestParam String nonOrder) {
//	}

	// 리스트, 상세 -> 결제 페이지
	@RequestMapping(value = "requestOrder")
	public void requestOrder(@RequestParam("productId") String productId, @RequestParam("qty") int qty, Model model, HttpServletRequest request) {
		String orderId = (String) request.getAttribute("orderId");
		String impKey = (String) request.getAttribute("impKey");
		List<String> oneProductId = new ArrayList<String>();
		oneProductId.add(productId);
		List<OrderInfo> productInfos = new ArrayList<OrderInfo>();
		PaymentDTO pd = new PaymentDTO();
		try {
			productInfos = os.getProductInfo(oneProductId);

			// 재고 조회
			if (productInfos.get(0).getCurrentQuantity() < 1) {
				productInfos.get(0).setAdequacy("N");
			} else {
				productInfos.get(0).setAdequacy("Y");
			}
			productInfos.get(0).setProductQuantity(1);
			productInfos.get(0).setCalculatedPrice(productInfos.get(0).getSellingPrice());
			if (productInfos.get(0).getSellingPrice() >= 10000) {
				pd.setShippingFee(0);
			} else {

				pd.setShippingFee(3000);
			}
			pd.setTotalAmount(productInfos.get(0).getSellingPrice());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("paymentInfo", pd);
		model.addAttribute("productInfos", productInfos);
		model.addAttribute("orderId", orderId);
		model.addAttribute("impKey", impKey);
	}

	// 장바구니 -> 결제 페이지
	@RequestMapping(value = "requestOrder", method = RequestMethod.POST)
	public String nonMemberOrder(Model model, OrderInfo2 items, HttpServletRequest request) {
		String path = "/order/requestOrder";
		
		String orderId = (String) request.getAttribute("orderId");
		String impKey = (String) request.getAttribute("impKey");
		System.out.println(items.toString());
		// 회원인지
		if(orderId.contains("O")) {
			// 쿠폰, 포인트, 적립금, 배송 주소록 
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("loginMember");
			try {
				List<ShippingAddress> shippingAddr = os.getShippingAddress(member.getMemberId());
//				List<ShippingAddress> otherAddr = new ArrayList<ShippingAddress>();
				
				
				for(ShippingAddress saddr : shippingAddr) {
					if(saddr.getBasicAddr() =='Y') {
						model.addAttribute("basicAddr", saddr);
					} 
				}
				model.addAttribute("member", member);
				model.addAttribute("shippingAddr", shippingAddr);
				System.out.println(shippingAddr.toString());
			    // 쿠폰이 한 개라도 있으면
				if(member.getCouponCount() > 0) {
					List<CouponInfos> couponInfos = os.getCouponInfos(member.getMemberId());
					model.addAttribute("couponInfos", couponInfos);
					System.out.println(couponInfos.toString());
					
				} 
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			path = "/order/requestOrder2";
		}

	
		List<String> productCategory = new ArrayList<String>();
		List<OrderInfo> productInfos = new ArrayList<OrderInfo>();
		PaymentDTO pd = new PaymentDTO();

		try {
			// 결제 페이지에 뿌려줄 상품 정보 가져오기
			productInfos = os.getProductInfo(items.getProductId()); // current_quantity 변경 예정(구매하려는 수량으로)

			int index = 0;
			int totalAmount = 0;

			// 재고 조회
			for (OrderInfo i : productInfos) {
				if (i.getCurrentQuantity() < items.getProductQuantity().get(index)) {
					i.setAdequacy("N");
				} else {
					i.setAdequacy("Y");
				}
				i.setProductQuantity(items.getProductQuantity().get(index));
				i.setCalculatedPrice(i.getProductQuantity() * i.getSellingPrice());
				
				productCategory.add(i.getCategoryKey());
				totalAmount += i.getCalculatedPrice();
				index++;
			}
			if (totalAmount >= 10000) {
				pd.setShippingFee(0);
			} else {
				pd.setShippingFee(3000);
			}
			pd.setTotalAmount(totalAmount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		model.addAttribute("productCategory", productCategory);
		model.addAttribute("paymentInfo", pd);
		model.addAttribute("orderId", orderId);
		model.addAttribute("productInfos", productInfos);
		model.addAttribute("impKey", impKey);
		System.out.println(productInfos.toString());

		return path;
	}

	@RequestMapping(value = "nonOrderComplete", method = RequestMethod.POST)
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
			if (os.saveNonOrderHistory(noh)) {
//				 결제랑 주문상세 조회
				Map<String, Object> paymentDetail = os.getPaymentDetail(noh.getNonOrderNo());
				System.out.println("paymentDetail 조회 - " + paymentDetail.toString());
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

	}
	
	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
	public void orderComplete(OrderHistory oh, Model model) {

		// 주문 결제 완료하고 주문 내역 창 띄우기

		System.out.println("결제 완료하고 주문 내역 저장하기");
		System.out.println(oh.toString());

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
			if (os.saveOrderHistory(oh)) {
//				 결제랑 주문상세 조회
				Map<String, Object> paymentDetail = os.getPaymentDetail(oh.getOrderNo());
//				List<DetailOrderItem>
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
