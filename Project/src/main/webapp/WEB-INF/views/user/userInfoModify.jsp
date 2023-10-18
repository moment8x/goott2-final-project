<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
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
	function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
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
						<form action="#" method="post">
							<div class="row">
								<div class="col-lg-8 col-md-6">
									<div class="checkout__input">
										<p>회원 등급</p>
										<input type="text" name="userGrade"
											value="${userInfo.membershipGrade }" readonly>
									</div>
									<div class="checkout__input">
										<p>아이디</p>
										<input type="text" name="memberId"
											value="${userInfo.memberId }" readonly>
									</div>
									<div class="checkout__input">
										<p>새 비밀번호</p>
										<input type="password" name="userPwd">
									</div>
									<div class="checkout__input">
										<p>새 비밀번호 확인</p>
										<input type="password" name="newUserPwd">
									</div>
									<div class="checkout__input">
										<p>이름</p>
										<input type="text" name="userName" value="${userInfo.name }"
											readonly>
									</div>
									<div class="row">
										<div class="col-lg-6">
											<div class="checkout__input">
												<p>생년월일</p>
												<input type="text" name="userBirth"
													value="${userInfo.dateOfBirth }" readonly>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="checkout__input">
												<p>성별</p>
												<input type="text" name="gender" value="${userInfo.gender }"
													readonly>
											</div>
										</div>
									</div>
									<div class="checkout__input">
										<p>이메일 주소</p>
										<input type="text" name="userEmail" value="${userInfo.email }"
											readonly>
										<button type="button" class="btn btn-outline-success">변경</button>
									</div>
									<div class="checkout__input">
										<p>휴대폰 번호</p>
										<input type="text" name="userPhoneNumber"
											value="${userInfo.phoneNumber }" readonly>
										<button type="button" class="btn btn-outline-success">변경</button>
									</div>
									<div class="checkout__input">
										<p>우편번호</p>
										<span><button type="button" class="site-btn addAddr">주소검색</button></span>
										<input type="text" name="zipNo" value="${userInfo.zipCode }"
											readonly>
									</div>
									<div class="checkout__input">
										<p>주소</p>
										<input type="text" name="addr" value="${userInfo.address }"
											readonly>
									</div>
									<div class="checkout__input">
										<p>상세주소</p>
										<input type="text" value="${userInfo.detailedAddress }"
											name="detailAddr">
									</div>
									<div class="checkout__input">
										<p>본인인증 여부</p>
										<c:choose>
											<c:when
												test="${fn:contains(userInfo.identityVerificationStatus,'Y')}">
												<input type="checkbox" name="authentication" checked
													disabled>
											</c:when>
											<c:otherwise>
												<input type="checkbox" name="authentication" disabled>
												<button>본인 인증</button>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="row">
										<div class="col-lg-6">
											<div class="checkout__input">
												<p>은행</p>
												<input type="text" name="refundBank"
													value="${userInfo.refundBank }" >
											</div>
										</div>
										<div class="col-lg-6">
											<div class="checkout__input">
												<p>환불계좌</p>
												<input type="text" name="refundAccount" value="${userInfo.refundAccount }"
													>
											</div>
										</div>
									</div>
										<button>변경</button>
								</div>

							</div>
							<button type="submit" class="site-btn">수정</button>
							<button type="button" class="site-btn">취소</button>
						</form>
						<div class="checkout__input">
							<p>회원 탈퇴</p>
							<button>탈퇴</button>
						</div>
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
							placeholder="주소" name="roadAddrPart1" readonly>
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