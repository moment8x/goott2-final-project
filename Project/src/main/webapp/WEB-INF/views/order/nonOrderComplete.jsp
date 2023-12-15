<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>Order Success</title>

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
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<title>Insert title here</title>
<script>
$(function() {
	itemLen = $(".product-detail").find("img").length; // 상품 종류
	for(i=0; i<itemLen; i++) {
  	 
  	  $('#productPrice'+i).text((Number($('#productPrice'+i).text())).toLocaleString('ko-KR'));
  	  $('#productSubTotal'+i).text((Number($('#productSubTotal'+i).text())).toLocaleString('ko-KR'));
    }
	 $("#payToAmount").text((Number($('#payToAmount').text())).toLocaleString('ko-KR'));
	 $('#subTotal').text((Number($('#subTotal').text())).toLocaleString('ko-KR'));
     $('#shippingFee').text((Number($('#shippingFee').text())).toLocaleString('ko-KR'));
     $('#bktAmount').text((Number($('#bktAmount').text())).toLocaleString('ko-KR'));
    
})
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<c:set var="contextPath" value="<%=request.getContextPath()%>" />

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
					<div class="breadscrumb-contain breadscrumb-order">
						<div class="order-box">
							<div class="order-image">
								<div class="checkmark">
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="star" height="19" viewBox="0 0 19 19" width="19"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M8.296.747c.532-.972 1.393-.973 1.925 0l2.665 4.872 4.876 2.66c.974.532.975 1.393 0 1.926l-4.875 2.666-2.664 4.876c-.53.972-1.39.973-1.924 0l-2.664-4.876L.76 10.206c-.972-.532-.973-1.393 0-1.925l4.872-2.66L8.296.746z">
                                        </path>
                                    </svg>
									<svg class="checkmark__check" height="36" viewBox="0 0 48 36"
										width="48" xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M47.248 3.9L43.906.667a2.428 2.428 0 0 0-3.344 0l-23.63 23.09-9.554-9.338a2.432 2.432 0 0 0-3.345 0L.692 17.654a2.236 2.236 0 0 0 .002 3.233l14.567 14.175c.926.894 2.42.894 3.342.01L47.248 7.128c.922-.89.922-2.34 0-3.23">
                                        </path>
                                    </svg>
									<svg class="checkmark__background" height="115"
										viewBox="0 0 120 115" width="120"
										xmlns="http://www.w3.org/2000/svg">
                                        <path
											d="M107.332 72.938c-1.798 5.557 4.564 15.334 1.21 19.96-3.387 4.674-14.646 1.605-19.298 5.003-4.61 3.368-5.163 15.074-10.695 16.878-5.344 1.743-12.628-7.35-18.545-7.35-5.922 0-13.206 9.088-18.543 7.345-5.538-1.804-6.09-13.515-10.696-16.877-4.657-3.398-15.91-.334-19.297-5.002-3.356-4.627 3.006-14.404 1.208-19.962C10.93 67.576 0 63.442 0 57.5c0-5.943 10.93-10.076 12.668-15.438 1.798-5.557-4.564-15.334-1.21-19.96 3.387-4.674 14.646-1.605 19.298-5.003C35.366 13.73 35.92 2.025 41.45.22c5.344-1.743 12.628 7.35 18.545 7.35 5.922 0 13.206-9.088 18.543-7.345 5.538 1.804 6.09 13.515 10.696 16.877 4.657 3.398 15.91.334 19.297 5.002 3.356 4.627-3.006 14.404-1.208 19.962C109.07 47.424 120 51.562 120 57.5c0 5.943-10.93 10.076-12.668 15.438z">
                                        </path>
                                    </svg>
								</div>
							</div>

							<div class="order-contain">
								<h3 class="theme-color">주문이 완료되었습니다.</h3>
								<h2 class="text-content">주문번호
									${requestScope.paymentDetail.paymentHistory.nonOrderNo}</h2>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->
	<!-- Cart Section Start -->
	<section class="cart-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row g-sm-4 g-3">
				<div class="col-xxl-9 col-lg-8">
					<div class="cart-table order-table order-table-2">
						<div class="table-responsive">
							<table class="table mb-0">
								<tbody>

									<c:forEach var="item" items="${requestScope.paymentDetail.detailOrderItem }" varStatus="status">



										<tr>
											<td class="product-detail">
												<div class="product border-0">
													<a href="product.left-sidebar.html" class="product-image">
														<img
														src="${item.productImage }"
														class="img-fluid blur-up lazyload" alt="">
													</a>
													<div class="product-detail">

														<ul>
															<li class="name"><div class="product_id">${item.productName }</div></li>

															
														</ul>
													</div>
												</div>
											</td>

											<td class="price">
												<h4 class="table-title text-content">가격</h4>
												<h6 class="theme-color"><span id="productPrice${status.index }">${item.productPrice}</span>원</h6>
											</td>

											<td class="quantity">
												<h4 class="table-title text-content">수량</h4>
												<h4 class="text-title">${item.productQuantity }</h4>
											</td>

											<td class="subtotal">
												<h4 class="table-title text-content">총 금액</h4>
												<h5><span id="productSubTotal${status.index }">${item.calculatedPrice }</span>원</h5>
											</td>
										</tr>
									</c:forEach>
									<!--  <tr>
										<td class="product-detail">
											<div class="product border-0">
												<a href="product.left-sidebar.html" class="product-image">
													<img src="/resources/assets/images/vegetable/product/2.png"
													class="img-fluid blur-up lazyload" alt="">
												</a>
												<div class="product-detail">
													<ul>
														<li class="name"><a
															href="product-left-thumbnail.html">Eggplant</a></li>

														<li class="text-content">Sold By: Nesto</li>

														<li class="text-content">Quantity - 250 g</li>
													</ul>
												</div>
											</div>
										</td>

										<td class="price">
											<h4 class="table-title text-content">Price</h4>
											<h6 class="theme-color">$15.14</h6>
										</td>

										<td class="quantity">
											<h4 class="table-title text-content">Qty</h4>
											<h4 class="text-title">01</h4>
										</td>

										<td class="subtotal">
											<h4 class="table-title text-content">Total</h4>
											<h5>$52.95</h5>
										</td>
									</tr>

									<tr>
										<td class="product-detail">
											<div class="product border-0">
												<a href="product.left-sidebar.html" class="product-image">
													<img src="/resources/assets/images/vegetable/product/3.png"
													class="img-fluid blur-up lazyload" alt="">
												</a>
												<div class="product-detail">
													<ul>
														<li class="name"><a
															href="product-left-thumbnail.html">Onion</a></li>

														<li class="text-content">Sold By: Basket</li>

														<li class="text-content">Quantity - 750 g</li>
													</ul>
												</div>
											</div>
										</td>

										<td class="price">
											<h4 class="table-title text-content">Price</h4>
											<h6 class="theme-color">$29.22</h6>
										</td>

										<td class="quantity">
											<h4 class="table-title text-content">Qty</h4>
											<h4 class="text-title">01</h4>
										</td>

										<td class="subtotal">
											<h4 class="table-title text-content">Total</h4>
											<h5>$67.36</h5>
										</td>
									</tr>
									-->
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="col-xxl-3 col-lg-4">
					<div class="row g-4">
						<div class="col-lg-12 col-sm-6">
							<div class="summery-box">
								<div class="summery-header">
									<h3>결제 정보</h3>
									<h5 class="ms-auto theme-color"></h5>
								</div>

								<ul class="summery-contain">
									<li>
										<h4>주문 금액</h4>
										<h4 class="price"><span id="subTotal">${requestScope.paymentDetail.paymentHistory.totalAmount }</span>원</h4>
									</li>

									<li>
										<h4>배송비</h4>
										<h4 class="price theme-color"><span id="shippingFee">${requestScope.paymentDetail.paymentHistory.shippingFee }</span>원</h4>
									</li>

									<li>
										<h4>결제 수단</h4>
										<h4 class="price text-danger">
											<c:choose>
											<c:when test="${requestScope.paymentDetail.paymentHistory.paymentMethod eq 'card' }">(${requestScope.paymentDetail.paymentHistory.cardName })</c:when>
											<c:when test="${requestScope.paymentDetail.paymentHistory.paymentMethod eq 'bkt' }">무통장입금</c:when>
											<c:otherwise>재화 사용</c:otherwise>
											</c:choose>
										</h4>
									</li>
								</ul>

								<ul class="summery-total">
									<li class="list-total">
										<h4>실 결제 금액</h4>
										<h4 class="price"><span id="payToAmount">${requestScope.paymentDetail.paymentHistory.actualPaymentAmount }</span>원</h4>
									</li>
									<c:if test="${requestScope.paymentDetail.paymentHistory.paymentMethod eq 'bkt'}">
										<li class="list-total">
										<h4>필요 입금 금액</h4>
										<h4 class="price"><span id="bktAmount">${requestScope.paymentDetail.paymentHistory.amountToPay}</span>원</h4>										
										</li>
										</c:if>	
								</ul>
							</div>
						</div>

						<div class="col-lg-12 col-sm-6">
							<div class="summery-box">
								<div class="summery-header d-block">
									<h3>배송 정보</h3>
								</div>

								<ul class="summery-contain pb-0 border-bottom-0">
									<li class="d-block">
										<h4>주소 : ${requestScope.paymentDetail.paymentHistory.nonShippingAddress }</h4>
										<h4 class="mt-2">상세 주소: ${requestScope.paymentDetail.paymentHistory.nonDetailedShippingAddress }</h4>
									</li>

									<li class="pb-0">
										<h4>받는 사람 :</h4>
										<h4>${requestScope.paymentDetail.paymentHistory.nonRecipientName }
											(${requestScope.paymentDetail.paymentHistory.nonRecipientPhoneNumber })</h4>
								</ul>
								<!--  <h4 class="price theme-color">
                                            <a href="order-tracking.html" class="text-danger">Track Order</a>
                                        </h4>
                                    </li>

                                <ul class="summery-total">
                                    <li class="list-total border-top-0 pt-2">
                                        <h4 class="fw-bold">Oct 21, 2021</h4>
                                    </li>
                                </ul>
                                -->
							</div>
						</div>

						<!-- <div class="col-12">
							<div class="summery-box">
								<div class="summery-header d-block">
									<h3>Payment Method</h3>
								</div>

								<ul class="summery-contain pb-0 border-bottom-0">
									<li class="d-block pt-0">
										<p class="text-content">Pay on Delivery (Cash/Card). Cash
											on delivery (COD) available. Card/Net banking acceptance
											subject to device availability.</p>
									</li>
								</ul>
							</div>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Cart Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>
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