<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
    <!-- latest jquery -->
    <script src="/resources/assets/js/jquery-3.6.0.min.js"></script>
    
    <script>
    $(function() {
    	showCart();
    	
    	$("#searching-var").on("keyup", function(e) {
			if(e.keyCode == "13"){
				let val = $(this).val();
		    	let encodedVal = encodeURIComponent(val);
		    	let url = "/list/searchPage?val=" + encodedVal;
		    	window.location.href=url;
			}
		})
	})
    
    
    function searching() {
    	let val = $("#searching-var").val();
    	let encodedVal = encodeURIComponent(val);
    	let url = "/list/searchPage?val=" + encodedVal;
    	window.location.href=url;
	}
    </script>

	
	<script>
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
			output += `<c:if test='${cartItems != "none"}'>`;
			
			output += `<c:forEach var="item" items="${cartItems}">`;
			output += `<li class="product-box-contain">`;
			output += `<div class="drop-cart">`;
    		output += `<a href="/detail/${item.productId}" class="drop-image">`;
    		output += `<img src="${item.productImage}" class="blur-up lazyload" alt=""></a>`;
    		output += `<div class="drop-contain">`;
    		output += `<a href="/detail/${item.productId}" class="drop-image">`;
    		output += `<h5>${item.productName}</h5></a>`;
    		output += `<h6><span>${item.quantity} x </span>`
    		output += '<fmt:formatNumber value="${item.sellingPrice}" pattern="#,###" />원</h6>';
    		output += `<button class="close-button close_button" onclick="delCart('${item.productId}');">`;
    		output += `<i class="fa-solid fa-xmark"></i></button></div></div></li>`;
    		output += `</c:forEach></c:if>`;
    		output += `<c:if test='${cartItems == "none"}'>`;
    		output += `등록된 상품이 없습니다.</c:if>`;
    		
    		output2 += `<h5>총계 :</h5>`;
    		output2 += `<c:if test='${cartItems != "none"}'>`;
    		output2 += `<c:set var="total" value="0" />`;
            output2 += `<c:forEach var="item" items="${cartItems}" varStatus="status">`;
            output2 += `<c:set var="total" value="${total + (item.sellingPrice * item.quantity)}" />`;
            output2 += `</c:forEach>`;
            output2 += `<fmt:formatNumber value="${total}" pattern="#,###" />원</c:if>`;
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
			let output2 = '<h5>총 계 :</h5>';
			let output3 = '';
			
			if (items !== "none") {
				let total = 0;
				items.forEach(function (item) {
					output += `<li class="product-box-contain">`;
					output += `<div class="drop-cart">`;
		    		output += '<a href="/detail/' + item.productId + '" class="drop-image">';
		    		output += '<img src=\"' + item.productImage + '\" class="blur-up lazyload" alt=""></a>';
		    		output += `<div class="drop-contain">`;
		    		output += '<a href="/detail/' + item.productId + '\" class="drop-image">';
		    		output += '<h5>' + item.productName + '</h5></a>';
		    		output += '<h6><span>' + item.quantity + 'x</span>' + item.sellingPrice.toLocaleString('ko-KR') + '원</h6>';
		    		output += '<button class="close-button close_button"';
		    		output += 'onclick=\"delCart(\'' + item.productId + '\');\">';
		    		output += `<i class="fa-solid fa-xmark"></i></button></div></div></li>`;
		    		
		            total += item.sellingPrice;
				});
				output2 += total.toLocaleString('ko-KR') + '원';
				output3 += '<span class="position-absolute top-0 start-100 translate-middle badge">';
				output3 += items.length + '<span class="visually-hidden">unread messages</span></span>';
			} else {
				output += '등록된 상품이 없습니다.';
	            output2 += '--';
			}
			
			$('.cart-list').html(output);
			$('.price-box').html(output2);
			$('.red-icon').html(output3);
		}
	</script>
	<style>
		.cart-list {
			max-height: 600px;
			overflow-y: auto;
		}
		.cart-list::-webkit-scrollbar {
			display: none; /* 크롬, 사파리, 오페라, 엣지 */
		}
	</style>
  </head>

  <!-- Header Start -->
    <header class="pb-md-4 pb-0">

        <div class="header-top">
            <div class="container-fluid-lg">
                <div class="row">
                    <div class="col-xxl-3 d-xxl-block d-none">
                        <div class="top-left-header">
                          <!--   <i class="iconly-Location icli text-white"></i>
                            <span class="text-white">1418 Riverwood Drive, CA 96052, US</span> -->
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
                       					 Deer Books에 오신것을 환영합니다!
                       					 <!-- <a href="shop-left-sidebar.html" class="text-white">Save Life!</a > -->
                    				  </h6>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                            <a href="/" >
                                <img src="/resources/assets/images/deer_logo.svg" class="img-fluid blur-up lazyload" alt="">
                            </a>

                            <div class="middle-box">

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
                                        <div class="onhover-dropdown header-badge">
                                            <button type="button" class="btn p-0 position-relative header-wishlist"
                                            		onclick="location.href='/shoppingCart/shoppingCart'">
                                            	<i data-feather="shopping-cart"></i>
                                            	<div class="red-icon"></div>
                                            </button>

                                            <div class="onhover-div">
                                                <ul class="cart-list">
                                                	
                                                </ul>

                                                <div class="price-box">
                                                    
                                                </div>

                                                <div class="button-group">
                                                    <a href="/shoppingCart/shoppingCart" class="btn btn-sm cart-button" style="margin:auto;">장바구니</a>
                                                    <!-- <a href="checkout.html" class="btn btn-sm cart-button theme-bg-color
                                                    text-white">결제</a> -->
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="right-side onhover-dropdown">
                                        <div class="delivery-login-box">
                                            <div class="delivery-icon">
                                                <i data-feather="user"></i>
                                            </div>
                                            	<c:choose>
													<c:when test="${sessionScope.loginMember == null }">
		                                                <div class="delivery-detail">
			                                                <h5>로그인 해주세요</h5>
			                                            </div>
													</c:when>
													<c:otherwise>
		                                                <div class="delivery-detail">
			                                                <h5>${sessionScope.loginMember.memberId }님 안녕하세요!</h5>
			                                            </div>
													</c:otherwise>
												</c:choose>                  
                                        </div>

                                        <div class="onhover-div onhover-div-login">
                                            <ul class="user-box-name">
                                                <li class="product-box-contain">
                                                    <c:choose>
														<c:when test="${sessionScope.loginMember == null}">
		                                                    <a href="/login/">로그인</a>
														</c:when>
														<c:otherwise>
		                                                    <a href="/login/logout">로그 아웃</a>
														</c:otherwise>
													</c:choose>
                                                </li>
												 <c:choose>
														<c:when test="${sessionScope.loginMember == null }">
			                                                <li class="product-box-contain">
			                                                    <a href="/register/register">회원가입</a>
			                                                </li>
														</c:when>
														<c:otherwise>
														</c:otherwise>
												</c:choose>
                                              <c:if test="${sessionScope.loginMember != null }">
                                              <li class="product-box-contain">
                                                    <a href="/user/myPage">My Page</a>
                                                </li>
                                               </c:if>
                                              
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
                                <span>전체 분류</span>
                            </button>

                            <div class="category-dropdown">
                                <div class="category-title">
                                    <h5>Categories</h5>
                                    <button type="button" class="btn p-0 close-button text-content">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </div>
		                  <ul class="category-list" >
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
                        <h5 class="modal-title w-100" id="deal_today"></h5>
                        <p class="mt-1 text-content"></p>
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