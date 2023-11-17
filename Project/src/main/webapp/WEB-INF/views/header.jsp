<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html >
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Fastkart">
    <meta name="keywords" content="Fastkart">
    <meta name="author" content="Fastkart">
    <link rel="icon" href="/resources/assets/images/favicon/1.png" type="image/x-icon">
    <title>Header</title>
      
       <!-- Google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet">
    <link 
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
        
    <!-- bootstrap css -->
    <link id="rtl-link" rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/bootstrap.css">
    <!-- font-awesome css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/font-awesome.css">
    <!-- feather icon css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/feather-icon.css">
    <!-- slick css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/slick/slick.css">
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/slick/slick-theme.css">
    <!-- Iconly css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/bulk-style.css">
    <!-- Template css -->
    <link id="color-link" rel="stylesheet" type="text/css" href="/resources/assets/css/style.css">
    
    <!-- latest jquery -->
    <script src="/resources/assets/js/jquery-3.6.0.min.js"></script>
    
    <script>
    	$(function () {
    		showCart();
    	});
    	
	    function searching() {
	    	let val = $("#searching-var").val();
	    	let url = "/list/searchPage?val=" + val;
	    	window.location.href=url;
		}
	    
		function delCart(productId) {
			$.ajax({
				url: "/shoppingCart/" + productId,
				type: "DELETE",
				data: {
					"productId" : productId
				},
				dataType: "json",
				async: false,
				success: function (data) {
					console.log("data", data);
					if (data.status === "success") {
						newCart(data.cartItems);
					}
				}, error: function (data) {
					console.log(data);
				}
			});
		}
		
		function showCart() {
			let output = "";
			let output2 = "";
			let output3 = "";
			//let output3 = '<i data-feather="shopping-cart"></i>';
			
			output += `<c:if test='${cartItems != "none"}'>`;
			
			output += `<c:forEach var="item" items="${cartItems}">`;
			output += `<li class="product-box-contain">`;
			output += `<div class="drop-cart">`;
    		output += `<a href="#" class="drop-image">`;
    		output += `<img src="${item.productImage}" class="blur-up lazyload" alt=""></a>`;
    		output += `<div class="drop-contain">`;
    		output += `<a href="#">`;
    		output += `<h5>${item.productName}</h5></a>`;
    		output += `<h6><span>1 x</span> ${item.sellingPrice}원</h6>`;
    		output += `<button class="close-button close_button" onclick="delCart('${item.productId}');">`;
    		output += `<i class="fa-solid fa-xmark"></i></button></div></div></li>`;
    		output += `</c:forEach></c:if>`;
    		output += `<c:if test='${cartItems == "none"}'>`;
    		output += `등록된 상품이 없습니다.</c:if>`;
    		
    		output2 += `<h5>Total :</h5>`;
    		output2 += `<c:if test='${cartItems != "none"}'>`;
    		output2 += `<c:set var="total" value="0" />`;
            output2 += `<c:forEach var="item" items="${cartItems}" varStatus="status">`;
            output2 += `<c:set var="total" value="${total + item.sellingPrice}" />`;
            output2 += `</c:forEach>`;
            output2 += `<c:out value="${total }"/>원</c:if>`;
            output2 += `<c:if test='${cartItems == "none"}'>--</c:if>`;
            
            output3 += `<c:if test='${cartItems != "none"}'>`;
            output3 += `<span class="position-absolute top-0 start-100 translate-middle badge">${cartItems.size()}`;
            output3 += `<span class="visually-hidden">unread messages</span></span></c:if>`;
            
			$('.cart-list').html(output);
			$('.price-box').html(output2);
			$('.red-icon').html(output3);
		}
		
		function newCart(items) {
			let output = "";
			let output2 = '<h5>Total :</h5>';
			let output3 = '';
			
			if (items !== "none") {
				let total = 0;
				items.forEach(function (item) {
					output += `<li class="product-box-contain">`;
					output += `<div class="drop-cart">`;
		    		output += `<a href="#" class="drop-image">`;
		    		output += '<img src=\"' + item.productImage + '\" class="blur-up lazyload" alt=""></a>';
		    		output += `<div class="drop-contain">`;
		    		output += `<a href="#">`;
		    		output += '<h5>' + item.productName + '</h5></a>';
		    		output += '<h6><span>1 x</span>' + item.sellingPrice + '원</h6>';
		    		output += '<button class="close-button close_button"';
		    		output += 'onclick=\"delCart(\'' + item.productId + '\');\">';
		    		output += `<i class="fa-solid fa-xmark"></i></button></div></div></li>`;
		    		
		            total += item.sellingPrice;
				});
				output2 += total + '원';
				output3 += '<span class="position-absolute top-0 start-100 translate-middle badge">';
				output3 += items.length + '<span class="visually-hidden">unread messages</span></span>';
			} else {
				output += '등록된 상품이 없습니다.';
	            output2 += '--';
	            // output3에 빨간거 없애기!
			}
			
			$('.cart-list').html(output);
			$('.price-box').html(output2);
			$('.red-icon').html(output3);
		}
	</script>
	
  </head>

  <!-- Header Start -->
    <header class="pb-md-4 pb-0">

        <div class="header-top">
            <div class="container-fluid-lg">
                <div class="row">
                    <div class="col-xxl-3 d-xxl-block d-none">
                        <div class="top-left-header">
                            <i class="iconly-Location icli text-white"></i>
                            <span class="text-white">1418 Riverwood Drive, CA 96052, US</span>
                        </div>
                    </div>

                    <div class="col-xxl-6 col-lg-9 d-lg-block d-none">
                        <div class="header-offer">
                            <div class="notification-slider">
                                <div>
                                    <div class="timer-notification">

                                        <h6>
                      					 <!-- <strong class="me-1">Deer Books에 오신것을 환영합니다!</strong>-->
                      					 <strong class="me-1">Deer Books에 오신것을 환영합니다!</strong>
                   					   </h6>
                                    </div>
                                </div>
                                <div>
                                    <div class="timer-notification">
                                       <h6>
                       					 사슴을 살려주세요!
                       					 <a href="shop-left-sidebar.html" class="text-white">Save Life!</a >
                    				  </h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <ul class="about-list right-nav-about">
                            <li class="right-nav-list">
                                <div class="dropdown theme-form-select">
                                    <button class="btn dropdown-toggle" type="button" id="select-language"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <img src="/resources/assets/images/country/united-states.png"
                                            class="img-fluid blur-up lazyload" alt="">
                                        <span>English</span>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="select-language">
                                        <li>
                                            <a class="dropdown-item" href="javascript:void(0)" id="english">
                                                <img src="/resources/assets/images/country/united-kingdom.png"
                                                    class="img-fluid blur-up lazyload" alt="">
                                                <span>English</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:void(0)" id="france">
                                                <img src="/resources/assets/images/country/germany.png"
                                                    class="img-fluid blur-up lazyload" alt="">
                                                <span>Germany</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="javascript:void(0)" id="chinese">
                                                <img src="/resources/assets/images/country/turkish.png"
                                                    class="img-fluid blur-up lazyload" alt="">
                                                <span>Turki</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="right-nav-list">
                                <div class="dropdown theme-form-select">
                                    <button class="btn dropdown-toggle" type="button" id="select-dollar"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <span>USD</span>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end sm-dropdown-menu"
                                        aria-labelledby="select-dollar">
                                        <li>
                                            <a class="dropdown-item" id="aud" href="javascript:void(0)">AUD</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" id="eur" href="javascript:void(0)">EUR</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" id="cny" href="javascript:void(0)">CNY</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="top-nav top-header sticky-header">
            <div class="container-fluid-lg">
                <div class="row">
                    <div class="col-12">
                        <div class="navbar-top">
                            <button class="navbar-toggler d-xl-none d-inline navbar-menu-button" type="button"
                                data-bs-toggle="offcanvas" data-bs-target="#primaryMenu">
                                <span class="navbar-toggler-icon">
                                    <i class="fa-solid fa-bars"></i>
                                </span>
                            </button>
                            <a href="/" class="web-logo nav-logo">

                                <img src="/resources/assets/images/deer.png" class="img-fluid blur-up lazyload" alt="">
                            </a>

                            <div class="middle-box">
                                <div class="location-box">
                                    <button class="btn location-button" data-bs-toggle="modal"
                                        data-bs-target="#locationModal">
                                        <span class="location-arrow">
                                            <i data-feather="map-pin"></i>
                                        </span>
                                        <span class="locat-name">Your Location</span>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </button>
                                </div>

                                <div class="search-box">
                                    <div class="input-group">
                                        <input type="search" class="form-control" placeholder="검색할 내용을 입력하세요"
                                            aria-label="Recipient's username" aria-describedby="button-addon2" id="searching-var">
                                        <button class="btn" type="button" id="button-addon2" onclick="searching();">
                                            <i data-feather="search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="rightside-box">
                                <div class="search-full">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i data-feather="search" class="font-light"></i>
                                        </span>
                                        <input type="text" class="form-control search-type" placeholder="Search here..">
                                        <span class="input-group-text close-search">
                                            <i data-feather="x" class="font-light"></i>
                                        </span>
                                    </div>
                                </div>
                                <ul class="right-side-menu">
                                    <li class="right-side">
                                        <div class="delivery-login-box">
                                            <div class="delivery-icon">
                                                <div class="search-box">
                                                    <i data-feather="search"></i>
                                                </div>
                                            </div>
                                        </div>

                                    <li class="right-side">
                                        <a href="contact-us.html" class="delivery-login-box">
                                            <div class="delivery-icon">
                                                <i data-feather="phone-call"></i>
                                            </div>
                                            <div class="delivery-detail">
                                                <h6>24/7 Delivery</h6>
                                                <h5>+91 888 104 2340</h5>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="right-side" data-bs-toggle="modal" data-bs-target="#deal-box">
                                            <i data-feather="heart"></i>

                                    </li>
                                    <li class="right-side">
                                        <div class="onhover-dropdown header-badge">
                                            <button type="button" class="btn p-0 position-relative header-wishlist">
                                            	<i data-feather="shopping-cart"></i>
                                            	<div class="red-icon"></div>
                                            </button>

                                            <div class="onhover-div">
                                                <ul class="cart-list">
                                                	
                                                </ul>

                                                <div class="price-box">
                                                    
                                                </div>

                                                <div class="button-group">
                                                    <a href="/shoppingCart/shoppingCart" class="btn btn-sm cart-button">View Cart</a>
                                                    <a href="checkout.html" class="btn btn-sm cart-button theme-bg-color
                                                    text-white">Checkout</a>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="right-side onhover-dropdown">
                                        <div class="delivery-login-box">
                                            <div class="delivery-icon">
                                                <i data-feather="user"></i>
                                            </div>
                                            <div class="delivery-detail">
                                                <h6>Hello,</h6>
                                                <h5>My Account</h5>
                                            </div>
                                        </div>

                                        <div class="onhover-div onhover-div-login">
                                            <ul class="user-box-name">
                                                <li class="product-box-contain">
                                                    <i></i>
                                                    <!-- 시큐리티 적용시
                                                    <sec:authorize access="isAnonymous()" >
                                                    	<a href="/login/">Log In</a>
                                                    </sec:authorize>
                                                    <sec:authorize access="isAuthenticated()">
                                                    	  <form method="post" action="/logout">
													        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													        <input type="submit" value="로그아웃" />    
													        </form>                                                
                                                    </sec:authorize>
                                                    -->
                                                    <c:choose>
														<c:when test="${sessionScope.loginMember == null }">
		                                                    <a href="/login/">Log In</a>
														</c:when>
														<c:otherwise>
		                                                    <a href="/login/logout">Log out</a>
														</c:otherwise>
													</c:choose>
                                                </li>

                                                <li class="product-box-contain">
                                                    <a href="/register/register">Register</a>
                                                </li>

                                                <li class="product-box-contain">
                                                    <a href="forgot.html">Forgot Password</a>
                                                </li>
                                                
                                              <li class="product-box-contain">
                                                    <a href="/user/myPage">My Page</a>
                                                </li>
                                              
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid-lg">
            <div class="row">
                <div class="col-12">
                    <div class="header-nav">
                        <div class="header-nav-left">
                            <button class="dropdown-category">
                                <i data-feather="align-left"></i>
                                <span>All Categories</span>
                            </button>

                            <div class="category-dropdown">
                                <div class="category-title">
                                    <h5>Categories</h5>
                                    <button type="button" class="btn p-0 close-button text-content">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </div>
		                  <ul class="category-list">
		                    <li class="onhover-category-list" >
		                      <a href="javascript:void(0)" class="category-name">
		                        <img src="/resources/assets/images/open-book.png" alt="" />
		                        <h6>국내도서</h6>
		                        <i class="fa-solid fa-angle-right"></i>
		                      </a>
		
		                      <div class="onhover-category-box" style="width: 600px; height: 550px;">
		                        <div class="list-1">
		                          <div class="category-title-box">
		                            <a href="/list/category/KOR"><h5>국내도서 전체</h5></a>
		                          </div>
		                          <ul>
		                            <li>
		                              <a href="/list/categoryList/KOR/01">소설</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/02"
		                                >시/에세이</a
		                              >
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/03">인문</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/04">가정/육아</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/05">요리</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/06"
		                                >건강</a
		                              >
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/07">취미/실용/스포츠</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/08">경제/경영</a>
		                            </li>
		                            <li>
		                                <a href="/list/categoryList/KOR/09">자기계발</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR/10">정치/사회</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR/11">역사/문화</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR/12">종교</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR/13">예술/대중문화</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR/14">중/고등 참고서</a>
		                              </li>
		                          </ul>
		                        </div>
		
		                        <div class="list-2">
		                          <div class="category-title-box">
		                          </div>
		                          <ul>
		                            <li>
		                              <a href="/list/categoryList/KOR/15">기술/공학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/16">외국어</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/17">과학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/18">취섭/수험서</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/19">여행</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/20">컴퓨터/IT</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/21">잡지</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/22">청소년</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/23">초등 참고서</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/24">유아(0~7세)</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/25">어린이(초등)</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/26">만화</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/27">대학교재</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR/28">한국소개도서</a>
		                            </li>
		                          </ul>
		                        </div>
		                      </div>
		                    </li>
		                    
		                    <li class="onhover-category-list">
		                      <a href="javascript:void(0)" class="category-name">
		                        <img src="/resources/assets/images/open-book.png" alt="" />
		                        <h6>서양도서</h6>
		                        <i class="fa-solid fa-angle-right"></i>
		                      </a>
		                      <div class="onhover-category-box" style="width: 400px; height: 350px;">
		                        <div class="list-1">
		                          <div class="category-title-box">
		                            <a href="/list/category/ENG"><h5>서양도서 전체</h5></a>
		                          </div>
		                          <ul>
		                            <li>
		                              <a href="/list/categoryList/ENG/01">문학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/02">취미/실용/여행</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/03">생활/요리/건강</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/04">예술/건축</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/05">인문/사회</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/06">경제/경영</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG/07">과학/기술</a>
		                            </li>
		                            <li>
		                                <a href="/list/categoryList/ENG/08">어린이ELT</a>
		                            </li>
		                          </ul>
                       			 </div>
                       			 <div class="list-2">
			                            <div class="category-title-box">
			                            </div>
			                            <ul>
			                              <li>
			                                <a href="/list/categoryList/ENG/09">유아/아동/청소년</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/10">환국관련도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/11">문구/멀티/비도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/12">ELT/수험서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/13">프랑스도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/14">독일도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/15">스페인도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/16">기타도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG/17">교재</a>
			                              </li>
			                            </ul>
			                          </div>
			                      </div>
			                    </li>
			
			                    <li class="onhover-category-list">
			                      <a href="javascript:void(0)" class="category-name">
			                        <img src="/resources/assets/images/open-book.png" alt="" />
			                        <h6>일본도서</h6>
			                        <i class="fa-solid fa-angle-right"></i>
			                      </a>
			
			                      <div class="onhover-category-box" style="width: 400px; height: 300px;">
			                        <div class="list-1">
			                          <div class="category-title-box">
			                            <a href="/list/category/JAP"><h5>일본도서 전체</h5></a>
			                          </div>
			                          <ul>
			                            <li>
			                              <a href="/list/categoryList/JAP/01">잡지</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP/02">엔터테인먼트</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP/03">만화/애니</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP/04">문학</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP/05">라이트노벨</a>
			                            </li>
			                            <li>
			                              <a href="/ist/categoryList/JAP/06">문고</a>
			                            </li>
			                            <li>
			                                <a href="/list/categoryList/JAP/07">신서</a>
			                            </li>
			                          </ul>
			                        </div>
			                    <div class="list-2">
			                       <div class="category-title-box">
			                       </div>
			                       <ul>
			                          <li>
			                           <a href="/list/categoryList/JAP/08">아동</a>
			                         </li>
			                          <li>
			                            <a href="/list/categoryList/JAP/09">실용서/예술</a>
			                          </li>
			                         <li>
			                            <a href="/list/categoryList/JAP/10">인문/사회</a>
			                          </li>
			                          <li>
			                           <a href="/list/categoryList/JAP/11">자연/기술과학</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP/12">어학/학습</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP/13">문구/멀티/기타</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP/14">중국도서</a>
			                          </li>
			                        </ul>
			                     </div>
			                  </ul>
                            </div>
                        </div>
                        <div class="header-nav-right">
                            <button class="btn deal-button" data-bs-toggle="modal" data-bs-target="#deal-box">
                                <i data-feather="zap"></i>
                                <span>Deal Today</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    
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

    
    <!-- Header End -->
    
	
    
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
</html>