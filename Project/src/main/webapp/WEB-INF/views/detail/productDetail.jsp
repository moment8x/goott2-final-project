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
	console.log("${requestScope.isLogin}");
	if("${requestScope.isLogin}" == "N") {
	$('#isLogin').val("N");
	} else {
		$('#isLogin').val("Y");
	}
})
	
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
		<div class="container">
			<a href="http://localhost:8081/detail/S000208719388"><img alt=""
				src="https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954699075.jpg"></a>
			<form action="/order/requestOrder" method="post" id="requestOrder">
				<input type='checkbox' name='productId' value='S000210833411'
					checked />상품1 <input name="productQuantity" value="2" /> <input
					type='checkbox' name='productId' value='S000210833273' checked />상품2<input
					name="productQuantity" value="1" /> <input type="hidden" id="isLogin"
					name="isLogin" value="">
				<button>구매하기</button>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>