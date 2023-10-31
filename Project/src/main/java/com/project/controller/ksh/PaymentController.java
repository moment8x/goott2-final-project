package com.project.controller.ksh;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.ksh.payment.OrderService;


import com.project.vodto.PaymentDTO;
import com.project.vodto.CancelDatas;
import com.project.vodto.DetailOrderItem;


@RestController
@RequestMapping("/pay/*")
public class PaymentController {

//	private IamportClient api;
	public PaymentDTO pdto;
	public List<DetailOrderItem> itemListdto;

//	public PaymentController() {
//		// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
//		this.api = new IamportClient("6208485383120734",
//				"LhGS6esknLSY3r3YH0Dtvh65MXPpP27VLL8F6FKcavXsrJKrmkuvUcjUxjLWYTTvZLeCxAMJXSjSaHcU");
//	}

	@Inject
	private OrderService os;


//	@RequestMapping(value = "requestPayment", method = RequestMethod.GET)
//	public String requestPayment() {
//		System.out.println("결제 요청");
//		return "pay/requestPayment";
//	}

	@ResponseBody
//	@RequestMapping(value = "verify/{imp_uid}")
//	public IamportResponse<com.siot.IamportRestClient.response.Payment> paymentByImpUid(Model model, Locale locale,
//			HttpSession session, @PathVariable(value = "imp_uid") String imp_uid)
//			throws IamportResponseException, IOException {
//		System.out.println("결제 정보 검증");
//		return api.paymentByImpUid(imp_uid);
//
//	}

	@RequestMapping(value = "output", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> nonPaymentOutput(@RequestBody PaymentDTO pd) {
		ResponseEntity<Map<String, Object>> result = null;
//		System.out.println(pd.toString());
//		pdto = pd;
		

		// 주문 상세 리스트 생성
		List<DetailOrderItem> itemList = new ArrayList<DetailOrderItem>();

		// ajax로 받은 PaymentDTO에서 주문 상세 상품만 getter로 뽑아 주문 상세 vo 생성 후 리스트 추가
		for (int i = 0; i < pd.getProduct_id().size(); i++) {
			itemList.add(
					new DetailOrderItem(pd.getNon_order_no(), pd.getProduct_id().get(i), pd.getProduct_price().get(i)));
		}
//		itemListdto = itemList;
		
		Map<String, Object> paymentDetail = new HashMap<String, Object>();
		try {

			// 결제 테이블, 주문 상세 테이블 저장
			if (os.savePayment(pd, itemList)) {
				result = new ResponseEntity<Map<String, Object>>(paymentDetail, HttpStatus.OK);
				paymentDetail.put("itemList", itemList);
				paymentDetail.put("pd", pd);
				System.out.println("무통장 입금 결제 정보 저장");
			} else {
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}

		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

//	@ResponseBody
//	@RequestMapping(value = "cancel", method = RequestMethod.POST)
//	public IamportResponse<com.siot.IamportRestClient.response.Payment> cancelPaymentByImpUid(@RequestBody CancelDatas rc)
//			throws IamportResponseException, IOException {
//		System.out.println("결제 취소");
//		// 주문내역에 환불가능 금액이 있으면 좋을듯
//		CancelData cancelData = new CancelData(rc.getImp_uid(), true, rc.getAmount());
//		// 서버와 포트원 서버간에 환불 가능 금액을 검증하기 위해서 checksum 입력 권장
//		cancelData.setChecksum(rc.getChecksum());	// 환불 가능 금액
//		cancelData.setReason(rc.getReason()); // 환불 사유
//		return api.cancelPaymentByImpUid(cancelData);
//
//	}
}
