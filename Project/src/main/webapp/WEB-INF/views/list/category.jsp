<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
</head>
<!-- Demo styles -->
  <style>
    html,
    body {
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

	.swiper-wrapper img{
	width : 50%
	}
    .swiper {
      width: 100%;
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

    .swiper-slide img {
      display: block;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .sidebar__item a {
    	text-decoration: none;
    }
  </style>
<body>
	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Breadcrumb Section End -->

	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-5">
					<div class="sidebar">
						<div class="sidebar__item">
							<h4>${nowCategory.category_name }</h4>
							<ul>
								<c:forEach var="category" items="${categories }">
									<li><a href="../categoryList/${category.category_key }">${category.category_name }</a></li>
								</c:forEach>						
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-9 col-md-7">
					<div class="section-title product__discount__title">
						<h2>${nowCategory.category_name }</h2>
					</div>
					  <div class="swiper mySwiper">
					    <div class="swiper-wrapper">
					    <c:choose>
					    	<c:when test="${key == 'KOR' }">
					    		<div class="swiper-slide"><img src="/resources/img/slider/slider1.png"></div>
					     		<div class="swiper-slide"><img src="/resources/img/slider/slider2.png"></div>
					    	</c:when>
					    	<c:when test="${key == 'JAP' }">
					    		<div class="swiper-slide"><img src="/resources/img/slider/slider1.png"></div>
					    	</c:when>
					    	<c:otherwise>
					    		<div class="swiper-slide"><img src="/resources/img/slider/slider2.png"></div>
					    	</c:otherwise>
					    </c:choose>
					      
					    </div>
					    <div class="swiper-button-next"></div>
					    <div class="swiper-button-prev"></div>
					    <div class="swiper-pagination"></div>
					    <div class="autoplay-progress">
					      <svg viewBox="0 0 48 48">
					        <circle cx="24" cy="24" r="20"></circle>
					      </svg>
					      <span></span>
					    </div>
					  </div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->

	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      spaceBetween: 30,
      centeredSlides: true,
      autoplay: {
        delay: 6500,
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
  </script>
</body>
</html>