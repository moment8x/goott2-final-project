<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
#orderHistory {
	margin-top: 30px;
	border: 1px solid #d2d2d2;
	border-radius: 10px;
}

.orderHistoryBtn {
	margin: 10px;
	width: 126px;
}

.shoping__cart__item img {
	width: 80px;
}

#totalPayments {
	width: 100px;
}

#deliveryStatus {
	width: 120px;
}

#productImg {
	width: 140px;


}
.orderName{
	text-align: center;
}
#orderList{
 margin-top: 20px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section{
 padding-top: 10px;
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
										<li><a class="dropdown-item" href="userInfo">회원정보</a></li>
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

					<h4 class="mt-5">주문내역</h4>
					<div id="orderHistory">
						<button type="button" class="btn btn-light orderHistoryBtn">
							<span>0</span>
							<p>준비중</p>
						</button>
						<button type="button" class="btn btn-light orderHistoryBtn">
							<span>0</span>
							<p>배송중</p>
						</button>
						<button type="button" class="btn btn-light orderHistoryBtn">
							<span>0</span>
							<p>배송완료</p>
						</button>
						<button type="button" class="btn btn-light orderHistoryBtn">
							<span>0</span>
							<p>취소</p>
						</button>
						<button type="button" class="btn btn-light orderHistoryBtn">
							<span>0</span>
							<p>교환/반품</p>
						</button>

					</div>
					<section class="shoping-cart spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__table">
										<c:forEach var="order" items="${orderList }">
											<table id="orderList">
												<th>${order.orderNo }<a
													href="detailOrderList?order_no=${order.orderNo }"><p>상세보기</p></a></th>
												<th colspan="3">${order.orderTime }</th>
												<th colspan="2"></th>
												<tbody>
													<tr>
													<c:choose>
													<c:when test="${order.productImage == '' }">
													<td class="shoping__cart__item" id="productImg"><i class="fa-regular fa-image fa-2xl" ></i></td>
													</c:when>
													<c:otherwise>
														<td class="shoping__cart__item" id="productImg"><a
															href="#"><img src="${order.productImage }"
																alt="${order.productName }" /></a> </td>
													</c:otherwise>
													</c:choose>
														<td class="shoping__cart__item"><a href="#"><p class="orderName">${order.productName }</p></a></td>
														<td class="shoping__cart__item" id="totalPayments">${order.actualPaymentAmount }</td>
														<td class="shoping__cart__quantity">
															<div class="quantity">
																<span>${order.totalOrderCnt }</span>
															</div>
														</td>
														<td class="shoping__cart__item" id="deliveryStatus">${order.deliveryStatus }</td>
														<td class="shoping__cart__item__close delOrderList"><span
															class="icon_close"></span></td>
													</tr>
												</tbody>
											</table>
												</c:forEach>
										${orderList }
									
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