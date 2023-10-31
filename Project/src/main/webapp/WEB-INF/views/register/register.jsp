<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Fastkart">
    <meta name="keywords" content="Fastkart">
    <meta name="author" content="Fastkart">
    <link rel="icon" href="/resources/assets/images/favicon/1.png" type="image/x-icon">
    <title>Register</title>

    <!-- Google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <!-- bootstrap css -->
    <link id="rtl-link" rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/bootstrap.css">
    <!-- font-awesome css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/font-awesome.css">
    <!-- feather icon css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/feather-icon.css">
    <!-- Template css -->
    <link id="color-link" rel="stylesheet" type="text/css" href="/resources/assets/css/style.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script>
    	let checkDuplication = false;
    	let isValidId = false;
    	
    	let checkedPasswordFormat = false;
    	let isValidPassword = false;
    	
    	let isValidName = false;
    	let isValidEmail = false;
    	let isValidPhone = false;
    	let isValidCellPhone = false;
    	let isValidBirth = false;
    	let isValidZipCode = false;
    	let isValidAddress = false;
    	
    	
    	$(function () {
    		// 아이디 유효성 검사
	    	$('#memberId').on('blur', function () {
	    		let regType1 = /^[A-Za-z0-9]{4,13}$/;	// 4~13글자의 영문자, 숫자만 입력 가능 정규식
	    		if (regType1.test($('#memberId').val())) {
	    			isDuplication();		// 아이디 중복 검사
	    			if (checkDuplication) {
		    			$('#memberId').parent().next().html("사용 가능한 아이디입니다.");
		    			validCss("memberId");
		    			isValidId = true;
	    			} else {
		    			$('#memberId').parent().next().html("중복된 아이디입니다.");
		    			notValidCss("memberId")
		    			isValidId = false;
	    			}
	    		} else {
	    			$('#memberId').parent().next().html("4~13글자의 영문자, 숫자만 입력 가능합니다.");
	    			notValidCss("memberId")
	    			isValidId = false;
	    		}
	    	});
    		
    		// 비밀번호 유효성 검사
    		$('#password').on('blur', function() {
    			let reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
    			if (reg.test($('#password').val())) {
    				$('#password').parent().next().html("사용 가능");
    				validCss("password");
    				checkedPasswordFormat = true;
    			} else {
    				$('#password').parent().next().html("사용 불가능");
    				notValidCss("password");
    				checkedPasswordFormat = false;
    			}
    		});
    		
    		// 비밀번호 확인 검사
    		$('#checkedPassword').on('blur', function() {
    			if (checkedPasswordFormat) {
	    			if ($('#password').val() === $('#checkedPassword').val()) {
	    				$('#checkedPassword').parent().next().html("비밀번호가 일치합니다.");
	    				validCss("checkedPassword");
	    				isValidPassword = true
	    			} else {
	    				$('#checkedPassword').parent().next().html("비밀번호가 일치하지 않습니다.");
	    				notValidCss("checkedPassword");
	    				isValidPassword = false;
	    			}
    			}
    		});
    		
    		// 이름 유효성 검사
    		$('#name').on('blur', function() {
    			let regName = /^[가-힣a-zA-Z]{1,30}$/;
    			if (regName.test($('#name').val())) {
    				isValidName = true; 
    				$('#name').parent().next().html('');
    			} else {
    				$('#name').parent().next().html("한글, 영문자로만 입력 가능합니다.");
    				notValidCss("name");
    				isValidName = false;
    			}
    		});
    		
    		// 이메일 유효성 검사
    		$('#email').on('blur', function() {
    			let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    			if (regEmail.test($('#email').val())) {
    				isValidEmail = true;
    				$('#email').parent().next().html('');
    			} else {
    				$('#email').parent().next().html("올바른 이메일이 아닙니다.");
    				notValidCss("email");
    				isValidEmail = false;
    			}
    		});
    		
    		// 전화번호 유효성 검사
    		$('#phoneNumber').on('blur', function () {
    			let regNumber = /^[0-9+]{9,15}$/;
    			if (regNumber.test($('#phoneNumber').val())) {
    				isValidPhone = true;
    				$('#phoneNumber').parent().next().html('');
    			} else {
    				$('#phoneNumber').parent().next().html("올바른 전화번호가 아닙니다.");
    				notValidCss("phoneNumber");
    				isValidPhone = false;
    			}
    		});
    		
    		// 휴대폰 번호 유효성 검사
    		$('#cellPhoneNumber').on('blur', function () {
    			let regNumber = /^[0-9+]{9,15}$/;
    			if (regNumber.test($('#cellPhoneNumber').val())) {
    				isValidCellPhone = true;
    				$('#cellPhoneNumber').parent().next().html('');
    			} else {
    				$('#cellPhoneNumber').parent().next().html("올바른 전화번호가 아닙니다.");
    				notValidCss("cellPhoneNumber");
    				isValidCellPhone = false;
    			}
    		});
    		
    		// 생년월일 유효성 검사
    		$('#dateOfBirth').on('blur', function () {
    			let regBirth = /^[0-9]{8}$/;
    			if (regBirth.test($('#dateOfBirth').val())) {
    				isValidBirth = true;
    				$('#dateOfBirth').parent().next().html('');
    			} else {
    				$('#dateOfBirth').parent().next().html("생년월일 8글자를 입력해주세요.<br/>ex) 1990년 1월 1일 : 19900101");
    				notValidCss("dateOfBirth");
    				isValidBirth = false;
    			}
    		});
    		
    		// 우편번호 입력 여부 확인
    		$('#zipCode').on('change', function() {
    			if ($('#zipCode').val() !== "") {
    				isValidZipCode = true;
    			} else {
    				isValidZipCode = false;
    			}
    		});
    		
    		// 주소 입력 여부 확인
    		$('#address').on('change', function() {
    			if ($('#address').val() != "") {
    				isvalidAddress = true;
    			} else {
    				isvalidAddress = false;
    			}
    		})
    	});
    	
    	// 우편번호 검색
    	function searchZipCode() {
    		goPopup();
    	}
    	
    	//도로명주소API 
    	function goPopup() {
    		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
    		var pop = window.open("/user/jusoPopup", "pop",
    				"width=570,height=420, scrollbars=yes, resizable=yes");

    		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
    	}
    	/** API 서비스 제공항목 확대 (2017.02) **/
    	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
    			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
    			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
    			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
    		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
    		let address1 = document.querySelector("#zipCode")
    		address1.value = zipNo;
    		isValidZipCode = true;

    		let address2 = document.querySelector("#address")
    		address2.value = roadAddrPart1;
    		isValidAddress = true;

    		let address3 = document.querySelector("#detailedAddress")
    		address3.value = addrDetail;
    	}
    	
    	// 회원가입 유효성검사 통과 여부
    	function isValid() {
    		let result = false;
    		console.log("isValidId",isValidId,"isValidPassword",isValidPassword,"isValidName",isValidName,"isValidEmail",isValidEmail,"isValidBirth",isValidBirth,"isValidZipCode",isValidZipCode,"isValidAddress",isValidAddress)
    		if (isValidId && isValidPassword && isValidName && isValidEmail && isValidBirth && isValidZipCode && isValidAddress) {
    			if (isValidPhone || isValidCellPhone) {
    				alert("유효성 검사 통과, 회원가입 가능");
    				result = true;
    			} else {
    				alert("전화번호 또는 핸드폰 번호는 필수입니다.");
    			}
    		} else {
    			alert("필수 항목은 모두 입력해주세요");
    		}
    		return result;
    	}
    	
    	// 아이디 중복 검사
    	function isDuplication() {
    		checkDuplication = false;
    		$.ajax({
    			url : "/register/checkedId",
    			type : "GET",
    			data : {
    				"memberId" : $('#memberId').val()
    			},
    			dataType : "json",
    			async : false,
    			success : function(data) {
    				if (data.status === "success") {
    					checkDuplication = true;
    				} else {
    					console.log("fail", data.status);
    				}
    			}, error : function(data) {
    				console.log("error!", data);
    			}
    		});
    	}
    	
    	function validCss(value) {
    		$('#' + value).parent().next().css("color", "#33cc33");
			$('#' + value).parent().next().css("font-weight", "bold");
    	}    	
    	function notValidCss(value) {
    		$('#' + value).parent().next().css("color", "#e33");
			$('#' + value).parent().next().css("font-weight", "bold");
    	}
    </script>
</head>

<body>

    <!-- Loader Start -->
    <div class="fullpage-loader">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
    </div>
    <!-- Loader End -->

	<!-- Include Header -->
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
                        <h2>Sign In</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active">Sign In</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- log in section start -->
    <section class="log-in-section section-b-space">
        <div class="container-fluid-lg w-100">
            <div class="row">
                <div class="col-xxl-6 col-xl-5 col-lg-6 d-lg-block d-none ms-auto">
                    <div class="image-contain">
                        <img src="/resources/assets/images/inner-page/sign-up.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="log-in-box">
                        <div class="log-in-title">
                            <h3>Welcome To Fastkart</h3>
                            <h4>Create New Account</h4>
                        </div>
						
						<!-- Login Form -->
                        <div class="input-box">
                            <form class="row g-4" action="/register/signUp" method="POST" onsubmit="return isValid();" enctype="multipart/form-data">
                            	<!-- 아이디 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="memberId" name="memberId" placeholder="ID">
                                        <label for="memberId">*ID</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 비밀번호 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="password" class="form-control" id="password" name="password"
                                            placeholder="Password">
                                        <label for="password">*Password</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="password" class="form-control" id="checkedPassword"
                                            placeholder="비밀번호 확인">
                                        <label for="checkedPassword">*비밀번호 확인</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 이름 -->
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="name" name="name" placeholder="Full Name">
                                        <label for="name">*Full Name</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 이메일 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Email Address">
                                        <label for="email">*Email Address</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 전화번호 -->
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="전화번호 '-' 없이 입력">
                                        <label for="phoneNumber">전화 번호</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 핸드폰 번호 -->
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="cellPhoneNumber" name="cellPhoneNumber" placeholder="전화번호 '-' 없이 입력">
                                        <label for="cellPhoneNumber">핸드폰 번호</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 생년월일 -->
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="생년월일 8글자">
                                        <label for="dateOfBirth">*생년월일</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 성별 -->
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="radio" class="form-radio gender" name="gender" value="M" checked>남
                                        <input type="radio" class="form-radio gender" name="gender" value="F">여
                                        <label for="gender"></label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 우편번호 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="우편번호" onclick="searchZipCode();">
                                        <label for="zipCode">*우편번호</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                <!-- 주소 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="address" name="address" placeholder="주소">
                                        <label for="address">*주소</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                <!-- 상세주소 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="detailedAddress" name="detailedAddress" placeholder="상세주소">
                                        <label for="detailedAddress">상세주소</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 프로필 사진 
								<div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="file" class="form-control" id="profileImage" name="profileImage" placeholder="프로필 이미지">
                                        <label for="profileImage">프로필 이미지</label>
                                    </div>
                                    <div class="validation"></div>
                                </div> -->
                                
                                <!-- 본인 인증 
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="checkbox" class="form-control" id="identity" name="identity" placeholder="본인 인증">
                                        <label for="identity">본인 인증</label>
                                    </div>
                                    <div class="validation"></div>
                                </div> -->
                                
                                <!-- 환불 은행 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <select id="refundBank" name="refundBank" class="form-control">
                                        	<option value="none">은행 선택</option>
                                        	<option value="shinhan">신한은행</option>
                                        	<option value="ibk">IBK기업은행</option>
                                        	<option value="hana">하나은행</option>
                                        	<option value="woori">우리은행</option>
                                        	<option value="nh">NH농협은행</option>
                                        	<option value="kdb">KDB산업은행</option>
                                        	<option value="sc">SC제일은행</option>
                                        	<option value="city">citybank</option>
                                        	<option value="busan">BNK부산은행</option>
                                        	<option value="dgb">DGB대구은행</option>
                                        	<option value="mg">MG새마을금고</option>
                                        	<option value="shinyeob">신협</option>
                                        	<option value="suhyeob">수협은행</option>
                                        	<option value="kb">KB국민은행</option>
                                        	<option value="post">우체국예금</option>
                                        	<option value="kakao">카카오뱅크</option>
                                        	<option value="toss">토스</option>
                                        </select>
                                        <label for="refundBank">환불 은행</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 환불 계좌 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="refundAccount" name="refundAccount" placeholder="환불 계좌">
                                        <label for="refundAccount">환불 계좌</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
								
								<!-- 동의 여부 
                                <div class="col-12">
                                    <div class="forgot-box">
                                        <div class="form-check ps-0 m-0 remember-box">
                                            <input class="checkbox_animated check-box" type="checkbox"
                                                id="flexCheckDefault">
                                            <label class="form-check-label" for="flexCheckDefault">I agree with
                                                <span>Terms</span> and <span>Privacy</span></label>
                                        </div>
                                    </div>
                                </div> -->

                                <div class="col-12">
                                    <button class="btn btn-animation w-100" type="submit">Sign Up</button>
                                </div>
                            </form>
                        </div>

                        <div class="other-log-in">
                            <h6>or</h6>
                        </div>

                        <div class="log-in-button">
                            <ul>
                                <li>
                                    <a href="https://accounts.google.com/signin/v2/identifier?flowName=GlifWebSignIn&flowEntry=ServiceLogin"
                                        class="btn google-button w-100">
                                        <img src="/resources/assets/images/inner-page/google.png" class="blur-up lazyload"
                                            alt="">
                                        Sign up with Google
                                    </a>
                                </li>
                                <li>
                                    <a href="https://www.facebook.com/" class="btn google-button w-100">
                                        <img src="/resources/assets/images/inner-page/facebook.png" class="blur-up lazyload"
                                            alt=""> Sign up with Facebook
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="other-log-in">
                            <h6></h6>
                        </div>

                        <div class="sign-up-box">
                            <h4>Already have an account?</h4>
                            <a href="login.html">Log In</a>
                        </div>
                    </div>
                </div>

                <div class="col-xxl-7 col-xl-6 col-lg-6"></div>
            </div>
        </div>
    </section>
    <!-- log in section end -->

    <!-- Tap to top start -->
    <div class="theme-option">
        <div class="back-to-top">
            <a id="back-to-top" href="#">
                <i class="fas fa-chevron-up"></i>
            </a>
        </div>
    </div>
    <!-- Tap to top end -->

    <!-- Bg overlay Start -->
    <div class="bg-overlay"></div>
    <!-- Bg overlay End -->

    <!-- Bootstrap js-->
    <script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/bootstrap/popper.min.js"></script>

    <!-- feather icon js-->
    <script src="/resources/assets/js/feather/feather.min.js"></script>
    <script src="/resources/assets/js/feather/feather-icon.js"></script>

    <!-- Slick js-->
    <script src="/resources/assets/js/slick/slick.js"></script>
    <script src="/resources/assets/js/slick/slick-animation.min.js"></script>
    <script src="/resources/assets/js/slick/custom_slick.js"></script>

    <!-- Lazyload Js -->
    <script src="/resources/assets/js/lazysizes.min.js"></script>

    <!-- script js -->
    <script src="/resources/assets/js/script.js"></script>
</body>

</html>