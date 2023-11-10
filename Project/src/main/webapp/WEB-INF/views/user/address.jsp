<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송주소록</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 새 배송지 등록 모달열기
		$('.addAddr').click(function() {
			$('#addAddrModal').show()
		})
		//새 배송지 등록 모달창 닫기
		$('.addAddrModalClose').click(function() {
			$('#addAddrModal').hide()
		})
	})
	//도로명주소API 
	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadAddrPart1, addrDetail,zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		let address1 = document.querySelector("#zipNo")
		address1.value = zipNo;

		let address2 = document.querySelector("#roadAddrPart1")
		address2.value = roadAddrPart1;

		let address3 = document.querySelector("#addrDetail")
		address3.value = addrDetail;
	}
</script>
<style type="text/css">
body>section.blog.spad {
	padding-top: 0px;
}

#recipientPhoneNumber {
	margin-bottom: 10px;
}

#findAddr, .form-label {
	font-weight: bold;
	color: gray;
}

#inputAddrInfo {
	margin: 0px 10px 5px 10px;
}

body>section.blog.spad>div>div>div.col-sm-8>section>div>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(2)
	{
	width: 80px;
}

body>section.blog.spad>div>div>div.col-sm-8>section>div>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(3)
	{
	width: 150px;
}

body>section.blog.spad>div>div>div.col-sm-8>section>div>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(4)
	{
	width: 400px;
}

body>section.blog.spad>div>div>div.col-sm-8>section {
	padding-top: 30px;
	padding-bottom: 0px;
}

body>section.blog.spad>div>div>div.col-sm-8>section>div>div>div>div>table
	{
	width: 800px;
}
body>section.blog.spad>div>div>div.col-lg-4.col-md-5 {
	width: 300px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section:nth-child(2) > div > div > div > div > table > tbody > tr:nth-child(1) > th:nth-child(1){
	width: 100px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section:nth-child(2) > div > div > div > div > table > tbody > tr:nth-child(1) > th:nth-child(5) > button{
	width: 155px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section:nth-child(2) > div > div > div > div > table > tbody > tr:nth-child(2) > td:nth-child(4){
	width: 150px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section:nth-child(2) > div > div > div > div > table > tbody > tr:nth-child(2) > td:nth-child(5){
	width: 400px;
}
body > section.blog.spad > div > div > div.col-sm-8 > section:nth-child(2) > div > div > div > div > table > tbody > tr:nth-child(1) > th:nth-child(7){
	width: 150px;
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
					<section class="shoping-cart spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__table">
										<table>
											<tbody>
												<tr>
													<th>기본 배송지</th>
													<th></th>
													<th></th>
													<th></th>
													<th></th>
												</tr>
												<tr>
													<td>집</td>
													<td>장민정</td>
													<td>010-1234-5678</td>
													<td>[우편번호]서울시 구로구 구로동</td>
													<td class="shoping__cart__item__close"><span
														>수정</span></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</section>
					<section class="shoping-cart spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__table">
										<table>
											<tbody>
												<tr>
													<th>총 100개</th>
													<th></th>
													<th></th>
													<th></th>
													<th colspan="2"><button type="button" class="site-btn addAddr">새 배송지 등록</button></th>
													<th></th>
												</tr>
												<tr>
													<td><input type="checkbox"></td>
													<td>집</td>
													<td>장민정</td>
													<td>010-1234-5678</td>
													<td>[우편번호]서울시 구로구 구로동</td>
													<td class="shoping__cart__item__close"><span
														>수정</span></td>
													<td class="shoping__cart__item__close"><span
														>삭제</span></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</section>
					<button type="button" class="site-btn basicAddr">기본 배송지로 설정</button>
				</div>
			</div>
		</div>
	</section>

	<!-- 배송지 추가 모달 -->
	<div class="modal" id="addAddrModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">배송지 추가</h4>
					<button type="button" class="btn-close addAddrModalClose"
						data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<form action="#" id="inputAddrInfo" method="post">
					<div class="mb-3 mt-3">
						<label for="addr" class="form-label">배송지명</label> <input
							type="text" class="form-control" id="addr"
							placeholder="배송지 이름을 입력해주세요." name="addr">
					</div>
					<div class="mb-3 mt-3">
						<label for="recipientName" class="form-label">받는 분</label> <input
							type="text" class="form-control" id="recipientName"
							placeholder="이름을 입력해주세요." name="recipientName">
					</div>
					<div>
						<input type="text" class="form-control" id="recipientPhoneNumber"
							placeholder="연락처를 입력해주세요." name="recipientPhoneNumber">
					</div>
						<div>
							<button type="button" class="site-btn" onclick="goPopup();">주소
								찾기</button>
						</div>
					<div>
						<input type="text" class="form-control" id="zipNo"
							placeholder="우편번호" name="zipNo" readonly>
					</div>
					<div>
						<input type="text" class="form-control" id="roadAddrPart1"
							placeholder="주소"name="roadAddrPart1" readonly>
					</div>
					<div>
						<input type="text" class="form-control" id="addrDetail"
							placeholder="상세주소" name="addrDetail">
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-outline-success">저장</button>
						<button type="button"
							class="btn btn-outline-danger addAddrModalClose"
							data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>