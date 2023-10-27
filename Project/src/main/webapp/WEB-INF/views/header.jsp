<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                            <a href="index.html" class="web-logo nav-logo">
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
                                        <input type="search" class="form-control" placeholder="I'm searching for..."
                                            aria-label="Recipient's username" aria-describedby="button-addon2">
                                        <button class="btn" type="button" id="button-addon2">
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
                                    </li>
                                    <li class="right-side" data-bs-toggle="modal" data-bs-target="#deal-box">
                                            <i data-feather="heart"></i>
                                    </li>
                                    <li class="right-side">
                                        <div class="onhover-dropdown header-badge">
                                            <button type="button" class="btn p-0 position-relative header-wishlist">
                                                <i data-feather="shopping-cart"></i>
                                                <span class="position-absolute top-0 start-100 translate-middle badge">2
                                                    <span class="visually-hidden">unread messages</span>
                                                </span>
                                            </button>

                                            <div class="onhover-div">
                                                <ul class="cart-list">
                                                    <li class="product-box-contain">
                                                        <div class="drop-cart">
                                                            <a href="product-left-thumbnail.html" class="drop-image">
                                                                <img src="/resources/assets/images/vegetable/product/1.png"
                                                                    class="blur-up lazyload" alt="">
                                                            </a>

                                                            <div class="drop-contain">
                                                                <a href="product-left-thumbnail.html">
                                                                    <h5>Fantasy Crunchy Choco Chip Cookies</h5>
                                                                </a>
                                                                <h6><span>1 x</span> $80.58</h6>
                                                                <button class="close-button close_button">
                                                                    <i class="fa-solid fa-xmark"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </li>

                                                    <li class="product-box-contain">
                                                        <div class="drop-cart">
                                                            <a href="product-left-thumbnail.html" class="drop-image">
                                                                <img src="/resources/assets/images/vegetable/product/2.png"
                                                                    class="blur-up lazyload" alt="">
                                                            </a>

                                                            <div class="drop-contain">
                                                                <a href="product-left-thumbnail.html">
                                                                    <h5>Peanut Butter Bite Premium Butter Cookies 600 g
                                                                    </h5>
                                                                </a>
                                                                <h6><span>1 x</span> $25.68</h6>
                                                                <button class="close-button close_button">
                                                                    <i class="fa-solid fa-xmark"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>

                                                <div class="price-box">
                                                    <h5>Total :</h5>
                                                    <h4 class="theme-color fw-bold">$106.58</h4>
                                                </div>

                                                <div class="button-group">
                                                    <a href="cart.html" class="btn btn-sm cart-button">View Cart</a>
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
                                                    <a href="/login/">Log In</a>
                                                </li>

                                                <li class="product-box-contain">
                                                    <a href="sign-up.html">Register</a>
                                                </li>

                                                <li class="product-box-contain">
                                                    <a href="forgot.html">Forgot Password</a>
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
		                              <a href="/list/categoryList/KOR01">소설</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR02"
		                                >시/에세이</a
		                              >
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR03">인문</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR04">가정/육아</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR05">요리</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR06"
		                                >건강</a
		                              >
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR07">취미/실용/스포츠</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR08">경제/경영</a>
		                            </li>
		                            <li>
		                                <a href="/list/categoryList/KOR09">자기계발</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR10">정치/사회</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR11">역사/문화</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR12">종교</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR13">예술/대중문화</a>
		                              </li>
		                              <li>
		                                <a href="/list/categoryList/KOR14">중/고등 참고서</a>
		                              </li>
		                          </ul>
		                        </div>
		
		                        <div class="list-2">
		                          <div class="category-title-box">
		                          </div>
		                          <ul>
		                            <li>
		                              <a href="/list/categoryList/KOR15">기술/공학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR16">외국어</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR17">과학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR18">취섭/수험서</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR19">여행</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR20">컴퓨터/IT</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR21">잡지</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR22">청소년</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR23">초등 참고서</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR24">유아(0~7세)</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR25">어린이(초등)</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR26">만화</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR27">대학교재</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/KOR28">한국소개도서</a>
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
		                              <a href="/list/categoryList/ENG01">문학</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG02">취미/실용/여행</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG03">생활/요리/건강</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG04">예술/건축</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG05">인문/사회</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG06">경제/경영</a>
		                            </li>
		                            <li>
		                              <a href="/list/categoryList/ENG07">과학/기술</a>
		                            </li>
		                            <li>
		                                <a href="/list/categoryList/ENG08">어린이ELT</a>
		                            </li>
		                          </ul>
                       			 </div>
                       			 <div class="list-2">
			                            <div class="category-title-box">
			                            </div>
			                            <ul>
			                              <li>
			                                <a href="/list/categoryList/ENG09">유아/아동/청소년</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG10">환국관련도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG11">문구/멀티/비도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG12">ELT/수험서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG13">프랑스도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG14">독일도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG15">스페인도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG16">기타도서</a>
			                              </li>
			                              <li>
			                                <a href="/list/categoryList/ENG17">교재</a>
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
			                              <a href="/list/categoryList/JAP01">잡지</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP02">엔터테인먼트</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP03">만화/애니</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP04">문학</a>
			                            </li>
			                            <li>
			                              <a href="/list/categoryList/JAP05">라이트노벨</a>
			                            </li>
			                            <li>
			                              <a href="/ist/categoryList/JAP06">문고</a>
			                            </li>
			                            <li>
			                                <a href="/list/categoryList/JAP07">신서</a>
			                            </li>
			                          </ul>
			                        </div>
			                    <div class="list-2">
			                       <div class="category-title-box">
			                       </div>
			                       <ul>
			                          <li>
			                           <a href="/list/categoryList/JAP08">아동</a>
			                         </li>
			                          <li>
			                            <a href="/list/categoryList/JAP09">실용서/예술</a>
			                          </li>
			                         <li>
			                            <a href="/list/categoryList/JAP10">인문/사회</a>
			                          </li>
			                          <li>
			                           <a href="/list/categoryList/JAP11">자연/기술과학</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP12">어학/학습</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP13">문구/멀티/기타</a>
			                          </li>
			                          <li>
			                            <a href="/list/categoryList/JAP14">중국도서</a>
			                          </li>
			                        </ul>
			                     </div>
			                  </ul>
                            </div>
                        </div>

                        <div class="header-nav-middle">
                            <div class="main-nav navbar navbar-expand-xl navbar-light navbar-sticky">
                                <div class="offcanvas offcanvas-collapse order-xl-2" id="primaryMenu">
                                    <div class="offcanvas-header navbar-shadow">
                                        <h5>Menu</h5>
                                        <button class="btn-close lead" type="button" data-bs-dismiss="offcanvas"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="offcanvas-body">
                                        <ul class="navbar-nav">
                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Home</a>

                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="index.html">Kartshop</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-2.html">Sweetshop</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-3.html">Organic</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-4.html">Supershop</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-5.html">Classic shop</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-6.html">Furniture</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-7.html">Search Oriented</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-8.html">Category Focus</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="index-9.html">Fashion</a>
                                                    </li>
                                                </ul>
                                            </li>

                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Shop</a>

                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="shop-category-slider.html">Shop
                                                            Category Slider</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-category.html">Shop
                                                            Category Sidebar</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-banner.html">Shop Banner</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-left-sidebar.html">Shop Left
                                                            Sidebar</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-list.html">Shop List</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-right-sidebar.html">Shop
                                                            Right Sidebar</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="shop-top-filter.html">Shop Top
                                                            Filter</a>
                                                    </li>
                                                </ul>
                                            </li>

                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Product</a>

                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="product-4-image.html">Product
                                                            4 Image</a>
                                                    </li>
                                                    <li class="sub-dropdown-hover">
                                                        <a href="javascript:void(0)" class="dropdown-item">Product
                                                            Thumbnail</a>
                                                        <ul class="sub-menu">
                                                            <li>
                                                                <a href="product-left-thumbnail.html">Left Thumbnail</a>
                                                            </li>

                                                            <li>
                                                                <a href="product-right-thumbnail.html">Right
                                                                    Thumbnail</a>
                                                            </li>

                                                            <li>
                                                                <a href="product-bottom-thumbnail.html">Bottom
                                                                    Thumbnail</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a href="product-bundle.html" class="dropdown-item">Product
                                                            Bundle</a>
                                                    </li>
                                                    <li>
                                                        <a href="product-slider.html" class="dropdown-item">Product
                                                            Slider</a>
                                                    </li>
                                                    <li>
                                                        <a href="product-sticky.html" class="dropdown-item">Product
                                                            Sticky</a>
                                                    </li>
                                                </ul>
                                            </li>

                                            <li class="nav-item dropdown dropdown-mega">
                                                <a class="nav-link dropdown-toggle ps-xl-2 ps-0"
                                                    href="javascript:void(0)" data-bs-toggle="dropdown">Mega Menu</a>
                                                                                                    <div class="dropdown-menu dropdown-menu-2">
                                                    <div class="row">
                                                        <div class="dropdown-column col-xl-3">
                                                            <h5 class="dropdown-header">Daily Vegetables</h5>
                                                            <a class="dropdown-item" href="shop-left-sidebar.html">Beans
                                                                & Brinjals</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Broccoli & Cauliflower</a>

                                                            <a href="shop-left-sidebar.html"
                                                                class="dropdown-item">Chilies, Garlic</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Vegetables & Salads</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Gourd, Cucumber</a>

                                                            <a class="dropdown-item" href="shop-left-sidebar.html">Herbs
                                                                & Sprouts</a>

                                                            <a href="demo-personal-portfolio.html"
                                                                class="dropdown-item">Lettuce & Leafy</a>
                                                        </div>

                                                        <div class="dropdown-column col-xl-3">
                                                            <h5 class="dropdown-header">Baby Tender</h5>
                                                            <a class="dropdown-item" href="shop-left-sidebar.html">Beans
                                                                & Brinjals</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Broccoli & Cauliflower</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Chilies, Garlic</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Vegetables & Salads</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Gourd, Cucumber</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Potatoes & Tomatoes</a>

                                                            <a href="shop-left-sidebar.html" class="dropdown-item">Peas
                                                                & Corn</a>
                                                        </div>

                                                        <div class="dropdown-column col-xl-3">
                                                            <h5 class="dropdown-header">Exotic Vegetables</h5>
                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Asparagus & Artichokes</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Avocados & Peppers</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Broccoli & Zucchini</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Celery, Fennel & Leeks</a>

                                                            <a class="dropdown-item"
                                                                href="shop-left-sidebar.html">Chilies & Lime</a>
                                                        </div>

                                                        <div class="dropdown-column dropdown-column-img col-3"></div>
                                                    </div>
                                                </div>
                                            </li>

                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Blog</a>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="blog-detail.html">Blog Detail</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="blog-grid.html">Blog Grid</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="blog-list.html">Blog List</a>
                                                    </li>
                                                </ul>
                                            </li>

                                            <li class="nav-item dropdown new-nav-item">
                                                <label class="new-dropdown">New</label>
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Pages</a>
                                                <ul class="dropdown-menu">
                                                    <li class="sub-dropdown-hover">
                                                        <a class="dropdown-item" href="javascript:void(0)">Email
                                                            Template <span class="new-text"><i
                                                                    class="fa-solid fa-bolt-lightning"></i></span></a>
                                                        <ul class="sub-menu">
                                                            <li>
                                                                <a
                                                                    href="../email-templete/abandonment-email.html">Abandonment</a>
                                                            </li>
                                                            <li>
                                                                <a href="../email-templete/offer-template.html">Offer
                                                                    Template</a>
                                                            </li>
                                                            <li>
                                                                <a href="../email-templete/order-success.html">Order
                                                                    Success</a>
                                                            </li>
                                                            <li>
                                                                <a href="../email-templete/reset-password.html">Reset
                                                                    Password</a>
                                                            </li>
                                                            <li>
                                                                <a href="../email-templete/welcome.html">Welcome
                                                                    template</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li class="sub-dropdown-hover">
                                                        <a class="dropdown-item" href="javascript:void(0)">Invoice
                                                            Template <span class="new-text"><i
                                                                    class="fa-solid fa-bolt-lightning"></i></span></a>
                                                        <ul class="sub-menu">
                                                            <li>
                                                                <a href="../invoice/invoice-1.html">Invoice 1</a>
                                                            </li>

                                                            <li>
                                                                <a href="../invoice/invoice-2.html">Invoice 2</a>
                                                            </li>

                                                            <li>
                                                                <a href="../invoice/invoice-3.html">Invoice 3</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="404.html">404</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="about-us.html">About Us</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="cart.html">Cart</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="contact-us.html">Contact</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="checkout.html">Checkout</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="coming-soon.html">Coming Soon</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="compare.html">Compare</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="faq.html">Faq</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="order-success.html">Order
                                                            Success</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="order-tracking.html">Order
                                                            Tracking</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="otp.html">OTP</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="search.html">Search</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="user-dashboard.html">User
                                                            Dashboard</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="wishlist.html">Wishlist</a>
                                                    </li>
                                                </ul>
                                            </li>

                                            <li class="nav-item dropdown">
                                                <a class="nav-link dropdown-toggle" href="javascript:void(0)"
                                                    data-bs-toggle="dropdown">Seller</a>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="seller-become.html">Become a
                                                            Seller</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="seller-dashboard.html">Seller
                                                            Dashboard</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="seller-detail.html">Seller
                                                            Detail</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="seller-detail-2.html">Seller
                                                            Detail 2</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="seller-grid.html">Seller Grid</a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="seller-grid-2.html">Seller Grid
                                                            2</a>
                                                    </li>
                                                </ul>
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
    
    <!-- latest jquery -->
    <script src="/resources/assets/js/jquery-3.6.0.min.js"></script>
    <!-- jquery ui-->
    <script src="/resources/assets/js/jquery-ui.min.js"></script>
    <!-- Bootstrap js-->
    <script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/bootstrap/popper.min.js"></script>
    <script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>

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