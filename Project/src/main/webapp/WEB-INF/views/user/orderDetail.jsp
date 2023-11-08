<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Fastkart">
<meta name="keywords" content="Fastkart">
<meta name="author" content="Fastkart">
<link rel="icon" href="/resources/assets/images/favicon/1.png"
	type="image/x-icon">
<title>Dear Books</title>

<!-- Google font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">

<!-- bootstrap css -->
<link id="rtl-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/bootstrap.css">

<!-- font-awesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/font-awesome.css">

<!-- feather icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/feather-icon.css">

<!-- slick css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick.css">
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick-theme.css">

<!-- Iconly css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/bulk-style.css">

<!-- Template css -->
<link id="color-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/style.css">
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

	//회원정보 수정 주소찾기
	let newZipNo = document.querySelector("#editZipNo")
		newZipNo.value = zipNo;
	let newAddr = document.querySelector("#editAddr")
		newAddr.value = roadAddrPart1;
	let newAddrDetail = document.querySelector("#editAddrDetail")
		newAddrDetail.value = addrDetail
}

//배송주소록 수정
function shippingAddrModify(orderNo) {
	let zipCode = $('#editZipNo').val()
	let address = $('#editAddr').val()
	let detailAddress = $('#editAddrDetail').val()
	let recipient = $('#recipient').val()
	let recipientContact = $('#recipientContact').val()
	let deliveryMessage = $('#editDeliveryMsg').val()
	
	$.ajax({
		url : '/user/editDeliveryAddress', // 데이터를 수신받을 서버 주소
		type : 'post', // 통신방식(GET, POST, PUT, DELETE)
		data : {
			zipCode,
			address,
			detailAddress,
			recipient,
			recipientContact,
			deliveryMessage,
			orderNo
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			console.log(data);
				location.reload()
		},
		error : function() {
		}
	});
}

function editBasicShippingAddress() {
	
	let checkAddr = $('#checkAddr').val();

	let recipient = '${userAddrList}'

	for (let i = 0; i < recipient.length; i++) {
		let recipient_element = recipient[i];
		console.log(recipient_element[i])
		
	}
	
}
</script>
<style type="text/css">
.completeBtn Button, .btn.theme-bg-color.text-white.m-0.productStatusBtn
	{
	width: 60px;
	height: 25px;
}

.completeBtn Button span, .btn.theme-bg-color.text-white.m-0.productStatusBtn span
	{
	font-size: 12px;
}

.col-xxl-3.col-lg-4.orderInfo {
	width: 850px;
}

.moveBtn {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.infoTitle {
	font-weight: bold;
}

.infoContent {
	font-size: 8px;
}
.col-xxl-6.col-lg-12.col-sm-6.addrInfo{
	margin-bottom: 10px;
}
</style>
</head>

<body>

	<!-- Header Start -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- Header End -->

	<!-- mobile fix menu start -->
	<div class="mobile-menu d-md-none d-block mobile-cart">
		<ul>
			<li class="active"><a href="index.html"> <i
					class="iconly-Home icli"></i> <span>Home</span>
			</a></li>

			<li class="mobile-category"><a href="javascript:void(0)"> <i
					class="iconly-Category icli js-link"></i> <span>Category</span>
			</a></li>

			<li><a href="search.html" class="search-box"> <i
					class="iconly-Search icli"></i> <span>Search</span>
			</a></li>

			<li><a href="wishlist.html" class="notifi-wishlist"> <i
					class="iconly-Heart icli"></i> <span>My Wish</span>
			</a></li>

			<li><a href="cart.html"> <i
					class="iconly-Bag-2 icli fly-cate"></i> <span>Cart</span>
			</a></li>
		</ul>
	</div>
	<!-- mobile fix menu end -->

	<!-- Cart Section Start -->
	<section class="cart-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row g-sm-4 g-3">
				<div class="col-xxl-9 col-lg-8">
					<div class="cart-table order-table order-table-2">
						<div class="table-responsive">
							<h3>주문번호 ${detailOrder.orderNo }</h3>
							<h4>${detailOrder.orderTime }</h4>
							<c:forEach var="order" items="${detailOrderInfo }">
								<table class="table mb-0 productInfo">
									<tbody>
										<tr>
											<td class="product-detail">
												<div class="product border-0">
													<c:choose>
														<c:when test="${order.productInfoImage != '' }">
															<a href="product.left-sidebar.html" class="product-image">
																<img src="${order.productInfoImage }"
																class="img-fluid blur-up lazyload"
																alt="${order.productName }">
															</a>
														</c:when>
														<c:otherwise>
															<a href="product.left-sidebar.html" class="product-image">
																<img src="/resources/assets/images/noimage.jpg"
																class="img-fluid blur-up lazyload"
																alt="${order.productName }">
															</a>
														</c:otherwise>
													</c:choose>
													<div class="product-detail">
														<ul>
															<li class="name"><a
																href="product-left-thumbnail.html">${order.productName }</a></li>
														</ul>
													</div>
												</div>
											</td>

											<td class="price">
												<h4 class="table-title text-content">상품금액</h4>
												<h6 class="theme-color">${order.productPrice }</h6>
											</td>

											<td class="quantity">
												<h4 class="table-title text-content">수량</h4>
												<h4 class="text-title">${order.productQuantity }</h4>
											</td>
											<c:choose>
												<c:when test="${order.productStatus eq '출고전' }">
													<td class="subtotal">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															type="button" id="button-addon1">
															<span>취소</span>
														</button>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '입금전' }">
													<td class="subtotal">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															type="button" id="button-addon1">
															<span>취소</span>
														</button>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '출고완료' }">
													<td class="subtotal">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															type="button" id="button-addon1">
															<span>배송조회</span>
														</button>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '배송중' }">
													<td class="subtotal">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															type="button" id="button-addon1">
															<span>배송조회</span>
														</button>
													</td>
												</c:when>
												<c:otherwise>
													<td class="subtotal">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td class="completeBtn">
														<button class="btn theme-bg-color text-white m-0"
															type="button" id="button-addon1">
															<span>리뷰작성</span>
														</button>
														<button class="btn theme-bg-color text-white m-0"
															type="button" id="button-addon1">
															<span>교환</span>
														</button>
														<button class="btn theme-bg-color text-white m-0"
															type="button" id="button-addon1">
															<span>반품</span>
														</button>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</tbody>
								</table>
							</c:forEach>

							<div class="col-xxl-3 col-lg-4 orderInfo">
								<div class="row g-4">
									<div class="col-lg-12 col-sm-6 orderInfo">
										<div class="summery-box">
											<div class="summery-header">
												<h3>배송정보</h3>
												<h5 class="ms-auto theme-color"></h5>
											</div>

											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="pb-0">
													<h4 class="infoTitle">받는사람 :</h4>
													<h4 class="infoContent">${detailOrder.recipientName }</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">받는사람 연락처 :</h4>
													<h4 class="infoContent">${detailOrder.recipientPhoneNumber }</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">주소</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.zipCode }</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.shippingAddress }</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.detailedShippingAddress }</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoTitle">배송메세지 :</h4>
													<h4 class="infoContent">${detailOrder.deliveryMessage }</h4>
												</li>
												<c:if test="${detailOrder.deliveryStatus eq '출고전' }">
													<li>
														<button
															class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
															data-bs-toggle="modal" data-bs-target="#change-address">
															<i data-feather="plus" class="me-2"></i> 배송지 변경
														</button>
													</li>
												</c:if>
												<c:if test="${detailOrder.deliveryStatus eq '입금전' }">
													<li>
														<button
															class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
															data-bs-toggle="modal" data-bs-target="#change-address">
															<i data-feather="edit" class="me-2"></i> 배송지 변경
														</button>
													</li>
												</c:if>
											</ul>
										</div>
									</div>

									<div class="col-lg-12 col-sm-6 orderInfo">
										<div class="summery-box">
											<div class="summery-header d-block">
												<h3>결제정보</h3>
											</div>

											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="pb-0">
													<h4 class="infoTitle">배송비 :</h4>
													<h4 class="infoContent">${detailOrder.shippingFee }원</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">총 금액(할인전 금액) :</h4>
													<h4 class="infoContent">${detailOrder.totalAmount }원</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">사용한 포인트 :</h4>
													<h4 class="infoContent">${detailOrder.usedPoints }원</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoTitle">사용한 적립금 :</h4>
													<h4 class="infoContent">${detailOrder.usedReward }점</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoTitle">사용한 쿠폰 :</h4>
													<h4 class="infoContent">???????????</h4>
												</li>

											</ul>

											<ul class="summery-total">
												<li class="list-total border-top-0 pt-2">
													<h4 class="fw-bold">결제금액</h4>
													<h4 class="fw-bold">${detailOrder.actualPaymentAmount }원</h4>
												</li>

											</ul>

											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="pb-0">
													<h4 class="infoTitle">결제카드 :</h4>
													<h4 class="infoContent">${detailOrder.cardName }</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">결제 카드 번호 :</h4>
													<h4 class="infoContent">${detailOrder.cardNumber }원</h4>
												</li>
											</ul>
										</div>
									</div>

									<div class="col-lg-12 col-sm-6 orderInfo">
										<div class="summery-box">
											<div class="summery-header d-block">
												<h3>포인트 / 적립금</h3>
											</div>

											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="d-block pt-0">
													<p class="text-content">Pay on Delivery (Cash/Card).
														Cash on delivery (COD) available. Card/Net banking
														acceptance subject to device availability.</p>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="moveBtn">
								<button class="btn theme-bg-color text-white m-0" type="button"
									id="button-addon1" onclick="location.href='myPage';">
									<span>마이페이지로</span>
								</button>
								<button class="btn theme-bg-color text-white m-0" type="button"
									id="button-addon1" onclick="location.href='/';">
									<span>메인페이지로</span>
								</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!-- Cart Section End -->

	<!-- Footer Section Start -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Footer Section End -->

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipient"
							value="${detailOrder.recipientName }" name="recipient"
							placeholder="받는사람" /><label for="recipient">받는사람</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipientContact"
							value="${detailOrder.recipientPhoneNumber }"
							name="recipientContact" placeholder="받는사람 연락처" /><label
							for="recipientContact">받는사람 연락처</label>
						<p>- 포함해서 입력해주세요.</p>
					</div>

					<div>
						<button type="button" class="btn theme-bg-color btn-md text-white"
							onclick="goPopup();">주소 검색</button>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editZipNo" id="editZipNo"
							value="${detailOrder.zipCode }" name="zipCode" placeholder="우편번호"
							readonly /><label for="editZipNo">우편번호</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editAddr" id="editAddr"
							value="${detailOrder.shippingAddress }" name="address"
							placeholder="주소" readonly /><label for="editAddr">주소</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editAddrDetail"
							value="${detailOrder.detailedShippingAddress }"
							id="editAddrDetail" name="detailAddress" placeholder="상세주소" /><label
							for="editAddrDetail">상세주소</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editDeliveryMsg"
							value="${detailOrder.deliveryMessage }" id="editDeliveryMsg"
							name="deliveryMessage" placeholder="배송메세지" /><label
							for="editDeliveryMsg">배송메세지</label>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="editShippingAddress(${detailOrder.orderNo });"
						data-bs-dismiss="modal">변경</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="change-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 변경</h5>
					<button
						class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
						data-bs-toggle="modal" data-bs-target="#add-address">
						<i data-feather="plus" class="me-2"></i> 배송지 추가
					</button>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<c:forEach var="addr" items="${userAddrList }">
						<div class="col-xxl-6 col-lg-12 col-sm-6 addrInfo">
							<div class="contact-detail-box">
								<div class="contact-icon"></div>
								<div class="contact-detail-title">
									<h4 id="doRecipient">
										<i class="fa-solid fa-location-dot"></i> ${addr.recipient } <input
											class="form-check-input" type="radio" value="Y"
											id="checkAddr" />
									</h4>
								</div>

								<div class="contact-detail-contain">
									<div id="doRecipientContact">${addr.recipientContact }</div>
									<div id="doZipCode">${addr.zipCode }</div>
									<div id="doAddress">${addr.address }</div>
									<div id="doDetailAddress">${addr.detailAddress }</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="editBasicShippingAddress();"
						data-bs-dismiss="modal">변경</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- Deal Box Modal Start -->
	<div class="modal fade theme-modal deal-modal" id="deal-box"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<div>
						<h5 class="modal-title w-100" id="deal_today">Deal Today</h5>
						<p class="mt-1 text-content">Recommended deals for you.</p>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="deal-offer-box">
						<ul class="deal-offer-list">
							<li class="list-1">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/10.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-2">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/11.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-3">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/12.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-1">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/13.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Deal Box Modal End -->

	<!-- Tap to top start -->
	<div class="theme-option">
		<div class="back-to-top">
			<a id="back-to-top" href="#"> <i class="fas fa-chevron-up"></i>
			</a>
		</div>
	</div>
	<!-- Tap to top end -->


	<!-- Bg overlay Start -->
	<div class="bg-overlay"></div>
	<!-- Bg overlay End -->

	<!-- latest jquery-->
	<script src="/resources/assets/js/jquery-3.6.0.min.js"></script>

	<!-- jquery ui-->
	<script src="/resources/assets/js/jquery-ui.min.js"></script>

	<!-- Bootstrap js-->
	<script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>
	<script src="/resources/assets/js/bootstrap/popper.min.js"></script>

	<!-- feather icon js-->
	<script src="/resources/assets/js/feather/feather.min.js"></script>
	<script src="/resources/assets/js/feather/feather-icon.js"></script>

	<!-- Lazyload Js -->
	<script src="/resources/assets/js/lazysizes.min.js"></script>

	<!-- Slick js-->
	<script src="/resources/assets/js/slick/slick.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>
</body>
</html>