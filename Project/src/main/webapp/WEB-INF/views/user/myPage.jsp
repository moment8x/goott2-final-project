<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style type="text/css">

body > section.blog.spad {
padding-top: 0px;
}
.memberShip {
	display: flex;
	justify-content: center;
}

.item {
	margin: 10px;
	padding: 10px 50px 10px 50px;
	border: 1px solid;
	border-radius: 10px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section{
	padding-top: 30px
}
body > section.blog.spad > div > div > div.col-lg-4.col-md-5 > div{
	padding-top: 0px;
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
										<li><a class="dropdown-item" href="#">회원정보</a></li>
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


				<div class="col-sm-8">
					<div class="memberShip">
						<div class="item">
							포인트
							<p>0점</p>
						</div>
						<div class="item">
							적립금
							<p>100원</p>
						</div>
						<div class="item">
							쿠폰
							<p>0개</p>
						</div>
					</div>
					<h4 class="mt-5">최근 주문내역</h4>
					<section class="shoping-cart spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__table">
										<table>
											<thead>
												<tr>
													<th class="shoping__product">주문번호</th>
													<th>상품</th>
													<th>가격</th>
													<th>상태</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="shoping__cart__price">1234560</td>
													<td class="shoping__cart__item"><img
														src="img/cart/cart-1.jpg" alt="" />
														<h5>Vegetable’s Package</h5></td>
													<td class="shoping__cart__price">$55.00</td>
													<td class="shoping__cart__quantity">
														<div class="quantity">
															<span>1</span>
														</div>
													</td>
													<td class="shoping__cart__total">$110.00</td>
													<td class="shoping__cart__item__close"><span
														class="icon_close"></span></td>
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
				</div>
			</div>
		</div>

	</section>

	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>s