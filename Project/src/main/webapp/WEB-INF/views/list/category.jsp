<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/assets/css/animate.min.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<title>Insert title here</title>
<script src="https://unpkg.com/feather-icons"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	function bestFloating(id) {
		$.ajax({
			url : '/list/float',
			type : 'POST',
			data : {
				"id" : id,
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				changeBestInfo(data);

			},
			error : function() {
				// 전송에 실패하면 이 콜백 함수를 실행
			}
		});
	}

	function changeBestInfo(data) {
		let sell = data.selling_price.toLocaleString() + "원";
		let con = data.consumer_price.toLocaleString() + "원";

		if ($("#bestSellerInfo_image").length) {
			$("#bestSellerInfo_image").attr("src", data.product_image);
		} else {
			$('#bestSellerInfo_image').attr("src",
					"/resources/assets/images/deer.png");
		}
		$("#bestSellerInfo_name").html(data.product_name);
		if ($("#bestSellerInfo_intro").length) {
			$("#bestSellerInfo_intro").html(data.introduction_intro);
		}

		$("#bestSellerInfo_sell").html(sell);
		$("#bestSellerInfo_consumer").html(con);
	}
</script>
<style>
html, body {
	position: relative;
	height: 100%;
}

body {
	background: #eee;
	font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	font-size: 14px;
	color: #000;
	margin: 0;
	padding: 0;
}

.custom-nav-tab {
	display: flex;
	flex-direction: column;
}

.categoryList {
	font-size: 24px;
}

.swiper {
	width: 100%;
	height: 30%;
}

.swiper2 {
	width: 100%;
	height: 18%;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
}

.banner-slider img {
	display: block;
	width: 90%;
	height: 50%;
	object-fit: fill;
}

.bset-seller img {
	display: block;
	width: 80%;
	height: 40%;
}

.bsetScript {
	margin: 20px 30px;
}

#bestSellImg img {
	width: 80%;
	height: 70%;
	object-fit: scale-down;
}

#best {
	margin: 0 150px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Breadcrumb Section Start -->
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>${nowCategory.category_name }</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page"><a
									href="/list/category/${categoryLang.category_key }">${categoryLang.category_name }</a></li>
								<li class="breadcrumb-item active" aria-current="page">${nowCategory.category_name }</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shop Section Start -->
	<section class="section-b-space shop-section">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-custome-3" style="width: 20%;">
					<div class="left-box wow fadeInUp">
						<div class="shop-left-sidebar">
							<ul class="nav nav-pills mb-3 custom-nav-tab" id="pills-tab"
								role="tablist">
								<c:forEach var="category" items="${categories }"
									varStatus="loop">
									<li class="categoryList" role="presentation"><a
										href='/list/categoryList/${category.category_key }'>${category.category_name }</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-custome-9">
					<div class="swiper banner-swiper">
						<div class="swiper-wrapper">
							<div class="swiper-slide banner-slider">
								<img src="/resources/assets/images/bann1.png" />
							</div>
							<div class="swiper-slide banner-slider">
								<img src="/resources/assets/images/bann2.png" />
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
						<div class="swiper-pagination1"></div>
					</div>
					<div>
						<div id="best">
							<div class="bsetScript">
								<h1>베스트셀러1</h1>
							</div>
							<div class="bestSellerInfo">
								<c:forEach var="bestSeller" items="${bestSellers }"
									varStatus="loop">
									<c:choose>
										<c:when test="${loop.index == 3 }">
											<div style="display: flex;">
												<c:choose>
													<c:when test="${bestSeller.introduction_intro != null }">
														<div id="bestSellImg">
															<img alt="" src="${bestSeller.product_image }"
																style="margin-right: 20px;" id="bestSellerInfo_image" />
														</div>
													</c:when>
												</c:choose>
												<div class="bsetinfo">
													<div style="padding: 20px 20px 50px 20px;">
														<h2 id="bestSellerInfo_name">${bestSeller.product_name }</h2>
													</div>
													<c:choose>
														<c:when test="${bestSeller.introduction_intro != null }">
															<div
																style="padding-left: 10px; font-weight: bolder; font-size: 30px;"
																id="bestSellerInfo_intro">
																<h3>${bestSeller.introduction_intro }</h3>
															</div>
														</c:when>
													</c:choose>
													<div style="padding: 30px 15px; font-size: 24px;">
														<span id="bestSellerInfo_sell"><fmt:formatNumber
																value="${bestSeller.selling_price}" pattern="#,###원" /></span>
														<del style="color: gray;" id="bestSellerInfo_consumer">
															<fmt:formatNumber value="${bestSeller.consumer_price}"
																pattern="#,###원" />
														</del>
													</div>
												</div>
											</div>
										</c:when>
									</c:choose>
								</c:forEach>
							</div>
						</div>
						<div class="swiper2 best-swiper" style="overflow: hidden;">
							<div class="swiper-wrapper">
								<c:forEach var="bestSeller" items="${bestSellers }">
									<div class="swiper-slide bset-seller"
										id="${bestSeller.product_id }" onclick="bestFloating(id);">
										<img src="${bestSeller.product_image }"
											style="object-fit: scale-down;">
									</div>
								</c:forEach>
								<c:forEach var="bestSeller" items="${bestSellers }">
									<div class="swiper-slide bset-seller">
										<img src="${bestSeller.product_image }"
											style="object-fit: scale-down;">
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="swiper-pagination2" style="text-align: center;"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shop Section End -->



	<!-- Quick View Modal Box Start -->
	<div class="modal fade theme-modal view-modal" id="view" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-xl modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header p-0">
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-sm-4 g-2">
						<div class="col-lg-6" style="display: flex">
							<div class="slider-image">
								<img
									src="https://media.istockphoto.com/id/1437657408/ko/%EB%B2%A1%ED%84%B0/%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B2%A9%EB%A6%AC%EB%90%9C-%EC%88%98%EC%B1%84%ED%99%94-%EC%95%84%EA%B8%B0-%EC%82%AC%EC%8A%B4-%EA%B7%80%EC%97%AC%EC%9A%B4-%EC%82%BC%EB%A6%BC-%EB%8F%99%EB%AC%BC-%EC%86%90%EC%9C%BC%EB%A1%9C-%EA%B7%B8%EB%A6%B0-%EA%B7%B8%EB%A6%BC-%ED%82%A4%EC%A6%88-%EB%94%94%EC%9E%90%EC%9D%B8.jpg?s=1024x1024&w=is&k=20&c=U3NghfcvPpFArhj6oAg9-6iVjW4pINKHcjNHFarbEzk="
									class="img-fluid blur-up lazyload" alt="" />
							</div>
							<div>
								<!-- 
							<sec:authorize  access="isAuthenticated()">
								<a href="/order/requestOrder?product_id="+pId+"&isLogin=Y" id="MemberLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
							</sec:authorize>
							<sec:authorize access="isAnonymous()">
								<a href="" id="loginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
								<a href="" id="noLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F9B572;" onclick="">비 회원 구매</button></a>
							</sec:authorize>	
							 -->
								<c:choose>
									<c:when test="${sessionScope.loginMember != null }">
										<a href="/order/requestOrder?product_id=" +pId+"&isLogin=Y
											" id="MemberLoginPay"><button type="button"
												class="btn buttonBuyMember"
												style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
									</c:when>
									<c:otherwise>
										<a href="" id="loginPay"><button type="button"
												class="btn buttonBuyMember"
												style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
										<a href="" id="noLoginPay"><button type="button"
												class="btn buttonBuyMember"
												style="background-color: #F9B572;" onclick="">비 회원
												구매</button></a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Quick View Modal Box End -->

	<!-- Price Range Js -->
	<script src="/resources/assets/js/ion.rangeSlider.min.js"></script>

	<!-- sidebar open js -->
	<script src="/resources/assets/js/filter-sidebar.js"></script>


	<!-- WOW js -->
	<script src="/resources/assets/js/wow.min.js"></script>
	<script src="/resources/assets/js/custom-wow.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

	<script>
		let bannerSwiper = new Swiper(".banner-swiper", {
			cssMode : true,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
			autoplay : {
				delay : 2500,
				disableOnInteraction : false,
			},
			pagination : {
				el : ".swiper-pagination1",
			},
			mousewheel : true,
			keyboard : true,
		});

		let bestSwiper = new Swiper(".best-swiper", {
			slidesPerView : 1,
			spaceBetween : 10,
			pagination : {
				el : ".swiper-pagination2",
				clickable : true,
			},
			breakpoints : {
				640 : {
					slidesPerView : 2,
					spaceBetween : 20,
				},
				768 : {
					slidesPerView : 4,
					spaceBetween : 40,
				},
				1024 : {
					slidesPerView : 5,
					spaceBetween : 50,
				},
			},
		});
	</script>

	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>