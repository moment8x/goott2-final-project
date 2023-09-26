<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zxx">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content="Ogani Template" />
    <meta name="keywords" content="Ogani, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    
    <title>Ogani | Template</title>

    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
      rel="stylesheet"
    />

    <!-- Css Styles -->
    <link rel="stylesheet" href="/controller/resources/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/elegant-icons.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/nice-select.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/owl.carousel.min.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/slicknav.min.css" type="text/css" />
    <link rel="stylesheet" href="/controller/resources/css/style.css" type="text/css" />
  </head>

  <body>
    <!-- Page Preloder -->
    <div id="preloder">
      <div class="loader"></div>
    </div>

    <!-- Humberger Begin -->
    <div class="humberger__menu__overlay"></div>
    <div class="humberger__menu__wrapper">
      <div class="humberger__menu__logo">
        <p style="font-size: 30px">
          <img src="img/logo1.png" alt="" />Kyobo Books
        </p>
      </div>
      <div class="humberger__menu__cart">
        <ul>
          <li>
            <a href="#"><i class="fa fa-heart"></i> <span>1</span></a>
          </li>
          <li>
            <a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a>
          </li>
        </ul>
      </div>
      <div class="humberger__menu__widget">
        <div class="header__top__right__auth">
          <a href="#"><i class="fa fa-user"></i>로그인</a>
        </div>
        <div class="header__top__right__auth">
          <a href="#"><i class="fa-solid fa-right-to-bracket"></i>회원가입</a>
        </div>
      </div>
      <nav class="humberger__menu__nav mobile-menu">
        <ul>
          <li>
            <a href="#">베스트셀러</a>
            <ul class="header__menu__dropdown">
              <li><a href="./shop-details.html">주간</a></li>
              <li><a href="./shoping-cart.html">월간</a></li>
              <li><a href="./checkout.html">연간</a></li>
            </ul>
          </li>
          <li><a href="./shop-grid.html">이벤트</a></li>
          <li>
            <a href="#">신상품</a>
            <ul class="header__menu__dropdown">
              <li><a href="./shop-details.html">Shop Details</a></li>
              <li><a href="./shoping-cart.html">Shoping Cart</a></li>
              <li><a href="./checkout.html">Check Out</a></li>
              <li><a href="./blog-details.html">Blog Details</a></li>
            </ul>
          </li>
          <li><a href="./blog.html">Blog</a></li>
          <li><a href="./contact.html">고객센터</a></li>
        </ul>
      </nav>
      <div id="mobile-menu-wrap"></div>
      <div class="header__top__right__social">
        <a href="#"><i class="fa fa-facebook"></i></a>
        <a href="#"><i class="fa fa-twitter"></i></a>
        <a href="#"><i class="fa fa-linkedin"></i></a>
        <a href="#"><i class="fa fa-pinterest-p"></i></a>
      </div>
      <div class="humberger__menu__contact">
      </div>
    </div>
    <!-- Humberger End -->

    <!-- Header Section Begin -->
    <header class="header">
      <div class="header__top">
        <div class="container">
          <div class="row">
            <div class="col-lg-6 col-md-6">
              <div class="header__top__left"></div>
            </div>
            <div class="col-lg-6 col-md-6">
              <div class="header__top__right">
                <div class="header__top__right__social">
                  <a href="#"><i class="fa fa-facebook"></i></a>
                  <a href="#"><i class="fa fa-twitter"></i></a>
                  <a href="#"><i class="fa fa-linkedin"></i></a>
                  <a href="#"><i class="fa fa-pinterest-p"></i></a>
                </div>
                <div class="header__top__right__auth">
                  <a href="#"><i class="fa fa-user"></i> 로그인</a>
                </div>
                <div class="header__top__right__auth">
                  <a href="#"
                    ><i class="fa-solid fa-right-to-bracket"></i>회원가입</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row">
          <div class="col-lg-3">
            <div class="header__logo">
              <a href="./index.html">Kyobo Books</a>
            </div>
          </div>
          <div class="col-lg-6">
            <nav class="header__menu">
              <ul>
                <li class="active"><a href="./index.html">베스트 셀러</a></li>
                <li><a href="./shop-grid.html">이벤트</a></li>
                <li>
                  <a href="#">신상품</a>
                  <ul class="header__menu__dropdown">
                    <li><a href="./shop-details.html">Shop Details</a></li>
                    <li><a href="./shoping-cart.html">Shoping Cart</a></li>
                    <li><a href="./checkout.html">Check Out</a></li>
                    <li><a href="./blog-details.html">Blog Details</a></li>
                  </ul>
                </li>
                <li><a href="./blog.html">무슨이름?</a></li>
                <li><a href="./contact.html">고객센터</a></li>
              </ul>
            </nav>
          </div>
          <div class="col-lg-3">
            <div class="header__cart">
              <ul>
                <li>
                  <a href="#"><i class="fa fa-heart"></i> <span>1</span></a>
                </li>
                <li>
                  <a href="#"
                    ><i class="fa fa-shopping-bag"></i> <span>3</span></a
                  >
                </li>
              </ul>
          </div>
        </div>
        <div class="humberger__open">
          <i class="fa fa-bars"></i>
        </div>
      </div>
      </div>
    </header>
    <!-- Header Section End -->

    <!-- Hero Section Begin -->
    <section class="hero">
      <div class="container">
        <div class="row">
          <div class="col-lg-3">
            <div class="hero__categories">
              <div class="hero__categories__all">
                <i class="fa fa-bars"></i>
                <span>Category</span>
              </div>
              <div id="drop_in" style="display: flex; width: 250%">
                <ul>
                  <li><a href="#" onclick="kor()">국내도서</a></li>
                  <li><a href="#" onclick="eng()">서양도서</a></li>
                  <li><a href="#" onclick="jap()">일본도서</a></li>
                </ul>
                <div id="drop_in_category" style="display: flex">
                  <ul>
                    <li>
                      <a href="#" style="font-weight: bold">국내도서 전체</a>
                    </li>
                    <li><a href="#">소설</a></li>
                    <li><a href="#">시/에세이</a></li>
                    <li><a href="#">인문</a></li>
                    <li><a href="#">가정/육아</a></li>
                    <li><a href="#">요리</a></li>
                    <li><a href="#">건강</a></li>
                    <li><a href="#">취미/실용/스포츠</a></li>
                    <li><a href="#">경제/경영</a></li>
                    <li><a href="#">자기계발</a></li>
                    <li><a href="#">정치/사회</a></li>
                    <li><a href="#">역사/문화</a></li>
                  </ul>
                  <ul style="padding-top: 60px">
                    <li><a href="#">종교</a></li>
                    <li><a href="#">예술/대중문화</a></li>
                    <li><a href="#">중/고등참고서</a></li>
                    <li><a href="#">기술/공학</a></li>
                    <li><a href="#">외국어</a></li>
                    <li><a href="#">과학</a></li>
                    <li><a href="#">취섭/수험서</a></li>
                    <li><a href="#">여행</a></li>
                    <li><a href="#">컴퓨터/IT</a></li>
                    <li><a href="#">잡지</a></li>
                    <li><a href="#">청소년</a></li>
                  </ul>
                  <ul style="padding-top: 60px">
                    <li><a href="#">초등 참고서</a></li>
                    <li><a href="#">유아(0~7세)</a></li>
                    <li><a href="#">어린이(초등)</a></li>
                    <li><a href="#">만화</a></li>
                    <li><a href="#">대학교재</a></li>
                    <li><a href="#">한국소개도서</a></li>
                    <li><a href="#">교보 오리지널</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-9">
            <div class="hero__search">
              <div class="hero__search__form">
                <form action="#">
                  <div class="hero__search__categories">
                    All Categories
                    <span class="arrow_carrot-down"></span>
                  </div>
                  <input type="text" placeholder="What do yo u need?" />
                  <button type="submit" class="site-btn">SEARCH</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Hero Section End -->

    <!-- Js Plugins -->
    <script
      src="https://kit.fontawesome.com/fd7fb2445c.js"
      crossorigin="anonymous"
    ></script>
    <script src="/controller/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/controller/resources/js/bootstrap.min.js"></script>
    <script src="/controller/resources/js/jquery.nice-select.min.js"></script>
    <script src="/controller/resources/js/jquery-ui.min.js"></script>
    <script src="/controller/resources/js/jquery.slicknav.js"></script>
    <script src="/controller/resources/js/mixitup.min.js"></script>
    <script src="/controller/resources/js/owl.carousel.min.js"></script>
    <script src="/controller/resources/js/main.js"></script>
  </body>
</html>