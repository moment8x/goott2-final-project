<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/assets/css/animate.min.css" />
<title>Insert title here</title>
<script src="https://unpkg.com/feather-icons"></script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	const swiper = new Swiper('.swiper', {
		  // Optional parameters
		  direction: 'vertical',
		  loop: true,
	
		  // If we need pagination
		  pagination: {
		    el: '.swiper-pagination',
		  },
	
		  // Navigation arrows
		  navigation: {
		    nextEl: '.swiper-button-next',
		    prevEl: '.swiper-button-prev',
		  },
	
		  // And if we need scrollbar
		  scrollbar: {
		    el: '.swiper-scrollbar',
		  },
		});
</script>
<style>
	.nav-link.noActive::after{
		width:100%;background:#1aa488
	}.product-section-box
	
	.swiper {
	  width: 600px;
	  height: 300px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- mobile fix menu start  -->
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
				<div class="col-custome-3" >
					<div class="left-box wow fadeInUp">
						<div class="shop-left-sidebar">
							<ul class="nav nav-pills mb-3 custom-nav-tab" id="pills-tab"
								role="tablist">
								<c:forEach var="category" items="${categories }"
									varStatus="loop">
									<li class="nav-item" role="presentation" style="width: 80%; height: 60%; background-color: #FFA17A;">
										<button class="nav-link ${loop.index % 2 == 0 ? 'active' : 'noActive' }" id="pills-vegetables"
											data-bs-toggle="pill" data-bs-target="#pills-vegetable"
											type="button" role="tab" aria-selected="true"
											onclick="location.href='/list/categoryList/${category.category_key }'"
											id="${loop.index }" style="font-weight: 600; color: #444">
											${category.category_name }<img
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
					<!-- Slider main container -->
					<div class="swiper">
					  <!-- Additional required wrapper -->
					  <div class="swiper-wrapper">
					    <!-- Slides -->
					    <div class="swiper-slide">Slide 1</div>
					    <div class="swiper-slide">Slide 2</div>
					    <div class="swiper-slide">Slide 3</div>
					  </div>
					  <!-- If we need pagination -->
					  <div class="swiper-pagination"></div>
					
					  <!-- If we need navigation buttons -->
					  <div class="swiper-button-prev"></div>
					  <div class="swiper-button-next"></div>
					
					  <!-- If we need scrollbar -->
					  <div class="swiper-scrollbar"></div>
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
								<img src="https://media.istockphoto.com/id/1437657408/ko/%EB%B2%A1%ED%84%B0/%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B2%A9%EB%A6%AC%EB%90%9C-%EC%88%98%EC%B1%84%ED%99%94-%EC%95%84%EA%B8%B0-%EC%82%AC%EC%8A%B4-%EA%B7%80%EC%97%AC%EC%9A%B4-%EC%82%BC%EB%A6%BC-%EB%8F%99%EB%AC%BC-%EC%86%90%EC%9C%BC%EB%A1%9C-%EA%B7%B8%EB%A6%B0-%EA%B7%B8%EB%A6%BC-%ED%82%A4%EC%A6%88-%EB%94%94%EC%9E%90%EC%9D%B8.jpg?s=1024x1024&w=is&k=20&c=U3NghfcvPpFArhj6oAg9-6iVjW4pINKHcjNHFarbEzk="
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
							 		<a href="/order/requestOrder?product_id="+pId+"&isLogin=Y" id="MemberLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
							 	</c:when>
							 	<c:otherwise>
							 		<a href="" id="loginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
									<a href="" id="noLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F9B572;" onclick="">비 회원 구매</button></a>
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


	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>