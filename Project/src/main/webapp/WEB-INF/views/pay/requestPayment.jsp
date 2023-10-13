<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<button onclick="kg_pay()">결제하기</button>
</body>
</html>