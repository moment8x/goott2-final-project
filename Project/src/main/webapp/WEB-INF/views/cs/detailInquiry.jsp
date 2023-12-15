<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Fastkart" />
<meta name="keywords" content="Fastkart" />
<meta name="author" content="Fastkart" />
<link rel="icon" href="/resources/assets/images/favicon/1.png"
	type="image/x-icon" />
<title>Dear Books</title>

<!-- Google font -->
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;ㅇ0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet" />

<!-- bootstrap css -->
<link id="rtl-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/bootstrap.css" />

<!-- font-awesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/font-awesome.css" />

<!-- feather icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/feather-icon.css" />

<!-- slick css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick-theme.css" />

<!-- Iconly css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/bulk-style.css" />

<!-- Template css -->
<link id="color-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/style.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	
	let isValidTitle = false;
	let isValidContent = false;
	let isValidState = false;
	let saveFile = false;

	$(function() {
		//첨부파일
		$(".upFileArea").on("dragenter dragover", function(e) {
			e.preventDefault();
		});
		$(".upFileArea").on("drop", function(e) {
			e.preventDefault();

			console.log(e.originalEvent.dataTransfer.files);

			let files = e.originalEvent.dataTransfer.files;
			if(files.length > 3) {
				alert("이미지 파일은 최대 3개까지만 첨부 가능합니다.");
			}
			for (let i = 0; i < files.length; i++) {
				if(i < 3) {
					let form = new FormData();
					form.append("uploadFile", files[i]); // 파일의 이름을 컨트롤러단의 MultipartFile 객체명과 맞춘다.
	
					$.ajax({
						url : "/cs/uploadFile",
						type : "post",
						data : form,
						dataType : "json",
						async : false,
						processData : false, // text데이터에 대해 쿼리스트링 처리를 하지 않겠다.  default = true
						contentType : false, // application/x-www-form-urlencoded 처리 안함.(인코딩 하지 않음)  default = true
						success : function(data) {
							console.log("업로드성공", data);
							if (data != null) {
								showUploadedFile(data);
							}
						},
						error : function(data) {
							console.log("업로드 실패", data);
						}
					});
				}
			}
			
		});
	})
	
	// 업로드 된 파일 표시    	
	function showUploadedFile(json) {
		console.log("newFileName", json);
		let output = "";
		let index = 0;
		for(let data of json){
			let name = data.thumbnailFileName.replaceAll("\\", "/");
			//output += "<img src='../resources/uploads" + name + "'/>";
			output += `<div id="\${name}" class="imgList"><img src='../resources/inquiryUploads\${name}'/>`;
			output += `<button id='\${name}\${index}' class="removeImgBtn" type="button" onclick="removeSpecificImg(this.id);"><img width="16" height="16" src="https://img.icons8.com/tiny-glyph/16/cancel.png" alt="cancel"/></button></div>`;
			index++;
		}
		$('.uploadFiles').html(output);
	}

	function isValidInquiry() {
		if($('#inquiryTitle').val() != "") {
			isValidTitle = true;
		}
		
		if($('#inquiryContent').val() != "") {
			isValidContent = true;
		}
		
		console.log($('#selectState').val());
		
		if($('#selectState').val() !="문의 유형을 선택해주세요.") {
			isValidState = true;
		}
		
		
		if(isValidTitle && isValidContent && isValidState) {
			console.log("유효성 검사 통과");
			saveFile = true;
			$('#saveInquiry').submit();
		}
	}
	
	// 페이지 나갈 시
	window.onbeforeunload = function (e) {
		if(!saveFile) {
			
		console.log("beforeunload 실행");
 		window.navigator.sendBeacon('/cs/refreshFile');
		}
	};
	
	function removeSpecificImg(id) {
		console.log(id);
		let fileName = id.slice(0, -1);
		console.log(fileName);
		$.ajax({
			url : "/cs/removeSpecificImg",
			type : "GET",
			data : {
				"fileName" : fileName
			},
			dataType : "text",
			async : false,
			success : function(data) {
				console.log("클릭한 이미지 삭제 성공");
				let div = document.getElementById(fileName);
				console.log(fileName);
				console.log(div);
				  
				div.remove();
				
			},
			error : function(data) {
				console.log("왜 여길 타냐고", data);
			}
		});
	}
</script>
<style>
.removeImgBtn {
	border: none;
	
}

.imgList {
	width : 80px;
}

.uploadFiles {
	display : flex;
}


</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>고객센터</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">
									고객센터</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- User Dashboard Section Start -->
	<section class="user-dashboard-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-xxl-3 col-lg-4">
					<div class="dashboard-left-sidebar">
						<div class="close-button d-flex d-lg-none">
							<button class="close-sidebar">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
						<!-- <div class="profile-box">
							<div class="cover-image">
								<img src="/resources/assets/images/deer.png"
									class="img-fluid blur-up lazyload" alt="" />
							</div>

							<div class="profile-contain">
								<div class="profile-image">
									<div class="position-relative">
										<img src="#" class="blur-up lazyload update_img" alt="" />
										<div class="cover-icon">
											<i class="fa-solid fa-pen"> <input type="file"
												onchange="readURL(this,0)" />
											</i>
										</div>
									</div>
								</div>

								<div class="profile-name">
									<h3>${userInfo.memberId }</h3>
									<h6 class="text-content">
										<img width="50" height="50"
											src="https://img.icons8.com/external-vitaliy-gorbachev-lineal-vitaly-gorbachev/60/external-deer-winter-vitaliy-gorbachev-lineal-vitaly-gorbachev.png"
											alt="external-deer-winter-vitaliy-gorbachev-lineal-vitaly-gorbachev" />${userInfo.membershipGrade }</h6>
								</div>
							</div>
						</div>-->

						<ul class="nav nav-pills user-nav-pills" id="pills-tab"
							role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="pills-dashboard-tab"
									data-bs-toggle="pill" data-bs-target="#pills-dashboard"
									type="button" role="tab" aria-controls="pills-dashboard"
									aria-selected="true">
									<i data-feather="home"></i> 메인
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-order-tab"
									data-bs-toggle="pill" data-bs-target="#pills-order"
									type="button" role="tab" aria-controls="pills-order"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>주문내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="user"></i> 회원정보
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-address-tab"
									data-bs-toggle="pill" data-bs-target="#pills-address"
									type="button" role="tab" aria-controls="pills-address"
									aria-selected="false">
									<i data-feather="map-pin"></i> 배송 주소록
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-wishlist-tab"
									data-bs-toggle="pill" data-bs-target="#pills-wishlist"
									type="button" role="tab" aria-controls="pills-wishlist"
									aria-selected="false">
									<i data-feather="heart"></i> 찜
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="help-circle"></i>1:1문의내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-review-tab"
									data-bs-toggle="pill" data-bs-target="#pills-review"
									type="button" role="tab" aria-controls="pills-review"
									aria-selected="false">
									<i data-feather="clipboard"></i>작성한 리뷰
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="smile"></i>포인트/쿠폰/적립금 내역
								</button>
							</li>
						</ul>
					</div>
				</div>

				<div class="col-xxl-9 col-lg-8">
					<button
						class="btn left-dashboard-show btn-animation btn-md fw-bold d-block mb-4 d-lg-none">
						Show Menu</button>
					<div class="dashboard-right-sidebar">
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-dashboard"
								role="tabpanel" aria-labelledby="pills-dashboard-tab">
								<div class="dashboard-home">
									<div class="title">
										<h2>1:1 문의</h2>
										<span class="title-leaf"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>



									<div class="dashboard-title">
										<jsp:include page="./requestInquiry.jsp"></jsp:include>
										<button class="btn theme-bg-color text-white m-0"
											type="button" id="button-addon1" style="float: right"
											onclick="isValidInquiry()">
											<span>등록</span>
										</button>
										<button class="btn theme-bg-color text-white m-0"
											type="button" id="button-addon1"
											style="float: right; margin-right: 10px !important; color: #fff !important; background-color: #6c757d !important;">
											<span>취소</span>
										</button>
									</div>


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>