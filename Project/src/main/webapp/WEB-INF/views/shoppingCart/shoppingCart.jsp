<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>


	<div class="container">
		<!-- 장바구니 상품 리스트 -->
		<div class="basket_area">
			
		</div>
		<!-- 장바구니 금액 표기란 -->
		<div class="payments_info_area">
			<div class="payments_info_box">
				<ul class="payments_info_list">
					<li>
						상품금액
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
					<li>
						배송비
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
				</ul>
			</div>
			<div class="payments_info_box">
				<ul class="payments_info_list">
					<li>
						결제 예정 금액
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
					<li>
						적립 예정 포인트
						<div class="right_box">
							<span class="price"></span>P
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>