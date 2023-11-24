package com.project.controller.ksh;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.ksh.payment.OrderService;
import com.project.service.ksh.sms.SmsService;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.MessageDTO;
import com.project.vodto.ksh.OrderInfo;
import com.project.vodto.ksh.PaymentDTO;
import com.project.vodto.ksh.SmsResponseDto;
import com.project.vodto.CancelDatas;
import com.project.vodto.DetailOrderItem;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@RestController
@RequestMapping("/pay/*")
public class PaymentController {

	private IamportClient api;

	public PaymentController() {
		// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("6208485383120734",
				"LhGS6esknLSY3r3YH0Dtvh65MXPpP27VLL8F6FKcavXsrJKrmkuvUcjUxjLWYTTvZLeCxAMJXSjSaHcU");
	}

	@Inject
	private OrderService os;

	@Inject
	private SmsService smsService;

//	@RequestMapping(value = "requestPayment", method = RequestMethod.GET)
//	public String requestPayment() {
//		System.out.println("결제 요청");
//		return "pay/requestPayment";
//	}

	@ResponseBody
	@RequestMapping(value = "verify/{imp_uid}")
	public IamportResponse<com.siot.IamportRestClient.response.Payment> paymentByImpUid(Model model, Locale locale,
			HttpSession session, @PathVariable(value = "imp_uid") String imp_uid)
			throws IamportResponseException, IOException {
		System.out.println("결제 정보 검증");
		return api.paymentByImpUid(imp_uid);

	}

	@RequestMapping(value = "output", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> nonPaymentOutput(@RequestBody PaymentDTO pd, HttpServletRequest request)
			throws IamportResponseException, IOException {

		if (pd.getImpUid() != null) {

			IamportResponse<Payment> importResponse = api.paymentByImpUid(pd.getImpUid());
			pd.setActualPaymentAmount(importResponse.getResponse().getAmount().intValue());
			pd.setPaymentTime(new Timestamp(importResponse.getResponse().getPaidAt().getTime()));
			pd.setCardName(importResponse.getResponse().getCardName());
			pd.setCardNumber(importResponse.getResponse().getCardNumber());
		}

		ResponseEntity<Map<String, Object>> result = null;

		System.out.println("pd : " + pd.toString());

		// 주문 상세 리스트 생성
		List<DetailOrderItem> itemList = pd.getProducts();

		System.out.println(itemList.toString());

		// ajax로 받은 PaymentDTO에서 주문 상세 상품만 getter로 뽑아 주문 상세 vo 생성 후 리스트 추가
//		for (int i = 0; i < pd.getProduct_id().size(); i++) {
//			itemList.add(
//					new DetailOrderItem(pd.getNon_order_no(), pd.getProduct_id().get(i), pd.getProduct_price().get(i)));
//		}
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		System.out.println(member.getMemberId());

		Map<String, Object> paymentDetail = new HashMap<String, Object>();
		pd.setMemberId(member.getMemberId());
		try {
			// member 다시 조회
			Memberkjy memberInfo = os.getMemberInfo(member.getMemberId());
			itemList = os.compareAmount(pd, itemList, memberInfo);
			if (itemList != null) { // 검증 성공
				
				// 결제 테이블, 주문 상세 테이블, 무통장입금일 시 무통장입금 또한 저장
				// 포인트, 적립금, 쿠폰, 멤버, 상품 재고 update
				if (os.savePayment(pd, itemList, memberInfo)) {
					result = new ResponseEntity<Map<String, Object>>(paymentDetail, HttpStatus.OK); // 아작스로 돌아가서 쓸모없음
					paymentDetail.put("itemList", itemList);
					paymentDetail.put("pd", pd);
					if (pd.getPaymentNumber().contains("bkt")) {
						MessageDTO messageDto = new MessageDTO();
						messageDto.setTo(pd.getPhoneNumber());
						SmsResponseDto responseDto = smsService.sendSms(messageDto);
						System.out.println(responseDto.getStatusCode());
					}
				} else { // 검증은 성공했지만 테이블 저장 실패
					result = new ResponseEntity<>(HttpStatus.CONFLICT);
				}
			} else {
				if (pd.getPaymentNumber().contains("imp")) {

					CancelData cancelData = new CancelData(pd.getImpUid(), true,
							new BigDecimal(pd.getActualPaymentAmount()));
					cancelData.setChecksum(new BigDecimal(pd.getActualPaymentAmount()));
					cancelData.setReason("사후검증 실패");
					if (api.cancelPaymentByImpUid(cancelData).getCode() == 0) {
						System.out.println("사후검증 실패로 인한 아임포트 결제 취소 완료");
					}
				} else {
					System.out.println("사후검증 실패로 인한 무통장입금 결제 취소 완료");
				}
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "cancel", method = RequestMethod.POST)
	public IamportResponse<com.siot.IamportRestClient.response.Payment> cancelPaymentByImpUid(
			@RequestBody CancelDatas rc) throws IamportResponseException, IOException {
		System.out.println("결제 취소");
		// 결제에 환불가능 금액이 있으면 좋을듯
		CancelData cancelData = new CancelData(rc.getImp_uid(), true, rc.getAmount()); // 주문번호, 환불요청금액, 환불가능금액, 사유
		// 서버와 포트원 서버간에 환불 가능 금액을 검증하기 위해서 checksum 입력 권장
		cancelData.setChecksum(rc.getChecksum()); // 환불 가능 잔액
		cancelData.setReason(rc.getReason()); // 환불 사유
		return api.cancelPaymentByImpUid(cancelData);
	}

}
