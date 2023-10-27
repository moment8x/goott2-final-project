<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

		// 새 비밀번호 입력 후
		$('#newPwdCheck').blur(function() {
			validUserPwd();
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

	// 유효성 검사 메세지
	function PrintMsg(focusId, msgId, msg, isFocus) {
		let divMsg = `<div class='msg'>\${msg}</div>`;
		if (isFocus == true) {
			$(`#\${focusId}`).focus();
		}else if(isFocus == false) {
			divMsg = `<div class='trueMsg'>\${msg}</div>`;
		}
		$(divMsg).insertAfter($(`#\${msgId}`));
		$('.msg').hide(5000);
		$('.trueMsg').hide(5000);
	}

	//이메일변경 버튼을 눌렀을 때
	function changeEmail() {
		$('.newEmail').show();
	}

	//이메일변경 인증번호 발송 버튼 눌렀을 때
	function sendMail() {
			if($('#newEmail').val() != ''){
			//이메일을 보내고
			$.ajax({
					url : '/user/sendMail', // 데이터를 수신받을 서버 주소
					type : 'post', // 통신방식(GET, POST, PUT, DELETE)
					data : {
						"newEmail" : $('#newEmail').val()
					},
					dataType : 'text',
					async : false,
					success : function(data) {
						console.log(data);
					}
				});
			$('.emailCode').show();		
			}else{
				$('#newEmail').blur(function () {
					PrintMsg('newEmail', 'newEmail', '이메일을 입력하고 인증버튼을 눌러주세요.', true)	
				})
			}
	}

	//비밀번호 유효성검사
	function validUserPwd() {
		let isValidPwd = false;
		
		if ($('#newPwd').val().length, $('#newPwdCheck').val().length >= 6 && $('#newPwd').val() != $('#newPwdCheck').val()) {
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			PrintMsg('newPwd', 'newPwdCheck', '비밀번호가 일치하지 않습니다. 다시 입력 해주세요.', true);
		} else if($('#newPwd').val().length, $('#newPwdCheck').val().length < 6){
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			PrintMsg('newPwd', 'newPwdCheck', '6자 이상 입력해주세요.', true);
		}else if($('#newPwd').val().length, $('#newPwdCheck').val().length >= 6 && $('#newPwd').val() == $('#newPwdCheck').val()) {
			PrintMsg('', 'newPwdCheck', '비밀번호가 일치합니다.', false);
			isValidPwd = true;
		}
		return isValidPwd;
	}
</script>
<style type="text/css">
.msg{
	color: tomato;
	font-weight: bold;
}
.trueMsg{
	font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- User Dashboard Section Start -->
	<section class="user-dashboard-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-xxl-3 col-lg-4">
					<div class="dashboard-left-sidebar">
						<div class="close-button d-flex d-lg-none">
							<button class="close-sidebar">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
						<div class="profile-box">
							<div class="cover-image">
								<img src="/resources/assets/images/deer.png"
									class="img-fluid blur-up lazyload" alt="" />
							</div>

							<div class="profile-contain">
								<div class="profile-image">
									<div class="position-relative">
										<img src="#" class="blur-up lazyload update_img" alt="" />
										<div class="cover-icon">
											<i class="fa-solid fa-pen"> <input type="file"
												onchange="readURL(this,0)" />
											</i>
										</div>
									</div>
								</div>

								<div class="profile-name">
									<h3>${userInfo.memberId }</h3>
									<h6 class="text-content">
										<img width="50" height="50"
											src="https://img.icons8.com/external-vitaliy-gorbachev-lineal-vitaly-gorbachev/60/external-deer-winter-vitaliy-gorbachev-lineal-vitaly-gorbachev.png"
											alt="external-deer-winter-vitaliy-gorbachev-lineal-vitaly-gorbachev" />${userInfo.membershipGrade }</h6>
								</div>
							</div>
						</div>

						<ul class="nav nav-pills user-nav-pills" id="pills-tab"
							role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="pills-dashboard-tab"
									data-bs-toggle="pill" data-bs-target="#pills-dashboard"
									type="button" role="tab" aria-controls="pills-dashboard"
									aria-selected="true">
									<i data-feather="home"></i> Home
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-order-tab"
									data-bs-toggle="pill" data-bs-target="#pills-order"
									type="button" role="tab" aria-controls="pills-order"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>주문내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
							<a href="userInfoModify"><button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="user"></i> 회원정보
								</button></a>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-address-tab"
									data-bs-toggle="pill" data-bs-target="#pills-address"
									type="button" role="tab" aria-controls="pills-address"
									aria-selected="false">
									<i data-feather="map-pin"></i> 배송 주소록
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-wishlist-tab"
									data-bs-toggle="pill" data-bs-target="#pills-wishlist"
									type="button" role="tab" aria-controls="pills-wishlist"
									aria-selected="false">
									<i data-feather="heart"></i> 찜
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="help-circle"></i>1:1문의내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="clipboard"></i>작성한 리뷰
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="smile"></i>포인트/쿠폰/적립금 내역
								</button>
							</li>
						</ul>
					</div>
				</div>

				<div class="col-xxl-9 col-lg-8">
					<button
						class="btn left-dashboard-show btn-animation btn-md fw-bold d-block mb-4 d-lg-none">
						Show Menu</button>
					<div class="dashboard-right-sidebar">
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-dashboard"
								role="tabpanel" aria-labelledby="pills-dashboard-tab">
								<div class="dashboard-home">
									<div class="title">
										<h2>마이페이지</h2>
										<span class="title-leaf"> <svg
												class="icon-width bg-gray">
                          <use xlink:href="resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>


								</div>
							</div>

							
							<div class="tab-pane fade show" id="pills-profile"
								role="tabpanel" aria-labelledby="pills-profile-tab">
								<div class="dashboard-profile">
									<div class="title">
										<h2>회원정보 수정</h2>
										<span class="title-leaf"> <svg
												class="icon-width bg-gray">
                          <use xlink:href="resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>

									<div class="profile-about dashboard-bg-box">
										<div class="row">
											<div class="col-xxl-7">
												<div class="dashboard-title mb-3">
													<h3>${userInfo.memberId }</h3>
												</div>

												<div class="input-box">
													<form class="row g-4" action="#" method="post">
														<div class="col-12">영어, 숫자, 특수문자 (!@#$%^*+=-) 를 1개이상
															포함하여 8-15글자로 입력해주세요.</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="password" class="form-control" id="newPwd"
																	name="newPwd" placeholder="Full Name" /> <label
																	for="newPwd">새 비밀번호</label>
															</div>
														</div>

														<div class="col-12 newPwdEdit">
															<div class="form-floating theme-form-floating">
																<input type="password" class="form-control"
																	id="newPwdCheck" name="newPwdCheck"
																	placeholder="Full Name" /> <label for="newPwdCheck">새
																	비밀번호 확인</label> <i class="fa-regular fa-circle-check fa-lg"
																	style="color: #0e997e"></i>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userName"
																	name="userName" placeholder="이름"
																	value="${userInfo.name }" readonly /> <label
																	for="userName">이름</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userBirth"
																	name="userBirth" value="${userInfo.dateOfBirth }"
																	placeholder="생년월일" readonly /> <label for="userBirth">생년월일</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userGender"
																	name="userGender" value="${userInfo.gender }"
																	placeholder="성별" readonly /> <label for="userGender">성별</label>
															</div>
														</div>
														
														<div class="col-12">
															<div
																class="form-floating theme-form-floating editPhoneNumber">
																<input type="text" class="form-control"
																	id="userPhonNumber" name="userPhonNumber"
																	value="${userInfo.phoneNumber }" placeholder="휴대폰 번호"
																	readonly /> <label for="userPhonNumber">휴대폰 번호</label>
																<i
																	class="fa-regular fa-pen-to-square fa-xl editPhoneNumber"></i>
															</div>
														</div>

														<div class="col-12 newPhoneNumberEdit">
															<div
																class="form-floating theme-form-floating editPhoneNumber">
																<input type="text" class="form-control"
																	id="newPhoneNumber" name="newPhoneNumber"
																	placeholder="새 휴대폰 번호" /> <label for="newPhoneNumber">새
																	휴대폰 번호</label>
																<button type="button"
																	class="btn theme-bg-color btn-md text-white" onclick="">
																	인증?</button>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating editEmail">
																<input type="email" class="form-control" id="userEmail"
																	name="userEmail" value="${userInfo.email }"
																	placeholder="이메일" readonly /> <label for="userEmail">이메일</label>
																<i class="fa-regular fa-pen-to-square fa-xl editEmail"></i>
															</div>
														</div>

														<div class="col-12 newEmailEdit">
															<div class="form-floating theme-form-floating editEmail">
																<input type="email" class="form-control" id="newEmail"
																	name="newEmail" placeholder="이메일" /> <label
																	for="newEmail">새 이메일</label>
															</div>
														</div>

														<div class="col-12">
															<button type="button"
																class="btn theme-bg-color btn-md text-white"
																onclick="goPopup();">주소 찾기</button>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="zipNo"
																	name="zipNo" value="${userInfo.zipCode}"
																	placeholder="우편번호" readonly /> <label for="zipNo">우편번호</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userAddr"
																	name="userAddr" value="${userInfo.address}"
																	placeholder="주소" readonly /> <label for="userAddr">주소</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control"
																	id="newAddrDatail" name="newAddrDatail"
																	value="${userInfo.detailedAddress}" placeholder="상세주소" />
																<label for="newAddrDatail">상세주소</label>
															</div>
														</div>

													<div class="col-12">
														<div class="forgot-box">
															<div class="form-check ps-0 m-0 remember-box">
																<c:choose>
																	<c:when
																		test="${fn:contains(userInfo.identityVerificationStatus,'Y')}">
																		<input class="checkbox_animated check-box"
																			type="checkbox" id="authentication" checked disabled />
																		<label class="form-check-label" for="authentication">본인인증</label>
																	</c:when>
																	<c:otherwise>
																		<input class="checkbox_animated check-box"
																			type="checkbox" id="authentication" disabled />
																		<label class="form-check-label" for="authentication">본인인증</label>
																		<button>본인 인증</button>
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
													</div>

													<div class="col-12 modifyBtn">
														<button class="btn theme-bg-color btn-md text-white"
															type="submit">수정</button>
													</div>
												</form>
													<div>
														<button
															class="btn theme-bg-color btn-md text-white delUser"
															type="button">탈퇴</button>
													</div>
												</div>

											</div>

											<div class="col-xxl-5">
												<div class="profile-image">
													<img
														src="resources/assets/images/inner-page/dashboard-profile.png"
														class="img-fluid blur-up lazyload" alt="" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>												
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- User Dashboard Section End -->

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>