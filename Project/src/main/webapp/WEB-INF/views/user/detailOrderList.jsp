<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#orderList>section {
	padding-top: 0px;
}

#returnOrderList {
	text-align: center;
}

.orderInfo {
	line-height: 1.4;
	display: block;
	background-color: #f5f5f5;
	border: 1px solid #eaeaea;
	border-radius: 16px;
	height: 60px;
	padding-top: 18px;
}

.orderInfo span {
	text-align: center;
}

#orderInfoArea {
	margin-bottom: 30px;
}
.deliveryInfo, .payInfo, .rewardInfo{
	margin-bottom: 20px;
}
.info{
	background-color: #f5f5f5;
	border: 1px solid #eaeaea;
	border-radius: 16px;
	padding: 10px;
}
.payments{
padding-left: 20px;
font-size: 13px;
}
.list-group-item{
	font-size: 15px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<section class="blog spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-5">
					<div class="blog__sidebar">

						<div class="blog__sidebar__item">
							<ul class="nav flex-column">
								<li class="nav-item"><a class="nav-link" href="orderList">주문내역</a></li>
							</ul>

							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
									href="#">회원</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="checkPwd">회원정보</a></li>
										<li><a class="dropdown-item" href="address">배송주소록</a></li>
									</ul></li>
							</ul>
							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
									href="#">활동내역</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#">찜</a></li>
										<li><a class="dropdown-item" href="#">작성한 리뷰</a></li>
										<li><a class="dropdown-item" href="#">포인트</a></li>
										<li><a class="dropdown-item" href="#">적립금</a></li>
										<li><a class="dropdown-item" href="#">쿠폰</a></li>
										<li><a class="dropdown-item" href="#">1:1 문의 내역</a></li>
									</ul></li>
							</ul>

						</div>
					</div>
				</div>


				<div class="col-sm-8" id="orderList">
					<section class="shoping-cart spad">
						<div class="container">
							<div class="row">
								<div class="orderInfo">
									<span class="">주문 날짜</span> <span>주문번호</span>
								</div>
								<div class="col-lg-12" id="orderInfoArea">
									<div class="shoping__cart__table">
										<table>
											<tbody>
												<tr>
													<td class="shoping__cart__item"><img
														src="img/cart/cart-1.jpg" alt="">
														<h5>Vegetable’s Package</h5></td>
													<td><h5>$55.00</h5></td>
													<td class="shoping__cart__quantity">
														<div class="quantity">
															<h5>1</h5>
														</div>
													</td>
													<td><h5>배송준비중</h5></td>
													<td><h5>운송장번호</h5></td>
													<td class="shoping__cart__item__close"><span
														class="icon_close"></span></td>
													<td class="shoping__cart__item__close"><span
														class="icon_close"></span></td>
													<td class="shoping__cart__item__close"><span
														class="icon_close"></span></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="deliveryInfo">
										<h4 class="info">배송정보</h4>
										<div class="mbmerOrderInfo">
											<ul class="list-group list-group-flush">
												<li class="list-group-item">수령인 이름</li>
												<li class="list-group-item">수령인 연락처</li>
												<li class="list-group-item">주소</li>
												<li class="list-group-item">배송메세지</li>
											</ul>
											
										</div>
									</div>
									<div class="payInfo">
										<h4 class="info">결제정보</h4>
										<div class="mbmerOrderInfo">
										<ul class="list-group list-group-flush">
												<li class="list-group-item">주문금액</li>
												<li class="list-group-item">포인트 사용</li>
												<li class="list-group-item">적립금 사용</li>
												<li class="list-group-item">쿠폰사용</li>
												<li class="list-group-item">총 결제 금액<span class="payments">결제 수단</span></li>
											</ul>
											
										</div>
									</div>
									<div class="rewardInfo">
										<h4 class="info">적립정보</h4>
										<div class="mbmerOrderInfo">
										<ul class="list-group list-group-flush">
												<li class="list-group-item">기본 적립</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__btns" id="returnOrderList">
										<a href="orderList" class="primary-btn cart-btn">주문내역</a>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>

	</section>


	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>