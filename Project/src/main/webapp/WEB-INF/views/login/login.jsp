<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-client_id" content="868189545870-s003dih3cpr96cotlbo38r5tti76sj5d.apps.googleusercontent.com">
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
    <script
      src="https://code.jquery.com/jquery-3.4.1.js"
      integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
      crossorigin="anonymous"
    ></script>
<title>Insert title here</title>
<style type="text/css">
	.login-button {
		margin-top: 15px;
	}
	.login-button ul{
		text-align: center;
	}
	#naver_id_login img{
		width: 50%
	}
</style>
<script>
	window.onload = function () {
		google.accounts.id.initialize({
			client_id: '868189545870-s003dih3cpr96cotlbo38r5tti76sj5d.apps.googleusercontent.com',
			callback: handleCredentialResponse
		});
		google.accounts.id.prompt();
	};
</script>
<!-- Callback 처리 -->

</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
<!-- mobile fix menu start -->
    <div class="mobile-menu d-md-none d-block mobile-cart">
        <ul>
            <li class="active">
                <a href="index.html">
                    <i class="iconly-Home icli"></i>
                    <span>Home</span>
                </a>
            </li>

            <li class="mobile-category">
                <a href="javascript:void(0)">
                    <i class="iconly-Category icli js-link"></i>
                    <span>Category</span>
                </a>
            </li>

            <li>
                <a href="search.html" class="search-box">
                    <i class="iconly-Search icli"></i>
                    <span>Search</span>
                </a>
            </li>

            <li>
                <a href="wishlist.html" class="notifi-wishlist">
                    <i class="iconly-Heart icli"></i>
                    <span>My Wish</span>
                </a>
            </li>

            <li>
                <a href="cart.html">
                    <i class="iconly-Bag-2 icli fly-cate"></i>
                    <span>Cart</span>
                </a>
            </li>
        </ul>
    </div>
    <!-- mobile fix menu end -->

    <!-- Breadcrumb Section Start -->
    <section class="breadscrumb-section pt-0">
        <div class="container-fluid-lg">
            <div class="row">
                <div class="col-12">
                    <div class="breadscrumb-contain">
                        <h2 class="mb-2">Log In</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active">Log In</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- log in section start -->
    <section class="log-in-section background-image-2 section-b-space">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/log-in.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="log-in-box">
                        <div class="log-in-title">
                            <div>
                            <img src="/resources/assets/images/deer.png" style="width: 50%" />
                            <img src="/resources/assets/images/Deer_logo.png" />
                            </div>
                            
                        </div>

                        <div class="input-box">
                            <form class="row g-4" action="/login/" method="post">
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating log-in-form">
                                        <input type="text" class="form-control" id="text" name="username" placeholder="">
                                        <label for="text">아이디를 입력해 주세요</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating theme-form-floating log-in-form">
                                        <input type="password" class="form-control" id="password"
                                            placeholder="Password" name="password">
                                        <label for="password">비밀번호를 입력해 주세요</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="forgot-box">
                                        <div class="form-check ps-0 m-0 remember-box">
                                            <input class="checkbox_animated check-box" type="checkbox"
                                                id="flexCheckDefault" name="remember">
                                            <label class="form-check-label" for="flexCheckDefault">자동 로그인</label>
                                        </div>
                                        <a href="forgot.html" class="forgot-password">아이디/비밀번호 찾기</a>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <button class="btn btn-animation w-100 justify-content-center" type="submit">로그인</button>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </div>
                            </form>
                        </div>

                        <div class="other-log-in">
                        </div>

                        <div class="login-button">
                            <ul>
                            	<li>
                            		<a href="/login/naverLogin">
                                   		<div id="naver_id_login"">
                                   	 		<img src="/resources/assets/images/Naver-login.png" />
                                    	</div>
                                    </a>
                                </li>
                                <li>
                                	<div class="g-signin2" data-onsuccess="onSignIn"></div>
                                </li>
                            </ul>
                        </div>

                        <div class="other-log-in">
                            <h6></h6>
                        </div>

                        <div class="sign-up-box">
                            <a href="sign-up.html">회원 가입</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    <jsp:include page="../footer.jsp"></jsp:include>
   </body>
</html>