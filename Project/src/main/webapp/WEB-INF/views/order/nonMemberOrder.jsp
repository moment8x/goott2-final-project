<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Ogani | Template</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
	rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="../resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="../resources/css/style.css" type="text/css">
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	var IMP = window.IMP;
	IMP.init("${impKey}") // 예: 'imp00000000a'
	let isPaid = false;
	let orderId = new URLSearchParams(location.search).get('orderId');
	function getOrderId() {

		console.log(orderId);
	}

	function getProducts() {
		$.ajax({
			url : "/order/products/" + boardNo + "/" + pageNo, // 데이터를 수신받을 서버 주소
			type : "get", // 통신방식(GET, POST, PUT, DELETE)
			dataType : "json",
			async : false, // 데이터가 오면 실행해야해서
			success : function(data) {
				console.log(data);
				console.log(data.replyList);
				displayAllReplies(data.replyList);
			},
			error : function() {
				alert("error 발생"); // http status로 부정적인 응답 받았을 때 error에 걸림
			}
		});
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
							} else {
								alert("본인인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
							}
						});
	}
	function kg_pay() {

		IMP.request_pay({ // 결제 정보 채우기
			pg : "html5_inicis",
			pay_method : "card",
			merchant_uid : orderId, // 주문번호
			name : "노르웨이 회전 의자",
			amount : 100, // 숫자 타입
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
					};

					$.ajax({
						url : "/pay/output",
						type : "POST",
						contentType : "application/json",
						data : JSON.stringify(obj),
						success : function(result) {
							alert("결제 완료");
						},
						error : function(error) {
							alert("결제 실패" + error);
						}
					})
				})
			} else {
				alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
			}
		})

	}

	function paidCheck() {
		isPaid = false;
		kg_pay();
		return isPaid;

	}
</script>
</head>

<body>

	<jsp:include page="../header.jsp"></jsp:include>
	<c:set var="contextPath" value="<%=request.getContextPath()%>" />

	<!-- Checkout Section Begin -->
	<section class="checkout spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h6>
						<span class="icon_tag_alt"></span> Have a coupon? <a href="#">Click
							here</a> to enter your code
					</h6>
				</div>
			</div>
			<div class="checkout__form">
				<h4>비회원 주문/결제</h4>
				<!--  <form action="#"> -->
				<form action="orderComplete" method="post">
					<div class="row">
						<div class="col-lg-8 col-md-6">
							<!-- <div class="row">
								 <div class="col-lg-6">
									<div class="checkout__input">
										<p>
											Fist Name<span>*</span>
										</p>
										<input type="text">
									</div>
								</div>
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											Last Name<span>*</span>
										</p>
										<input type="text">
									</div>
								</div> 
							</div> -->

							<div class="col-lg-6">
								<div class="checkout__input">
									<p>
										이름<span>*</span>
									</p>
									<input type="text" name=recipient_name>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="checkout__input">
									<p>
										휴대폰번호<span>*</span>
									</p>
									<input type="text" name="recipient_phone_number">
								</div>
							</div>
							<div class="col-lg-6">
								<div class="checkout__input">
									<p>
										이메일<span>*</span>
									</p>
									<input type="text" name="non_email">
								</div>
							</div>
							<div class="col-lg-6">
								<div class="checkout__input">
									<p>
										비밀번호<span>*</span>
									</p>
									<input type="password" name="non_password">
								</div>
							</div>
							<div class="col-lg-6">
								<div class="checkout__input">
									<p>
										비밀번호 확인<span>*</span>
									</p>
									<input type="password">
								</div>
							</div>
							<div class="checkout__input col-lg-10">
								<p>
									배송지<span>*</span>
								</p>
								<input type="text" placeholder="Street Address"
									class="checkout__input__add" name="shipping_address"> <input
									type="text" placeholder="Apartment, suite, unite ect (optinal)"
									name="detailed_shipping_address">
							</div>
							<div class="checkout__input col-lg-10">
								<p>
									배송메시지<span>*</span>
								</p>
								<input type="text">
							</div>
							<!-- Shoping Cart Section Begin -->
							<section class="shoping-cart spad">
								<div class="container">
									<div class="row">
										<div class="col-lg-12">
											<div class="shoping__cart__table">
												<table>
													<thead>
														<tr>
															<th class="shoping__product">주문상품</th>
															<!--  <th>Price</th>
															<th>Quantity</th>
															<th>Total</th>
															<th></th>-->
														</tr>
													</thead>
													<tbody>
														<tr>
															<td class="shoping__cart__item"><img
																src="../resources/img/cart/cart-1.jpg" alt="">
																<h5>Vegetable’s Package</h5></td>
															<td class="shoping__cart__price">$55.00</td>
															<td class="shoping__cart__quantity">
																<div class="quantity">
																	<div class="pro-qty">
																		<input type="text" value="1">
																	</div>
																</div>
															</td>
															<td class="shoping__cart__total">$110.00</td>
															<td class="shoping__cart__item__close"><span
																class="icon_close"></span></td>
														</tr>
														<tr>
															<td class="shoping__cart__item"><img
																src="../img/cart/cart-2.jpg" alt="">
																<h5>Fresh Garden Vegetable</h5></td>
															<td class="shoping__cart__price">$39.00</td>
															<td class="shoping__cart__quantity">
																<div class="quantity">
																	<div class="pro-qty">
																		<input type="text" value="1">
																	</div>
																</div>
															</td>
															<td class="shoping__cart__total">$39.99</td>
															<td class="shoping__cart__item__close"><span
																class="icon_close"></span></td>
														</tr>
														<tr>
															<td class="shoping__cart__item"><img
																src="../img/cart/cart-3.jpg" alt="">
																<h5>Organic Bananas</h5></td>
															<td class="shoping__cart__price">$69.00</td>
															<td class="shoping__cart__quantity">
																<div class="quantity">
																	<div class="pro-qty">
																		<input type="text" value="1">
																	</div>
																</div>
															</td>
															<td class="shoping__cart__total">$69.99</td>
															<td class="shoping__cart__item__close"><span
																class="icon_close"></span></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</section>



							<div class="checkout__input__checkbox">
								<label for="acc"> Create an account? <input
									type="checkbox" id="acc"> <span class="checkmark"></span>
								</label>
							</div>
							<p>Create an account by entering the information below. If
								you are a returning customer please login at the top of the page</p>
							<div class="checkout__input">
								<p>
									Account Password<span>*</span>
								</p>
								<input type="text">
							</div>
							<div class="checkout__input__checkbox">
								<label for="diff-acc"> Ship to a different address? <input
									type="checkbox" id="diff-acc"> <span class="checkmark"></span>
								</label>
							</div>
							<div class="checkout__input">
								<p>
									Order notes<span>*</span>
								</p>
								<input type="text"
									placeholder="Notes about your order, e.g. special notes for delivery.">
							</div>
						</div>
						<div class="col-lg-4 col-md-6">
							<div class="checkout__order">
								<h4>주문상세</h4>
								<div class="checkout__order__products">
									상품 <span>가격</span>
								</div>
								<ul>
									<li>도시와 그 불확실한 벽 <span>$75.99</span></li>
									<li>미스우렁의 스토킹일지 <span>$151.99</span></li>
									<li>일론 머스크 <span>$53.99</span></li>
								</ul>
								<div class="checkout__order__subtotal">
									상품금액 <span>$750.99</span>
								</div>
								<div class="checkout__order__total">
									최종결제금액 <span>$750.99</span>
								</div>
								<div class="checkout__input__checkbox">
									<label for="acc-or"> 위 주문내용을 확인하였으며, 결제에 동의합니다. <input
										type="checkbox" id="acc-or"> <span class="checkmark"></span>
									</label>
								</div>
								<!-- 약관 -->
								<iframe src="../resources/terms.txt"></iframe>

								<!--  <p>Lorem ipsum dolor sit amet, consectetur adip elit, sed do
									eiusmod tempor incididunt ut labore et dolore magna aliqua.</p> 
								<div class="checkout__input__checkbox">
									<label for="payment"> Check Payment <input
										type="checkbox" id="payment"> <span class="checkmark"></span>
									</label>
								</div>
								<div class="checkout__input__checkbox">
									<label for="paypal"> Paypal <input type="checkbox"
										id="paypal"> <span class="checkmark"></span>
									</label>
								</div> -->
								<button type="submit" class="site-btn"
									onclick="return paidCheck();">결제하기</button>
								<!--  <button type="button" class="site-btn" onclick="identify()">본인
									인증</button> -->
								<button type="button" onclick="getOrderId();">test</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	<!-- Checkout Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>


	<!-- Js Plugins -->
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.nice-select.min.js"></script>
	<script src="../js/jquery-ui.min.js"></script>
	<script src="../js/jquery.slicknav.js"></script>
	<script src="../js/mixitup.min.js"></script>
	<script src="../js/owl.carousel.min.js"></script>
	<!--  <script src="../js/main.js"></script>-->

</body>
</html>