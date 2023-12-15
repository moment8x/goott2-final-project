<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Fastkart">
    <meta name="keywords" content="Fastkart">
    <meta name="author" content="Fastkart">
    <link rel="icon" href="/resources/assets/images/favicon/3.png" type="image/x-icon">
    <title>On-demand last-mile delivery</title>
<script src="https://unpkg.com/feather-icons"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
function changeProduct(pId, type) {
	$.ajax({
		url : '/list/float',
		type : 'POST',
		data : {
			"id" : pId,
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			if(type == "selling"){
				changeSellingProductInfo(data);
			} else {
				changeRatingProductInfo(data);
			}
		},
		error : function() {
			
		}
	});
}

function changeSellingProductInfo(data) {
	$("#sellingProductInfoLink").attr("href","/detail/"+data.productId)
	$("#sellingProductInfoImg").attr("src", data.productImage);
	$("#sellingProductInfoName").html(data.productName);
	$("#sellingProductInfoPublisher").html(data.publisher);
}
function changeRatingProductInfo(data) {
	$("#ratingProductInfoLink").attr("href","/detail/"+data.productId)
	$("#ratingProductInfoImg").attr("src", data.productImage);
	$("#ratingProductInfoName").html(data.productName);
	$("#ratingProductInfoPublisher").html(data.publisher);
}
</script>
<style>
	.text-abb {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 200px; 
}
	.text-abb-300 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 300px; 
}
	.productInfoImg {
	width: 400px; 
	height: 600px; 
	margin-top: 70px;"
	}
	.main {
		height: 100% !impotant;
	}
</style>
</head>

<body class="">

	<jsp:include page="./header.jsp"></jsp:include>

    <!-- Home Section Start -->
    <section class="home-section pt-2">
        <div class="container-fluid-lg">
            <div class="row g-4">
                <div class="col-xl-9 col-lg-8">
                    <div class="home-contain h-100">
                        <img src="/resources/assets/images/banner2.jpg" class="bg-img blur-up lazyload" alt="">
                        </div>
                        <div class="home-detail p-center-left w-75 position-relative mend-auto">
                        </div>
                </div>
                <div class="col-xl-3 col-lg-4 d-lg-inline-block d-none ratio_156">
                    <div class="home-contain h-100">
                        <img src="/resources/assets/images/subBanner1.png" class="bg-img blur-up lazyload" alt="">
                        <div class="home-detail p-top-left home-p-sm w-75">
                            <div>
                                <h2 class="mt-0 text-danger">15% <span class="discount text-title text-warnning" style="font-size: 42px;">할인</span></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Home Section End -->

    <!-- Category Section Start -->
    <section>
        <div class="container-fluid-lg">
            <div class="title">
                <h2>바로 가기</h2>
                <span class="title-leaf">
                    <svg class="icon-width">
                        <use xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
                </span>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="slider-9">
                        <div>
                            <a href="/login/" class="category-box wow fadeInUp" data-wow-delay="0.15s">
                                <div style="margin: 0, 500px;">
                                    <img src="/resources/assets/images/login.png" class="blur-up lazyload" alt="">
                                    <h5>로그인</h5>
                                </div>
                            </a>
                        </div>
                        <div>
                            <a href="/user/myPage" class="category-box wow fadeInUp">
                                <div>
                                    <img src="/resources/assets/images/invoice.png" class="blur-up lazyload" alt="">
                                    <h5>마이페이지</h5>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a href="shop-left-sidebar.html" class="category-box wow fadeInUp" data-wow-delay="0.05s">
                                <div>
                                    <img src="/resources/assets/images/shopping-cart.png" class="blur-up lazyload" alt="">
                                    <h5>장바구니</h5>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a href="/cs/serviceCenter" class="category-box wow fadeInUp" data-wow-delay="0.1s">
                                <div>
                                    <img src="/resources/assets/images/customer-care.png" class="blur-up lazyload" alt="">
                                    <h5>고객센터</h5>
                                </div>
                            </a>
                        </div>


                        <div>
                            <a href="/etc/notice" class="category-box wow fadeInUp" data-wow-delay="0.2s">
                                <div>
                                    <img src="/resources/assets/images/notice.png"" class="blur-up lazyload" alt="">
                                    <h5>공지사항</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Category Section End -->

    <!-- Discount Section Start -->
    <section>
        <div class="container-fluid-lg">
            <div class="row">
                <div class="col-12">
                    <div class="banner-contain">
                        <div class="banner-contain hover-effect">
                            <img src="/resources/assets/images/middle-banner1.png" class="bg-img blur-up lazyload" alt="">
                            <div class="banner-details p-center p-sm-4 p-3 text-white text-center" style="height: 135px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Discount Section End -->

    <!-- Product Section Start -->
    <section>
        <div class="container-fluid-lg">
            <div class="title">
                <h2>이 달의 베스트 셀러</h2>
                <span class="title-leaf">
                    <svg class="icon-width">
                        <use xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
                </span>
                <p>디어 북스 추천 도서!</p>
            </div>
            <div class="product-border border-row">
                <div class="slider-6_2 no-arrow">
                        <c:forEach var="bestSellerProduct" items="${listProductsMap.bestSellerList }">
                            <div class="col-12 px-0">
                                <div class="product-box wow fadeIn" data00-wow-delay="0.1s">
                                    <div class="product-image">
                                        <a href="/detail/${bestSellerProduct.productId }">
                                            <img src="${bestSellerProduct.productImage }"
                                                class="img-fluid blur-up lazyload" alt=""  style="height: 400px;">
                                        </a>
                                    </div>
                                    <div class="product-detail">
                                        <a href="/detail/${bestSellerProduct.productId }">
                                            <h4 class="name name-2 h-100 text-abb">${bestSellerProduct.productName }</h4>
                                        </a>
                                        <div class="product-rating mt-2">
                                            <ul class="rating">
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                            </ul>
                                            <span>(34)</span>
                                        </div>

                                        <div class="counter-box">
                                            <span class="theme-color">
                                            	<fmt:formatNumber value="${bestSellerProduct.sellingPrice}" pattern="#,###원" />
                                            </span>
                                            <del>
												<fmt:formatNumber value="${bestSellerProduct.consumerPrice}" pattern="#,###원" />
											</del>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Offer Section Start -->
    <section>
        <div class="container-fluid-lg">
            <div class="row">
                <div class="col-12">
                    <div class="offer-box hover-effect" style="height: 180px;">
                        <img src="/resources/assets/images/middleBanner2.png" class="bg-img blur-up lazyload" alt="">
   
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Offer Section End -->

    <!-- Product Section Start -->
    <section>
        <div class="container-fluid-lg">
            <div class="title">
                <h2>신간 도서</h2>
                <span class="title-leaf">
                    <svg class="icon-width">
                        <use xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
                </span>
                <p>방금 들어온 도서</p>
            </div>
            <div class="product-border border-row">
                <div class="slider-6_2 no-arrow">
                	<c:forEach var="newProduct" items="${listProductsMap.newList }">
                            <div class="col-12 px-0">
                                <div class="product-box wow fadeIn" data-wow-delay="0.1s">
                                    <div class="product-image">
                                        <a href="/detail/${newProduct.productId }">
                                            <img src="${newProduct.productImage }"
                                                class="img-fluid blur-up lazyload" alt="" style="height: 400px;">
                                        </a>
                                    </div>
                                    <div class="product-detail">
                                        <a href="/detail/${newProduct.productId }">
                                            <h4 class="name name-2 h-100 text-abb">${newProduct.productName }</h4>
                                        </a>

                                        <div class="product-rating mt-2">
                                            <ul class="rating">
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                            </ul>
                                            <span>(34)</span>
                                        </div>

                                        <div class="counter-box">
                                            <span class="theme-color">
                                            	<fmt:formatNumber value="${newProduct.sellingPrice}" pattern="#,###원" />
                                            </span>
                                            <del>
												<fmt:formatNumber value="${newProduct.consumerPrice}" pattern="#,###원" />
											</del>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->


    <!-- Top Selling Section Start -->
    <section class="top-selling-section">
        <div class="container-fluid-lg">
            <div class="slider-1">
                <div>
                    <div class="row">
                        <div class="col-6">
                            <div class="top-selling-box">
                                <div class="top-selling-title">
                                    <h3>많이 팔린 도서</h3>
                                </div>
                            <c:forEach var="sellingProduct" items="${listProductsMap.sellingList }" varStatus="loop">
                                <div class="top-selling-contain wow">
                                    <a href="javascript:void(0)" class="top-selling-image" onclick="changeProduct('${sellingProduct.productId}', 'selling');">
                                        <img src="${sellingProduct.productImage }"
                                            class="img-fluid blur-up lazyload" alt="">
                                    </a>

                                    <div class="top-selling-detail">
                                        <a href="javascript:void(0)" onclick="changeProduct('${sellingProduct.productId}', 'selling'););">
                                            <h5 class="text-abb-300">${sellingProduct.productName }</h5>
                                        </a>
                                        <div class="product-rating">
                                            <ul class="rating selling-rating">
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                            </ul>
                                            <span>(34)</span>
                                        </div>
                                        <span class="theme-color">
                                            <fmt:formatNumber value="${sellingProduct.sellingPrice}" pattern="#,###원" />
                                        </span>
                                        <del>
											<fmt:formatNumber value="${sellingProduct.consumerPrice}" pattern="#,###원" />
										</del>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-6 productInfo">
                        	<a href="/detail/${listProductsMap.sellingList[0].productId }" id="sellingProductInfoLink">
                        	<img src="${listProductsMap.sellingList[0].productImage }" id="sellingProductInfoImg" class="productInfoImg" />
                        	<div id="sellingProductInfoPublisher" style="margin: 40px 0 20px 0">
                        		${listProductsMap.sellingList[0].publisher }
                        	</div>
                        	<div>
                        		<h2 id="sellingProductInfoName">${listProductsMap.sellingList[0].productName }</h2>
                        	</div>
                        	</a>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="row">
                        <div class="col-6">
                            <div class="top-selling-box">
                                <div class="top-selling-title">
                                    <h3>높은 평점순</h3>
                                </div>
								<c:forEach var="ratingProduct" items="${listProductsMap.ratingList }">
                                <div class="top-selling-contain wow">
                                    <a href="product-left-thumbnail.html" class="top-selling-image" onclick="changeProduct('${ratingProduct.productId}');">
                                        <img src="${ratingProduct.productImage }"
                                            class="img-fluid blur-up lazyload" alt="">
                                    </a>

                                    <div class="top-selling-detail">
                                        <a href="product-left-thumbnail.html" onclick="changeProduct('${ratingProduct.productId}');">
                                            <h5 class="text-abb-300">${ratingProduct.productName }</h5>
                                        </a>
                                        <div class="product-rating">
                                            <ul class="rating">
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                            </ul>
                                            <span>(34)</span>
                                        </div>
                                        <span class="theme-color">
                                            <fmt:formatNumber value="${ratingProduct.sellingPrice}" pattern="#,###원" />
                                        </span>
                                        <del>
											<fmt:formatNumber value="${ratingProduct.consumerPrice}" pattern="#,###원" />
										</del>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-6 productInfo">
                        	<a href="/detail/${listProductsMap.ratingList[0].productId }" id="ratingProductInfoLink">
                        	<img src="${listProductsMap.ratingList[0].productImage }" id="ratingProductInfoImg" class="productInfoImg"/>
                        	<div id="ratingProductInfoPublisher" style="margin: 40px 0 20px 0">${listProductsMap.ratingList[0].publisher }</div>
                        	<div>
                        		<h2 id="ratingProductInfoName">${listProductsMap.ratingList[0].productName }</h2>
                        	</div>
                        	</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Top Selling Section End -->

    <!-- Blog Section Start -->
    <section>
        <div class="container-fluid-lg" style="padding-bottom: 150px;">
            <div class="title">
                <h2>고객님들께서 많이 담아간 상품</h2>
                <span class="title-leaf">
                    <svg class="icon-width">
                        <use xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
                </span>
                <p>일반적으로 장바구니에 많이 담겨진 상품들</p>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="slider-5 ratio_87">
                    	<c:forEach var="cartProduct" items="${listProductsMap.cartList }" >
                        <div>
                            <div class="blog-box">
                                <div class="blog-box-image">
                                    <a href="/detail/${cartProduct.productId }" class="blog-image">
                                        <img src="${cartProduct.productImage }" class="bg-img blur-up lazyload cartProductImg" 
                                            alt="">
                                    </a>
                                </div>

                                <div class="blog-detail">
                                    <h6>${cartProduct.publisher }</h6>
                                    <h5>${cartProduct.productName }</h5>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->


    <!-- Quick View Modal Box Start -->
    <div class="modal fade theme-modal view-modal" id="view" tabindex="-1" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl modal-fullscreen-sm-down">
            <div class="modal-content">
                <div class="modal-header p-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row g-sm-4 g-2">
                        <div class="col-lg-6">
                            <div class="slider-image">
                                <img src="/resources/assets/images/product/category/1.jpg" class="img-fluid blur-up lazyload"
                                    alt="">
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="right-sidebar-modal">
                                <h4 class="title-name">Peanut Butter Bite Premium Butter Cookies 600 g</h4>
                                <h4 class="price">$36.99</h4>
                                <div class="product-rating">
                                    <ul class="rating">
                                        <li>
                                            <i data-feather="star" class="fill"></i>
                                        </li>
                                        <li>
                                            <i data-feather="star" class="fill"></i>
                                        </li>
                                        <li>
                                            <i data-feather="star" class="fill"></i>
                                        </li>
                                        <li>
                                            <i data-feather="star" class="fill"></i>
                                        </li>
                                        <li>
                                            <i data-feather="star"></i>
                                        </li>
                                    </ul>
                                    <span class="ms-2">8 Reviews</span>
                                    <span class="ms-2 text-danger">6 sold in last 16 hours</span>
                                </div>

                                <div class="product-detail">
                                    <h4>Product Details :</h4>
                                    <p>Candy canes sugar plum tart cotton candy chupa chups sugar plum chocolate I love.
                                        Caramels marshmallow icing dessert candy canes I love soufflé I love toffee.
                                        Marshmallow pie sweet sweet roll sesame snaps tiramisu jelly bear claw. Bonbon
                                        muffin I love carrot cake sugar plum dessert bonbon.</p>
                                </div>

                                <ul class="brand-list">
                                    <li>
                                        <div class="brand-box">
                                            <h5>Brand Name:</h5>
                                            <h6>Black Forest</h6>
                                        </div>
                                    </li>

                                    <li>
                                        <div class="brand-box">
                                            <h5>Product Code:</h5>
                                            <h6>W0690034</h6>
                                        </div>
                                    </li>

                                    <li>
                                        <div class="brand-box">
                                            <h5>Product Type:</h5>
                                            <h6>White Cream Cake</h6>
                                        </div>
                                    </li>
                                </ul>

                                <div class="select-size">
                                    <h4>Cake Size :</h4>
                                    <select class="form-select select-form-size">
                                        <option selected>Select Size</option>
                                        <option value="1.2">1/2 KG</option>
                                        <option value="0">1 KG</option>
                                        <option value="1.5">1/5 KG</option>
                                        <option value="red">Red Roses</option>
                                        <option value="pink">With Pink Roses</option>
                                    </select>
                                </div>

                                <div class="modal-button">
                                    <button onclick="location.href = 'cart.html';"
                                        class="btn btn-md add-cart-button icon">Add
                                        To Cart</button>
                                    <button onclick="location.href = 'product-left.html';"
                                        class="btn theme-bg-color view-button icon text-white fw-bold btn-md">
                                        View More Details</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Quick View Modal Box End -->

    <!-- Location Modal Start -->
    <div class="modal location-modal fade theme-modal" id="locationModal" tabindex="-1"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Choose your Delivery Location</h5>
                    <p class="mt-1 text-content">Enter your address and we will specify the offer for your area.</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="location-list">
                        <div class="search-input">
                            <input type="search" class="form-control" placeholder="Search Your Area">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>

                        <div class="disabled-box">
                            <h6>Select a Location</h6>
                        </div>

                        <ul class="location-select custom-height">
                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Alabama</h6>
                                    <span>Min: $130</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Arizona</h6>
                                    <span>Min: $150</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>California</h6>
                                    <span>Min: $110</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Colorado</h6>
                                    <span>Min: $140</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Florida</h6>
                                    <span>Min: $160</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Georgia</h6>
                                    <span>Min: $120</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Kansas</h6>
                                    <span>Min: $170</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Minnesota</h6>
                                    <span>Min: $120</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>New York</h6>
                                    <span>Min: $110</span>
                                </a>
                            </li>

                            <li>
                                <a href="javascript:void(0)">
                                    <h6>Washington</h6>
                                    <span>Min: $130</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Location Modal End -->

    <!-- Deal Box Modal Start -->
    <div class="modal fade theme-modal deal-modal" id="deal-box" tabindex="-1" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
            <div class="modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title w-100" id="deal_today">Deal Today</h5>
                        <p class="mt-1 text-content">Recommended deals for you.</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="deal-offer-box">
                        <ul class="deal-offer-list">
                            <li class="list-1">
                                <div class="deal-offer-contain">
                                    <a href="shop-left-sidebar.html" class="deal-image">
                                        <img src="/resources/assets/images/vegetable/product/10.png" class="blur-up lazyload"
                                            alt="">
                                    </a>

                                    <a href="shop-left-sidebar.html" class="deal-contain">
                                        <h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
                                        <h6>$52.57 <del>57.62</del> <span>500 G</span></h6>
                                    </a>
                                </div>
                            </li>

                            <li class="list-2">
                                <div class="deal-offer-contain">
                                    <a href="shop-left-sidebar.html" class="deal-image">
                                        <img src="/resources/assets/images/vegetable/product/11.png" class="blur-up lazyload"
                                            alt="">
                                    </a>

                                    <a href="shop-left-sidebar.html" class="deal-contain">
                                        <h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
                                        <h6>$52.57 <del>57.62</del> <span>500 G</span></h6>
                                    </a>
                                </div>
                            </li>

                            <li class="list-3">
                                <div class="deal-offer-contain">
                                    <a href="shop-left-sidebar.html" class="deal-image">
                                        <img src="/resources/assets/images/vegetable/product/12.png" class="blur-up lazyload"
                                            alt="">
                                    </a>

                                    <a href="shop-left-sidebar.html" class="deal-contain">
                                        <h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
                                        <h6>$52.57 <del>57.62</del> <span>500 G</span></h6>
                                    </a>
                                </div>
                            </li>

                            <li class="list-1">
                                <div class="deal-offer-contain">
                                    <a href="shop-left-sidebar.html" class="deal-image">
                                        <img src="/resources/assets/images/vegetable/product/13.png" class="blur-up lazyload"
                                            alt="">
                                    </a>

                                    <a href="shop-left-sidebar.html" class="deal-contain">
                                        <h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
                                        <h6>$52.57 <del>57.62</del> <span>500 G</span></h6>
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
            <a id="back-to-top" href="#">
                <i class="fas fa-chevron-up"></i>
            </a>
        </div>
    </div>
    <!-- Tap to top end -->
    
    <jsp:include page="./footer.jsp"></jsp:include>

    <!-- Bg overlay Start -->
    <div class="bg-overlay"></div>
    <!-- Bg overlay End -->

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

    <!-- Auto Height Js -->
    <script src="/resources/assets/js/auto-height.js"></script>

    <!-- Timer Js -->
    <script src="/resources/assets/js/timer1.js"></script>

    <!-- Fly Cart Js -->
    <script src="/resources/assets/js/fly-cart.js"></script>

    <!-- Quantity js -->
    <script src="/resources/assets/js/quantity-2.js"></script>

    <!-- WOW js -->
    <script src="/resources/assets/js/wow.min.js"></script>
    <script src="/resources/assets/js/custom-wow.js"></script>

    <!-- script js -->
    <script src="/resources/assets/js/script.js"></script>
</body>

</html>