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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	var IMP = window.IMP;
	IMP.init("imp77460302") // 예: 'imp00000000a'
	function kg_pay() {
		IMP.request_pay({
			pg : "html5_inicis",
			pay_method : "card",
			merchant_uid : "ORD20180131-0000013", // 주문번호
			name : "노르웨이 회전 의자",
			amount : 100, // 숫자 타입
			buyer_email : "gildong@gmail.com",
			buyer_name : "홍길동",
			buyer_tel : "010-4242-4242",
			buyer_addr : "서울특별시 강남구 신사동",
			buyer_postcode : "01181"
		}, function(rsp) { // callback
		//rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
			if (rsp.success) {

				$.ajax({
					url : "/payOutput/",
					method : "POST",
					headers : {
						"Content-Type" : "application/json"
					},
					data : {
						imp_uid : rsp.imp_uid,
						merchant_uid : rsp.merchant_uid
					}
				}).done(function(data) {
					// 가맹점 서버 결제 API 성공시 로직
					console.log(data);
				})
			} else {
				alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
			}
		});
	}
</script>
</head>

<body>

	<jsp:include page="../header.jsp"></jsp:include>


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
				<h4>회원 주문/결제</h4>
				<!--  <form action="#"> -->
				<form>
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

							<div class="checkout__input">
								<p>
									배송지<span>*</span>
								</p>
								<input type="text" placeholder="Street Address"
									class="checkout__input__add"> <input type="text"
									placeholder="Apartment, suite, unite ect (optinal)">
							</div>
							<div class="checkout__input">
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
																src="../img/cart/cart-1.jpg" alt="">
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
							
								<div class="checkout__input">
									<p>
										쿠폰<span>*</span>
									</p>
									<input type="text">
								</div>
								<div class="checkout__input">
									<p>
										적립금<span>*</span>
									</p>
									<input type="text">
								</div>
								<div class="checkout__input">
									<p>
										포인트<span>*</span>
									</p>
									<input type="text">
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="checkout__input">
											<p>
												Phone<span>*</span>
											</p>
											<input type="text">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="checkout__input">
											<p>
												Email<span>*</span>
											</p>
											<input type="text">
										</div>
									</div>
								</div>
								<div class="checkout__input__checkbox">
									<label for="acc"> Create an account? <input
										type="checkbox" id="acc"> <span class="checkmark"></span>
									</label>
								</div>
								<p>Create an account by entering the information below. If
									you are a returning customer please login at the top of the
									page</p>
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
									<h4>Your Order</h4>
									<div class="checkout__order__products">
										Products <span>Total</span>
									</div>
									<ul>
										<li>Vegetable’s Package <span>$75.99</span></li>
										<li>Fresh Vegetable <span>$151.99</span></li>
										<li>Organic Bananas <span>$53.99</span></li>
									</ul>
									<div class="checkout__order__subtotal">
										Subtotal <span>$750.99</span>
									</div>
									<div class="checkout__order__total">
										Total <span>$750.99</span>
									</div>
									<div class="checkout__input__checkbox">
										<label for="acc-or"> Create an account? <input
											type="checkbox" id="acc-or"> <span class="checkmark"></span>
										</label>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adip elit, sed
										do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
									<div class="checkout__input__checkbox">
										<label for="payment"> Check Payment <input
											type="checkbox" id="payment"> <span class="checkmark"></span>
										</label>
									</div>
									<div class="checkout__input__checkbox">
										<label for="paypal"> Paypal <input type="checkbox"
											id="paypal"> <span class="checkmark"></span>
										</label>
									</div>
									<button type="button" class="site-btn" onclick="kg_pay()">PLACE
										ORDER</button>
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
	<script src="../js/main.js"></script>

</body>
</html>