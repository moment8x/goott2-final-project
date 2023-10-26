<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Fastkart" />
<meta name="keywords" content="Fastkart" />
<meta name="author" content="Fastkart" />
<link rel="icon" href="/resources/assets/images/favicon/1.png"
	type="image/x-icon" />
<title>마이페이지</title>

<!-- Google font -->
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet" />

<!-- bootstrap css -->
<link id="rtl-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/bootstrap.css" />

<!-- font-awesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/font-awesome.css" />

<!-- feather icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/feather-icon.css" />

<!-- slick css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick-theme.css" />

<!-- Iconly css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/bulk-style.css" />

<!-- Template css -->
<link id="color-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/style.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
		let newZipNo = document.querySelector("#newZipNo")
		newZipNo.value = zipNo;

		let newAddr = document.querySelector("#newAddr")
		newAddr.value = roadAddrPart1;

		let newAddrDatail = document.querySelector("#newAddrDatail")
		newAddrDatail.value = addrDetail;
	}

	$(function() {
		//변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.editPhoneNumber').click(
				function() {
					$('.newPhoneNumberEdit').show();
				})
		$('.fa-regular.fa-pen-to-square.fa-xl.editEmail').click(function() {
			$('.newEmailEdit').show();
		})

		// 새 비밀번호 입력 후
		$('#newPwdCheck').blur(function() {
			validUserPwd();
		})
	})

	// 유효성 검사 메세지
	function printMsg(focusId, msgId, msg, isFocus) {
		let divMsg = `<div class='msg'>\${msg}</div>`;
		if (isFocus == true) {
			$(`#\${focusId}`).focus();
		} else if (isFocus == false) {
			divMsg = `<div class='trueMsg'>\${msg}</div>`;
		}
		$(divMsg).insertAfter($(`#\${msgId}`));
		$('.msg').hide(10000);
	}

	//비밀번호 유효성검사
	function validUserPwd() {
		let isValidPwd = false;
		let reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		let pwd = $('#newPwd').val();
		let pwdCheck = $('#newPwdCheck').val();

		if (!reg.test(pwd) && !reg.test(pwdCheck)) {
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			$('.fa-regular.fa-circle-check.fa-lg').hide();
			printMsg('newPwd', 'newPwdCheck',
					'영어, 숫자, 특수문자(!@#$%^*+=-)를 1개이상 포함하여 8-15글자로 입력해주세요.', true)
		} else if (pwd != pwdCheck) {
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			$('.fa-regular.fa-circle-check.fa-lg').hide();
			printMsg('newPwd', 'newPwdCheck', '비밀번호가 일치하지 않습니다. 다시 입력해주세요.',
					true)
		} else if (reg.test(pwd) && reg.test(pwdCheck) && pwd == pwdCheck) {
			printMsg('', 'newPwdCheck', '', false);
			$('.fa-regular.fa-circle-check.fa-lg').show();
			isValidPwd = true;
		}
		return isValidPwd;
	}

	function sendMail() {
		let isValidEamil = false;
		$.ajax({
			url : '/user/sendMail', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				tmpEmail : $('#newEmail').val()
			},
			async : false,
			dataType : 'json',
			success : function(data) {
				console.log(data);
				if (data === null) {
					$('.mailCode').show();
					printMsg("", "newEmail", "사용가능한 이메일 입니다.", false)
				}else{
					
					$('#newEmail').val('');
					printMsg("newEmail", "newEmail", "중복된 이메일 입니다.", true)
				}
			},
			error : function() {
			}
		});
	}
</script>
<style>
#deliveryStatus {
	display: flex;
}

#productImg {
	width: 184px;
}

.fa-regular.fa-circle-check.fa-lg, .newPhoneNumberEdit, .newEmailEdit,
	.mailCode {
	display: none;
}

.fa-regular.fa-pen-to-square.fa-xl.editPhoneNumber, .fa-regular.fa-pen-to-square.fa-xl.editEmail
	{
	cursor: pointer;
	text-align: center;
}

.msg {
	color: tomato;
	font-weight: bold;
}

.trueMsg {
	font-weight: bold;
}

.col-12.modifyBtn {
	display: flex;
	justify-content: center;
}

.form-floating.theme-form-floating.editPhoneNumber, .form-floating.theme-form-floating.editEmail
	{
	display: flex;
	justify-content: flex-end;
}

.btn.theme-bg-color.btn-md.text-white.delUser {
	
}
</style>
</head>

<body>
	<!-- Loader Start -->

	<!-- Loader End -->

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

	<!-- Breadcrumb Section Start -->
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>MyPage</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">
									마이페이지</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

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
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="user"></i> 회원정보
								</button>
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
                          <use xlink:href="../assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>

									<div class="total-box">
										<div class="row g-sm-4 g-3">
											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="../assets/images/svg/order.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="../assets/images/svg/order.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>포인트</h5>
														<h3>3658</h3>
													</div>
												</div>
											</div>

											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="../assets/images/svg/pending.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="../assets/images/svg/pending.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>적립금</h5>
														<h3>254</h3>
													</div>
												</div>
											</div>

											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="../assets/images/svg/wishlist.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="../assets/images/svg/wishlist.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>쿠폰</h5>
														<h3>32158</h3>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="dashboard-title">
										<h3>최근 주문내역</h3>
									</div>

									<section class="cart-section section-b-space">
										<div class="container-fluid-lg">
											<div class="row g-sm-5 g-3">
												<div class="col-xxl-9">
													<div class="cart-table">
														<div class="table-responsive-xl">
															<table class="table">
																<tbody>
																	<tr class="product-box-contain">
																		<td class="product-detail">
																			<div class="product border-0">
																				<a href="product-left-thumbnail.html"
																					class="product-image"> <img
																					src="../assets/images/vegetable/product/1.png"
																					class="img-fluid blur-up lazyload" alt="" />
																				</a>
																				<div class="product-detail">
																					<ul>
																						<li class="name"><a
																							href="product-left-thumbnail.html">Bell
																								pepper</a></li>

																						<li class="text-content"><span
																							class="text-title">Sold By:</span> Fresho</li>

																						<li class="text-content"><span
																							class="text-title">Quantity</span> - 500 g</li>

																						<li>
																							<h5 class="text-content d-inline-block">
																								Price :</h5> <span>$35.10</span> <span
																							class="text-content">$45.68</span>
																						</li>

																						<li>
																							<h5 class="saving theme-color">Saving :
																								$20.68</h5>
																						</li>

																						<li class="quantity-price-box">
																							<div class="cart_qty">
																								<div class="input-group">
																									<button type="button"
																										class="btn qty-left-minus" data-type="minus"
																										data-field="">
																										<i class="fa fa-minus ms-0" aria-hidden="true"></i>
																									</button>
																									<input
																										class="form-control input-number qty-input"
																										type="text" name="quantity" value="0" />
																									<button type="button"
																										class="btn qty-right-plus" data-type="plus"
																										data-field="">
																										<i class="fa fa-plus ms-0" aria-hidden="true"></i>
																									</button>
																								</div>
																							</div>
																						</li>

																						<li>
																							<h5>Total: $35.10</h5>
																						</li>
																					</ul>
																				</div>
																			</div>
																		</td>

																		<td class="price">
																			<h4 class="table-title text-content">Price</h4>
																			<h5>
																				$35.10
																				<del class="text-content">$45.68</del>
																			</h5>
																			<h6 class="theme-color">You Save : $20.68</h6>
																		</td>

																		<td class="quantity">
																			<h4 class="table-title text-content">Qty</h4>
																			<div class="quantity-price">
																				<div class="cart_qty">
																					<div class="input-group">
																						<button type="button" class="btn qty-left-minus"
																							data-type="minus" data-field="">
																							<i class="fa fa-minus ms-0" aria-hidden="true"></i>
																						</button>
																						<input class="form-control input-number qty-input"
																							type="text" name="quantity" value="0" />
																						<button type="button" class="btn qty-right-plus"
																							data-type="plus" data-field="">
																							<i class="fa fa-plus ms-0" aria-hidden="true"></i>
																						</button>
																					</div>
																				</div>
																			</div>
																		</td>

																		<td class="subtotal">
																			<h4 class="table-title text-content">Total</h4>
																			<h5>$35.10</h5>
																		</td>

																		<td class="save-remove">
																			<h4 class="table-title text-content">Action</h4> <a
																			class="save notifi-wishlist"
																			href="javascript:void(0)">Save for later</a> <a
																			class="remove close_button" href="javascript:void(0)">Remove</a>
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</section>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-wishlist"
								role="tabpanel" aria-labelledby="pills-wishlist-tab">
								<div class="dashboard-wishlist">
									<div class="title">
										<h2>My Wishlist History</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use xlink:href="../assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>
									<div class="row g-sm-4 g-3">
										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/2.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Vegetable</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Fresh Bread and Pastry Flour 200 g
															</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Cheesy feet cheesy grin brie. Mascarpone cheese and wine
															hard cheese the big cheese everyone loves smelly cheese
															macaroni cheese croque monsieur.</p>
														<h6 class="unit mt-1">250 ml</h6>
														<h5 class="price">
															<span class="theme-color">$08.02</span>
															<del>$15.15</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/3.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Vegetable</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Peanut Butter Bite Premium Butter
																Cookies 600 g</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Feta taleggio croque monsieur swiss manchego cheesecake
															dolcelatte jarlsberg. Hard cheese danish fontina boursin
															melted cheese fondue.</p>
														<h6 class="unit mt-1">350 G</h6>
														<h5 class="price">
															<span class="theme-color">$04.33</span>
															<del>$10.36</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/4.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Snacks</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">SnackAmor Combo Pack of Jowar Stick
																and Jowar Chips</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Lancashire hard cheese parmesan. Danish fontina
															mozzarella cream cheese smelly cheese cheese and wine
															cheesecake dolcelatte stilton. Cream cheese parmesan who
															moved my cheese when the cheese comes out everybody's
															happy cream cheese red leicester ricotta edam.</p>
														<h6 class="unit mt-1">570 G</h6>
														<h5 class="price">
															<span class="theme-color">$12.52</span>
															<del>$13.62</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/5.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Snacks</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Yumitos Chilli Sprinkled Potato
																Chips 100 g</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Cheddar cheddar pecorino hard cheese hard cheese cheese
															and biscuits bocconcini babybel. Cow goat paneer cream
															cheese fromage cottage cheese cauliflower cheese
															jarlsberg.</p>
														<h6 class="unit mt-1">100 G</h6>
														<h5 class="price">
															<span class="theme-color">$10.25</span>
															<del>$12.36</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/6.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Vegetable</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Fantasy Crunchy Choco Chip Cookies
															</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Bavarian bergkase smelly cheese swiss cut the cheese
															lancashire who moved my cheese manchego melted cheese.
															Red leicester paneer cow when the cheese comes out
															everybody's happy croque monsieur goat melted cheese
															port-salut.</p>
														<h6 class="unit mt-1">550 G</h6>
														<h5 class="price">
															<span class="theme-color">$14.25</span>
															<del>$16.57</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/7.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Vegetable</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Fresh Bread and Pastry Flour 200 g
															</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Melted cheese babybel chalk and cheese. Port-salut
															port-salut cream cheese when the cheese comes out
															everybody's happy cream cheese hard cheese cream cheese
															red leicester.</p>
														<h6 class="unit mt-1">1 Kg</h6>
														<h5 class="price">
															<span class="theme-color">$12.68</span>
															<del>$14.69</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6">
											<div class="product-box-3 theme-bg-white h-100">
												<div class="product-header">
													<div class="product-image">
														<a href="product-left-thumbnail.html"> <img
															src="../assets/images/cake/product/2.png"
															class="img-fluid blur-up lazyload" alt="" />
														</a>

														<div class="product-header-top">
															<button class="btn wishlist-button close_button">
																<i data-feather="x"></i>
															</button>
														</div>
													</div>
												</div>

												<div class="product-footer">
													<div class="product-detail">
														<span class="span-name">Vegetable</span> <a
															href="product-left-thumbnail.html">
															<h5 class="name">Fresh Bread and Pastry Flour 200 g
															</h5>
														</a>
														<p class="text-content mt-1 mb-2 product-content">
															Squirty cheese cottage cheese cheese strings. Red
															leicester paneer danish fontina queso lancashire when the
															cheese comes out everybody's happy cottage cheese paneer.
														</p>
														<h6 class="unit mt-1">250 ml</h6>
														<h5 class="price">
															<span class="theme-color">$08.02</span>
															<del>$15.15</del>
														</h5>
														<div class="add-to-cart-box mt-2">
															<button class="btn btn-add-cart addcart-button"
																tabindex="0">
																Add <span class="add-icon"> <i
																	class="fa-solid fa-plus"></i>
																</span>
															</button>
															<div class="cart_qty qty-box">
																<div class="input-group">
																	<button type="button" class="qty-left-minus"
																		data-type="minus" data-field="">
																		<i class="fa fa-minus" aria-hidden="true"></i>
																	</button>
																	<input class="form-control input-number qty-input"
																		type="text" name="quantity" value="0" />
																	<button type="button" class="qty-right-plus"
																		data-type="plus" data-field="">
																		<i class="fa fa-plus" aria-hidden="true"></i>
																	</button>
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

							<div class="tab-pane fade show" id="pills-order" role="tabpanel"
								aria-labelledby="pills-order-tab">
								<div class="dashboard-order">
									<div class="title">
										<h2>주문내역</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use xlink:href="../assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>

										<div id="deliveryStatus">
											<button
												class="btn theme-bg-color text-white m-0 deliveryStatusBtn"
												type="button" id="button-addon1">
												<span>준비중</span> <span>0</span>
											</button>
											<button
												class="btn theme-bg-color text-white m-0 deliveryStatusBtn"
												type="button" id="button-addon1">
												<span>배송중</span> <span>0</span>
											</button>
											<button
												class="btn theme-bg-color text-white m-0 deliveryStatusBtn"
												type="button" id="button-addon1">
												<span>배송완료</span> <span>0</span>
											</button>
											<button
												class="btn theme-bg-color text-white m-0 deliveryStatusBtn"
												type="button" id="button-addon1">
												<span>취소</span> <span>0</span>
											</button>
											<button
												class="btn theme-bg-color text-white m-0 deliveryStatusBtn"
												type="button" id="button-addon1">
												<span>교환/반품</span> <span>0</span>
											</button>
										</div>
									</div>
									<div class="order-contain">
										<div class="order-box dashboard-bg-box">

											${orderList }

											<div class="product-order-detail">
												<c:forEach var="order" items="${orderList }">
													<a href="#" class="order-image"> <img
														src="${order.productImage }" class="blur-up lazyload"
														alt="${order.productName }" id="productImg" />
													</a>

													<div class="order-wrap">
														<h3>${order.orderNo }</h3>
														<p class="text-content">${order.orderTime }</p>
														<a href="#">
															<h3>${order.productName }</h3>
														</a>
														<ul class="product-size">
															<li>
																<div class="size-box">
																	<h6 class="text-content">총 수량 :</h6>
																	<h5>${order.totalOrderCnt }</h5>
																</div>
															</li>



															<li>
																<div class="size-box">
																	<h6 class="text-content">총 결제금액 :</h6>
																	<h5>${order.actualPaymentAmount }</h5>
																</div>
															</li>

															<li>
																<div class="size-box">
																	<h6 class="text-content">Quantity :</h6>
																	<h5>250 G</h5>
																</div>
															</li>
														</ul>
													</div>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade show" id="pills-address"
								role="tabpanel" aria-labelledby="pills-address-tab">
								<div class="dashboard-address">
									<div class="title title-flex">
										<div>
											<h2>배송주소록</h2>
											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="../assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>

										<button
											class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
											data-bs-toggle="modal" data-bs-target="#add-address">
											<i data-feather="plus" class="me-2"></i> 배송지 추가
										</button>
									</div>

									<div class="row g-sm-4 g-3">
										<div class="col-xxl-4 col-xl-6 col-lg-12 col-md-6">
											<div class="address-box">
												<div>
													<div class="form-check">
														<input class="form-check-input" type="radio" name="jack"
															id="flexRadioDefault1" />
													</div>

													<div class="label">
														<label>Home 2</label>
													</div>

													<div class="table-responsive address-table">
														<table class="table">
															<tbody>
																<tr>
																	<td colspan="2">Gary M. Bailey</td>
																</tr>

																<tr>
																	<td>Address :</td>
																	<td>
																		<p>2135 Burning Memory Lane Philadelphia, PA 19135</p>
																	</td>
																</tr>

																<tr>
																	<td>Pin Code :</td>
																	<td>+26</td>
																</tr>

																<tr>
																	<td>Phone :</td>
																	<td>+ 215-335-9916</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>

												<div class="button-group">
													<button class="btn btn-sm add-button w-100"
														data-bs-toggle="modal" data-bs-target="#editProfile">
														<i data-feather="edit"></i> Edit
													</button>
													<button class="btn btn-sm add-button w-100"
														data-bs-toggle="modal" data-bs-target="#removeProfile">
														<i data-feather="trash-2"></i> Remove
													</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-card" role="tabpanel"
								aria-labelledby="pills-card-tab">
								<div class="dashboard-card">
									<div class="title title-flex">
										<div>
											<h2>My Card Details</h2>
											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="../assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>

										<button
											class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
											data-bs-toggle="modal" data-bs-target="#editCard">
											<i data-feather="plus" class="me-2"></i> Add New Card
										</button>
									</div>

									<div class="row g-4">
										<div class="col-xxl-4 col-xl-6 col-lg-12 col-sm-6">
											<div class="payment-card-detail">
												<div class="card-details">
													<div class="card-number">
														<h4>XXXX - XXXX - XXXX - 2548</h4>
													</div>

													<div class="valid-detail">
														<div class="title">
															<span>valid</span> <span>thru</span>
														</div>
														<div class="date">
															<h3>08/05</h3>
														</div>
														<div class="primary">
															<span class="badge bg-pill badge-light">primary</span>
														</div>
													</div>

													<div class="name-detail">
														<div class="name">
															<h5>Audrey Carol</h5>
														</div>
														<div class="card-img">
															<img src="../assets/images/payment-icon/1.jpg"
																class="img-fluid blur-up lazyloaded" alt="" />
														</div>
													</div>
												</div>

												<div class="edit-card">
													<a data-bs-toggle="modal" data-bs-target="#editCard"
														href="javascript:void(0)"><i class="far fa-edit"></i>
														edit</a> <a href="javascript:void(0)" data-bs-toggle="modal"
														data-bs-target="#removeProfile"><i
														class="far fa-minus-square"></i> delete</a>
												</div>
											</div>

											<div class="edit-card-mobile">
												<a data-bs-toggle="modal" data-bs-target="#editCard"
													href="javascript:void(0)"><i class="far fa-edit"></i>
													edit</a> <a href="javascript:void(0)"><i
													class="far fa-minus-square"></i> delete</a>
											</div>
										</div>

										<div class="col-xxl-4 col-xl-6 col-lg-12 col-sm-6">
											<div class="payment-card-detail">
												<div class="card-details card-visa">
													<div class="card-number">
														<h4>XXXX - XXXX - XXXX - 1536</h4>
													</div>

													<div class="valid-detail">
														<div class="title">
															<span>valid</span> <span>thru</span>
														</div>
														<div class="date">
															<h3>12/23</h3>
														</div>
														<div class="primary">
															<span class="badge bg-pill badge-light">primary</span>
														</div>
													</div>

													<div class="name-detail">
														<div class="name">
															<h5>Leah Heather</h5>
														</div>
														<div class="card-img">
															<img src="../assets/images/payment-icon/2.jpg"
																class="img-fluid blur-up lazyloaded" alt="" />
														</div>
													</div>
												</div>

												<div class="edit-card">
													<a data-bs-toggle="modal" data-bs-target="#editCard"
														href="javascript:void(0)"><i class="far fa-edit"></i>
														edit</a> <a href="javascript:void(0)" data-bs-toggle="modal"
														data-bs-target="#removeProfile"><i
														class="far fa-minus-square"></i> delete</a>
												</div>
											</div>

											<div class="edit-card-mobile">
												<a data-bs-toggle="modal" data-bs-target="#editCard"
													href="javascript:void(0)"><i class="far fa-edit"></i>
													edit</a> <a href="javascript:void(0)"><i
													class="far fa-minus-square"></i> delete</a>
											</div>
										</div>

										<div class="col-xxl-4 col-xl-6 col-lg-12 col-sm-6">
											<div class="payment-card-detail">
												<div class="card-details dabit-card">
													<div class="card-number">
														<h4>XXXX - XXXX - XXXX - 1366</h4>
													</div>

													<div class="valid-detail">
														<div class="title">
															<span>valid</span> <span>thru</span>
														</div>
														<div class="date">
															<h3>05/21</h3>
														</div>
														<div class="primary">
															<span class="badge bg-pill badge-light">primary</span>
														</div>
													</div>

													<div class="name-detail">
														<div class="name">
															<h5>mark jecno</h5>
														</div>
														<div class="card-img">
															<img src="../assets/images/payment-icon/3.jpg"
																class="img-fluid blur-up lazyloaded" alt="" />
														</div>
													</div>
												</div>

												<div class="edit-card">
													<a data-bs-toggle="modal" data-bs-target="#editCard"
														href="javascript:void(0)"><i class="far fa-edit"></i>
														edit</a> <a href="javascript:void(0)" data-bs-toggle="modal"
														data-bs-target="#removeProfile"><i
														class="far fa-minus-square"></i> delete</a>
												</div>
											</div>

											<div class="edit-card-mobile">
												<a data-bs-toggle="modal" data-bs-target="#editCard"
													href="javascript:void(0)"><i class="far fa-edit"></i>
													edit</a> <a href="javascript:void(0)"><i
													class="far fa-minus-square"></i> delete</a>
											</div>
										</div>
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
                          <use xlink:href="../assets/svg/leaf.svg#leaf"></use>
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
																<button type="button"
																	class="btn theme-bg-color btn-md text-white"
																	onclick="sendMail();">인증</button>
															</div>
														</div>

														<div class="col-12 mailCode">
															<div class="form-floating theme-form-floating editEmail">
																<input type="text" class="form-control" id="emailCode"
																	name="emailCode" placeholder="인증코드" /> <label
																	for="emailCode">인증코드</label>
																<button type="button"
																	class="btn theme-bg-color btn-md text-white" onclick="">확인</button>
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
														src="../assets/images/inner-page/dashboard-profile.png"
														class="img-fluid blur-up lazyload" alt="" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-security"
								role="tabpanel" aria-labelledby="pills-security-tab">
								<div class="dashboard-privacy">
									<div class="dashboard-bg-box">
										<div class="dashboard-title mb-4">
											<h3>Privacy</h3>
										</div>

										<div class="privacy-box">
											<div class="d-flex align-items-start">
												<h6>Allows others to see my profile</h6>
												<div class="form-check form-switch switch-radio ms-auto">
													<input class="form-check-input" type="checkbox"
														role="switch" id="redio" aria-checked="false" /> <label
														class="form-check-label" for="redio"></label>
												</div>
											</div>

											<p class="text-content">all peoples will be able to see
												my profile</p>
										</div>

										<div class="privacy-box">
											<div class="d-flex align-items-start">
												<h6>who has save this profile only that people see my
													profile</h6>
												<div class="form-check form-switch switch-radio ms-auto">
													<input class="form-check-input" type="checkbox"
														role="switch" id="redio2" aria-checked="false" /> <label
														class="form-check-label" for="redio2"></label>
												</div>
											</div>

											<p class="text-content">all peoples will not be able to
												see my profile</p>
										</div>

										<button
											class="btn theme-bg-color btn-md fw-bold mt-4 text-white">
											Save Changes</button>
									</div>

									<div class="dashboard-bg-box mt-4">
										<div class="dashboard-title mb-4">
											<h3>Account settings</h3>
										</div>

										<div class="privacy-box">
											<div class="d-flex align-items-start">
												<h6>Deleting Your Account Will Permanently</h6>
												<div class="form-check form-switch switch-radio ms-auto">
													<input class="form-check-input" type="checkbox"
														role="switch" id="redio3" aria-checked="false" /> <label
														class="form-check-label" for="redio3"></label>
												</div>
											</div>
											<p class="text-content">Once your account is deleted, you
												will be logged out and will be unable to log in back.</p>
										</div>

										<div class="privacy-box">
											<div class="d-flex align-items-start">
												<h6>Deleting Your Account Will Temporary</h6>
												<div class="form-check form-switch switch-radio ms-auto">
													<input class="form-check-input" type="checkbox"
														role="switch" id="redio4" aria-checked="false" /> <label
														class="form-check-label" for="redio4"></label>
												</div>
											</div>

											<p class="text-content">Once your account is deleted, you
												will be logged out and you will be create new account</p>
										</div>

										<button
											class="btn theme-bg-color btn-md fw-bold mt-4 text-white">
											Delete My Account</button>
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

	<!-- Footer Section Start -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Footer Section End -->

	<!-- Deal Box Modal Start
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
										src="resources/assets/images/vegetable/product/10.png"
										class="blur-up lazyload" alt="" />
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
										src="resources/assets/images/vegetable/product/11.png"
										class="blur-up lazyload" alt="" />
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
										src="resources/assets/images/vegetable/product/12.png"
										class="blur-up lazyload" alt="" />
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
										src="resources/assets/images/vegetable/product/13.png"
										class="blur-up lazyload" alt="" />
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
	Deal Box Modal End -->

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

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<form action="#" id="inputAddrInfo" method="post">
						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="newaddrName"
								name="newaddrName" placeholder="배송지 이름을 입력해주세요." /> <label
								for="newaddrName">배송지명</label>
						</div>

						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="recipientName"
								name="recipientName" placeholder="이름을 입력해주세요." /> <label
								for="recipientName">받는 분</label>
						</div>

						<div class="form-floating mb-4 theme-form-floating">
							<input type="email" class="form-control"
								id="recipientPhoneNumber" name="recipientPhoneNumber"
								placeholder="연락처를 입력해주세요." /> <label for="recipientPhoneNumber">연락처</label>
						</div>

						<div>
							<button type="button"
								class="btn theme-bg-color btn-md text-white"
								onclick="goPopup();">주소 검색</button>
						</div>

						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="newZipNo"
								name="newZipNo" placeholder="우편번호" readonly />
						</div>

						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="newAddr"
								name="newAddr" placeholder="주소" readonly />
						</div>

						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="newAddrDatail"
								name="newAddrDatail" placeholder="상세 주소" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						data-bs-dismiss="modal">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- Location Modal Start -->
	<div class="modal location-modal fade theme-modal" id="locationModal"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">Choose your
						Delivery Location</h5>
					<p class="mt-1 text-content">Enter your address and we will
						specify the offer for your area.</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="location-list">
						<div class="search-input">
							<input type="search" class="form-control"
								placeholder="Search Your Area" /> <i
								class="fa-solid fa-magnifying-glass"></i>
						</div>

						<div class="disabled-box">
							<h6>Select a Location</h6>
						</div>

						<ul class="location-select custom-height">
							<li><a href="javascript:void(0)">
									<h6>Alabama</h6> <span>Min: $130</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Arizona</h6> <span>Min: $150</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>California</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Colorado</h6> <span>Min: $140</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Florida</h6> <span>Min: $160</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Georgia</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Kansas</h6> <span>Min: $170</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Minnesota</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>New York</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Washington</h6> <span>Min: $130</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Location Modal End -->

	<!-- Edit Profile Start -->
	<div class="modal fade theme-modal" id="editProfile" tabindex="-1"
		aria-labelledby="exampleModalLabel2" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel2">Edit Profile</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-4">
						<div class="col-xxl-12">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="pname"
										value="Jack Jennas" /> <label for="pname">Full Name</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="email" class="form-control" id="email1"
										value="vicki.pope@gmail.com" /> <label for="email1">Email
										address</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input class="form-control" type="tel" value="4567891234"
										name="mobile" id="mobile" maxlength="10"
										oninput="javascript: if (this.value.length > this.maxLength) this.value =
                                            this.value.slice(0, this.maxLength);" />
									<label for="mobile">Email address</label>
								</div>
							</form>
						</div>

						<div class="col-12">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="address1"
										value="8424 James Lane South San Francisco" /> <label
										for="address1">Add Address</label>
								</div>
							</form>
						</div>

						<div class="col-12">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="address2"
										value="CA 94080" /> <label for="address2">Add Address
										2</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-4">
							<form>
								<div class="form-floating theme-form-floating">
									<select class="form-select" id="floatingSelect1"
										aria-label="Floating label select example">
										<option selected>Choose Your Country</option>
										<option value="kindom">United Kingdom</option>
										<option value="states">United States</option>
										<option value="fra">France</option>
										<option value="china">China</option>
										<option value="spain">Spain</option>
										<option value="italy">Italy</option>
										<option value="turkey">Turkey</option>
										<option value="germany">Germany</option>
										<option value="russian">Russian Federation</option>
										<option value="malay">Malaysia</option>
										<option value="mexico">Mexico</option>
										<option value="austria">Austria</option>
										<option value="hong">Hong Kong SAR, China</option>
										<option value="ukraine">Ukraine</option>
										<option value="thailand">Thailand</option>
										<option value="saudi">Saudi Arabia</option>
										<option value="canada">Canada</option>
										<option value="singa">Singapore</option>
									</select> <label for="floatingSelect">Country</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-4">
							<form>
								<div class="form-floating theme-form-floating">
									<select class="form-select" id="floatingSelect">
										<option selected>Choose Your City</option>
										<option value="kindom">India</option>
										<option value="states">Canada</option>
										<option value="fra">Dubai</option>
										<option value="china">Los Angeles</option>
										<option value="spain">Thailand</option>
									</select> <label for="floatingSelect">City</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-4">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="address3"
										value="94080" /> <label for="address3">Pin Code</label>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-animation btn-md fw-bold"
						data-bs-dismiss="modal">Close</button>
					<button type="button" data-bs-dismiss="modal"
						class="btn theme-bg-color btn-md fw-bold text-light">
						Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Edit Profile End -->

	<!-- Edit Card Start -->
	<div class="modal fade theme-modal" id="editCard" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel8">Edit Card</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-4">
						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="finame"
										value="Mark" /> <label for="finame">First Name</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="laname"
										value="Jecno" /> <label for="laname">Last Name</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-4">
							<form>
								<div class="form-floating theme-form-floating">
									<select class="form-select" id="floatingSelect12"
										aria-label="Floating label select example">
										<option selected>Card Type</option>
										<option value="kindom">Visa Card</option>
										<option value="states">MasterCard Card</option>
										<option value="fra">RuPay Card</option>
										<option value="china">Contactless Card</option>
										<option value="spain">Maestro Card</option>
									</select> <label for="floatingSelect12">Card Type</label>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-animation btn-md fw-bold"
						data-bs-dismiss="modal">Cancel</button>
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light">
						Update Card</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Edit Card End -->

	<!-- Remove Profile Modal Start -->
	<div class="modal fade theme-modal remove-profile" id="removeProfile"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header d-block text-center">
					<h5 class="modal-title w-100" id="exampleModalLabel22">Are You
						Sure ?</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="remove-box">
						<p>The permission for the use/group, preview is inherited from
							the object, object will create a new permission for this object</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-animation btn-md fw-bold"
						data-bs-dismiss="modal">No</button>
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light"
						data-bs-target="#removeAddress" data-bs-toggle="modal">
						Yes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade theme-modal remove-profile" id="removeAddress"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center" id="exampleModalLabel12">
						Done!</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="remove-box text-center">
						<h4 class="text-content">It's Removed.</h4>
					</div>
				</div>
				<div class="modal-footer pt-0">
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Remove Profile Modal End -->

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

	<!-- Wizard js -->
	<script src="/resources/assets/js/wizard.js"></script>

	<!-- Slick js-->
	<script src="/resources/assets/js/slick/slick.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- Quantity js -->
	<script src="/resources/assets/js/quantity-2.js"></script>

	<!-- Nav & tab upside js -->
	<script src="/resources/assets/js/nav-tab.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>
</body>
</html>
