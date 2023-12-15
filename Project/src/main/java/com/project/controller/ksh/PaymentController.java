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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.util.WebUtils;

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

   // 개인정보 보호를 위해 properties에 숨김
   @Value(value = "${rest-api.key}")
   private String apiKey;

   @Value(value = "${rest-api.secret}")
   private String apiSecret;

   @Value(value = "${my-test.phoneNumber}")
   private String testPhone;

   private IamportClient api;

   @Inject
   private OrderService os;

//  문자
   @Inject
   private SmsService smsService;

   @ResponseBody
   @RequestMapping(value = "verify/{imp_uid}")
   public IamportResponse<com.siot.IamportRestClient.response.Payment> paymentByImpUid(Model model, Locale locale,
         HttpSession session, @PathVariable(value = "imp_uid") String imp_uid) {
      IamportResponse<com.siot.IamportRestClient.response.Payment> result = null;
      System.out.println("결제 정보 검증");
      api = new IamportClient(apiKey, apiSecret);
      try {
         result = api.paymentByImpUid(imp_uid);
      } catch (IamportResponseException | IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      return result;

   }

   @RequestMapping(value = "output", method = RequestMethod.POST)
   public ResponseEntity<Map<String, Object>> paymentOutput(@RequestBody PaymentDTO pd, HttpServletRequest request) {
      api = new IamportClient(apiKey, apiSecret);
      System.out.println(pd.toString());
      String memberId = "";
      ResponseEntity<Map<String, Object>> result = null;
      Map<String, Object> paymentDetail = new HashMap<String, Object>();
      Memberkjy memberInfo = null;
      HttpSession session = request.getSession();
      
      if(pd.getNonOrderHistory() != null) {
         // 비회원 회원 아이디 set
         Cookie cookie = WebUtils.getCookie(request, "nom");
         System.out.println(cookie.getValue());
         pd.getNonOrderHistory().setNonMemberId(cookie.getValue());
      }
      try {
         if (pd.getImpUid() != null) {
            System.out.println(apiKey);
            System.out.println(apiSecret);
            System.out.println(api.toString());
            IamportResponse<Payment> importResponse = api.paymentByImpUid(pd.getImpUid());
            pd.setActualPaymentAmount(importResponse.getResponse().getAmount().intValue());
            pd.setPaymentTime(new Timestamp(importResponse.getResponse().getPaidAt().getTime()));
            pd.setCardName(importResponse.getResponse().getCardName());
            pd.setCardNumber(importResponse.getResponse().getCardNumber());
         }

         System.out.println("pd : " + pd.toString());

         // 주문 상세 리스트 생성
         List<DetailOrderItem> itemList = pd.getProducts();

         System.out.println(itemList.toString());
         // member 다시 조회
         if (session.getAttribute("loginMember") != null) {
            memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
            pd.setMemberId(memberId);
            memberInfo = os.getMemberInfo(memberId);
         }
         itemList = os.compareAmount(pd, itemList, memberInfo);
         if (itemList != null) { // 검증 성공
            // 결제 테이블, 주문 상세 테이블, 무통장입금일 시 무통장입금 또한 저장
            // 포인트, 적립금, 쿠폰, 멤버, 상품 재고 update
            if (os.savePayment(pd, itemList, memberInfo)) {
               System.out.println("여기까지 오나효?");
               paymentDetail.put("itemList", itemList);
               paymentDetail.put("pd", pd);
               result = new ResponseEntity<Map<String, Object>>(paymentDetail, HttpStatus.OK); // 아작스로 돌아가서 쓸모없음
               // 문자
               if (pd.getPaymentNumber().contains("bkt") && pd.getBktSms().equals("sms")) {
                  MessageDTO messageDto = new MessageDTO();
                  messageDto.setTo(testPhone); 
                  messageDto.setContent("[deerBooks] 무통장입금 계좌 : "+pd.getDepositedAccount()+ ", 필요 입금 금액 : " + pd.getAmountToPay()+"원");
                  System.out.println(messageDto.toString());
                  SmsResponseDto responseDto = smsService.sendSms(messageDto);
                  System.out.println(responseDto.getStatusCode());
               }
            } else { // 검증은 성공했지만 테이블 저장 실패
               System.out.println("몰까요?");
               if (pd.getPaymentNumber().contains("imp")) {
                  CancelData cancelData = new CancelData(pd.getImpUid(), true,
                        new BigDecimal(pd.getActualPaymentAmount()));
                  cancelData.setChecksum(new BigDecimal(pd.getActualPaymentAmount()));
                  cancelData.setReason("테이블 저장 실패");
                  if (api.cancelPaymentByImpUid(cancelData).getCode() == 0) {
                     System.out.println("테이블 저장 실패로 인한 아임포트 결제 취소 완료");
                  }
               } else {
                  System.out.println("테이블 저장 실패로 인한 결제 취소 완료");
               }
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
               System.out.println("사후검증 실패로 인한 결제 취소 완료");
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
         @RequestBody CancelDatas rc) {
      System.out.println("결제 취소");
      api = new IamportClient(apiKey, apiSecret);
      CancelData cancelData = new CancelData(rc.getImp_uid(), true, rc.getAmount()); // 주문번호, 환불요청금액, 환불가능금액, 사유
      IamportResponse<com.siot.IamportRestClient.response.Payment> result = null;
      // 서버와 포트원 서버간에 환불 가능 금액을 검증하기 위해서 checksum 입력 권장
      cancelData.setChecksum(rc.getChecksum()); // 환불 가능 잔액
      cancelData.setReason(rc.getReason()); // 환불 사유
      try {
         result = api.cancelPaymentByImpUid(cancelData);
      } catch (IamportResponseException | IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      return result;
   }

}