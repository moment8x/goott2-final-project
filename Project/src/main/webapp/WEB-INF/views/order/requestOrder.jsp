<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script>
	$(function() {

		$("#non_order_no").val(orderId);
		$("#non_member_id").val("1232123");
		$("#zip_code").val("12321");
		$("#delivery_status").val("출고전");
	});
	let IMP = window.IMP;
	IMP.init("${impKey}") // 예: 'imp00000000a'
	console.log("${requestScope.impKey}");
	let isPaid = false;
	let orderId = ('${requestScope.orderId}');
	console.log(orderId);
	function getOrderId() {

		console.log(orderId);
		console.log($("#non_order_no").val());
	}
	products = [ 'S000208574421', 'S000202281617' ];
	price = [ 100, 100 ];

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
			name : "노르웨이 회전 의자",
			amount : 200, // 숫자 타입
			buyer_email : "ssingfly3232@gmail.com",
			buyer_name : "김상희",
			buyer_tel : "010-4242-4242",
			buyer_addr : "서울특별시 강남구 신사동",
			buyer_postcode : "01181"

		}, function(rsp) { // callback
			//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
			if (rsp.success) { // 결제 내역 받기
				// 결제 검증 ajax
				$.ajax({
					url : '/pay/verify/' + rsp.imp_uid,
					type : "POST",
					data : rsp.imp_uid,
					async : false,
				}).done(function(data) {
					console.log(data);

					// 결제 내역 저장 ajax
					obj = {
						"payment_number" : rsp.imp_uid, // 결제번호
						"non_order_no" : rsp.merchant_uid, // 주문번호
						"payment_method" : rsp.pay_method, // 결제수단
						"total_amount" : rsp.paid_amount, // 총 상품 금액, 수정 필요
						"shipping_fee" : 0, // 배송비
						"used_points" : 0, // 사용한 포인트
						"used_reward" : 0, // 사용한 적립금
						"actual_payment_amount" : data.response.amount, // 실 결제 금액
						"payment_time" : data.response.paidAt,// 결제 시각
						"amount_to_pay" : rsp.paid_amount,
						"product_id" : products,
						"product_price" : price,
						"card_name" : data.response.cardName,
						"card_number" : data.response.cardNumber,

					// 선택한 상품 보내줘야함
					};

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
								$("#requestOrder").submit();
							}

							//return true;
							// alert("결제 완료");

						},
						error : function(error) {
							console.log(error);
							//failVerification();

						}
					})
				})
			} else {
				alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
			}
		})
	}

	// 검증 실패로 인한 취소
	function failVerification() {
		rc = {
			"imp_uid" : "imp_651936891989",
			"amount" : 200,
			"checksum" : 200,
			"reason" : "사후검증 실패로 인한 취소 테스트",
		}
		$.ajax({
			url : "/pay/cancel",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(rc),
			async : false,
			success : function(result) {
				console.log(result);
				alert("사후검증 결과 위조된 금액으로 취소 처리됐습니다.");
			},
			error : function(error) {
				alert("취소 실패" + error);

			}

		})
	}

	// 취소
	function cancelPayment() {
		rc = {
			"imp_uid" : "imp_651959197008",
			"amount" : 200,
			"checksum" : 200,
			"reason" : "전체 환불",
		}
		$.ajax({
			url : "/pay/cancel",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(rc),
			async : false,
			success : function(result) {
				console.log(result);
				alert("취소 완료");
			},
			error : function(error) {
				alert("취소 실패" + error);
			}
		})
	}

	function checkPayMethod() {

		if ($("input[name='payMethod']").is(':checked')) {
			// 전체 radio 중에서 하나라도 체크되어 있는지 확인
			// 아무것도 선택안되어있으면, false

			let payMethod = $("input[name='payMethod']:checked").val();
			// score의 라디오 중 체크된 것의 값만 가져옴
			// 아무것도 선택안되어있으면, undefined
			console.log(payMethod);
			if (payMethod == "bkt") {
				let bktPayNo = "bkt"
						+ ((String(new Date().getTime())).substring(1));
				obj = {
					"payment_number" : bktPayNo, // 결제번호 생성 코드 필요
					"non_order_no" : orderId, // 주문번호
					"payment_method" : payMethod, // 결제수단
					"total_amount" : 200, // 총 상품 금액, 수정 필요
					"shipping_fee" : 0, // 배송비
					"used_points" : 0, // 사용한 포인트
					"used_reward" : 0, // 사용한 적립금
					"actual_payment_amount" : 0, // 실 결제 금액(무통장입금은 default 0)
					"product_id" : products,
					"product_price" : price,

				};

				$.ajax({
					url : "/pay/output",
					type : "POST",
					contentType : "application/json",
					data : JSON.stringify(obj),
					async : false,
					success : function(result) {
						isPaid = true;
						console.log("ajax 결과 : ", isPaid);
						
						
						
						if (isPaid) {
							$("#requestOrder").submit();
						}
						// alert("결제 완료");
					},
					error : function(error) {

						alert("결제 실패" + error);
					}
				})
			} else {
				kg_pay();
			}
		}
	}

	//function createBktPaymentNo() {
	//	return 'bkt' + (new Date().getTime()).substring(1);
	//}
</script>
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
		<form action="orderComplete" method="post" id="requestOrder">

			<input type="hidden" name="non_order_no" id="non_order_no" value="">
			<input type="hidden" name="non_member_id" value="" id="non_member_id"><input
				type="hidden" name="zip_code" value="" id="zip_code"><input
				type="hidden" name="delivery_status" id="delivery_status" value="">
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
																			<span class="text-title"> 주소 : </span><input
																				name="shipping_address">

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content">

																			<span class="text-title">상세주소:</span><input
																				name="detailed_shipping_address">
																		</h6>
																	</li>

																	<li>
																		<h6 class="text-content">
																			<span class="text-title">수령인: </span> <input
																				name="recipient_name">
																		</h6>
																	</li>

																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">휴대폰: </span> <input
																				name="recipient_phone_number">

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">비밀번호: </span> <input
																				type="password" name="non_password">

																		</h6>
																	</li>
																	<li>
																		<h6 class="text-content mb-0">
																			<span class="text-title">이메일: </span> <input
																				name="non_email">

																		</h6>
																	</li>
																	<li>
																		<div class="col-12">
																			<div class="select-option">
																				<div class="form-floating theme-form-floating">
																					<select class="form-select theme-form-select"
																						aria-label="Default select example"
																						name="delivery_message">
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
																		id="directInput" placeholder=""></li>
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
												<h4>Delivery Option</h4>
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
																		<label class="form-check-label" for="standard">적용
																			가능한 쿠폰이 없습니다.</label>
																	</div>
																</div>
															</div>
														</div>
													</div>

													<div class="container mt-3">

														<table class="table table-borderless">

															<tbody>
																<tr>
																	<td>보유 포인트</td>
																	<td>0</td>
																	<td><input name="points"></td>
																	<td><button>전액사용</button></td>
																</tr>
																<tr>
																	<td>보유 적립금</td>
																	<td>0</td>
																	<td><input name="reward"></td>
																	<td><button>전액사용</button></td>
																</tr>

															</tbody>
														</table>
													</div>


													<div class="row g-4">
														<div class="col-xxl-6">
															<div class="delivery-option">
																<div class="delivery-category">
																	<div class="shipment-detail">
																		<div
																			class="form-check custom-form-check hide-check-box">
																			<input class="form-check-input" type="radio"
																				name="coupon" id="standard" checked> <label
																				class="form-check-label btn" for="standard"
																				data-bs-toggle="collapse" href="#collapseOne">적용
																				가능한 쿠폰이 없습니다.</label>
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
																	</form>
																</div>
															</div>
														</div>
													</div>
													-->
													</div>
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
												<h4>Payment Option</h4>
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
														<div id="flush-collapseFour"
															class="accordion-collapse collapse show"
															data-bs-parent="#accordionFlushExample">
															<div class="accordion-body">
																<p class="cod-review">
																	Pay digitally with SMS Pay Link. Cash may not be
																	accepted in COVID restricted areas. <a
																		href="javascript:void(0)">Know more.</a>
																</p>
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
														<div id="flush-collapseOne"
															class="accordion-collapse collapse"
															data-bs-parent="#accordionFlushExample">
															<div class="accordion-body">
																<div class="row g-2">
																	<div class="col-12">
																		<div class="payment-method">
																			<div
																				class="form-floating mb-lg-3 mb-2 theme-form-floating">
																				<input type="text" class="form-control" id="credit2"
																					placeholder="Enter Credit & Debit Card Number">
																				<label for="credit2">Enter Credit & Debit
																					Card Number</label>
																			</div>
																		</div>
																	</div>

																	<div class="col-xxl-4">
																		<div
																			class="form-floating mb-lg-3 mb-2 theme-form-floating">
																			<input type="text" class="form-control" id="expiry"
																				placeholder="Enter Expiry Date"> <label
																				for="expiry">Expiry Date</label>
																		</div>
																	</div>

																	<div class="col-xxl-4">
																		<div
																			class="form-floating mb-lg-3 mb-2 theme-form-floating">
																			<input type="text" class="form-control" id="cvv"
																				placeholder="Enter CVV Number"> <label
																				for="cvv">CVV Number</label>
																		</div>
																	</div>

																	<div class="col-xxl-4">
																		<div
																			class="form-floating mb-lg-3 mb-2 theme-form-floating">
																			<input type="password" class="form-control"
																				id="password" placeholder="Enter Password">
																			<label for="password">Password</label>
																		</div>
																	</div>

																	<div class="button-group mt-0">
																		<ul>
																			<li>
																				<button class="btn btn-light shopping-button">Cancel</button>
																			</li>

																			<li>
																				<button class="btn btn-animation">Use This
																					Card</button>
																			</li>
																		</ul>
																	</div>
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
														<div id="flush-collapseTwo"
															class="accordion-collapse collapse"
															data-bs-parent="#accordionFlushExample">
															<div class="accordion-body">
																<h5 class="text-uppercase mb-4">Select Your Bank</h5>
																<div class="row g-2">
																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank1"> <label class="form-check-label"
																				for="bank1">Industrial & Commercial Bank</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank2"> <label class="form-check-label"
																				for="bank2">Agricultural Bank</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank3"> <label class="form-check-label"
																				for="bank3">Bank of America</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank4"> <label class="form-check-label"
																				for="bank4">Construction Bank Corp.</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank5"> <label class="form-check-label"
																				for="bank5">HSBC Holdings</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="bank6"> <label class="form-check-label"
																				for="bank6">JPMorgan Chase & Co.</label>
																		</div>
																	</div>

																	<div class="col-12">
																		<div class="select-option">
																			<div class="form-floating theme-form-floating">
																				<select class="form-select theme-form-select"
																					aria-label="Default select example">
																					<option value="hsbc">HSBC Holdings</option>
																					<option value="loyds">Lloyds Banking Group</option>
																					<option value="natwest">Nat West Group</option>
																					<option value="Barclays">Barclays</option>
																					<option value="other">Others Bank</option>
																				</select> <label>Select Other Bank</label>
																			</div>
																		</div>
																	</div>
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
																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<label class="form-check-label" for="amazon"><input
																				class="form-check-input mt-0" type="radio"
																				id="amazon">Amazon Pay</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="gpay"> <label class="form-check-label"
																				for="gpay">Google Pay</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="airtel"> <label class="form-check-label"
																				for="airtel">Airtel Money</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="paytm"> <label class="form-check-label"
																				for="paytm">Paytm Pay</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="jio"> <label class="form-check-label"
																				for="jio">JIO Money</label>
																		</div>
																	</div>

																	<div class="col-md-6">
																		<div class="custom-form-check form-check">
																			<input class="form-check-input mt-0" type="radio"
																				id="free"> <label class="form-check-label"
																				for="free">Freecharge</label>
																		</div>
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
									<li><img
										src="/resources/assets/images/vegetable/product/1.png"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											Bell pepper <span>X 1</span>
										</h4>
										<h4 class="price">$32.34</h4></li>

									<li><img
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
										<h4 class="price">$29.69</h4></li>
								</ul>

								<ul class="summery-total">
									<li>
										<h4>Subtotal</h4>
										<h4 class="price">$111.81</h4>
									</li>

									<li>
										<h4>Shipping</h4>
										<h4 class="price">$8.90</h4>
									</li>

									<li>
										<h4>Tax</h4>
										<h4 class="price">$29.498</h4>
									</li>

									<li>
										<h4>Coupon/Code</h4>
										<h4 class="price">$-23.10</h4>
									</li>

									<li class="list-total">
										<h4>Total (USD)</h4>
										<h4 class="price">$19.28</h4>
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
										<h6>Available Offers</h6>
									</div>
								</div>

								<ul class="offer-detail">
									<li>
										<p>Combo: BB Royal Almond/Badam Californian, Extra Bold
											100 gm...</p>
									</li>
									<li>
										<p>combo: Royal Cashew Californian, Extra Bold 100 gm + BB
											Royal Honey 500 gm</p>
									</li>
								</ul>
							</div>

							<button
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								type="button" onclick="checkPayMethod()">결제하기</button>
							<button
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								type="button" onclick="cancelPayment()">취소하기</button>
							<button type="button"
								class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
								onclick="identify()">본인 인증</button>
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