<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(function() {

		$("#nonOrder").val(nonOrder);
		checkMember();
		console.log(nonOrder);
	})

	let nonOrder = "false";
	let isMember = false;
	let orderId = "";
	// 회원인지 체크
	function checkMember() {
		nonOrder = new URLSearchParams(location.search).get('nonOrder');
		if (nonOrder === 'true') {

			$("#nonOrder").val(nonOrder);
		}

		// 회원이면 바로 submit()하고 
		// 비회원이면 로그인/회원가입 페이지 띄움
		return isMember;
	}

	function createOrderId() {
		if (!isMember) {
			orderId = 'N' + new Date().getTime();
			
		} else {
			orderId = 'O' + new Date().getTime();
			
		}
		$("#requestOrder").submit();
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
		<div class="container">
			<a href="http://localhost:8081/detail/S000208719388"><img alt=""
				src="https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954699075.jpg"></a>
			<form action="/order/requestOrder" method="post" id="requestOrder">
				<input type='hidden' name='nonOrder' id='nonOrder' value="" /> <input
					type='hidden' name='orderId' id='orderId' value="" /> <input
					type='checkbox' name='product_id' value='S000210833411' checked/>상품1
					<input name="product_quantity" value="2" />
					<input type='checkbox' name='product_id' value='S000210833273'
					checked />상품2<input name="product_quantity" value="1" />
			</form>
			<button type="button" onclick="createOrderId()">구매하기</button>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>