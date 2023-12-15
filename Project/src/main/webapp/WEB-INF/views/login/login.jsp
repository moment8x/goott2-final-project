<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.4.0/kakao.min.js"
  integrity="sha384-mXVrIX2T/Kszp6Z0aEWaA8Nm7J6/ZeWXbL8UpGRjKwWe56Srd/iyNmWMBhcItAjH" crossorigin="anonymous"></script>
<script>
  Kakao.init('b116d826d54948d007fe4dd027ba8553'); // 사용하려는 앱의 JavaScript 키 입력
</script>
<title>Insert title here</title>
<script>
		let regTypeId = /^(?=.*[A-Za-z]+)[A-Za-z0-9]{4,13}$/;
		let regTypePd = /^(?=.*[a-zA-Z]+)(?=.*[!@#$%^*+=-])(?=.*[0-9]+).{8,15}$/;
		let resultId = false;
		let resultPd = false;
	$(function() {
		
		$('.log-in-form input[type=text]').on("blur", function() {
			if(regTypeId.test($(this).val())){
				$(".idError").html("");
				resultId = true;
			} else {
    			$(".idError").html("아이디는 영문이 포함된 4~13글자여야 합니다.");
    			resultId = false;
    		}
		});
		
		$('.log-in-form input[type=password]').on("blur keyup", function() {
			if(regTypePd.test($(this).val())){
				$(".pdError").html("");
				resultPd = true;
			} else {
    			$(".pdError").html("올바른 비밀번호가 아닙니다.");
    			resultPd = false;
    		}
		});
	});

	function allRight() {
		
		if(resultId == true && resultPd == true){
			return true;
		}
		window.alert(resultId, resultPd);
		return false;
	}
	
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8081/login/kakaoLogin',
    });
  }


  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>
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
	.idError, .pdError{
		color: red;
	}
</style>
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
                            <!-- <img src="/resources/assets/images/deer.png" style="width: 50%" />
                            <img src="/resources/assets/images/Deer_logo.png" /> -->
                            </div>
                        </div>

                        <div class="input-box">
                            <form class="row g-4" action="/login/" method="post" onsubmit="return allRight();">
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating log-in-form">
                                        <input type="text" class="form-control" id="username" name="username" placeholder="">
                                        <label for="username">아이디를 입력해 주세요</label>
                                    </div>
                                </div>
                                <div class="idError"></div>
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating log-in-form">
                                        <input type="password" class="form-control" id="password"
                                            placeholder="Password" name="password">
                                        <label for="password">비밀번호를 입력해 주세요</label>
                                    </div>
                                </div>
                                <div class="pdError"></div>
                                <div class="col-12">
                                    <div class="forgot-box">
                                        <div class="form-check ps-0 m-0 remember-box">
                                            <input class="checkbox_animated check-box" type="checkbox"
                                                id="flexCheckDefault" name="remember">
                                            <label class="form-check-label" for="flexCheckDefault" >자동 로그인</label>
                                        </div>
                                        <a href="" class="forgot-password" data-bs-toggle="modal" data-bs-target="#myModal">아이디/비밀번호 찾기</a>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <button class="btn btn-animation w-100 justify-content-center" type="submit" >로그인</button>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </div>
                            </form>
                        </div>

                        <div class="other-log-in">
                        </div>

						<!-- 
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
                                	<a id="kakao-login-btn" href="javascript:loginWithKakao()">
									  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
									    alt="카카오 로그인 버튼" />
									</a>
                                </li>
                            </ul>
                        </div>
						 -->
						
                        <div class="other-log-in">
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
    
    <!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" style="align-items: center; text-align: center;">
      <a href="/login/forgot?statusValue=id"><button type="button" class="btn btn-outline-primary">아이디 찾기</button></a>
       <a href="/login/forgot?statusValue=password"><button type="button" class="btn btn-outline-success">비밀번호 찾기</button></a>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
   </body>
</html>