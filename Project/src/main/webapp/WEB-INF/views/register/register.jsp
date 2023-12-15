<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    
    <!-- iamport -->
    <script type="text/javascript"
		src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script>
    	let fileName = "";
    	let fileList = [];
    	let checkDuplication = false;
    	let isValidServiceTerms = false;
    	let isValidPrivacyTerms = false;
    	
    	let isValidId = false;
    	
    	let checkedPasswordFormat = false;
    	let isValidPassword = false;
    	
    	let isValidName = false;
    	let isValidEmail = false;
    	let isValidEmailCode = false;
    	let isValidPhone = false;
    	let isValidCellPhone = false;
    	let isValidBirth = false;
    	let isValidZipCode = false;
    	let isValidAddress = false;
    	
    	let IMP = window.IMP;
    	IMP.init("imp77460302") // 예: 'imp00000000a'
    	
    	$(function () {
    		$('#submit-btn').click(function (e) {
    			let snsSign = window.location.search;
    			if (snsSign != "") {
	    			snsSign = snsSign.split("?")[1];
	    			if (snsSign.includes("snsSignUp")) {
	    				snsSign = snsSign.split("snsSignUp=")[1].charAt(0);
	    			}
    			}
        		if (isValid()) {
        			let sendData;
        			if (snsSign != 1) {
	    	    		sendData = {
	    	    			"memberId" : $('#memberId').val(),
	    	    			"password" : $('#password').val(),
	    	    			"name" : $('#name').val(),
	    	    			"email" : $('#email').val(),
	    	    			"phoneNumber" : $('#phone-number').val(),
	    	    			"cellPhoneNumber" : $('#cell-phone-number').val(),
	    	    			"dateOfBirth" : $('#dateOfBirth').val(),
	    	    			"gender" : $('input[name=gender]:checked').val(),
	    	    			"zipCode" : $('#zipCode').val(),
	    	    			"address" : $('#address').val(),
	    	    			"detailedAddress" : $('#detailedAddress').val(),
	    	    			"basicAddr" : $('input[name=basicAddr]:checked').val(),
	    	    			"refundBank" : $('#refundBank').val(),
	    	    			"refundAccount" : $('#refundAccount').val(),
	    	    			fileList
	    	    		}
        			} else {
        				sendData = {
    	    	    		"memberId" : "${id}",
    	    	    		"password" : $('#password').val(),
    	    	    		"name" : $('#name').val(),
    	    	    		"email" : $('#email').val(),
    	    	    		"cellPhoneNumber" : "${mobile}",
    	    	    		"dateOfBirth" : $('#dateOfBirth').val(),
    	    	    		"gender" : $('input[name=gender]:checked').val(),
    	    	    		"zipCode" : $('#zipCode').val(),
    	    	    		"address" : $('#address').val(),
    	    	    		"detailedAddress" : $('#detailedAddress').val(),
    	    	    		"basicAddr" : $('input[name=basicAddr]:checked').val(),
    	    	    		"refundBank" : $('#refundBank').val(),
    	    	    		"refundAccount" : $('#refundAccount').val(),
    	    	    		fileList
    	    	    	}
        			}
    	    		$.ajax({
    	    			url : "/register/signUp",
    	    			type : "POST",
    	    			contentType : "application/json",
    	    			data : JSON.stringify(sendData),
    	    			dataType : "TEXT",
    	    			async : false,
    	    			success : function(data) {
    	    				location.href="/";
    	    			}, error : function(data) {
    	    				console.log("err", data);
    	    			}
    	    		});
        		}
    		});
    		
    		$('#sendMail').click(function (e) {
        		if ($('#email').val() != '') {
        			// 이메일 전송
        			$.ajax({
        				url : "/register/sendMail",
        				type : "GET",
        				data : {
        					"email" : $('#email').val()
        				},
        				dataType : "text",
        				async : false,
        				success : function(data) {
        					if (data == "success") {
        						alert('메일을 발송했습니다.');
        					}
        				}, error : function(data) {
        					console.log("error", data);
        					alert('메일 발송에 실패했습니다.');
        				}
        			});
        		} else {
    				alert('이메일 주소를 기입하고 인증 버튼을 눌러주세요');
    			}
    		});
    		
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
    				$('#password').parent().next().html("비밀번호는 영문자, 숫자, 특수문자가 포함된 8글자 이상 15글자 이하의 번호만 가능합니다.");
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
    				$('#email').parent().next().next().next().html("올바른 이메일이 아닙니다.");
    				notValidCss("email-code");
    				isValidEmail = false;
    			}
    		});
    		
    		$('#phone-number').on('blur', function() {
    			let regNumber = /^([0-9]{2,3})-?([0-9]{3,4})-?([0-9]{4})$/;
    			if (regNumber.test($(this).val())) {
    				$(this).parent().next().html('');
    				let addHyphen = $(this).val().replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
    				$(this).val(addHyphen);
    				isValidPhone = true;
    			} else {
    				$('#phone-number').parent().next().html('숫자만 입력이 가능합니다.');
    				$(this).val("");
    				notValidCss("phone-number");
    				isValidPhone = false;
    			}
    		});
    		
    		// 휴대폰 번호 유효성 검사
			$('#cell-phone-number').on('blur', function () {
				let regNumber = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
				if (regNumber.test($('#cell-phone-number').val())) {
					let addHyphen = $('#cell-phone-number').val().replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
					$('#cell-phone-number').val(addHyphen);
					isValidCellPhone = true;   
				} else {
					alert("올바른 전화번호가 아닙니다.");
					$('#cell-phone-number').val("");
					$(this).parent().next().html('숫자만 입력이 가능합니다.');
    				notValidCss("cell-phone-number");
					isValidCellPhone = false;
    	         }
    	            
    	      });
    		
    		// 생년월일 유효성 검사
    		$('#dateOfBirth').on('blur', function () {
    			let regBirth = /^[0-9]{8}$/;
    			if (regBirth.test($('#dateOfBirth').val())) {
    				let addHyphen = $('#dateOfBirth').val().replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})(\d{2})$/, `$1-$2-$3`);
    				$('#dateOfBirth').val(addHyphen);
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
    		
    		// 첨부파일
    		$(".upFileArea").on("dragenter dragover", function(evt) {
    			evt.preventDefault();
    		});
    		$(".upFileArea").on("drop", function(evt) {
    			evt.preventDefault();
    			let files = evt.originalEvent.dataTransfer.files;
    			for (let i = 0; i < 1/*files.length*/; i++) {
    				let form = new FormData();
    				form.append("uploadFile", files[i]);	// 파일의 이름을 컨트롤러단의 MultipartFile 객체명과 맞춘다.
    				form.append("fileName", fileName);
    				$.ajax({
    					url : "/register/uploadFile",
    					type : "post",
    					data : form,
    					dataType : "json",
    					async : false,
    					processData : false,   // text데이터에 대해 쿼리스트링 처리를 하지 않겠다.  default = true
    					contentType : false,   // application/x-www-form-urlencoded 처리 안함.(인코딩 하지 않음)  default = true
    					success : function(data) {
    						if (data != null) {
    							if (fileList.length > 0) {
    								fileList.pop();
    								flieList.push(data);
    							} else {
    								flieList.push(data);
    							}
    							fileName = data.newFileName;
    							showUploadedFile(data);
    						}
    					}, error : function(data) {
    						console.log("업로드 실패", data);
    					}
    				});
    			}
    		});
    		
    		// 약관 동의
    		$("#service-terms").click(function(e) {
    			if (document.getElementById('service-terms').checked) {
    				isValidServiceTerms = true;
    			} else {
    				isValidServiceTerms = false;
    			}
    		});
    		// 개인정보처리 동의
    		$("#privacy-terms").click(function(e) {
    			if (document.getElementById('privacy-terms').checked) {
    				isValidPrivacyTerms = true;
    			} else {
    				isValidPrivacyTerms = false;
    			}
    		});
    	});
    	
    	// 이메일 인증하기
    	function sendMail() {
    		if ($('#email').val() != '') {
    			// 이메일 전송
    			$.ajax({
    				url : "/register/sendMail",
    				type : "GET",
    				data : {
    					"email" : $('#email').val()
    				},
    				dataType : "JSON",
    				async : false,
    				success : function(data) {
    					if (data.status = "success") {
    						alert('메일을 발송했습니다.');
    					}
    				}, error : function(data) {
    					console.log("error", data);
    					alert('메일 발송에 실패했습니다.');
    				}
    			});
    		} else {
				alert('이메일 주소를 기입하고 인증 버튼을 눌러주세요');
			}
    	}
    	// 이메일 인증 확인하기
    	function confirmCode() {
    		$.ajax({
    			url : "/register/confirmCode",
    			type : "GET",
    			data : {
    				"emailCode" : $('#email-code').val()
    			},
    			dataType : "text",
    			async : false,
    			success : function(data) {
    				if (data === "pass") {
    					$('#email-code').parent().next().html("인증 되었습니다.");
    					validCss("email");
    					isValidEmailCode = true;
    				} else {
    					$('#email-code').parent().next().html("올바른 코드가 아닙니다.");
    					notValidCss("email");
        				isValidEmail = false;
    				}
    			}, error : function(data) {
    				console.log("error", data);
    			}
    		});
    	}
    	
		// 업로드 된 파일 표시    	
    	function showUploadedFile(json) {
    		let output = "";
    		let name = json.newFileName.replaceAll("\\", "/");
			output += `<img src='../resources/uploads\${name}'/>`; 
    		
    		$('.uploadFiles').html(output);
    	}
    	
    	// 우편번호 검색
    	function searchZipCode() {
    		goPopup();
    	}
    	
    	//도로명주소API 
    	function goPopup() {
    		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
    		var pop = window.open("/register/jusoPopup", "pop",
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
    		if (isValidServiceTerms && isValidPrivacyTerms) {
	    		if (isValidId && isValidPassword && isValidName && isValidBirth && isValidZipCode && isValidAddress) {
	    			if (isValidEmailCode) {
		    			if (isValidPhone || isValidCellPhone) {
		    				alert("유효성 검사 통과, 회원가입 가능");
		    				result = true;
		    			} else {
		    				alert("전화번호 또는 핸드폰 번호는 필수입니다.");
		    				document.getElementById("phone-number1").focus();
		    			}
	    			} else {
	    				alert("이메일 인증은 필수입니다.");
	    				document.getElementById("email").focus();
	    			}
	    		} else if (${name.length > 0}) {
	    			isValidId = true;
	    			isValidName = true;
	    			isValidBirth = true;
	    			isValidCellphone = true;
	    			isValidEmailCode = true;
	    		} else {
	    			alert("필수 항목은 모두 입력해주세요");
	    			document.getElementById("memberId").focus();
	    		}
    		} else {
    			alert("약관에 동의를 해주세요.");
    			document.getElementById("service-terms").focus();
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
    	
    	// 페이지 나갈 시
    	window.onbeforeunload = function (e) {
    		let sendData = {
    				"fileName" : fileName
    		}
    		$.ajax({
    			url : "/review/refreshFile",
    			type : "POST",
    			data : JSON.stringify(sendData),
    			contentType : "application/json",
    			dataType : "JSON",
    			async : true,
    			success : function(data) {
    			}, error : function(data) {
    				console.log("err");
    			}
    		});
	 		//window.navigator.sendBeacon('/register/refreshFile');
   		};
   		    	
    	// form버튼으로 페이지 이동 시
    	$(document).on("submit", "form", function (e) {
    		window.onbeforeunload = null;
    	});
    </script>
    <style>
    	.terms {
    		padding : 10px;
    		background-color: #f8f8f8;
    		border-radius: 10px;
    	}
    	.edit-btn {
    		border: 1px solid #ccc;
    		background-color: #ccc;
    		height: 30px;
    		margin: 5px 0;
    		border-radius: 5px;
    	}
    	textarea {
    		resize : none;
    		width: 100%;
    		min-height: 250px;
    	}
    	.profile {
    		color : #4a5568;
    		font-size: 16px;
    	}
    	.upFileArea {
    		width: 100%;
    		min-height : 200px;
    		border: 1px solid gray;
    		background-color: white;
    	}
    </style>
</head>

<body>
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
                        <h2>회원가입</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active">회원가입</li>
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
                	<!-- 약관 동의 -->
                	<div class="terms">
	                	<div>
	                		<p>이용약관</p>
	                		<textarea>${terms[0].termsContent}</textarea>
	                	</div>
	                	<div>
	                		<input type="checkbox" id="service-terms" value="Y"/>
	                		<label for="service-terms">위 내용에 동의합니다.</label>
	                	</div>
	                	<br/><br/>
	                	<div>
	                		<p>개인정보처리</p>
	                		<textarea>${terms[1].termsContent}</textarea>
	                	</div>
	                	<div>
	                		<input type="checkbox" id="privacy-terms" value="Y"/>
	                		<label for="service-terms">위 내용에 동의합니다.</label>
	                	</div>
                	</div>
                </div>

                <div class="col-xxl-4 col-xl-5 col-lg-6 col-sm-8 mx-auto">
                    <div class="log-in-box">
                        <div class="log-in-title">
                            <h3>디어북스</h3>
                            <h4>계정 만들기</h4>
                        </div>
						
						<!-- Login Form -->
                        <div class="input-box">
                            <form class="row g-4" id="form">
                            	<!-- 아이디 -->
                            	<c:if test="${name == '' || name == null}">
                            		<div class="col-12">
										<div class="form-floating theme-form-floating">
											<input type="text" class="form-control" id="memberId" name="memberId" placeholder="ID">
											<label for="memberId">*아이디</label>
										</div>
										<div class="validation"></div>
									</div>
                            	</c:if>
                            	
                                <!-- 비밀번호 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="password" class="form-control" id="password" name="password"
                                            placeholder="Password">
                                        <label for="password">*비밀번호</label>
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
                                	<div>${pageScope.name}</div>
	                                <c:choose>
	                                	<c:when test="${name.length > 0}">
			                                    <div class="form-floating theme-form-floating">
			                                        <input type="text" class="form-control" id="name" name="name" placeholder="Full Name" value="${name}" readonly>
			                                        <label for="name">*이름</label>
			                                    </div>
			                                    <div class="validation"></div>
	                                	</c:when>
	                                	<c:otherwise>
			                                    <div class="form-floating theme-form-floating">
			                                        <input type="text" class="form-control" id="name" name="name" placeholder="Full Name">
			                                        <label for="name">*이름</label>
			                                    </div>
			                                    <div class="validation"></div>
	                                	</c:otherwise>
	                                </c:choose>
								</div>
								
                                <!-- 이메일 -->
                                <div class="col-12">
                                	<c:choose>
                                		<c:when test="${email.length > 0}">
                                			<div class="form-floating theme-form-floating">
		                                        <input type="email" class="form-control" id="email" name="email" placeholder="Email Address" value="${email}" readonly>
		                                        <label for="email">*이메일</label>
		                                    </div>
                                		</c:when>
                                		<c:otherwise>
                                			<div class="form-floating theme-form-floating">
		                                        <input type="email" class="form-control" id="email" name="email" placeholder="Email Address">
		                                        <label for="email">*이메일</label>
		                                    </div>
		                                    <button type="button" id="sendMail" class="edit-btn">인증하기</button>
		                                    <div class="form-floating theme-form-floating">
		                                    	<input type="text" class="form-control" id="email-code" placeholder="인증 코드 입력">
		                                    	<label for="email-code">인증코드 입력</label>
		                                    	<button type="button" class="edit-btn" onclick="confirmCode();">확인</button>
		                                    </div>
		                                    <div class="validation"></div>
                                		</c:otherwise>
                                	</c:choose>
                                </div>
                                
                                <!-- 전화 번호 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating phone-number">
                                        <input type="text" class="form-control" id="phone-number" name="phoneNumber">
                                        <label for="phoneNumber">전화 번호</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 핸드폰 번호 -->
								<div class="col-12">
									<div class="form-floating theme-form-floating phone-number">
										<input type="text" class="form-control" id="cell-phone-number" name="cellPhoneNumber">
										<label for="cellPhoneNumber">핸드폰 번호</label>
									</div>
                                </div>
                                
                                <!-- 생년월일 -->
								<div class="col-12">
	                                <c:choose>
	                                	<c:when test="${birthday.length > 0}">
	                                		<div class="form-floating theme-form-floating">
		                                        <input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="생년월일 8글자" value="${birthday}" readonly>
		                                        <label for="dateOfBirth">*생년월일</label>
		                                    </div>
	                                	</c:when>
	                                	<c:otherwise>
	                                		<div class="form-floating theme-form-floating">
		                                        <input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="생년월일 8글자">
		                                        <label for="dateOfBirth">*생년월일</label>
		                                    </div>
                                    		<div class="validation"></div>
	                                	</c:otherwise>
	                                </c:choose>
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
                                        <input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="우편번호" onclick="searchZipCode();" readonly>
                                        <label for="zipCode">*우편번호</label>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                <!-- 주소 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <input type="text" class="form-control" id="address" name="address" placeholder="주소" readonly>
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
                                    <div>
                                    	<input id="basicAddr" type="checkbox" name="basicAddr" value="Y" checked/>
                                    	<label for="basicAddr">기본 배송지로 설정</label>
                                    </div>
                                </div>
                                <!-- 프로필사진 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <!-- <label for="profileImage">프로필 이미지</label> -->
                                        <div class="profile">프로필 이미지
	                                        <div class="upFileArea">
									    		<div class="uploadFiles"></div>
								    			업로드할 파일을 드래그 앤 드랍 하세요.
								    		</div>
							    		</div>
                                    </div>
                                    <div class="validation"></div>
                                </div>
                                
                                <!-- 환불 은행 -->
                                <div class="col-12">
                                    <div class="form-floating theme-form-floating">
                                        <select id="refundBank" name="refundBank" class="form-control">
                                        	<option>은행 선택</option>
                                        	<option>신한은행</option>
                                        	<option>IBK기업은행</option>
                                        	<option>하나은행</option>
                                        	<option>우리은행</option>
                                        	<option>NH농협은행</option>
                                        	<option>KDB산업은행</option>
                                        	<option>SC제일은행</option>
                                        	<option>씨티은행</option>
                                        	<option>BNK부산은행</option>
                                        	<option>DGB대구은행</option>
                                        	<option>MG새마을금고</option>
                                        	<option>신협</option>
                                        	<option>수협은행</option>
                                        	<option>KB국민은행</option>
                                        	<option>우체국예금</option>
                                        	<option>카카오뱅크</option>
                                        	<option>토스</option>
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

                                <div class="col-12">
                                    <button type="button" id="submit-btn" class="btn btn-animation w-100">가입하기</button>
                                </div>
                            </form>
                        </div>
						<c:if test="${!name}">
                        <div class="other-log-in">
                            <h6>또는</h6>
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
						</c:if>
                        <div class="other-log-in">
                            <h6></h6>
                        </div>
						
                        <div class="sign-up-box">
                            <h4>이미 가입한 계정이 있습니까?</h4>
                            <a href="/login/">로그인</a>
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