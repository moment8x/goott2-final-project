<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="/resources/js/ksh/addr.js"></script>
<script src="/resources/js/ksh/cancelPayment.js"></script>
<script>
let itemLen = $(".summery-contain").find("li").length; // 상품 종류
let addrValid = false;
let detailAddrValid = false;
let zipCodeValid = false;
let recipientValid = false;
let phoneNumberValid = false;
let passwordValid = false;
let emailValid = false;
let totalAmount = Number('${requestScope.paymentInfo.totalAmount}');
let shippingFee = Number('${requestScope.paymentInfo.shippingFee}');
let IMP = window.IMP;
IMP.init("${impKey}") // 예: 'imp00000000a'
let isPaid = false;
let orderId = ('${requestScope.orderId}');
let products = [];
let createName = "";
let finalTotal = 0;
	$(function() {
		itemLen = $(".summery-contain").find("li").length; // 상품 종류
		for(i=0; i<itemLen; i++) {
	    	  let localePrice = (Number($('#productPrice'+i).text())).toLocaleString('ko-KR');
	    	  $('#productPrice'+i).text(localePrice);
	      }
		finalTotal = totalAmount + shippingFee;
		console.log(finalTotal);
		$("#payToAmount").text(finalTotal);
		// 이메일 유효성 검사
		// =========================================================== 수정 필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		$('#nonEmail').on('blur', function() {
			let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if (regEmail.test($('#nonEmail').val())) {
				isValidEmail = true;
				$('#nonEmail').parent().next().html('');
			} else {
				alert("올바른 이메일이 아닙니다.");
				isValidEmail = false;
			}
		});
		
		// 휴대폰 번호 유효성 검사
		$('#nonRecipientPhoneNumber').on('blur', function () {
			let regNumber = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			if (regNumber.test($('#nonRecipientPhoneNumber').val())) {
				let addHyphen = $('#nonRecipientPhoneNumber').val().replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
				$('#nonRecipientPhoneNumber').val(addHyphen);
				isValidCellPhone = true;	
			} else {
				alert("올바른 전화번호가 아닙니다.");
				$('#nonRecipientPhoneNumber').val("");
				isValidCellPhone = false;
			}
				
		});
		
		
	
		$("#nonOrderNo").val(orderId);
		  $("#payToAmount").text((totalAmount + shippingFee).toLocaleString('ko-KR'));	    
	      $('#subTotal').text(totalAmount.toLocaleString('ko-KR'));
	      $('#shippingFee').text(shippingFee.toLocaleString('ko-KR'));
	
		$("#selectMessage").on("change", function(){

		if($("option:selected", this).text() == "직접입력") {
			$('#directInput').attr('style', 'display:');
			console.log("hi");
		} else {
			$('#directInput').attr('style', 'display:none');	
		}
		});
		
		$("#bktBank").on("change", function(){

    		if($("option:selected", this).text() == "입금할 은행을 선택해주세요.") {
    			$('#showBktBank').attr('style', 'display:none');	
    		} else {
    			$('#showBktBank').attr('style', 'display:');
    			$('#showBktBank').text($("option:selected", this).text()+' 123-456-789012');			
    		}
   		});  
	});
		
		//$("#subTotal").val();

	function getOrderId() {
		console.log($("#nonOrderNo").val());
		
		let itemLen = $(".summery-contain").find("li").length; // 2
		for(i=0; i<itemLen; i++) {
			let product = new Object();
		}

		//console.log(itemLen);
		for(i=0; i<itemLen; i++) { 
			product.nonOrderNo = orderId;
			product.productId = $(".summery-contain").find("li").eq(i).attr("id");
			products2[i] = product; 
		}	
	}
	

	function identify() {
		// IMP.certification(param, callback) 호출
		IMP
				.certification(
						{ // param
							pg : 'MIIiasTest',//본인인증 설정이 2개이상 되어 있는 경우 필수 
							merchant_uid : "ORD20180131-0000011", // 주문 번호
							m_redirect_url : "http://localhost:8081/order/nonMemberOrder?productId=S000208719388", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
							popup : false
						// PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
						},
						function(rsp) { // callback
							if (rsp.success) {
								alert("본인인증 성공");
								console.log(rsp);
							} else {
								alert("본인인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
							}
						});
	}

	function kg_pay() {
        console.log("!!");
        IMP.request_pay({ // 결제 정보 채우기
          pg : "html5_inicis",
          pay_method : "card",
          merchant_uid : orderId, // 주문번호
          name : createName, // 수정필______________________________________
          amount : Number($('#payToAmount').text().replaceAll(",","")), // 숫자 타입
          buyer_email : "",
          buyer_name : $('#nonRecipientName').val(),
          buyer_tel : $('#nonRecipientPhoneNumber').val(),
          buyer_addr : $('#addAddr').text(),
          buyer_postcode :  $('#addZipNo').text(),
        }, function(rsp) { // callback
          //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
          if (rsp.success) { // 결제 내역 받기
            // 결제 검증 ajax        
              // 결제 내역 저장 ajax
              obj = {
                "paymentNumber" : rsp.imp_uid, // 결제번호
                "nonOrderNo" : rsp.merchant_uid, // 주문번호
                "paymentMethod" : rsp.pay_method, // 결제수단
                "totalAmount" : totalAmount, // 총 상품 금액, 수정 필요
                "shippingFee" : shippingFee, // 배송비
                "usedPoints" : Number($('#usingPoints').val()), // 사용한 포인트
                "usedReward" : Number($('#usingRewards').val()), // 사용한 적립금
                //"actualPaymentAmount" : data.response.amount, // 실 결제 금액
                //"paymentTime" : data.response.paidAt,// 결제 시각
                "amountToPay" : rsp.paid_amount,
                //"cardName" : data.response.cardName,
                //"cardNumber" : data.response.cardNumber,   주석 처리 한 것은 백에서 작업.            
                "impUid" : rsp.imp_uid,
                products,
                nonOrderHistory : {
	            	   "nonRecipientName" : $('#recipient').text(),
	             		  "nonRecipientPhoneNumber" : $('#recipientContact').text(),
	             		  "nonZipCode" : $('#zipCode').text(),
	             		  "nonShippingAddress" : $('#address').text(),
	             		  "nonDetailedShippingAddress" : $('#detailAddress').text().replaceAll("\n",""),
	             		  "nonDeliveryMessage" : deliveryMessage,
	               }
              }
              $.ajax({
                url : "/pay/output/",
                type : "POST",
                contentType : "application/json",
                data : JSON.stringify(obj),
                async : false,
                success : function(result) {
                  isPaid = true;
                  console.log("ajax 결과 : ", isPaid);
                  if (isPaid) {
                     console.log("띠용?");
                    $("#requestNonOrder").submit();
                  }
                  // alert("결제 완료");
                },
                error : function(error) {
                  console.log(error);
                  alert("검증 실패로 인해 결제가 취소되었습니다.")
                },
              })
            } else {
            alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
          }
        })
      }

	

	function validateAll() {
		if($('#addAddr').val() != "") {
			
			addrValid = true;
		}
		if($('#addAddrDetail').val() != "") {
			detailAddrValid = true;
		}
		if($('#addZipNo').val() != "") {
			zipCodeValid = true;
		}
		if($('#nonRecipientName').val() != "") {
			recipientValid = true;
		}
		if($('#nonRecipientPhoneNumber').val() != "") {
			phoneNumberValid = true;
		}
		if($('#nonPassword').val() != "") {
			passwordValid = true;
		}
		if($('#nonEmail').val() != "") {
			emailValid = true;
		}
	
		if(addrValid && detailAddrValid && zipCodeValid && recipientValid && phoneNumberValid && passwordValid && emailValid) {
			console.log("통과하셨습니다~");
			return true;
		} else {
			console.log("제대로 입력해");
			console.log(addrValid);
			return false;
		}
		
	}
	function packData() {
	      for(i=0; i<itemLen; i++) {
	         products[i] = new Object;
	         products[i].nonOrderNo = orderId;
	         products[i].productId = $(".summery-contain").find("li").eq(i).attr("id");
	         products[i].productQuantity = $('#productQty'+i).text();
	         products[i].productPrice = $('#productPrice'+i).text().replaceAll(",","");
	       
	         products[i].productOrderNo = orderId + "-"+(i+1);
	      }
	      if($("select[name=nonDeliveryMessage] option:selected").text() == "직접입력") {
	    	  console.log('여기오냐');
	    	  deliveryMessage = $('#directInput').val();
	      } else {
	    	  deliveryMessage = $("select[name=deliveryMessage] option:selected").text();
	      }
	         /* $('#addRecipient').val($('#recipient').text());
	         $('#addAddress').val($('#address').text());
	         $('#addDetailAddress').val($('#detailAddress').text());
	         $('#addZipCode').val($('#zipCode').text());
	         $('#addRecipientContact').val($('#recipientContact').text());
	         console.log($('#addRecipientContact').val());
	         console.log($('#addAddress').val());
	         console.log($('#addDetailAddress').val());
	         console.log($('#addZipCode').val());
	         console.log($('#addRecipientContact').val()); */

	      if(itemLen > 1) {
	         createName = $('#productName0').text()+" 외 "+(itemLen - 1)+"개";
	      } else {
	         createName = $('#productName0').text();
	      }
	      console.log(createName);
	      console.log(products);
	   
	   }
	
	function checkBank() {
		   if($("select[name=bktBank] option:selected").text() == "입금할 은행을 선택해주세요.") {
			   $('#bktSms').removeAttr('value');
			   alert("입금하실 은행을 선택하시고 체크해 주세요.");
			   $("input:checkbox[name='bktSms']").prop("checked", false);   
		   } else {
			   if( $("input:checkbox[name='bktSms']").prop("checked")){
				   
			   	$('#bktSms').val('sms');
			   } else {
				   $('#bktSms').removeAttr('value');
			   }
			   // 체크된 체크박스의 value만 제출 데이터에 포함되고 체크 해제된 체크박스의 value는 아예 누락됩니다. 
			   // 또한 value를 지정하지 않은 경우의 기본 값은 문자열 on입니다.
		   }
		   console.log($('#bktSms').val());	// 체크하면 sms, 아니면 on
	   }
	
	function checkPayMethod() {
		 let payNo = "";
		 let objAmountToPay = Number($('#payToAmount').text().replaceAll(",",""));
		if(validateAll()) {
			if ($("input[name='payMethod']").is(':checked')) {
		         // 전체 radio 중에서 하나라도 체크되어 있는지 확인
		         // 아무것도 선택안되어있으면, false
		         let payMethod = $("input[name='payMethod']:checked").val();
		         
		         // score의 라디오 중 체크된 것의 값만 가져옴
		         // 아무것도 선택안되어있으면, undefined
		         console.log(payMethod);
		         if (payMethod == "bkt" || payMethod == "ptr") {
		            let payNo = "bkt_"
		                  + ((String(new Date().getTime())).substring(1));
		            packData();
		            obj = {
		               "paymentNumber" : payNo, // 결제번호 생성 코드 필요
		               "nonOrderNo" : orderId, // 주문번호
		               "paymentMethod" : payMethod, // 결제수단
		               "totalAmount" : totalAmount, // 총 상품 금액, 수정 필요
		               "shippingFee" : shippingFee, // 배송비
		               "amountToPay" : objAmountToPay, // (total+배송비-포인트-적립금)
		               "actualPaymentAmount" : 0, // 실 결제 금액(무통장입금은 default 0)              
		               products,
		               nonOrderHistory : {
		            	   "nonRecipientName" : $('#recipient').text(),
		             		  "nonRecipientPhoneNumber" : $('#recipientContact').text(),
		             		  "nonZipCode" : $('#zipCode').text(),
		             		  "nonShippingAddress" : $('#address').text(),
		             		  "nonDetailedShippingAddress" : $('#detailAddress').text().replaceAll("\n",""),
		             		  "nonDeliveryMessage" : deliveryMessage,
		             		  "nonPassword" : $('#nonPassword').val(),
		             		  "nonEmail" : $('#nonEmail').val(),
		               }
		            };
		            console.log(obj);
		            $.ajax({
		               url : "/pay/output",
		               type : "POST",
		               contentType : "application/json",
		               data : JSON.stringify(obj),
		               async : false,
		               success : function(result) {
		                  isPaid = true;
		                  console.log(result);
		                  if (isPaid) {
		                     // 주문 완료 페이지에 필요한 것
		                     $("#requestNonOrder").submit();
		                  }
		                  // alert("결제 완료");
		               },
		               error : function(error) {
		                  alert("결제 실패" + error);
		                  console.log(error);
		               }
		            })
		         } else {
		            packData();
		            kg_pay();
		         }
		      }
		};
		
		
	}


	
	//function createBktPaymentNo() {
	//	return 'bkt' + (new Date().getTime()).substring(1);
	//}
</script>
<style>
#iframeSon {
	width: 100%;
	background-color: white;
}

.greenBtn {
	background-color: #0da487;
	color: white;
	margin-top: 10px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- mobile fix menu start -->

	<div class="mobile-menu d-md-none d-block mobile-cart">
		<ul>
			<li class="active"><a href="index.html"> <i
					class="iconly-Home icli"></i> <span>Home</span>
			</a></li>

			<li class="mobile-category"><a href="javascript:void(0)"> <i
					class="iconly-Category icli js-link"></i> <span>Category</span>
			</a></li>

			<li><a href="search.html" class="search-box"> <i
					class="iconly-Search icli"></i> <span>Search</span>
			</a></li>

			<li><a href="wishlist.html" class="notifi-wishlist"> <i
					class="iconly-Heart icli"></i> <span>My Wish</span>
			</a></li>

			<li><a href="cart.html"> <i
					class="iconly-Bag-2 icli fly-cate"></i> <span>Cart</span>
			</a></li>
		</ul>
	</div>
	<!-- mobile fix menu end -->

	<!-- Breadcrumb Section Start -->
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>Checkout</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">Checkout</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->
	<!-- Checkout section Start -->
	<section class="checkout-section-2 section-b-space">

		<form action="nonOrderComplete" method="post" id="requestNonOrder">
			<input type="hidden" name="nonOrderNo" id="nonOrderNo" value="">

			<div class="container-fluid-lg">
				<div class="row g-sm-4 g-3">
					<div class="col-lg-8">
						<div class="left-sidebar-checkout">
							<div class="checkout-detail-box">
								<ul>
									<li>
										<div class="checkout-icon">
											<lord-icon target=".nav-item"
												src="https://cdn.lordicon.com/ggihhudh.json"
												trigger="loop-on-hover"
												colors="primary:#121331,secondary:#646e78,tertiary:#0baf9a"
												class="lord-icon"> </lord-icon>
										</div>
										<div class="checkout-box">
											<div class="checkout-title">
												<h4>정보 입력</h4>

											</div>

											<div class="checkout-detail">
												<div class="row g-4">
													<div class="col-xxl-6 col-lg-12 col-md-6">
														<div class="delivery-address-box">
															<div>
																<!--<div class="form-check">
																<input class="form-check-input" type="radio" name="jack"
																	id="flexRadioDefault1">
															</div>

															  <div class="label">
																<label>기본 배송지</label>
															</div>
															<li>
																	<h4 class="fw-500"><input  style="border:none" value="집"></h4>
																</li>
															-->

																<ul class="delivery-address-detail">
																	<li>

																		<h6 class="text-content">
																			<span class="text-title">우편번호:</span><input
																				class="form-control" name="nonZipCode" id="addZipNo"
																				value="" readOnly>
																		</h6>
																	</li>

																	<li>
																		<h6 class="text-content">
																			<span class="text-title"> 주소 : </span><input
																				class="form-control" name="nonShippingAddress"
																				id="addAddr" value="" readOnly>
																			<button type="button" class="greenBtn"
																				onclick="goPopup()">주소 찾기</button>

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content">

																			<span class="text-title">상세주소:</span><input
																				class="form-control"
																				name="nonDetailedShippingAddress" id="addAddrDetail"
																				value="">
																		</h6>
																	</li>



																	<li>
																		<h6 class="text-content">
																			<span class="text-title">수령인: </span> <input
																				class="form-control" id="nonRecipientName"
																				name="nonRecipientName">
																		</h6>
																	</li>

																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">휴대폰: </span> <input
																				class="form-control" name="nonRecipientPhoneNumber"
																				id="nonRecipientPhoneNumber">

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">비밀번호: </span> <input
																				class="form-control" type="password"
																				name="nonPassword" id="nonPassword">

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">이메일: </span> <input
																				class="form-control" name="nonEmail" id="nonEmail">

																		</h6>
																	</li>
																	<li>
																		<div class="col-12">
																			<div class="select-option">
																				<div class="form-floating theme-form-floating">
																					<select class="form-select theme-form-select"
																						aria-label="Default select example"
																						name="nonDeliveryMessage" id="selectMessage">
																						<option value="없음">배송메시지를 선택해 주세요.</option>
																						<option>배송 전 연락주세요.</option>
																						<option>부재 시 연락주세요.</option>
																						<option>부재 시 경비실에 맡겨주세요.</option>
																						<option>문 앞에 놓아주세요.</option>
																						<option>직접입력</option>
																					</select>
																				</div>
																			</div>
																		</div>
																	</li>
																	<li><input type="text" class="form-control"
																		id="directInput" name="directMessage" placeholder=""
																		style="display: none"></li>
																</ul>



															</div>

														</div>




													</div>


													<!--  <div class="col-xxl-6 col-lg-12 col-md-6">
													<div class="delivery-address-box">
														<div>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="jack"
																	id="flexRadioDefault2" checked="checked">
															</div>

															<div class="label">
																<label>Office</label>
															</div>

															<ul class="delivery-address-detail">
																<li>
																	<h4 class="fw-500">Jack Jennas</h4>
																</li>

																<li>
																	<p class="text-content">
																		<span class="text-title">Address :</span>Nakhimovskiy
																		R-N / Lastovaya Ul., bld. 5/A, appt. 12
																	</p>
																</li>

																<li>
																	<h6 class="text-content">
																		<span class="text-title">Pin Code :</span> +380
																	</h6>
																</li>

																<li>
																	<h6 class="text-content mb-0">
																		<span class="text-title">Phone :</span> + 380 (0564)
																		53 - 29 - 68
																	</h6>
																</li>
															</ul>
														</div>
													</div>
												</div>
												-->
												</div>
											</div>
										</div>
									</li>

									<li>
										<div class="checkout-icon">
											<lord-icon target=".nav-item"
												src="https://cdn.lordicon.com/oaflahpk.json"
												trigger="loop-on-hover" colors="primary:#0baf9a"
												class="lord-icon"> </lord-icon>
										</div>
										<div class="checkout-box">
											<div class="checkout-title">
												<h4>할인 수단</h4>
											</div>

											<div class="checkout-detail">
												<div class="row g-4">
													<div class="col-xxl-6">
														<div class="delivery-option">
															<div class="delivery-category">
																<div class="shipment-detail">
																	<div
																		class="form-check custom-form-check hide-check-box">
																		<!--  <input class="form-check-input" type="radio"
																		name="standard" id="standard" checked>-->
																		<label class="form-check-label" for="standard">비회원
																			적용 가능한 쿠폰이 없습니다.</label>
																	</div>
																</div>
															</div>

														</div>
													</div>


													<!-- <div class="container mt-3">

														<table class="table table-borderless">

															<tbody>
																<tr>
																	<td>보유 포인트</td>
																	<td>${requestScope.member.totalPoints }</td>
																	<td><input name="points" id="points"></td>
																	<td><button>전액사용</button></td>
																</tr>
																<tr>
																	<td>보유 적립금</td>
																	<td>${requestScope.member.totalRewards }</td>
																	<td><input name="reward" id="reward"></td>
																	<td><button>전액사용</button></td>
																</tr>

															</tbody>
														</table>
													</div> -->


													<div class="row g-4">
														<div class="col-xxl-6">
															<div class="delivery-option">
																<div class="delivery-category">
																	<div class="shipment-detail">
																		<div
																			class="form-check custom-form-check hide-check-box">
																			<label class="form-check-label btn" for="standard"
																				data-bs-toggle="collapse" href="#collapseOne">비회원
																				포인트와 적립금 사용이 불가합니다. </label>
																		</div>
																	</div>
																</div>
															</div>

														</div>




														<!--<div class="col-xxl-6">
													<div class="delivery-option">
														<div class="delivery-category">
															<div class="shipment-detail">
																<div
																	class="form-check mb-0 custom-form-check show-box-checked">
																	<input class="form-check-input" type="radio"
																		name="standard" id="future"> <label
																		class="form-check-label" for="future">포인트/적립금</label>
																</div>
															</div>
														</div>
													</div>
												</div>


													  <div class="col-12 future-box">
														<div class="future-option">
															<div class="row g-md-0 gy-4">
																<div class="col-md-6">
																	<div class="delivery-items">
																		<div>
																			<h5 class="items text-content">
																				<span>3 Items</span>@ $693.48
																			</h5>
																			<h5 class="charge text-content">
																				Delivery Charge $34.67
																				<button type="button" class="btn p-0"
																					data-bs-toggle="tooltip" data-bs-placement="top"
																					title="Extra Charge">
																					<i class="fa-solid fa-circle-exclamation"></i>
																				</button>
																			</h5>
																		</div>
																	</div>
																</div>

																<div class="col-md-6">
																	<form
																		class="form-floating theme-form-floating date-box">
																		<input type="date" class="form-control"> <label>Select
																			Date</label>
																	
																</div>
															</div>
														</div>
													</div>
													-->

													</div>
												</div>
											</div>
									</li>

									<li>
										<div class="checkout-icon">
											<lord-icon target=".nav-item"
												src="https://cdn.lordicon.com/qmcsqnle.json"
												trigger="loop-on-hover"
												colors="primary:#0baf9a,secondary:#0baf9a" class="lord-icon">
											</lord-icon>
										</div>
										<div class="checkout-box">
											<div class="checkout-title">
												<h4>결제 수단</h4>
											</div>

											<div class="checkout-detail">
												<div class="accordion accordion-flush custom-accordion"
													id="accordionFlushExample">
													<div class="accordion-item">
														<div class="accordion-header" id="flush-headingFour">
															<div class="accordion-button collapsed"
																data-bs-toggle="collapse"
																data-bs-target="#flush-collapseFour">
																<div class="custom-form-check form-check mb-0">
																	<label class="form-check-label" for="cash"><input
																		class="form-check-input mt-0" type="radio"
																		name="payMethod" id="cash" checked> 신용카드</label>
																</div>
															</div>
														</div>
														
													</div>

													<div class="accordion-item">
														<div class="accordion-header" id="flush-headingOne">
															<div class="accordion-button collapsed"
																data-bs-toggle="collapse"
																data-bs-target="#flush-collapseOne">
																<div class="custom-form-check form-check mb-0">
																	<label class="form-check-label" for="credit"><input
																		class="form-check-input mt-0" type="radio"
																		name="payMethod" id="credit"> 카카오페이</label>
																</div>
															</div>
														</div>
														
													</div>

													<div class="accordion-item">
														<div class="accordion-header" id="flush-headingTwo">
															<div class="accordion-button collapsed"
																data-bs-toggle="collapse"
																data-bs-target="#flush-collapseTwo">
																<div class="custom-form-check form-check mb-0">
																	<label class="form-check-label" for="banking"><input
																		class="form-check-input mt-0" type="radio"
																		name="payMethod" id="banking">네이버페이</label>
																</div>
															</div>
														</div>
														
													</div>

													<div class="accordion-item">
														<div class="accordion-header" id="flush-headingThree">
															<div class="accordion-button collapsed"
																data-bs-toggle="collapse"
																data-bs-target="#flush-collapseThree">
																<div class="custom-form-check form-check mb-0">
																	<label class="form-check-label" for="wallet"><input
																		class="form-check-input mt-0" type="radio"
																		name="payMethod" id="wallet" value="bkt">무통장입금</label>
																</div>
															</div>
														</div>
														<div id="flush-collapseThree"
															class="accordion-collapse collapse"
															data-bs-parent="#accordionFlushExample">
															<div class="accordion-body">
																<h5 class="text-uppercase mb-4">Select Your Wallet</h5>
																<div class="row">


																	<div class="form-floating theme-form-floating">
																		<select id="bktBank" name="bktBank"
																			class="form-control">
																			<option value="none">입금할 은행을 선택해주세요.</option>
																			<option>신한은행</option>
																			<option>IBK기업은행</option>
																			<option>하나은행</option>
																			<option>우리은행</option>
																			<option>NH농협은행</option>
																			<option>KDB산업은행</option>
																			<option>SC제일은행</option>
																			<option>씨티은행</option>
																			<option>BNK부산은행</option>
																			<option>DGB대구은행</option>
																			<option>MG새마을금고</option>
																			<option>신협</option>
																			<option>수협은행</option>
																			<option>KB국민은행</option>
																			<option>우체국예금</option>
																			<option>카카오뱅크</option>
																			<option>토스</option>
																		</select> <label for="bktBank">은행</label> <br>
																		<h5 id="showBktBank" style="display: none"></h5>
																		<br> sms 수신 동의 여부<input type="checkbox"
																			id="bktSms" name="bktSms" onclick="checkBank()" />
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="right-side-summery-box">
							<div class="summery-box-2">
								<div class="summery-header">
									<h3>Order Summery</h3>
								</div>
								<ul class="summery-contain">
									<c:forEach var="info" items="${requestScope.productInfos }"
										varStatus="status">
										<input type="hidden" name="products"
											value="${info.productId }" />
										<li id="${info.productId }"><img
											src="${info.productImage }"
											class="img-fluid blur-up lazyloaded checkout-image" alt="">
											<h4>
												<span id="productName${status.index }">${info.productName }</span>
												X<span id="productQty${status.index }">${info.productQuantity }</span>
											</h4>
											<h4 class="price">
												<span id="productPrice${status.index }">${info.sellingPrice }</span>원
											</h4></li>
									</c:forEach>

									<!-- <li><img
										src="/resources/assets/images/vegetable/product/2.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Eggplant <span>X 3</span>
										</h4>
										<h4 class="price">$12.23</h4></li>

									<li><img
										src="/resources/assets/images/vegetable/product/3.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Onion <span>X 2</span>
										</h4>
										<h4 class="price">$18.27</h4></li>

									<li><img
										src="/resources/assets/images/vegetable/product/4.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Potato <span>X 1</span>
										</h4>
										<h4 class="price">$26.90</h4></li>

									<li><img
										src="/resources/assets/images/vegetable/product/5.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Baby Chili <span>X 1</span>
										</h4>
										<h4 class="price">$19.28</h4></li>

									<li><img
										src="/resources/assets/images/vegetable/product/6.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Broccoli <span>X 2</span>
										</h4>
										<h4 class="price">$29.69</h4></li> -->
								</ul>

								<ul class="summery-total">
									<li>
										<h4>총 상품 가격</h4>
										<h4 class="price">
											<span id="subTotal">${requestScope.paymentInfo.totalAmount }</span>원
										</h4>
									</li>

									<li>
										<h4>배송비</h4>
										<h4 class="price">
											<span id="shippingFee">${requestScope.paymentInfo.shippingFee }</span>원
										</h4>
									</li>
									<li class="list-total">
										<h4>총 결제 금액</h4>
										<h4 class="price">
											<span id="payToAmount">${requestScope.paymentInfo.totalAmount }</span>원
										</h4>
									</li>
								</ul>
							</div>

							<div class="checkout-offer">
								<div class="offer-title">
									<div class="offer-icon">
										<img src="/resources/assets/images/inner-page/offer.svg"
											class="img-fluid" alt="">
									</div>
									<div class="offer-name">
										<h6>Notification</h6>
									</div>
								</div>

								<ul class="offer-detail">
									<li>
										<p>카드를 제외한 결제 수단으로(간편결제 ex:카카오페이 등) 결제할 시 추후 부분취소의 경우 전체
											취소 후 재결제가 필요합니다.</p>
									</li>
									<!--  <li>
										<p>combo: Royal Cashew Californian, Extra Bold 100 gm + BB
											Royal Honey 500 gm</p>
									</li>-->
								</ul>
							</div>

							<button
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								type="button" onclick="checkPayMethod()">결제하기</button>
							<div class="checkout-offer" id="iframeParent">
								<label for="acc-or" class="offer-name"> 위 주문내용을 확인하였으며,
									결제에 동의합니다. <input type="checkbox" id="acc-or"> <span
									class="checkmark"></span>
								</label>
								<iframe id="iframeSon" src="../resources/terms.txt"></iframe>
								<!-- 약관 -->
							</div>
							<!--  <button
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								type="button" onclick="cancelPayment()">취소하기</button>
							<button type="button"
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								onclick="identify()">본인 인증</button>-->
							
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>
	<!-- Checkout section End -->
	<!-- Location Modal Start -->
	<div class="modal location-modal fade theme-modal" id="locationModal"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Choose your
						Delivery Location</h5>
					<p class="mt-1 text-content">Enter your address and we will
						specify the offer for your area.</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="location-list">
						<div class="search-input">
							<input type="search" class="form-control"
								placeholder="Search Your Area"> <i
								class="fa-solid fa-magnifying-glass"></i>
						</div>

						<div class="disabled-box">
							<h6>Select a Location</h6>
						</div>

						<ul class="location-select custom-height">
							<li><a href="javascript:void(0)">
									<h6>Alabama</h6> <span>Min: $130</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Arizona</h6> <span>Min: $150</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>California</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Colorado</h6> <span>Min: $140</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Florida</h6> <span>Min: $160</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Georgia</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Kansas</h6> <span>Min: $170</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Minnesota</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>New York</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Washington</h6> <span>Min: $130</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Location Modal End -->

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">Add a new
						address</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="fname"
								placeholder="Enter First Name"> <label for="fname">First
								Name</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="lname"
								placeholder="Enter Last Name"> <label for="lname">Last
								Name</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="email" class="form-control" id="email"
								placeholder="Enter Email Address"> <label for="email">Email
								Address</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<textarea class="form-control" placeholder="Leave a comment here"
								id="address" style="height: 100px"></textarea>
							<label for="address">Enter Address</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="email" class="form-control" id="pin"
								placeholder="Enter Pin Code"> <label for="pin">Pin
								Code</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						data-bs-dismiss="modal">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Tap to top start -->
	<div class="theme-option">
		<div class="back-to-top">
			<a id="back-to-top" href="#"> <i class="fas fa-chevron-up"></i>
			</a>
		</div>
	</div>
	<!-- Tap to top end -->

	<!-- Bg overlay Start -->
	<div class="bg-overlay"></div>
	<!-- Bg overlay End -->

	<!-- latest jquery-->
	<script src="/resources/assets/js/jquery-3.6.0.min.js"></script>

	<!-- jquery ui-->
	<script src="/resources/assets/js/jquery-ui.min.js"></script>

	<!-- Lordicon Js -->
	<script src="/resources/assets/js/lusqsztk.js"></script>

	<!-- Bootstrap js-->
	<script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/bootstrap/popper.min.js"></script>
	<script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>

	<!-- feather icon js-->
	<script src="/resources/assets/js/feather/feather.min.js"></script>
	<script src="/resources/assets/js/feather/feather-icon.js"></script>

	<!-- Lazyload Js -->
	<script src="/resources/assets/js/lazysizes.min.js"></script>

	<!-- Delivery Option js -->
	<script src="/resources/assets/js/delivery-option.js"></script>

	<!-- Slick js-->
	<script src="/resources/assets/js/slick/slick.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- Quantity js -->
	<script src="/resources/assets/js/quantity.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>

</body>
</html>