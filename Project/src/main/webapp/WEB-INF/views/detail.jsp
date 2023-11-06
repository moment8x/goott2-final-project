<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>Header</title>

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



<style type="text/css">
.flip-card {
	background-color: transparent;
	width: 390px;
	height: 570px;
	perspective: 1000px;
	display: flex;
	margin: auto;
}

.flip-card-inner {
	position: relative;
	width: 100%;
	height: 100%;
	text-align: center;
	transition: transform 0.6s;
	transform-style: preserve-3d;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	z-index: -1;
}

.flip-card:hover .flip-card-inner {
	transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
	position: absolute;
	width: 100%;
	height: 100%;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
}

.flip-card-front {
	background-color: #bbb;
	color: black;
}

.flip-card-back {
	background-color: #2980b9;
	color: white;
	transform: rotateY(180deg);
}
</style>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>

	<div class="container">

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
							<h2>Creamy Chocolate Cake</h2>
							<nav>
								<ol class="breadcrumb mb-0">
									<li class="breadcrumb-item"><a href="index.html"> <i
											class="fa-solid fa-house"></i>
									</a></li>

									<li class="breadcrumb-item active">Creamy Chocolate Cake</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Breadcrumb Section End -->


		<!-- Product Left Sidebar Start -->
		<section class="product-section">
			<div class="container-fluid-lg">
				<div class="row">
					<div class="col-xxl-9 col-xl-8 col-lg-7 wow fadeInUp">
						<div class="row g-4">
							<div class="col-xl-6 wow fadeInUp">
								<div class="product-left-box">
									<div class="row g-2">
										<div
											class="col-xxl-10 col-lg-12 col-md-10 order-xxl-2 order-lg-1 order-md-2">
											<div class="flip-card">
												<div class="flip-card-inner">
													<div class="flip-card-front">
														<div class="product-image">
															<img src="${Product.productImage.split(',')[0]}"
																id="img-1"
																data-zoom-image="/resources/assets/images/product/category/1.jpg"
																class="img-fluid image_zoom_cls-0 blur-up lazyload"
																alt="${Product.productName}">
														</div>
													</div>
													<div class="flip-card-back">
														<img src="${Product.productImage.split(',')[1]}"
															id="img-1"
															data-zoom-image="/resources/assets/images/product/category/1.jpg"
															class="img-fluid image_zoom_cls-0 blur-up lazyload"
															alt="${Product.productName}">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-xl-6 wow fadeInUp" data-wow-delay="0.1s">
								<div class="right-box-contain">
									<h6 class="offer-top">소득공제</h6>
									<h2 class="name">${Product.productName}</h2>
									<div class="price-rating">
										<h3 class="theme-color price">${Product.sellingPrice}원<del
												class="text-content">${Product.consumerPrice}원</del>
											<span class="offer theme-color"><fmt:formatNumber
													value="${Product.sellingPrice/Product.consumerPrice* 10}"
													pattern="#0"></fmt:formatNumber>% 할인</span>
										</h3>
										<div class="product-rating custom-rate">
											<ul class="rating">
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star"></i></li>
											</ul>
											<span class="review">23개 리뷰</span>
										</div>
									</div>

									<div class="procuct-contain">
										<p>${Product.introductionIntro}</p>
									</div>

									<div class="note-box product-packege">
										<div class="cart_qty qty-box product-qty">
											<div class="input-group">
												<button type="button" class="qty-right-plus"
													data-type="plus" data-field="">
													<i class="fa fa-plus" aria-hidden="true"></i>
												</button>
												<input class="form-control input-number qty-input"
													type="text" name="quantity" value="0">
												<button type="button" class="qty-left-minus"
													data-type="minus" data-field="">
													<i class="fa fa-minus" aria-hidden="true"></i>
												</button>
											</div>
										</div>

										<button onclick="location.href = 'cart.html';"
											class="btn btn-md bg-dark cart-button text-white w-80">장바구니</button>

										<button
											onclick="location.href = '/order/${Product.productId}';"
											class="btn btn-md bg-dark cart-button text-white w-80">바로구매</button>
									</div>

									<div class="buy-box">
										<a href="wishlist.html"> <i data-feather="heart"></i> <span>위시리스트</span>
										</a>
									</div>

									<div class="pickup-box">
										<div class="product-title">
											<h4>저자 소개</h4>
										</div>

										<div class="pickup-detail">
											<h4 class="text-content">${Product.authorIntroduction.toString().substring(0, 80)}...</h4>
										</div>

										<div class="product-info">
											<ul class="product-info-list product-info-list-2">
												<li><div>${Product.publisher}</div></li>
												<li><div>${Product.publicationDate.toString().substring(0, 10)}</div></li>
												<li><div>${Product.authorTranslator}</div></li>
											</ul>
										</div>
									</div>

									<div class="paymnet-option">
										<div class="product-title">
											<h4>안전 결재 보장</h4>
										</div>
										<ul>
											<li><a href="javascript:void(0)"> <img
													src="/resources/assets/images/product/payment/1.svg"
													class="blur-up lazyload" alt="">
											</a></li>
											<li><a href="javascript:void(0)"> <img
													src="/resources/assets/images/product/payment/2.svg"
													class="blur-up lazyload" alt="">
											</a></li>
											<li><a href="javascript:void(0)"> <img
													src="/resources/assets/images/product/payment/3.svg"
													class="blur-up lazyload" alt="">
											</a></li>
											<li><a href="javascript:void(0)"> <img
													src="/resources/assets/images/product/payment/4.svg"
													class="blur-up lazyload" alt="">
											</a></li>
											<li><a href="javascript:void(0)"> <img
													src="/resources/assets/images/product/payment/5.svg"
													class="blur-up lazyload" alt="">
											</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="col-12">
								<div class="product-section-box">
									<ul class="nav nav-tabs custom-nav" id="myTab" role="tablist">
										<li class="nav-item" role="presentation">
											<button class="nav-link active" id="description-tab"
												data-bs-toggle="tab" data-bs-target="#description"
												type="button" role="tab" aria-controls="description"
												aria-selected="true">소개정보</button>
										</li>

										<li class="nav-item" role="presentation">
											<button class="nav-link" id="info-tab" data-bs-toggle="tab"
												data-bs-target="#info" type="button" role="tab"
												aria-controls="info" aria-selected="false">상품정보</button>
										</li>

										<li class="nav-item" role="presentation">
											<button class="nav-link" id="care-tab" data-bs-toggle="tab"
												data-bs-target="#care" type="button" role="tab"
												aria-controls="care" aria-selected="false">교환/반품/품절
												안내</button>
										</li>

										<li class="nav-item" role="presentation">
											<button class="nav-link getAllReview" id="review-tab"
												data-bs-toggle="tab" data-bs-target="#review" type="button"
												role="tab" aria-controls="review" aria-selected="false"
												value="${Product.productId}"
												data-productId="${Product.productId}">리뷰(총 리뷰 개수)</button>
										</li>
									</ul>

									<div class="tab-content custom-tab" id="myTabContent">
										<div class="tab-pane fade show active" id="description"
											role="tabpanel" aria-labelledby="description-tab">
											<div class="product-description">
												<div class="nav-desh">
													<p>${Product.introductionDetail}</p>
												</div>

												<div class="nav-desh">
													<div class="desh-title">
														<h5>상세이미지</h5>
													</div>
													<img src="${Product.productInfoImage}" />
												</div>

												<div class="banner-contain nav-desh">
													<img src="/resources/assets/images/vegetable/banner/14.jpg"
														class="bg-img blur-up lazyload" alt="">
													<div
														class="banner-details p-center banner-b-space w-100 text-center">
														<div>
															<h6 class="ls-expanded theme-color mb-sm-3 mb-1">SUMMER</h6>
															<h2>VEGETABLE</h2>
															<p class="mx-auto mt-1">Save up to 5% OFF</p>
														</div>
													</div>
												</div>

												<div class="nav-desh">
													<div class="desh-title">
														<h5>From The Manufacturer:</h5>
													</div>
													<p>Jelly beans shortbread chupa chups carrot cake
														jelly-o halvah apple pie pudding gingerbread. Apple pie
														halvah cake tiramisu shortbread cotton candy croissant
														chocolate cake. Tart cupcake caramels gummi bears macaroon
														gingerbread fruitcake marzipan wafer. Marzipan dessert
														cupcake ice cream tootsie roll. Brownie chocolate cake
														pudding cake powder candy ice cream ice cream cake.
														Jujubes soufflé chupa chups cake candy halvah donut. Tart
														tart icing lemon drops fruitcake apple pie.</p>

													<p>Dessert liquorice tart soufflé chocolate bar apple
														pie pastry danish soufflé. Gummi bears halvah gingerbread
														jelly icing. Chocolate cake chocolate bar pudding chupa
														chups bear claw pie dragée donut halvah. Gummi bears
														cookie ice cream jelly-o jujubes sweet croissant. Marzipan
														cotton candy gummi bears lemon drops lollipop lollipop
														chocolate. Ice cream cookie dragée cake sweet roll sweet
														roll.Lemon drops cookie muffin carrot cake chocolate
														marzipan gingerbread topping chocolate bar. Soufflé
														tiramisu pastry sweet dessert.</p>
												</div>
											</div>
										</div>

										<div class="tab-pane fade" id="info" role="tabpanel"
											aria-labelledby="info-tab">
											<div class="table-responsive">
												<table class="table info-table">
													<tbody>
														<tr>
															<td>ISBN</td>
															<td>${Product.isbn}</td>
														</tr>
														<tr>
															<td>발행(출시)일자</td>
															<td>${Product.publicationDate.toString().substring(0, 10)}</td>
														</tr>
														<tr>
															<td>쪽수</td>
															<td>${Product.pageCount}</td>
														</tr>
														<tr>
															<td>크기</td>
															<td>${ProductSize}
																<button>판형알림</button>
															</td>
														</tr>
														<tr>
															<td>총권수</td>
															<td>${Product.totalVolume}권</td>
														</tr>
														<tr>
															<td>원서명/저자명</td>
															<td>${Product.originalAuthor}</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>

										<div class="tab-pane fade" id="care" role="tabpanel"
											aria-labelledby="care-tab">
											<div class="information-box">
												<ul>
													<li>
														<h5>반품/교환방법</h5>
														<p>마이룸 > 주문관리 > 주문/배송내역 > 주문조회 > 반품/교환 신청, [1:1 상담 >
															반품/교환/환불] 또는 고객센터 (1544-1900) * 오픈마켓, 해외배송 주문, 기프트 주문시
															[1:1 상담>반품/교환/환불] 또는 고객센터 (1544-1900)</p>
													</li>

													<li>
														<h5>반품/교환가능 기간</h5>
														<p>변심반품의 경우 수령 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제점 발견 후
															30일 이내</p>
													</li>

													<li>
														<h5>반품/교환비용</h5>
														<p>변심 혹은 구매착오로 인한 반품/교환은 반송료 고객 부담</p>
													</li>

													<li>
														<h5>반품/교환 불가 사유</h5>
														<p>1) 소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우 (단지 확인을 위한 포장
															훼손은 제외)</p>
														<p>2) 소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 예) 화장품,
															식품, 가전제품(악세서리 포함) 등</p>
														<p>3) 복제가 가능한 상품 등의 포장을 훼손한 경우 예) 음반/DVD/비디오, 소프트웨어,
															만화책, 잡지, 영상 화보집</p>
														<p>4) 소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우 ((1)해외주문도서)</p>
														<p>5) 디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우</p>
														<p>6) 시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</p>
														<p>7) 전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에
															해당되는 경우</p>
														<p>8) 세트상품 일부만 반품 불가 (필요시 세트상품 반품 후 낱권 재구매)</p>
													</li>

													<li>
														<h5>상품 품절</h5>
														<p>공급사(출판사) 재고 사정에 의해 품절/지연될 수 있으며, 품절 시 관련 사항에 대해서는
															이메일과 문자로 안내드리겠습니다.</p>
													</li>

													<li>
														<h5>소비자 피해보상 환불 지연에 따른 배상</h5>
														<p>1) 상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은
															소비자분쟁 해결 기준 (공정거래위원회 고시)에 준하여 처리됨</p>
														<p>2) 대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자
															보호에 관한 법률에 따라 처리함</p>
														<div>*상품 설명에 반품/교환 관련한 안내가 있는 경우 그 내용을 우선으로 합니다. (업체
															사정에 따라 달라질 수 있습니다.)</div>
													</li>


												</ul>
											</div>
										</div>

										<div class="tab-pane fade" id="review" role="tabpanel"
											aria-labelledby="review-tab">
											<div class="review-box">
												<div class="row g-4">
													<div class="col-xl-6">
														<div class="review-title">
															<h4 class="fw-500">Customer reviews</h4>
														</div>

														<div class="d-flex">
															<div class="product-rating">
																<ul class="rating">
																	<li><i data-feather="star" class="fill"></i></li>
																	<li><i data-feather="star" class="fill"></i></li>
																	<li><i data-feather="star" class="fill"></i></li>
																	<li><i data-feather="star"></i></li>
																	<li><i data-feather="star"></i></li>
																</ul>
															</div>
															<h6 class="ms-3">4.2 Out Of 5</h6>
														</div>

														<div class="rating-box">
															<ul>
																<li>
																	<div class="rating-list">
																		<h5>5 Star</h5>
																		<div class="progress">
																			<div class="progress-bar" role="progressbar"
																				style="width: 68%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">68%</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="rating-list">
																		<h5>4 Star</h5>
																		<div class="progress">
																			<div class="progress-bar" role="progressbar"
																				style="width: 67%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">67%</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="rating-list">
																		<h5>3 Star</h5>
																		<div class="progress">
																			<div class="progress-bar" role="progressbar"
																				style="width: 42%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">42%</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="rating-list">
																		<h5>2 Star</h5>
																		<div class="progress">
																			<div class="progress-bar" role="progressbar"
																				style="width: 30%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">30%</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="rating-list">
																		<h5>1 Star</h5>
																		<div class="progress">
																			<div class="progress-bar" role="progressbar"
																				style="width: 24%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">24%</div>
																		</div>
																	</div>
																</li>
															</ul>
														</div>
													</div>

													<div class="col-xl-6">
														<div class="review-title">
															<h4 class="fw-500">Add a review</h4>
														</div>

														<div class="row g-4">
															<div class="col-md-6">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control" id="name"
																		placeholder="Name"> <label for="name">Your
																		Name</label>
																</div>
															</div>

															<div class="col-md-6">
																<div class="form-floating theme-form-floating">
																	<input type="email" class="form-control" id="email"
																		placeholder="Email Address"> <label
																		for="email">Email Address</label>
																</div>
															</div>

															<div class="col-md-6">
																<div class="form-floating theme-form-floating">
																	<input type="url" class="form-control" id="website"
																		placeholder="Website"> <label for="website">Website</label>
																</div>
															</div>

															<div class="col-md-6">
																<div class="form-floating theme-form-floating">
																	<input type="url" class="form-control" id="review1"
																		placeholder="Give your review a title"> <label
																		for="review1">Review Title</label>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<textarea class="form-control"
																		placeholder="Leave a comment here"
																		id="floatingTextarea2" style="height: 150px"></textarea>
																	<label for="floatingTextarea2">Write Your
																		Comment</label>
																</div>
															</div>
														</div>
													</div>

													<div class="col-12">
														<div class="review-title">
															<h4 class="fw-500">Customer questions & answers</h4>
														</div>

														<div class="review-people">
															<ul class="review-list">
																<li>
																	<div class="people-box">
																		<div>
																			<div class="people-image">
																				<img src="/resources/assets/images/review/1.jpg"
																					class="img-fluid blur-up lazyload" alt="">
																			</div>
																		</div>

																		<div class="people-comment">
																			<a class="name" href="javascript:void(0)">Tracey</a>
																			<div class="date-time">
																				<h6 class="text-content">14 Jan, 2022 at 12.58
																					AM</h6>

																				<div class="product-rating">
																					<ul class="rating">
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star"></i></li>
																						<li><i data-feather="star"></i></li>
																					</ul>
																				</div>
																			</div>

																			<div class="reply">
																				<p>
																					Icing cookie carrot cake chocolate cake sugar plum
																					jelly-o danish. Dragée dragée shortbread tootsie
																					roll croissant muffin cake I love gummi bears.
																					Candy canes ice cream caramels tiramisu marshmallow
																					cake shortbread candy canes cookie.<a
																						href="javascript:void(0)">Reply</a>
																				</p>
																			</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="people-box">
																		<div>
																			<div class="people-image">
																				<img src="/resources/assets/images/review/2.jpg"
																					class="img-fluid blur-up lazyload" alt="">
																			</div>
																		</div>

																		<div class="people-comment">
																			<a class="name" href="javascript:void(0)">Olivia</a>
																			<div class="date-time">
																				<h6 class="text-content">01 May, 2022 at 08.31
																					AM</h6>
																				<div class="product-rating">
																					<ul class="rating">
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star"></i></li>
																						<li><i data-feather="star"></i></li>
																					</ul>
																				</div>
																			</div>

																			<div class="reply">
																				<p>
																					Tootsie roll cake danish halvah powder Tootsie roll
																					candy marshmallow cookie brownie apple pie pudding
																					brownie chocolate bar. Jujubes gummi bears I love
																					powder danish oat cake tart croissant.<a
																						href="javascript:void(0)">Reply</a>
																				</p>
																			</div>
																		</div>
																	</div>
																</li>

																<li>
																	<div class="people-box">
																		<div>
																			<div class="people-image">
																				<img src="/resources/assets/images/review/3.jpg"
																					class="img-fluid blur-up lazyload" alt="">
																			</div>
																		</div>

																		<div class="people-comment">
																			<a class="name" href="javascript:void(0)">Gabrielle</a>
																			<div class="date-time">
																				<h6 class="text-content">21 May, 2022 at 05.52
																					PM</h6>

																				<div class="product-rating">
																					<ul class="rating">
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star" class="fill"></i>
																						</li>
																						<li><i data-feather="star"></i></li>
																						<li><i data-feather="star"></i></li>
																					</ul>
																				</div>
																			</div>

																			<div class="reply">
																				<p>
																					Biscuit chupa chups gummies powder I love sweet
																					pudding jelly beans. Lemon drops marzipan apple pie
																					gingerbread macaroon croissant cotton candy pastry
																					wafer. Carrot cake halvah I love tart caramels
																					pudding icing chocolate gummi bears. Gummi bears
																					danish cotton candy muffin marzipan caramels
																					awesome feel. <a href="javascript:void(0)">Reply</a>
																				</p>
																			</div>
																		</div>
																	</div>
																</li>
															</ul>
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

					<div
						class="col-xxl-3 col-xl-4 col-lg-5 d-none d-lg-block wow fadeInUp">
						<div class="right-sidebar-box">
							<div class="vendor-box">
								<div class="verndor-contain">
									<div class="vendor-image">
										<img src="/resources/assets/images/product/vendor.png"
											class="blur-up lazyload" alt="">
									</div>

									<div class="vendor-name">
										<h5 class="fw-500">Noodles Co.</h5>

										<div class="product-rating mt-1">
											<ul class="rating">
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star" class="fill"></i></li>
												<li><i data-feather="star"></i></li>
											</ul>
											<span>(36 Reviews)</span>
										</div>

									</div>
								</div>

								<p class="vendor-detail">Noodles & Company is an American
									fast-casual restaurant that offers international and American
									noodle dishes and pasta.</p>

								<div class="vendor-list">
									<ul>
										<li>
											<div class="address-contact">
												<i data-feather="map-pin"></i>
												<h5>
													Address: <span class="text-content">1288 Franklin
														Avenue</span>
												</h5>
											</div>
										</li>

										<li>
											<div class="address-contact">
												<i data-feather="headphones"></i>
												<h5>
													Contact Seller: <span class="text-content">(+1)-123-456-789</span>
												</h5>
											</div>
										</li>
									</ul>
								</div>
							</div>

							<!-- Trending Product -->
							<div class="pt-25">
								<div class="category-menu">
									<h3>Trending Products</h3>

									<ul class="product-list product-right-sidebar border-0 p-0">
										<li>
											<div class="offer-product">
												<a href="product-left-thumbnail.html" class="offer-image">
													<img
													src="/resources/assets/images/vegetable/product/23.png"
													class="img-fluid blur-up lazyload" alt="">
												</a>

												<div class="offer-detail">
													<div>
														<a href="product-left-thumbnail.html">
															<h6 class="name">Meatigo Premium Goat Curry</h6>
														</a> <span>450 G</span>
														<h6 class="price theme-color">$ 70.00</h6>
													</div>
												</div>
											</div>
										</li>

										<li>
											<div class="offer-product">
												<a href="product-left-thumbnail.html" class="offer-image">
													<img
													src="/resources/assets/images/vegetable/product/24.png"
													class="blur-up lazyload" alt="">
												</a>

												<div class="offer-detail">
													<div>
														<a href="product-left-thumbnail.html">
															<h6 class="name">Dates Medjoul Premium Imported</h6>
														</a> <span>450 G</span>
														<h6 class="price theme-color">$ 40.00</h6>
													</div>
												</div>
											</div>
										</li>

										<li>
											<div class="offer-product">
												<a href="product-left-thumbnail.html" class="offer-image">
													<img
													src="/resources/assets/images/vegetable/product/25.png"
													class="blur-up lazyload" alt="">
												</a>

												<div class="offer-detail">
													<div>
														<a href="product-left-thumbnail.html">
															<h6 class="name">Good Life Walnut Kernels</h6>
														</a> <span>200 G</span>
														<h6 class="price theme-color">$ 52.00</h6>
													</div>
												</div>
											</div>
										</li>

										<li class="mb-0">
											<div class="offer-product">
												<a href="product-left-thumbnail.html" class="offer-image">
													<img
													src="/resources/assets/images/vegetable/product/26.png"
													class="blur-up lazyload" alt="">
												</a>

												<div class="offer-detail">
													<div>
														<a href="product-left-thumbnail.html">
															<h6 class="name">Apple Red Premium Imported</h6>
														</a> <span>1 KG</span>
														<h6 class="price theme-color">$ 80.00</h6>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</div>

							<!-- Banner Section -->
							<div class="ratio_156 pt-25">
								<div class="home-contain">
									<img src="/resources/assets/images/vegetable/banner/8.jpg"
										class="bg-img blur-up lazyload" alt="">
									<div class="home-detail p-top-left home-p-medium">
										<div>
											<h6 class="text-yellow home-banner">Seafood</h6>
											<h3 class="text-uppercase fw-normal">
												<span class="theme-color fw-bold">Freshes</span> Products
											</h3>
											<h3 class="fw-light">every hour</h3>
											<button onclick="location.href = 'shop-left-sidebar.html';"
												class="btn btn-animation btn-md fw-bold mend-auto">
												Shop Now <i class="fa-solid fa-arrow-right icon"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Product Left Sidebar End -->


		<!-- Releted Product Section Start -->
		<section class="product-list-section section-b-space">
			<div class="container-fluid-lg">
				<div class="title">
					<h2>Related Products</h2>
					<span class="title-leaf"> <svg class="icon-width">
                        <use
								xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
					</span>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="slider-6_1 product-wrapper">
							<div>
								<div class="product-box-3 wow fadeInUp">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left.htm"> <img
												src="/resources/assets/images/cake/product/11.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Cake</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Chocolate Chip Cookies 250 g</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
												</ul>
												<span>(5.0)</span>
											</div>
											<h6 class="unit">500 G</h6>
											<h5 class="price">
												<span class="theme-color">$10.25</span>
												<del>$12.57</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.05s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/2.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>
									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Vegetable</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Fresh Bread and Pastry Flour 200 g</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star"></i></li>
												</ul>
												<span>(4.0)</span>
											</div>
											<h6 class="unit">250 ml</h6>
											<h5 class="price">
												<span class="theme-color">$08.02</span>
												<del>$15.15</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.1s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/3.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Vegetable</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Peanut Butter Bite Premium Butter
													Cookies 600 g</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star"></i></li>
													<li><i data-feather="star"></i></li>
													<li><i data-feather="star"></i></li>
												</ul>
												<span>(2.4)</span>
											</div>
											<h6 class="unit">350 G</h6>
											<h5 class="price">
												<span class="theme-color">$04.33</span>
												<del>$10.36</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.15s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/4.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Snacks</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">SnackAmor Combo Pack of Jowar Stick
													and Jowar Chips</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
												</ul>
												<span>(5.0)</span>
											</div>
											<h6 class="unit">570 G</h6>
											<h5 class="price">
												<span class="theme-color">$12.52</span>
												<del>$13.62</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.2s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/5.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Snacks</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Yumitos Chilli Sprinkled Potato Chips
													100 g</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star"></i></li>
													<li><i data-feather="star"></i></li>
												</ul>
												<span>(3.8)</span>
											</div>
											<h6 class="unit">100 G</h6>
											<h5 class="price">
												<span class="theme-color">$10.25</span>
												<del>$12.36</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.25s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/6.png"
												class="img-fluid blur-up lazyload" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Vegetable</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Fantasy Crunchy Choco Chip Cookies</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star"></i></li>
												</ul>
												<span>(4.0)</span>
											</div>

											<h6 class="unit">550 G</h6>

											<h5 class="price">
												<span class="theme-color">$14.25</span>
												<del>$16.57</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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

							<div>
								<div class="product-box-3 wow fadeInUp" data-wow-delay="0.3s">
									<div class="product-header">
										<div class="product-image">
											<a href="product-left-thumbnail.html"> <img
												src="/resources/assets/images/cake/product/7.png"
												class="img-fluid" alt="">
											</a>

											<ul class="product-option">
												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="View"><a href="javascript:void(0)"
													data-bs-toggle="modal" data-bs-target="#view"> <i
														data-feather="eye"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Compare"><a href="compare.html"> <i
														data-feather="refresh-cw"></i>
												</a></li>

												<li data-bs-toggle="tooltip" data-bs-placement="top"
													title="Wishlist"><a href="wishlist.html"
													class="notifi-wishlist"> <i data-feather="heart"></i>
												</a></li>
											</ul>
										</div>
									</div>

									<div class="product-footer">
										<div class="product-detail">
											<span class="span-name">Vegetable</span> <a
												href="product-left-thumbnail.html">
												<h5 class="name">Fresh Bread and Pastry Flour 200 g</h5>
											</a>
											<div class="product-rating mt-2">
												<ul class="rating">
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star" class="fill"></i></li>
													<li><i data-feather="star"></i></li>
													<li><i data-feather="star"></i></li>
												</ul>
												<span>(3.8)</span>
											</div>

											<h6 class="unit">1 Kg</h6>

											<h5 class="price">
												<span class="theme-color">$12.68</span>
												<del>$14.69</del>
											</h5>
											<div class="add-to-cart-box bg-white">
												<button class="btn btn-add-cart addcart-button">
													Add <span class="add-icon bg-light-gray"> <i
														class="fa-solid fa-plus"></i>
													</span>
												</button>
												<div class="cart_qty qty-box">
													<div class="input-group bg-white">
														<button type="button" class="qty-left-minus bg-gray"
															data-type="minus" data-field="">
															<i class="fa fa-minus" aria-hidden="true"></i>
														</button>
														<input class="form-control input-number qty-input"
															type="text" name="quantity" value="0">
														<button type="button" class="qty-right-plus bg-gray"
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
			</div>
		</section>
		<!-- Releted Product Section End -->


	</div>

	<jsp:include page="./footer.jsp"></jsp:include>

	<script>
        $(document).ready(function() {
            // 리뷰 목록을 가져옵니다.
            $.ajax({
                url: "/review/all/<%=request.getParameter("subcategory")%>",
                type: "GET",
                dataType: "json",
                success: function(data) {
                    // 리뷰 목록을 DOM에 추가합니다.
                    for (let review of data) {
                        let li = $("<li>").append($("<strong>").text(review.title)).append($("<p>").text(review.content)).append($("<p>").text(review.author)).append($("<p>").text(review.createdDate));
                        $("#review-list").append(li);
                    }
                }
            });
        });
    </script>


	<!-- latest jquery
    <script src="/resources/assets/js/jquery-3.6.0.min.js"></script>-->
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

	<!-- Quantity js -->
	<script src="/resources/assets/js/quantity.js"></script>
	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>
</body>
</html>