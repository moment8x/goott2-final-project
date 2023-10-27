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
	// 회원인지 체크
	function checkMember() {

	}
	
	function createOrderId() {
		let orderId = 'N' + new Date().getTime();
		$("#orderId").val(orderId);
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
			<form action="/order/nonMemberOrder" method="post" id="requestOrder">
			<input type='hidden' name='orderId' id='orderId'value=""/>
				<input type='checkbox' name='orderItem' value='S000208719388' checked/>도시와 그 불확실한 벽<input
					type='checkbox' name='orderItem' value='S000208698551' checked/>일론 머스크
			</form>
			<button type="button" onclick="createOrderId()">구매하기</button>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>