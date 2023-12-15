<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>FAQ</title>

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
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
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
	<section class="faq-breadscrumb pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>고객센터</h2>
						<p>무엇을 도와드릴까요? 디어북스 고객센터입니다.</p>
						<div class="faq-form-tag">
							<div class="input-group">
								<i class="fa-solid fa-magnifying-glass"></i> <input
									type="search" class="form-control"
									id="exampleFormControlInput1" placeholder="name@example.com">
								<div class="dropdown">
									<button class="btn btn-md faq-dropdown-button dropdown-toggle"
										type="button" id="dropdownMenuButton1"
										data-bs-toggle="dropdown">
										All Product <i class="fa-solid fa-angle-down ms-2"></i>
									</button>
									<ul class="dropdown-menu faq-dropdown-menu dropdown-menu-end">
										<li><a class="dropdown-item" href="#">Action</a></li>
										<li><a class="dropdown-item" href="#">Another action</a></li>
										<li><a class="dropdown-item" href="#">Something else
												here</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Faq Question section Start -->
	<section class="faq-contain">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="slider-4-2 product-wrapper">
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/start.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									
									 <h3>
										<a href="/cs/serviceCenter">FAQ</a>
									</h3>
									
								</div>
							</div>
						</div>
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/price.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>
										<a href="/etc/notice">공지사항</a>
									</h3>
									
								</div>
							</div>
						</div>
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/help.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>
										<a href="/cs/makeInquiry">1:1 문의접수</a>
									</h3>
									
								</div>
							</div>
						</div>

						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/contact.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>
										<a href="/cs/viewInquiry">1:1 문의내역</a>
									</h3>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Faq Question section End -->

	<!-- Faq Section Start -->
	<section class="faq-box-contain section-b-space">
		<div class="container">
			<div class="row">
				<div class="col-xl-5">
					<div class="faq-contain">
						<h2>FAQ</h2>
						<p>
							찾으시는 질문이 없다면 1:1 문의 접수를 이용해주세요.<br><a href="/cs/makeInquiry"
								class="theme-color text-decoration-underline">contact our
								support.</a>
						</p>
					</div>
					<br>
					
				</div>

				<div class="col-xl-7">
					<div class="faq-accordion">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										주문을 수정(취소/변경)할 수 있나요? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>회원님께서 주문하신 상품은 아래의 단계별로 처리됩니다.&nbsp;</p>
										<p style="font-weight: bold;">입금전 - 결제완료 - 출고전 - 출고완료 -배송중
											- 배송완료&nbsp;</p>
										<p>
											주문수정(취소/변경)은 주문/배송조회에서 회원 로그인 후 하실 수 있습니다. <br>비회원 주문의
											경우는 주문하실 때 입력했던 이메일 주소와 비밀번호로 로그인하실 수 있습니다.&nbsp;
										</p>
										<p>
											- 입금전, 결제완료, 출고전 단계의 주문은 취소가 가능합니다.<br> - 출고완료된 상품은
											주문취소가 불가합니다.<br> - 배송중인 상품은 택배사로 물품을 인계되는 단계로 주문취소가
											불가합니다.
										</p>


									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										주문한 상품이 아직 안 왔어요. <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>주문하신 도서를 아직 못받아 보셨다면 다음 사항을 확인해 주십시오.&nbsp;</p>
										<p>
											- 주문·배송 확인 시 상품의 처리상태가 출고완료로 되어 있는 경우 이 상품은 당사에서는 출고처리를 한
											것입니다.<br> 당사에서 출고처리가 되었으나 2~3일 이내에 받아보시지 못한 경우는 고객센터의
											1:1문의를 이용하시면 신속히 처리해 드립니다.
										</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										인터넷 주문도서의 반품이 가능한가요? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>
											-고객님의 변심 또는 주문오류로 인한 반품과 교환은 불가합니다.<br> - 주문하신 상품의 결함 및
											계약내용과 다를 경우, 문제점 발견 후 7일 이내 반품신청이 가능합니다.<br> - 디어북스
											마이페이지 > 주문내역 > 주문 상세에서 직접 반품/교환을 신청하실 수 있습니다.<br> 회수기사
											방문 전에 미리 도서를 동봉하여 택배포장을 준비하여 주시기 바랍니다.<br>
										</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFour">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFour"
										aria-expanded="true" aria-controls="collapseFour">
										회원가입/회원탈퇴는 어떻게 하나요? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse"
									aria-labelledby="headingFour"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>개인 회원가입 : 홈 > register를 통해 회원가입이 가능합니다.</p>
										<a href="/register/register">회원가입 바로가기</a><br> <br>
										<p>
											회원 탈퇴&nbsp;<br>
											<br>디어북스의 회원가입 및 탈퇴는 방문자의 의사를 존중합니다. 자유롭게 탈퇴하실 수 있으며, 탈퇴
											방법은 다음과 같습니다. 회원 탈퇴 전, 유의사항을 반드시 확인해 주세요.<br>
											<br>1. WEB : 마이 > 회원정보관리 > 회원정보 수정 > 회원탈퇴 > 탈퇴사유 입력 후
											확인&nbsp; 회원탈퇴 시 유의사항&nbsp; 1. 회원탈퇴 시 모든 회원정보와 할인쿠폰, 통합포인트,
											마일리지, 교환권, 교보캐시, 이벤트 교보e캐시, 구매내역이 자동으로 삭제되며, 복구가 불가합니다.<br>
											2. 자동 삭제 항목(복구 불가능) : 회원정보, 상품구매, eBook 콘텐츠, 할인쿠폰, 마일리지,
											통합포인트, 예치금, 교보e캐시 등의 모든 내역<br> 3. 회원 아이디에 대해서는 서비스 이용의
											혼선 방지, 법령에서 규정하는 회원 거래 정보의 보존기간 동안의 보관 의무의 이행, 기타 안정적인 서비스
											제공을 위하여 필요한 정보이므로 탈퇴 후 동일 아이디로의 재가입은 허용되지 않습니다.<br> 4.
											다만, 주문 건에 따른 후속처리 발생에 대비하여 최근 1달 내 구매내역이 있으실 경우에는 탈퇴가 불가합니다.<br>
										</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFive">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFive"
										aria-expanded="false" aria-controls="collapseFive">
										주문취소 시 환불은 어떻게 되나요? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseFive" class="accordion-collapse collapse"
									aria-labelledby="headingFive"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>
											주문 시 사용된 결제수단 별로 환불되며, 결제수단 별 자세한 환불 방법은 아래와 같습니다.<br><br>

											결제수단별 환불 안내<br><br>
											(1) 신용카드<br><br> - 전체 취소 : 카드사 매입전은
											당일 취소되며, 카드사 매입 후는 카드사에 따라 2일~ 최대 2주(공휴일 제외) 소요됩니다.<br> - 부분 취소 :
											카드사 매입 후 취소 처리되며, 카드사에 따라 2일~ 최대 2주(공휴일 제외) 소요됩니다. (당일 부분취소한
											경우도 동일함) <br><br>※ 신용카드 부분 취소 유의 사항 <br>- 카드사 취소 처리되는 시점에 카드사에서 취소 문자
											전송됩니다.<br> - 신용카드를 제외한 결제 수단(카카오페이, 네이버페이와 같은 간편 결제)은 부분 취소가 불가하므로 이 점 유의하시기 바랍니다.
										</p>

										<p>(2) 간편결제(신용카드를 제외한 결제 수단)<br><br> - 부분 취소 불가하고 전체 취소만 가능합니다. </p>
										<p>(3) 재화결제(포인트, 적립금)<br><br> - 포인트나 적립금을 현금과 함께 사용하여 결제 했을 경우 부분 취소 시엔 적립금 > 포인트 > 현금 순으로 환불됩니다.</p>
										<p>(4) 무통장입금<br><br> - 전체 취소와 부분 취소 모두 환불 요청 확인되는 즉시 처리됩니다. 환불 신청 건이 많은 경우 2 ~ 3일(공휴일 제외) 소요될 수 있습니다.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSix">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseSix"
										aria-expanded="false" aria-controls="collapseSix">
										포인트랑 적립금에 대해 알려주세요. <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseSix" class="accordion-collapse collapse"
									aria-labelledby="headingSix" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p> - 디어북스의 통합회원이 되면, 디어북스 온라인에서 구매시 사용 할 수 있는 재화입니다.</p>
										<p> - 적립금 : 회원 등급에 따라 구매 시에 해당되는 적립률로 배송완료 시점에 적립됩니다.<br>
										 - 포인트 : 이벤트로 적립되는 재화입니다. </p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSeven">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseSeven"
										aria-expanded="true" aria-controls="collapseSeven">
										쿠폰 사용 시 제한이 있나요? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseSeven" class="accordion-collapse collapse"
									aria-labelledby="headingSeven"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>상품쿠폰, 배송쿠폰 제한없이 중복 적용 가능합니다.</p>
										단, 쿠폰 여러 개 선택 시 구매 금액을 초과하게 된다면 마지막으로 선택한 쿠폰은 자동으로 선택 취소됩니다. 
										
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingEight">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseEight"
										aria-expanded="false" aria-controls="collapseEight">
										주문취소 시 쿠폰 환원이 되나요? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseEight" class="accordion-collapse collapse"
									aria-labelledby="headingEight"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>상품 쿠폰일 경우 카테고리가 일치하는 상품을 취소 시에 환원 가능합니다.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingNine">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseNine"
										aria-expanded="false" aria-controls="collapseNine">
										비회원 주문이 가능한가요? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseNine" class="accordion-collapse collapse"
									aria-labelledby="headingNine"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>네. 디어북스는 비회원으로도 주문하실 수 있습니다.
비회원으로 주문을 하시려면 비회원 주문을 클릭하시고 해당사항을 입력하시면 됩니다.
주문에 관련된 사항을 모두 입력하시고 결제 과정에서 본인 확인을 위한 이메일 주소와 비밀번호만 입력하시면 됩니다.
주문/배송조회는 주문 시 입력한 이메일주소와 비밀번호로 로그인하실 수 있습니다.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Faq Section End -->
	<!-- Location Modal Start -->
	<div class="modal location-modal fade theme-modal" id="locationModal"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Choose your
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
								placeholder="Search Your Area"> <i
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
	<script src="/resources/assets/js/bootstrap/popper.min.js"></script>
	<script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>

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


	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>