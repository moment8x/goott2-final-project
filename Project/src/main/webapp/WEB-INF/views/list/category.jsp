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
		let sell = data.sellingPrice.toLocaleString() + "원";
		let con = data.consumerPrice.toLocaleString() + "원";

		if ($("#bestSellerInfoImage").length) {
			$("#bestSellerInfoImage").attr("src", data.productImage);
		} else {
			$('#bestSellerInfoImage').attr("src",
					"/resources/assets/images/deer.png");
		}
		$("#bestSellerInfoName").html(data.productName);
		if ($("#bestSellerInfoIntro").length) {
			$("#bestSellerInfoIntro").html(data.introductionIntro);
		}

		$("#bestSellerInfoSell").html(sell);
		$("#bestSellerInfoConsumer").html(con);
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
	width: 80%;
	height: 20%;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
}

.swiper-slide img{
	width: 100%;
	height: 100%;
	border-radius: 10px;
}

.swiper-button-next {
  background: url(/resources/assets/images/next1.png) no-repeat;
  color:gray;
  background-size: 100% auto;
  background-position: center;
}

.swiper-button-prev {
  background: url(/resources/assets/images/previous1.png) no-repeat;
  background-size: 100% auto;
  background-position: center;
}
.swiper-button-next::after,
.swiper-button-prev::after {
  display: none;
}

#smallBanners {
	display: flex;
	margin-top: 20px;
	margin-left: 140px;
}
#smallBanners div {
	margin: 15px;
}
#smallBanners img {
	width: 100%;
	height: 100%;
}

#smallBanners div:active {
	border:2px solid; black;
}
.bestSellerInfo{
	margin-left: 80px;
}

#bestSellerId {
	display: flex;
}

#bestSellerId img{
	width: 40%;
	height: 50%
}

#bestSellerTextInfo {
	margin: 40px;
	vertical-align: middle;
}
#bestSellerName{
	margin-bottom: 40px;
}
#bestSellerPrice{
	margin-bottom: 20px;
}
.swiper2 {
	margin-top: 30px;
}
.sellingList ul{
	list-style: none;
}
.sellingList li {
	display: block;
    margin-right: 10px; /* 각 아이템 간 간격 설정 */
    margin-bottom: 10px;
}
.sellingList img {
	width: 30%;
	height: 35%;
}
.lankList{
	display: flex;
}
.numberIcon{
    width: 20px !important;
    height : 20px !important;
    margin-left: 10px;
    margin-right: 5px;
}
.sellingListInfo {
	margin-left: 10px;
	margin-top: 10px;
}
.subj {
	margin-top : 100px;
	margin-bottom: 30px;
	color: green;
}
.newProd {
	margin-left: 50px;
	width: 200px;
	height: 260px;
}
li:first-child.newProd {
    padding-left: 0;
}
.newProd h3 {
	margin-top : 20px;
	width : 200px;
	white-space: nowrap; 
    overflow: hidden; 
    text-overflow: ellipsis; 
    font-weight: bold;
}
.newProd img {
	width: 200px;
	height: 260px;
}
.newPoductList {
	height: 500px;
	margin-left: 60px;
}
.newPoductList ul{
	display: flex;
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
						<h2>${nowCategory.categoryName }</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page"><a
									href="/list/category/${categoryLang.categoryKey }">${categoryLang.categoryName }</a></li>
								<li class="breadcrumb-item active" aria-current="page">${nowCategory.categoryName }</li>
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
				<div class="col-custome-3">
					<div class="left-box wow fadeInUp">
						<div class="shop-left-sidebar">
							<ul class="nav nav-pills mb-3 custom-nav-tab" id="pills-tab"
								role="tablist">
								<c:forEach var="category" items="${categories }"
									varStatus="loop">
									<li class="nav-item" role="presentation">
										<button class="nav-link active" id="pills-vegetables"
											data-bs-toggle="pill" data-bs-target="#pills-vegetable"
											type="button" role="tab" aria-selected="true"
											onclick="location.href='/list/categoryList/${category.categoryKey }'"
											id="${loop.index }">
											${category.categoryName }<img
												src="/resources/assets/images/books.png"
												class="blur-up lazyload" alt="">
										</button>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-custome-9">
				<div class="swiper banner-swiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide"><img src="/resources/assets/images/banner/banner2.png"></div>
				      <div class="swiper-slide"><img src="/resources/assets/images/banner/banner3.png"></div>
				      <div class="swiper-slide">Slide 3</div>
				      <div class="swiper-slide">Slide 4</div>
				      <div class="swiper-slide">Slide 5</div>
				      <div class="swiper-slide">Slide 6</div>
				      <div class="swiper-slide">Slide 7</div>
				      <div class="swiper-slide">Slide 8</div>
				      <div class="swiper-slide">Slide 9</div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				    <div class="swiper-pagination"></div>
				  </div>
				  
				  <div id="smallBanners">
				  	<div><img src="/resources/assets/images/banner/smallBanner1.png"></div>
				  	<div><img src="/resources/assets/images/banner/smallBanner1.png"></div>
				  </div>
				  <div class="row">
				  	<div class="col-6 bestSellerInfo">
				  		<h2 class="subj">베스트 셀러</h2>
								<c:forEach var="bestSeller" items="${listMap.bestSellerList }"
									varStatus="loop">
									<c:choose>
										<c:when test="${loop.index == 3 }">
											<a href="/detail/${bestSeller.productId }" style="color: black;">
											<div id="bestSellerId">
												<c:choose>
													<c:when test="${bestSeller.introductionIntro != null }">
														<img src="${bestSeller.productImage }" id="bestSellerInfo_image" />
													</c:when>
												</c:choose>
												<div id="bestSellerTextInfo">
													<div id="bestSellerName">
														<h2 id="bestSellerInfo_name">${bestSeller.productName }</h2>
													</div>
													<div id="bestSellerPrice">
													<span id="bestSellerInfo_sell"><fmt:formatNumber
																value="${bestSeller.sellingPrice}" pattern="#,###원" /></span>
														<del style="color: gray;" id="bestSellerInfo_consumer">
															<fmt:formatNumber value="${bestSeller.consumerPrice}"
																pattern="#,###원" />
														</del>
													</div>
													<c:choose>
														<c:when test="${bestSeller.introductionIntro != null }">
															<div id="bestSellerInfo_intro">
																<h3>${bestSeller.introductionIntro }</h3>
															</div>
														</c:when>
													</c:choose>	
													</div>
													</div>
													</a>
													<div class="swiper2 best-swiper" style="overflow: hidden;">
														<div class="swiper-wrapper">
															<c:forEach var="bestSeller" items="${listMap.bestSellerList }">
																<div class="swiper-slide bset-seller"
																	id="${bestSeller.productId }" onclick="bestFloating(id);">
																	<img src="${bestSeller.productImage }"
																		style="object-fit: scale-down;">
																</div>
															</c:forEach>
															<c:forEach var="bestSeller" items="${listMap.bestSellerList }">
																<div class="swiper-slide bset-seller">
																	<img src="${bestSeller.productImage }"
																		style="object-fit: scale-down;">
																</div>
															</c:forEach>
														</div>
													</div>
												</div>	
												<div class="col-4 sellingList">
												<h2 class="subj">많이 팔린 상품</h2>
													<div>
														<ul>
														<c:forEach var="sellingProduct" items="${listMap.sellingList }" varStatus="loop" begin="0" end="6">
															<c:choose>
																<c:when test="${loop.index == 0 || loop.index == 1 }">
																<a href="/detail/${sellingProduct.productId }" style="color: black;">												
																	<li><div class="lankList"><img src="${sellingProduct.productImage}"/><div class="sellingListInfo"><img class="numberIcon" src="/resources/assets/images/numberIcon/${loop.index + 1 }.png" /><div class="sellingListInfo"><h3>${sellingProduct.productName }</h3><div>${sellingProduct.publisher }</div></div><div class="sellingListInfo"><fmt:formatNumber value="${sellingProduct.sellingPrice}" pattern="#,###원" /></div></div></li>
																</a>
																</c:when>
																<c:otherwise>
																<a href="/detail/${sellingProduct.productId }" style="color: black;">	
																	<li><img class="numberIcon" src="/resources/assets/images/numberIcon/${loop.index + 1 }.png" />${sellingProduct.productName }</li>
																</a>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														</ul>
													</div>
												</div>
											</div>
										</c:when>
									</c:choose>
								</c:forEach>
								<div class="newPoductList">
								<h2 class="subj">새로 나온 책</h2>
									<ul>
									<c:forEach var="newProduct" items="${listMap.newList }">
									<a href="/detail/${newProduct.productId }" style="color: black;">								
										<li class="newProd">
										<img src="${newProduct.productImage }">
										<h3>${newProduct.productName }</h3>
										<span><fmt:formatNumber value="${newProduct.sellingPrice}" pattern="#,###원" /></span>
										<del style="color: gray;">
										<fmt:formatNumber value="${newProduct.consumerPrice}" pattern="#,###원" /></del></li>
									</a>
									</c:forEach>
									</ul>
								</div>
							</div>
						</div>
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
		   	  spaceBetween: 30,
		      centeredSlides: true,
		      autoplay: {
		        delay: 7500,
		        disableOnInteraction: false,
		      },
		      pagination: {
		        el: ".swiper-pagination",
		        clickable: true,
		      },
		      navigation: {
		        nextEl: ".swiper-button-next",
		        prevEl: ".swiper-button-prev",
		      },
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