package com.project.service.ksh.payment;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mchange.v2.sql.filter.SynchronizedFilterDataSource;
import com.project.dao.ksh.order.OrderDAO;
import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderHistory;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.CompleteOrder;
import com.project.vodto.ksh.CompleteOrderItem;
import com.project.vodto.ksh.OrderInfo;
import com.project.vodto.ksh.PaymentDTO;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderDAO od;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean savePayment(PaymentDTO pd, List<DetailOrderItem> itemList, Memberkjy memberInfo) throws Exception {
		boolean result = false;
		boolean orderHistory = false;

		if (pd.getPaymentMethod().equals("point")) { // method set
			if (pd.getCardName() == null) {
				pd.setPaymentMethod("kakaoPay");
			} else {
				pd.setPaymentMethod("naverPay");
			}
		}

		// 무통장 입금이거나 재화만으로 결제했을 때
		if (pd.getPaymentNumber().contains("bkt") || pd.getPaymentNumber().contains("ptr")) {
			pd.setPaymentTime(new Timestamp(System.currentTimeMillis())); // 결제 시간 null이어서 set
			pd.setPaymentStatus("입금전");
			if (pd.getPaymentNumber().contains("ptr")) {
				pd.setPaymentStatus("결제완료");
			}
			if (od.insertNewPayment(pd) > 0) { // 결제
				System.out.println("결제 테이블 저장");
            if (pd.getOrderHistory() != null) { // 회원 주문내역
               pd.getOrderHistory().setDeliveryStatus(pd.getPaymentStatus());
               pd.getOrderHistory().setOrderNo(pd.getOrderNo());
               pd.getOrderHistory().setMemberId(pd.getMemberId());
               this.saveOrderHistory(pd.getOrderHistory());
               orderHistory = true;
            } else { // 비회원 주문내역
               pd.getNonOrderHistory().setNonDeliveryStatus(pd.getPaymentStatus());
               pd.getNonOrderHistory().setNonOrderNo(pd.getNonOrderNo());
               this.saveNonOrderHistory(pd.getNonOrderHistory());
               orderHistory = true;
            }
				if (orderHistory) {
					if (od.saveDetailItems(itemList) > 0) { // 주문 상세
						System.out.println("주문 상세 테이블 저장");
						if (pd.getPaymentNumber().contains("bkt")) {
							pd.setDepositedAccount(pd.getDepositedAccount()+" 123-456-789012");
							if (od.saveBankTransfer(pd) > 0) {
								System.out.println("무통장 입금 테이블 저장");
								System.out.println(od.deleteShoppingCart(pd, itemList));
							}
						}

					}
				}
			}
			if (updateDiscountMethod(pd, itemList)) {
				result = true;
				System.out.println("여기까지 오나?");
			}
		} else { // 카드 및 간편결제
			pd.setPaymentStatus("결제완료");
			if (od.insertNewPayment(pd) > 0) { // 결제
				System.out.println("결제완료!" + pd.toString());
				System.out.println(itemList.toString());
				if (pd.getOrderHistory() != null) { // 회원 주문내역
					pd.getOrderHistory().setDeliveryStatus(pd.getPaymentStatus());
					pd.getOrderHistory().setOrderNo(pd.getOrderNo());
					pd.getOrderHistory().setMemberId(pd.getMemberId());
					if (this.saveOrderHistory(pd.getOrderHistory())) {
						orderHistory = true;
					}
				} else { // 비회원 주문내역
					pd.getNonOrderHistory().setNonDeliveryStatus(pd.getPaymentStatus());
					pd.getNonOrderHistory().setNonOrderNo(pd.getNonOrderNo());
					if (this.saveNonOrderHistory(pd.getNonOrderHistory())) {
						orderHistory = true;
					}
				}
				if (orderHistory) {
					if (od.saveDetailItems(itemList) > 0) { // 주문 상세
						System.out.println("주문 상세 테이블 저장");
						if (updateDiscountMethod(pd, itemList)) {
							System.out.println(od.deleteShoppingCart(pd, itemList));
							result = true;
						
						}
					}
				}
			}
		}
		return result;
	}

	@Override
	public List<DetailOrderItem> compareAmount(PaymentDTO pd, List<DetailOrderItem> itemList, Memberkjy memberInfo) {

		boolean result = false;
		int realAmount = 0;
		int totalAmount = 0;
		int couponDiscount = 0;
		boolean isValidPoint = false;
		boolean isValidReward = false;

		List<DetailOrderItem> renewaledList = null;
		List<String> productId = new ArrayList<String>();
		List<Integer> productQuantity = new ArrayList<Integer>();

		try {
			for (DetailOrderItem item : itemList) {
				productId.add(item.getProductId());
				productQuantity.add(item.getProductQuantity());
				if (pd.getPaymentMethod().equals("bkt")) {
					item.setProductStatus("입금전");
				} else {
					item.setProductStatus("결제완료");
				}
				item.setCouponDiscount(0);
			}
			List<OrderInfo> products = od.getProductInfo(productId);
			System.out.println("products : " + products.toString());
			int qty = 0;
			for (OrderInfo product : products) {
				product.setProductQuantity(productQuantity.get(qty));
				product.setCalculatedPrice(product.getSellingPrice() * product.getProductQuantity());
				totalAmount += product.getCalculatedPrice();
				qty++;
			}
			if (memberInfo != null) {
				// 넘어온 쿠폰넘버를 이 회원이 가지고 있는지 조회
				if (!pd.getCouponNumbers().get(0).equals("N")) {
					// 쿠폰 사용

					List<CouponInfos> couponInfos = od.getCouponInfos(memberInfo.getMemberId());
					couponInfos = od.addCategoryKey(couponInfos);
					System.out.println("couponInfos!!!!!!!!!!!!!" + couponInfos.toString());

					for (CouponInfos couponInfo : couponInfos) {

						// 넘어온 쿠폰번호와 멤버가 가지고 있는 쿠폰번호가 일치하는지
						for (int i = 0; i < pd.getCouponNumbers().size(); i++) {
							if (pd.getCouponNumbers().get(i).equals(couponInfo.getCouponNumber())) {
								System.out.println("넘어온 쿠폰번호랑 멤버가 가지고 있는 쿠폰번호랑 같음!");
								for (int j = 0; j < products.size(); j++) { // 상품 종류만큼 반복
									// 쿠폰적용카테고리와 상품카테고리가 일치하는지

									if (couponInfo.getCategoryKey().contains(products.get(j).getCategoryKey())
											|| couponInfo.getCategoryKey().contains("ALL")) {
										System.out.println("ALL 카테고리 적용쿠폰이거나 쿠폰 카테고리 일치!");
										System.out.println("couponDiscount!" + couponDiscount);
										System.out.println("검증 다 통과한 쿠폰! : " + couponInfo.toString());
										System.out.println(products.get(j).getCalculatedPrice());
										if (couponInfo.getCategoryKey().contains(products.get(j).getCategoryKey())) {

											int calcAmount = (int) Math.round((products.get(j).getCalculatedPrice()
													* (double) couponInfo.getDiscountAmount() / 100) / 10) * 10;

											// 주문 상세 상품의 쿠폰 할인 금액을 위한 코드를 짜야함
											if (itemList.get(j).getCouponDiscount() > 0) {

												itemList.get(j).setCouponDiscount(
														itemList.get(j).getCouponDiscount() + calcAmount);

											} else {
												itemList.get(j).setCouponDiscount(calcAmount);
											}

											System.out.println(products.get(j).getProductName() + "의 쿠폰 할인 금액은 : "
													+ itemList.get(j).getCouponDiscount());

											couponDiscount += calcAmount;// 테스트땜에 주석처리함 다시
											// 풀어야해!!!!!!!!!!!!!!!!!!!!!!!!!!!
											// couponDiscount = 0;
										}

										// couponDiscount += (int)Math.round((totalAmount *
										// (double)couponInfo.getDiscountAmount()/100) / 10) * 10;

										// System.out.println("" + totalAmount + "," + couponInfo.getDiscountAmount() /
										// 100 + "," + (totalAmount * (couponInfo.getDiscountAmount() / 100)));
										// couponDiscount += (totalAmount * (couponInfo.getDiscountAmount() / 100));
										System.out.println("couponDiscount!" + couponDiscount);

									}
								}
							}
						}
					}
				}

			} else { // 비회원일 때
				pd.setUsedPoints(0);
				pd.setUsedReward(0);
				couponDiscount = 0;
			}
			// 배송비 설정
			if (totalAmount >= 10000) {
				pd.setShippingFee(0);
			} else {
				pd.setShippingFee(3000);
			}

			// 넘어온 포인트와 적립금을 가지고 있는지 조회
			if (pd.getUsedPoints() != 0) {
				if (memberInfo.getTotalPoints() >= pd.getUsedPoints()) {
					isValidPoint = true;
				}
			} else {
				isValidPoint = true;
			}

			if (pd.getUsedReward() > 0) {
				if (memberInfo.getTotalRewards() >= pd.getUsedReward()) {
					isValidReward = true;
				}
			} else {
				isValidReward = true;
			}

			if (isValidPoint && isValidReward) {

				realAmount = totalAmount + pd.getShippingFee() - pd.getUsedPoints() - pd.getUsedReward()
						- couponDiscount;
				if (pd.getPaymentNumber().contains("bkt")) {
					if (pd.getAmountToPay() == realAmount) {
						result = true;
					}
					System.out.println("무통장 내야 할 금액! : " + pd.getAmountToPay() + ", 검증 된 금액! : " + realAmount);
				} else {
					if (pd.getActualPaymentAmount() == realAmount) {
						result = true;

					}
					System.out.println("결제 한 금액! : " + pd.getActualPaymentAmount() + ", 검증 된 금액! : " + realAmount);
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result) {
			System.out.println("결제 해야 할 금액과 실 결제 금액 일치 - 검증 완료");
			renewaledList = itemList;
		} else {
			System.out.println("금액 불일치!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
		return renewaledList;

	}

	@Override
	public Map<String, Object> getPaymentDetail(NonOrderHistory noh, List<String> productId) throws Exception {
		// 비회원 결제 가져오기
		Map<String, Object> paymentDetail = new HashMap<String, Object>();
		CompleteOrder completeOrder = null;
		completeOrder = od.getPaymentHistory(noh.getNonOrderNo());
		completeOrder.setNonRecipientName(noh.getNonRecipientName());
		completeOrder.setNonRecipientPhoneNumber(noh.getNonRecipientPhoneNumber());
		completeOrder.setNonShippingAddress(noh.getNonShippingAddress());
		completeOrder.setNonDetailedShippingAddress(noh.getNonDetailedShippingAddress());
		if (completeOrder != null) {
			System.out.println(completeOrder.toString());
			List<CompleteOrderItem> itemDetail = od.getDetailOrderItem(noh.getNonOrderNo(), productId);
			for (CompleteOrderItem item : itemDetail) {
				item.setCalculatedPrice(item.getProductPrice() * item.getProductQuantity());
			}

			if (completeOrder.getTotalAmount() < 10000) {
				System.out.println("10000원 미만 상품");
			} else if (completeOrder.getActualPaymentAmount() != 0) { // 무통장, 재화 제외
				completeOrder
						.setDiscountAmount(completeOrder.getTotalAmount() - completeOrder.getActualPaymentAmount());
			} else { // 무통장, 재화
				completeOrder.setDiscountAmount(completeOrder.getTotalAmount() - completeOrder.getAmountToPay());
			}
			paymentDetail.put("detailOrderItem", itemDetail);
			paymentDetail.put("paymentHistory", completeOrder);
			System.out.println(paymentDetail.toString());
		}
		;
		return paymentDetail;

	}

	@Override
	public Map<String, Object> getPaymentDetail(String orderNo) throws Exception {
		Map<String, Object> paymentDetail = new HashMap<String, Object>();
		// 결제 가져오기

		CompleteOrder completeOrder = null;
		// 상품 id 가져오기
		List<String> productId = od.getProductIds(orderNo);
		System.out.println(productId);

		// 배송지, 결제 관련 정보 가져오기 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!추가 수정 필요
		completeOrder = od.getPaymentHistory(orderNo);
		System.out.println(completeOrder.toString());
//      completeOrder.setRecipientName(oh.getRecipientName());
//      completeOrder.setRecipientPhoneNumber(oh.getRecipientPhoneNumber());
//      completeOrder.setShippingAddress(oh.getShippingAddress());
//      completeOrder.setDetailedShippingAddress(oh.getDetailedShippingAddress());
		if (completeOrder != null) {
			System.out.println(completeOrder.toString());
			List<CompleteOrderItem> itemDetail = od.getDetailOrderItem(orderNo, productId);
			for (CompleteOrderItem item : itemDetail) {
				item.setCalculatedPrice(item.getProductPrice() * item.getProductQuantity());
			}
			if (completeOrder.getActualPaymentAmount() != 0) {
				completeOrder
						.setDiscountAmount(completeOrder.getTotalAmount() - completeOrder.getActualPaymentAmount());
			} else {
				completeOrder.setDiscountAmount(completeOrder.getTotalAmount() - completeOrder.getAmountToPay());
				System.out.println("ptr일 때 : " + completeOrder.getAmountToPay());
			}

			paymentDetail.put("detailOrderItem", itemDetail);
			paymentDetail.put("paymentHistory", completeOrder);
			System.out.println(paymentDetail.toString());
		}
		;
		return paymentDetail;
	}

//   @Override
//   public Map<String, Object> getPaymentDetail(OrderHistory oh, List<String> productId) throws Exception {
//      Map<String, Object> paymentDetail = new HashMap<String, Object>();
//      // 결제 가져오기
//      System.out.println(oh.toString());
//      
//      CompleteOrder completeOrder = null;
//      // 상품 id 가져오기
//      productId = od.getProductIds(oh.getOrderNo());
//      System.out.println(productId);
//      
//      // 배송지, 결제 관련 정보 가져오기 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!추가 수정 필요
//      completeOrder = od.getPaymentHistory(oh.getOrderNo());
//      System.out.println(completeOrder.toString());
////      completeOrder.setRecipientName(oh.getRecipientName());
////      completeOrder.setRecipientPhoneNumber(oh.getRecipientPhoneNumber());
////      completeOrder.setShippingAddress(oh.getShippingAddress());
////      completeOrder.setDetailedShippingAddress(oh.getDetailedShippingAddress());
//      if (completeOrder != null) {
//         System.out.println(completeOrder.toString());
//         List<CompleteOrderItem> itemDetail = od.getDetailOrderItem(oh.getOrderNo(), productId);
//         for(CompleteOrderItem item : itemDetail) {
//            item.setCalculatedPrice(item.getProductPrice()*item.getProductQuantity());
//         }
//         if(completeOrder.getActualPaymentAmount()!=0) {
//            completeOrder.setDiscountAmount(completeOrder.getTotalAmount()-completeOrder.getActualPaymentAmount());
//         } else {
//            completeOrder.setDiscountAmount(completeOrder.getTotalAmount()-completeOrder.getAmountToPay());
//            System.out.println("ptr일 때 : "+completeOrder.getAmountToPay());
//         }
//         
//         paymentDetail.put("detailOrderItem", itemDetail);
//         paymentDetail.put("paymentHistory", completeOrder);
//         System.out.println(paymentDetail.toString());
//      }
//      ;
//      return paymentDetail;
//   }

	@Override
	public List<OrderInfo> getProductInfo(List<String> productId) throws Exception {
		List<OrderInfo> productInfos = od.getProductInfo(productId);
		return productInfos;
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) throws Exception {
		// 회원 배송 주소록 가져오기

		return od.getShippingAddr(memberId);
	}

	@Override
	public List<CouponInfos> getCouponInfos(String memberId) throws Exception {
		// CouponInfos와 List<String> categoryKey 가져오기

		List<CouponInfos> couponInfos = od.getCouponInfos(memberId);
		od.addCategoryKey(couponInfos);

		return couponInfos;
	}

	@Override
	public boolean saveOrderHistory(OrderHistory oh) throws Exception {
		boolean result = false;
		if (od.insertNewOrderHistory(oh) > 0) {
			System.out.println("회원 주문내역 테이블 저장 성공");

			result = true;
		}
		; // 1이 나오면 성공
		return result;
	}

	@Override
	public boolean saveNonOrderHistory(NonOrderHistory noh) throws Exception {
		boolean result = false;

		if (od.insertNewNonOrderHistory(noh) > 0) {
			System.out.println("주문내역 테이블 저장 성공");

			result = true;
		}
		; // 1이 나오면 성공

		System.out.println("result 값 : " + result);
		return result;
	}

	/**
	 * @MethodName : updateDiscountMethod
	 * @author : ksh
	 * @param pd
	 * @return
	 * @throws Exception
	 * @returnValue :
	 * @description : 쿠폰, 포인트, 적립금, 멤버, 상품테이블 update
	 * @date : 2023. 11. 13.
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateDiscountMethod(PaymentDTO pd, List<DetailOrderItem> itemList) throws Exception {
		// 쿠폰, 포인트, 적립금, 멤버, 재고
		boolean result = false;
		if (pd.getCouponNumbers() != null) {
			for (String coupon : pd.getCouponNumbers()) {
				// ex) coupon : C0001
				if (coupon != "N") {
					if (od.updateCouponLogs(pd) > 0) { // 쿠폰로그 update
						System.out.println("쿠폰" + pd.getCouponNumbers().size() + "개 사용해서 update 완료");
						od.updateMemberCoupon(pd); // 멤버 쿠폰 갯수 update
						break;
					}
				}
			}
		}

		if (pd.getUsedPoints() != 0) {
			// 멤버 포인트 update
			if (od.updateMemberPoints(pd) > 0) {
				if (od.updatePointLogs(pd) > 0) {
					// 포인트로그 update
					System.out.println("포인트 업데이트 완료");
				}

			}
		}

		if (pd.getUsedReward() != 0) { // 적립금로그 update

			if (od.updateMemberRewards(pd) > 0) {
				if (od.updateRewardLogs(pd) > 0) {
					System.out.println("적립금 업데이트 완료");
				}
				; // 멤버 적립금 update
			}
		}

		if (od.updateProducts(itemList) > 0) { // 상품 재고 update
			System.out.println("재고 업데이트 완료");
			if (pd.getMemberId() != null) {

				if (od.updateMemberAcumPayment(pd.getActualPaymentAmount(), pd.getMemberId()) > 0) {

					result = true;
				}
			} else {
				result = true;
			}
		}

		return result;
	}

	@Override
	public Memberkjy getMemberInfo(String memberId) throws Exception {

		return od.getMemberInfo(memberId);
	}

}