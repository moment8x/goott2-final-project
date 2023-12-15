<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgot Password</title>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>

let resultName = false; let resultPhone = false;
let regTypeEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

$(function () {
	$("#userName").on("keyup", function() {
		let val = $(this).val();
		delayTime(function() {
			if(val.length > 2) {
				resultName = true;
				$(".nameError").html("");
			} else {
				resultName = false;
				$(".nameError").html("성함을 입력해주세요");
			} 
		}, 1000);
	});
	$("#userId").on("keyup", function() {
		let val = $(this).val();
		delayTime(function() {
			if(val.length > 2) {
				resultName = true;
				$(".idError").html("");
			} else {
				resultName = false;
				$(".idError").html("ID를 입력해주세요");
			} 
		}, 1000);
	});
	
	$("#email").on("keyup", function() {
		let val = $(this).val();
		delayTime(function() {
			if(regTypeEmail.test(val)) {
				resultName = true;
				$(".emailError").html("");
			} else {
				resultName = false;
				$(".emailError").html("이메일을 입력해주세요");
			} 
		}, 1000);
	});
	
});

let delayTime = (function() {
	let timer = 0;
	
	return function (callback, ms) {
		clearTimeout(timer);
		timer = setTimeout(callback, ms);
	};
})();

function redirectToPage(going) {
	if(going == "forgot"){
		let status = "${lookFor}";
    	window.location.href = '/login/forgot?status='+status;
	} else {
		window.location.href = '/login/';
	}
}

function getSubmit() {
	$("#idForgotForm").submit();
	//$("#pdForgotForm").submit();
}

</script>
<style>
	.nameError, .emailError, idError{
		color: red;
	}
</style>
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
                    <c:choose>
                    	<c:when test="${status == 'id' }">
                    	<h2>아이디 찾기</h2>
                    	</c:when>
                    	<c:when test="${status == 'password' }">
                    	<h2>비밀번호 찾기</h2>
                    	</c:when>
                    	<c:when test="${status == 'failed' }">
                    	<h2>에러</h2>
                    	</c:when>
                    	<c:when test="${status == 'success' }">
                    	<h2>아이디/비밀번호</h2>
                    	</c:when>
                    </c:choose>
                        
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active">Forgot Password</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <c:choose>
	<c:when test="${status == 'id' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>아이디 찾기</h3>
                            </div>

                            <div class="input-box">
                                <form class="row g-4" method="POST" action="/login/auth" id="idForgotForm">
                                    <div class="col-12">
                                        <div class="form-floating theme-form-floating log-in-form"> 
                                            <input type="text" class="form-control" id="userName"
                                                placeholder="성함을 입력하세요" name="userName">
                                                <label for="userName">성함을 입력하세요</label>
                                                <div class="nameError"></div>
                                        </div>
                                        <div class="form-floating theme-form-floating log-in-form">
                                            <input type="email" class="form-control" id="email"
                                                placeholder="이메일을 입력하세요" name="email">
                                                <label for="email">이메일을 입력하세요</label>
                                                 <div class="emailError"></div>
                                        </div>
                                    </div>
									<input type="hidden" name="status" value="id" >
                                    <div class="col-12">
                                        <button class="btn btn-animation w-100" data-bs-toggle="modal" data-bs-target="#myModal" type="button" >아이디 찾기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
    <c:when test="${status == 'auth' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>이메일 인증하기</h3>
                            </div>

                            <div class="input-box">
                                <form class="row g-4" method="POST" action="/login/validCode" >
                                    <div class="col-12">
                                        <div class="form-floating theme-form-floating log-in-form">
                                            <input type="text" class="form-control" id="emailCode"
                                                placeholder="인증 코드를 입력하세요" name="emailCode"  style="width: 200px;">
                                        	<label for="emailCode">인증 코드를 입력하세요</label>
                                        	<div class="codeError"></div>
                                    	</div>
                                    	<input type="hidden" value="${lookFor }" name="status">
                                    <div class="col-12">
                                    <button class="btn btn-animation w-100" type="submit">인증 하기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
     <c:when test="${status == 'success' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                        	<div class="log-in-title">
                        		<h3>회원가입된 아이디 : </h3>
                        	</div>
                        <div class="input-box">
                        	<div class="col-12">
                        		<div class="form-floating theme-form-floating log-in-form">
                        			<input type="text" class="form-control" style="width: 400px; text-align: center;"readonly="readonly" value="${memberId }">
                                </div>
                                <button class="btn btn-animation w-100" onclick="redirectToPage('login');">로그인 페이지로 돌아가기</button>
                           	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
     <c:when test="${status == 'successUpdate' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                        	<div class="log-in-title">
                        		<h3>비밀번호가 변경되었습니다!</h3>
                        	</div>
                        <div class="input-box">
                        	<div class="col-12">	
                                <button class="btn btn-animation w-100" onclick="redirectToPage('login');">로그인 페이지로 돌아가기</button>
                           	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
<c:when test="${status == 'successPd' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>비밀번호 변경</h3>
                            </div>

                            <div class="input-box">
                                <form class="row g-4"  method="POST" action="/login/passwordUpdate" >
                                    <div class="col-12">
                        					<input type="hidden" class="form-control" value="${memberId }" name="userId">
                                        <div class="form-floating theme-form-floating log-in-form"> 
                                            <input type="password" class="form-control" id="password"
                                                placeholder="새로 설정한 비밀번호를 입력하세요" name="password">
                                                <label for="password">새로 설정할 비밀번호를 입력하세요</label>
                                                <div class="passError"></div>
                                        </div>
                                        <div class="form-floating theme-form-floating log-in-form">
                                            <input type="password" class="form-control" id="rePassword"
                                                placeholder="다시 한번 입력해 주세요" >
                                                <label for="rePassword">다시 한번 입력해 주세요</label>
                                                 <div class="rePassError"></div>
                                        </div>
                                    </div>
									<input type="hidden" name="status" value="${status }" >
                                    <div class="col-12">
                                        <button class="btn btn-animation w-100" type="submit">비밀번호 변경</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
       <c:when test="${status == 'failed' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>인증에 실패하셨습니다.</h3>
                            </div>

                            <div class="input-box">
                                
                                    <div class="col-12">
                                        <div>다시 인증해주세요</div>
                                    <div class="col-12">
                                    <button class="btn btn-animation w-100" type="button" onclick="redirectToPage('forgot')">처음 페이지로</button>
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
       <c:when test="${status == 'error' }">
    <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>작업 도중 에러가 발생하였습니다.</h3>
                            </div>

                            <div class="input-box">
                                
                                    <div class="col-12">
                                        <div>처음부터 다시 시작해주세요</div>
                                    <div class="col-12">
                                    <button class="btn btn-animation w-100" type="button" onclick="redirectToPage('forgot')">처음 페이지로</button>
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:when>
    <c:otherwise>
     <!-- log in section start -->
    <section class="log-in-section section-b-space forgot-section">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/forgot.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <div class="log-in-box">
                            <div class="log-in-title">
                                <h3>비밀번호 변경</h3>
                            </div>

                            <div class="input-box">
                                <form class="row g-4"  method="POST" action="/login/auth" id="pdForgotForm">
                                    <div class="col-12">
                                        <div class="form-floating theme-form-floating log-in-form">
                                            <input type="text" class="form-control" id="usetId"
                                                placeholder="ID를 입력하세요">
                                            <label for="usetId">ID를 입력하세요</label>
                                             <div class="idError"></div>
                                        </div>
                                         <div class="form-floating theme-form-floating log-in-form">
                                            <input type="text" class="form-control" id="userName"
                                                placeholder="성함을 입력하세요" name="userName">
                                                <label for="userName">성함을 입력하세요</label>
                                                <div class="nameError"></div>
                                        </div>
                                        <div class="form-floating theme-form-floating log-in-form">
                                            <input type="email" class="form-control" id="email"
                                                placeholder="이메일을 입력하세요" name="email">
                                                <label for="email">이메일을 입력하세요</label>
                                                 <div class="emailError"></div>
                                                 <div>*이메일은 도메인 주소까지 입력해 주세요.</div>
                                        </div>
                                    </div>
									<input type="hidden" name="status" value="password" >
                                    <div class="col-12">
                                        <button class="btn btn-animation w-100" data-bs-toggle="modal" data-bs-target="#myModal" type="button">비밀번호 변경</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- log in section end -->
    </c:otherwise>
    </c:choose>

    <!-- Tap to top start -->
    <div class="theme-option">
        <div class="back-to-top">
            <a id="back-to-top" href="#">
                <i class="fas fa-chevron-up"></i>
            </a>
        </div>
    </div>
    
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" style="align-items: center; text-align: center;">
      		등록된 이메일로 인증 code를 보내겠습니다.
      		확인하여 인증해주세요
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="getSubmit();">Close</button>
      </div>
    </div>
  </div>
</div>

    <jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>