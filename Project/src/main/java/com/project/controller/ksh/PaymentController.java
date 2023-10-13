package com.project.controller.ksh;

import java.io.IOException;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.ksh.payment.OrderService;
import com.project.service.ksh.payment.PayService;
import com.project.vodto.PaymentDTO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;

@Controller
@RequestMapping("/pay/*")
public class PaymentController {

	private IamportClient api;

	public PaymentController() {
		// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("6208485383120734",
				"LhGS6esknLSY3r3YH0Dtvh65MXPpP27VLL8F6FKcavXsrJKrmkuvUcjUxjLWYTTvZLeCxAMJXSjSaHcU");
	}

	@Inject
	OrderService os;

	@Inject
	PayService ps;

	@RequestMapping(value = "requestPayment", method = RequestMethod.GET)
	public String requestPayment() {
		System.out.println("결제 요청");
		return "pay/requestPayment";
	}

	@ResponseBody
	@RequestMapping(value = "verify/{imp_uid}")
	public IamportResponse<com.siot.IamportRestClient.response.Payment> paymentByImpUid(Model model, Locale locale,
			HttpSession session, @PathVariable(value = "imp_uid") String imp_uid)
			throws IamportResponseException, IOException {
		System.out.println("결제 정보 검증");
		return api.paymentByImpUid(imp_uid);
	}

	
	@RequestMapping(value = "output", method = RequestMethod.POST)
	public ResponseEntity<String> nonPaymentOutput(@RequestBody PaymentDTO pd) {

		System.out.println(pd.toString());
		ResponseEntity<String> result = null;
		try {
			
			System.out.println("결제 정보 저장");
			if(os.compareAmount(pd)) {
				
				os.savePayment(pd);
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
			}
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
}
