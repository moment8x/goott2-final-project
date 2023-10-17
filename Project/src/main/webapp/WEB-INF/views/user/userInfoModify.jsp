<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script type="text/javascript">
//도로명주소API 
function goPopup() {
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("jusoPopup", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");

	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}
/** API 서비스 제공항목 확대 (2017.02) **/
function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
		roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
		detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
		buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	let address1 = document.querySelector("#zipNo")
	address1.value = zipNo;

	let address2 = document.querySelector("#roadAddrPart1")
	address2.value = roadAddrPart1;

	let address3 = document.querySelector("#addrDetail")
	address3.value = addrDetail;
}
</script>
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
					<div class="checkout__form">
						<h4>회원정보 수정</h4>
						<form action="#">
							<div class="row">
								<div class="col-lg-8 col-md-6">
									<div class="checkout__input">
										<p>회원 등급</p>
										<span>아기사슴</span>
									</div>
									<div class="checkout__input">
										<p>아이디</p>
										<input type="text">
									</div>
									<div class="checkout__input">
										<p>새 비밀번호</p>
										<input type="password">
									</div>
									<div class="checkout__input">
										<p>새 비밀번호 확인</p>
										<input type="password">
									</div>
									<div class="checkout__input">
										<p>이름</p>
										<input type="text">
									</div>
									<div class="checkout__input">
										<p>생년월일 / 성별</p>
										<span>생년월일 / 성별</span>
									</div>
									<div class="checkout__input">
										<p>이메일 주소</p>
										<span>이메일 주소</span>
										<button type="button" class="btn btn-outline-success">변경</button>
									</div>
									<div class="checkout__input">
										<p>휴대폰 번호</p>
										<span>휴대폰 번호</span>
										<button type="button" class="btn btn-outline-success">변경</button>
									</div>
									<div class="checkout__input">
										<p>우편번호</p>
										<input type="text">
									</div>
									<div class="checkout__input">
										<p>
											주소<span><button type="button" class="btn btn-outline-success addAddr">새 배송지 등록</button></span>
										</p>
										<input type="text">
									</div>
									<div class="checkout__input">
										<p>상세주소</p>
										<input type="text">
									</div>

								</div>

							</div>
					</div>
					<button type="submit" class="site-btn">수정</button>
					<button type="button" class="site-btn">취소</button>
					</form>
				</div>
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