<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Fastkart">
<meta name="keywords" content="Fastkart">
<meta name="author" content="Fastkart">
<link rel="icon" href="/resources/assets/images/favicon/1.png"
   type="image/x-icon">
<title>Header</title>

<!-- Google font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
   href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
   rel="stylesheet">



<!-- bootstrap css -->
<link id="rtl-link" rel="stylesheet" type="text/css"
   href="/resources/assets/css/vendors/bootstrap.css">
<!-- font-awesome css -->
<link rel="stylesheet" type="text/css"
   href="/resources/assets/css/vendors/font-awesome.css">
<!-- feather icon css -->
<link rel="stylesheet" type="text/css"
   href="/resources/assets/css/vendors/feather-icon.css">
<!-- slick css -->
<link rel="stylesheet" type="text/css"
   href="/resources/assets/css/vendors/slick/slick.css">
<link rel="stylesheet" type="text/css"
   href="/resources/assets/css/vendors/slick/slick-theme.css">
<!-- Iconly css -->
<link rel="stylesheet" type="text/css"
   href="/resources/assets/css/bulk-style.css">
<!-- Template css -->
<link id="color-link" rel="stylesheet" type="text/css"
   href="/resources/assets/css/style.css">
<!-- latest jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
	$(function () {
		$('.single-item').slick();
		
		$('.review-imgs').click(function (e) {
			let output = "";
			let index = $(this).prev().val();
			let src = `<c:out value='${reviewList}'/>`;
			src = src.split("ReviewBoardDTO");
			src = src[index].split("imagesAddr=[")[1];
			src = src.replaceAll("]", "");
			src = src.replaceAll(")", "");
			src = src.replaceAll("thumb_", "");
			src = src.split(', ');
			console.log("src", src);
			
			for (let i = 0; i < src.length; i++) {
				if (src[i] !== "") {
					output += "<div><img src='../resources/uploads" + src[i] + "'></div>";
				}
			}
			
			console.log(output);
			
			$('.fade-img').html(output);
			
			$('.fade-img').slick({
				dots: false,
				infinite: true,
				speed: 500,
				fade: true,
				cssEase: 'linear'
			});
		});
	
		changeStar();
		
		// 첨부파일
		uploadFiles();
		
		// 리뷰 작성하려 할 시 검증!
		$("form").click(function(e) {
			if (${sessionScope.loginMember == null}) {
				if (window.confirm("회원만 리뷰 등록이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
					location.href="/login/";
				} else {
					return false;
				}
			} else {
				$.ajax({
					url : "/review/isValid",
					type : "GET",
					data : {
						"productId" : "${product.productId}"
					},
					dataType : "json",
					async : false,
					success : function(data) {
						console.log("success", data);
					}, error : function(data) {
						console.log("error", data);
					}
				});
			}
		});
		
		// 페이징
		$('.paging-btn').click(function(e) {
			let page = $(this).html();
			let productId = "${product.productId}";
			console.log("productId", productId);
			$.ajax({
				url: "/review/" + productId,
				type: "GET",
				data: {
					"productId" : productId,
					"page" : page
				},
				dataType: "JSON",
				async: false,
				success: function(data) {
					console.log("success", data);
					showReview(data);
					changeStar();
				}, error: function(data) {
					console.log("err", data);
				}
			});
		});
	});
	
	// 첨부파일 함수
	function uploadFiles() {
		$(".upFileArea").on("dragenter dragover", function(e) {
			e.preventDefault();
		});
		$(".upFileArea").on("drop", function(e) {
			e.preventDefault();
			
			console.log(e.originalEvent.dataTransfer.files);
			
			let key = $(this).attr("id").split("-")[0];
			let files = e.originalEvent.dataTransfer.files;
			for (let i = 0; i < files.length; i++) {
				let form = new FormData();
				form.append("uploadFile", files[i]);	// 파일의 이름을 컨트롤러단의 MultipartFile 객체명과 맞춘다.
				
				$.ajax({
					url : "/review/uploadFile",
					type : "post",
					data : form,
					dataType : "json",
					async : false,
					processData : false,	// text데이터에 대해 쿼리스트링 처리를 하지 않겠다.  default = true
					contentType : false,	// application/x-www-form-urlencoded 처리 안함.(인코딩 하지 않음)  default = true
					success : function(data) {
						console.log("업로드성공", data);
						if (data != null) {
							showUploadedFile(key, data);
						}
					}, error : function(data) {
						console.log("업로드 실패", data);
					}
				});
			}
		});
	}
	
	// 업로드 파일 삭제 시 실행할 이벤트
	function uploadFileDelete() {
		$('.u-img').on('click', function(e) {
			e.stopPropagation();
			let key = $(this).parent().parent().attr("id").split("-")[0];
			let thumbFileName = $(this).prev().attr("src").split("/resources/uploads")[1];
			$.ajax({
				url : "/review/deleteUploadFile",
				type : "POST",
				data : {
					"thumbFileName" : thumbFileName
				},
				dataType : "JSON",
				async : false,
				success: function(data) {
					console.log("success", data); 
					if (data != null) {
						showUploadedFile(key, data);
					}
				}, error: function(data) {
					console.log("err", data);
				}
			});
		});
	}
	
	// 리뷰 수정 클릭 시 검증
	function updateReviewCheck(index, postNo) {
		let productId = "${product.productId}";
		
		// 해당 리뷰 수정 가능한지 확인
		$.ajax({
			url: "/review/update",
			type: "GET",
			data: {
				"productId" : productId,
				"postNo" : postNo
			},
			dataType: "JSON",
			async: false,
			success: function(data) {
				console.log("success", data);
				if (data.status === "success") {
					// 리뷰 수정 시작
					openReviewWriter(index, data.review);
					uploadFiles();
					changeStar();
					showUploadedFile("update", data.review.images);
				} else {
					alert("작성자만 수정 가능합니다.");
					return false;
				}
			}, error: function(data) {
				console.log("err", data);
			}
		});
	}
	
	// 리뷰 수정
	function openReviewWriter(index, review) {
		let content = review.content;
		content = content.replaceAll("<br/>", "\n");
		let output = "";		// 글 수정
		let output2 = "";		// 별 수정
		
		output += '<div class="col-12"><textarea class="col-12">' + content + '</textarea></div>';
		output += '<div><button onclick="updateReview(' + index + ', ' + review.postNo + ');">수정</button>';
		output += '<button onclick="updateCancel(' + index + ', ' + review.postNo + ', \'' + review.author +  '\', \'' + review.content + '\', '+ review.rating + ');">취소</button>';
		
		output += '<div class="form-floating theme-form-floating">';
		output += '<div style="color: #4a5568;">파일 업로드</div>';
		output += '<div id="update-files" class="upFileArea">업로드 할 파일을 드래그 앤 드랍 하세요.<div id="update-uploadFiles" class="uploadFiles"></div></div></div></div>';
		
		output2 += '<div class="star-rating">';
		for (let i = 1; i < 6; i++) {
			if (i === review.rating) {
				output2 += '<input type="radio" id="u-' + i + '-stars" name="updateRating" value=' + i + ' checked>';
			} else {
				output2 += '<input type="radio" id="u-' + i + '-stars" name="updateRating" value=' + i + '>';
			}
			if (i > review.rating) {
				output2 += '<label for="u-' + i + '-stars" class="star" id="u-' + i + '-span"><i class="fa-regular fa-star" style="color: #f9e50b;"></i></label>'; 
			} else {
				output2 += '<label for="u-' + i + '-stars" class="star" id="u-' + i + '-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>';
			}
		}
		output2 += '</div>';
		
		$('#review-' + index + ' div.reply').html(output);
		$('#review-' + index + ' div.product-rating').html(output2);
	}
	
	// 리뷰 수정 완료 시
	function updateReview(index, postNo) {
		//let author = $('#review-' + index + ' div.name').text();
		let rating = $('#review-' + index + ' input:radio[name="updateRating"]:checked').val();
		let content = $('#review-' + index + ' div.reply textarea').val();
		let productId = "${product.productId}";
		//console.log("author", author);
		console.log("rating", rating);
		console.log("content", content);
		console.log("productId", productId);
		/*$.ajax({
			url : "/review/update",
			type : "POST",
			data : {
				"postNo" : postNo,
				//"author" : author,
				"rating" : rating,
				"content" : content,
				"productId" : productId
			},
			dataType : "JSON",
			async : false,
			success : function(data) {
				console.log("success", data);
			}, error : function(data) {
				console.log("err", data);
			}
		});*/
	}
	
	// 리뷰 수정 중 취소 시
	function updateCancel(index, postNo, author, content, rating) {
		let output = "";
				
		output += '<p>' + content;
		
		if ("${sessionScope.loginMember.memberId}" == author) {
			output += '<a onclick="updateReviewCheck(' + index + ', ' + postNo + ');">수정</a>';
			output += '<a onclick="removeReviewCheck(${index}, ' + postNo + ');" style="top:20px; color:#ff3535;">삭제</a>';
		}
		output += '</p>';
		
		let output2 = '<ul class="rating">';
		for (let i = 1; i < 6; i++) {
			if (i > rating) {
				output2 += '<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>';
			} else {
				output2 += '<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>';
			}
		}
		output2 += '</ul>';
		
		$('#review-' + index + ' div.reply').html(output);
		$('#review-' + index + ' div.product-rating').html(output2);
	}
	
	// 리뷰 삭제 클릭 시
	function removeReviewCheck(index, postNo) {
		let productId = "${product.productId}";
		alert("아직 구현 X");
		// 해당 리뷰 삭제 가능한지 확인
		/*$.ajax({
			url: "/review/update",
			type: "GET",
			data: {
				"productId" : productId,
				"postNo" : postNo
			},
			dataType: "JSON",
			async: false,
			success: function(data) {
				console.log("success", data);
				if (data.status === "success") {
					// 리뷰 삭제 시작
					
				} else {
					alert("작성자만 삭제 가능합니다.");
					return false;
				}
			}, error: function(data) {
				console.log("err", data);
			}
		});*/
	}
	
	// 리뷰출력
	function showReview(data) {
		let reviewList = data.reviewList;
		
		let output = "";
		for (let i = 0; i < reviewList.length; i++) {
			output += '<li id="review-' + (i + 1) + '"><div class="people-box"><div><div class="people-image">';
			// 이미지 영역
			if (reviewList[i].imagesAddr !== null) {
				output += '<input type="hidden" value=' + (i + 1) + '>';
				output += '<img src="../resources/uploads' + reviewList[i].imagesAddr[0] + '"';
				output += 'class="img-fluid blur-up lazyload review-imgs"';
				output += 'data-bs-toggle="modal" data-bs-target="#myModal" />';
			}
			// 이미지 영역 종료
			output += '</div></div>';
			output += '<div class="people-comment">';
			output += '<div class="name">' + reviewList[i].author + '</div>';
			output += '<div class="date-time">';
			output += '<h6 class="text-content">' + Date(reviewList[i].createdDate) + '</h6>';
			output += '<div class="product-rating">';
			output += '<ul class="rating">';
			for (let j = 1; j < 6; j++) {
				if (j > reviewList[i].rating) {
					output += '<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>';
				} else {
					output += '<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>';
				}
			}
			output += '</ul></div></div>'
			output += '<div class="reply"><p>' + reviewList[i].content
			if ("${sessionScope.loginMember.memberId}" === reviewList[i].author) {
				output += '<a onclick="updateReviewCheck(' + (i + 1) + ', ' + reviewList[i].postNo + ');">수정</a>';
				output += '<a onclick="removeReviewCheck(' + (i + 1) + ', ' + reviewList[i].postNo + ');" style="top:20px; color:#ff3535;">삭제</a>';
			}
			output += '</p></div></div></div></li>';
		}
		console.log("output", output);
		
		$('.review-list').html(output);
	}
	
	// 별 변경!
	function changeStar() {
		$(".star").on("click", function(e) {
			// 누른 별표까지 색칠, 이 후 별표는 X
			let isUpdate = $(this).attr("id").includes('u-');
			let selectValue = $(this).prev().val();
			if (isUpdate) {
				for (let i = 1; i < 6; i++) {
					if (selectValue < $('#u-' + i + '-stars').val()) {
						$('#u-' + i + '-span').html('<i class="fa-regular fa-star" style="color: #f9e50b;"></i>');
					} else {
						$('#u-' + i + '-span').html('<i class="fa-solid fa-star" style="color: #f9e50b;"></i>');
					}
				}
			} else {
				for (let i = 1; i < 6; i++) {
					if (selectValue < $('#' + i + '-stars').val()) {
						$('#' + i + '-span').html('<i class="fa-regular fa-star" style="color: #f9e50b;"></i>');
					} else {
						$('#' + i + '-span').html('<i class="fa-solid fa-star" style="color: #f9e50b;"></i>');
					}
				}
			}
		});
	}
	
	function plusQTY() {
		$('#qty').val(parseInt($('#qty').val()) + 1);
	}
	function minusQTY() {
		if ($('#qty').val() > 0) {
			$('#qty').val($('#qty').val() - 1);
		}
	}
	
	function buy() {
		let qty = $('#qty').val();
		location.href = "/order/requestOrder?productId=" + "${product.productId}" + "&qty=" + qty + "&fromCart=N";
	}
	
	function addCart() {
		$.ajax({
			url: "/shoppingCart/insert",
			type: "POST",
			data: {
				productId : "${product.productId}",
				quantity : $('#qty').val()
			},
			dataType: "JSON",
			async: false,
			success: function(data) {
				console.log(data);
				if (data.status === "success") {
					alert("장바구니 등록 완료");
				} else if (data.status === "exist") {
					alert("기존에 장바구니에 존재하는 상품입니다.");
				}
			}, error: function(data) {
				console.log(data);
			}
		});
	}
	
	// 리뷰달기 버튼 클릭 시 유효성 검사
	function isValid() {
		let result = false;
		if ($('#floatingTextarea2').val() !== "") {
			result = true
		}
		return result;
	}
	
	// 업로드 된 파일 표시    	
	function showUploadedFile(key, json) {
		let output = "";
		let index = 0;
		for(let data of json){
			let name = data.thumbnailFileName.replaceAll("\\", "/");
			output += `<span><img src='../resources/uploads\${name}'/><i class="fa-solid fa-circle-xmark u-img" style="color: #fc1d1d;"></i></span>`;
			index++;
		}
		if (key === "insert") {
			$('#insert-uploadFiles').html(output);
		} else if (key === "update") {
			$('#update-uploadFiles').html(output);
		}
		uploadFileDelete();
	}
	
	// 페이지 나갈 시
	window.onbeforeunload = function (e) {
		console.log("beforeunload 실행");
 		window.navigator.sendBeacon('/review/refreshFile');
	};
		    	
	// form버튼으로 페이지 이동 시
	$(document).on("submit", "form", function (e) {
		window.onbeforeunload = null;
	});
</script>
   
<style type="text/css">
.flip-card {
   background-color: transparent;
   width: 390px;
   height: 570px;
   perspective: 1000px;
   display: flex;
   margin: auto;
}

.flip-card-inner {
   position: relative;
   width: 100%;
   height: 100%;
   text-align: center;
   transition: transform 0.6s;
   transform-style: preserve-3d;
   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
   z-index: -1;
}

.flip-card:hover .flip-card-inner {
   transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
   position: absolute;
   width: 100%;
   height: 100%;
   -webkit-backface-visibility: hidden;
   backface-visibility: hidden;
}

.flip-card-front {
   background-color: #bbb;
   color: black;
}

.flip-card-back {
   background-color: #2980b9;
   color: white;
   transform: rotateY(180deg);
}

.upFileArea {
	width: 100%;
	height: 200px;
	border: 1px solid black;
}

.star-rating input{
	display: none;
}
textarea {
	resize: none;
}
</style>



</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	<div class="container">
	
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
						<h2>${product.productName}</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item">
									<a href="index.html">
										<i class="fa-solid fa-house"></i>
									</a>
								</li>
								<c:forEach var="category" items="${categories }">
									<li class="breadcrumb-item active">${category}</li>
								</c:forEach>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->
	
	<!-- Product Left Sidebar Start -->
	<section class="product-section">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-xxl-9 col-xl-8 col-lg-7 wow fadeInUp">
					<div class="row g-4">
						<div class="col-xl-6 wow fadeInUp">
							<div class="product-left-box">
								<div class="row g-2">
									<div class="col-xxl-10 col-lg-12 col-md-10 order-xxl-2 order-lg-1 order-md-2">
										<!-- 플립 카드 or 단일? 이미지 -->
										<c:choose>
											<c:when test="${productImages.size() > 2}">
												<!-- 이미지 슬라이더 추가 -->
												<div class="single-item">
													<div class="flip-card">
														<div class="flip-card-inner">
															<div class="flip-card-front">
																<div class="product-image">
																	<img src="${productImages[0].productImage}"
																		id="img-1"
																		data-zoom-image="/resources/assets/images/product/category/1.jpg"
																		class="img-fluid image_zoom_cls-0 blur-up lazyload"
																		alt="${product.productName}">
			      												</div>
			      											</div>
			      											<div class="flip-card-back">
			      												<img src="${productImages[2].productImage}"
			      													id="img-1"
			      													data-zoom-image="/resources/assets/images/product/category/1.jpg"
			      													class="img-fluid image_zoom_cls-0 blur-up lazyload"
			      													alt="${product.productName}">
			      											</div>
			      										</div>
			      									</div>
			      									<div>
			      										<div class="product-image">
			      											<img src="${productImages[1].productImage}" alt="${product.productName }">
			      										</div>
			      									</div>
		      									</div>
											</c:when>
											<c:when test="${productImages.size() == 2 }">
												<div class="flip-card">
													<div class="flip-card-inner">
														<div class="flip-card-front">
															<div class="product-image">
																<img src="${productImages[0].productImage}"
																	id="img-1"
																	data-zoom-image="/resources/assets/images/product/category/1.jpg"
																	class="img-fluid image_zoom_cls-0 blur-up lazyload"
																	alt="${product.productName}">
		      												</div>
		      											</div>
		      											<div class="flip-card-back">
		      												<img src="${productImages[1].productImage}"
		      													id="img-1"
		      													data-zoom-image="/resources/assets/images/product/category/1.jpg"
		      													class="img-fluid image_zoom_cls-0 blur-up lazyload"
		      													alt="${product.productName}">
		      											</div>
		      										</div>
		      									</div>
											</c:when>
											<c:when test="${productImages.size() == 1 }">
												<div class="product-image">
													<img src="${productImages[0].productImage }" id="img-1"
														data-zoom-image="/resources/assets/images/product/category/1.jpg"
														class="img-fluid image_zoom_cls-0 blur-up lazyload"
														alt="${product.productName}">
												</div>
											</c:when>
											<c:otherwise>
												<div class="product-image">
													<img src="https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"
														id="img-1"
														data-zoom-image="/resources/assets/images/product/category/1.jpg"
														class="img-fluid image_zoom_cls-0 blur-up lazyload"
														alt="${product.productName}">
												</div>
											</c:otherwise>
										</c:choose>
      								</div>
      							</div>
      						</div>
      					</div>
      					
      					<div class="col-xl-6 wow fadeInUp" data-wow-delay="0.1s">
      						<div class="right-box-contain">
      							<h6 class="offer-top">30% Off</h6>
      							<h2 class="name">${product.productName}</h2>
   								<div class="price-rating">
    								<h3 class="theme-color price">${product.sellingPrice}원
 	  									<del class="text-content">${product.consumerPrice}원</del>
   										<span class="offer theme-color">(10% off)</span>
   									</h3>
   									<div class="product-rating custom-rate">
   										<ul class="rating">
   											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
   											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
   											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
   											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
   											<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
   										</ul>
   										<span class="review">23개 리뷰</span>
   									</div>
   								</div>
      							<div class="author">
      								${product.authorTranslator}
      							</div>
   								<div class="procuct-contain">
   									<p>${product.introductionIntro}</p>
   								</div>
                       			<div class="note-box product-packege">
                       				<div class="cart_qty qty-box product-qty">
                       					<div class="input-group">
                       						<button type="button" class="qty-right-plus"
                       							data-type="plus" data-field="" onclick="plusQTY();">
                       							<i class="fa fa-plus" aria-hidden="true"></i>
                       						</button>
                       						<input class="form-control input-number qty-input"
                       							type="text" id="qty" name="qty" value="1">
                       						<button type="button" class="qty-left-minus"
                       							data-type="minus" data-field="" onclick="minusQTY();">
                       							<i class="fa fa-minus" aria-hidden="true"></i>
                       						</button>
                       					</div>
                       				</div>
                       				<button onclick="addCart();"
                       					class="btn btn-md bg-dark cart-button text-white w-80">장바구니</button>
                       				<button onclick="buy();"
                       					class="btn btn-md bg-dark cart-button text-white w-80">바로구매</button>
                       			</div>
                           		
                       			<div class="buy-box">
                       				<a href="wishlist.html">
                       					<i data-feather="heart"></i>
                       					<span>Add To Wishlist</span>
                       				</a>
                       				<a href="compare.html">
                       					<i data-feather="shuffle"></i>
                       					<span>Add To Compare</span>
                       				</a>
                       			</div>

                           	</div>
                        </div>
                        <div class="col-12">
                           		<div class="product-section-box">
                       				<ul class="nav nav-tabs custom-nav" id="myTab" role="tablist">
                       					<li class="nav-item" role="presentation">
                       						<button class="nav-link active" id="description-tab"
                       							data-bs-toggle="tab" data-bs-target="#description"
                       							type="button" role="tab" aria-controls="description"
                       							aria-selected="true">소개정보</button>
                       					</li>
                       					<li class="nav-item" role="presentation">
                       					<button class="nav-link" id="info-tab" data-bs-toggle="tab"
                       						data-bs-target="#info" type="button" role="tab"
                       						aria-controls="info" aria-selected="false">상품정보</button>
                       					</li>
                       					<li class="nav-item" role="presentation">
                       						<button class="nav-link" id="care-tab" data-bs-toggle="tab"
                       							data-bs-target="#care" type="button" role="tab"
                       							aria-controls="care" aria-selected="false">교환/반품/품절안내</button>
                       					</li>
                       					<li class="nav-item" role="presentation">
                       					<button class="nav-link getAllReview" id="review-tab"
                       						data-bs-toggle="tab" data-bs-target="#review" type="button"
                       						role="tab" aria-controls="review" aria-selected="false"
                       						value="${product.productId}"
                       						data-productId="${product.productId}">리뷰(총 리뷰 개수)</button>
                       					</li>
                       				</ul>
                          			<div class="tab-content custom-tab" id="myTabContent">
                          				<div class="tab-pane fade show active" id="description"
                          					role="tabpanel" aria-labelledby="description-tab">
                          					<div class="product-description">
                          						<div class="nav-desh">
                          							<c:choose>
                           								<c:when test="${product.productInfoImage != ''}">
                          									<img src="${product.productInfoImage }">
                          								</c:when>
                          								<c:otherwise>
			                        						<h5>책 소개</h5>
		                           							<p>${product.introductionDetail}</p>
                          								</c:otherwise>
                          							</c:choose>
                          						</div>
                          						<div class="nav-desh">
                          							<div class="desh-title">
                          								<h5>목차</h5>
                          							</div>
                          							<p>${product.tableOfContents }</p>
                          						</div>
                          						<div class="nav-desh">
                           							<div class="desh-title">
                           								<c:choose>
                           									<c:when test="${product.authorIntroduction != ''}">
                           										<h5>저자 소개</h5>
                           										<p>${product.authorIntroduction }</p>
                           									</c:when>
                           								</c:choose>
                           							</div>
                           						</div>
                           					</div>
                           				</div>
                           				<div class="tab-pane fade" id="info" role="tabpanel"
                           					aria-labelledby="info-tab">
                           					<div class="table-responsive">
                           						<table class="table info-table">
                           							<tbody>
                           								<tr>
                           									<td>ISBN</td>
                           									<td>${product.isbn}</td>
                           								</tr>
                           								<tr>
                           									<td>발행(출시)일자</td>
                           									<td>${product.publicationDate}</td>
                           								</tr>
                           								<tr>
                           									<td>쪽수</td>
                           									<td>${product.pageCount}</td>
                           								</tr>
                           								<tr>
                           									<td>크기</td>
                           									<td>${productSize}
                           										<button>판형알림</button>
                           									</td>
                           								</tr>
                           								<tr>
                           									<td>총권수</td>
                           									<td>${product.totalVolume}권</td>
                           								</tr>
                           								<tr>
                           									<td>원서명/저자명</td>
                           									<td>${product.originalAuthor}</td>
                           								</tr>
                           							</tbody>
                           						</table>
                           					</div>
                           				</div>
                           				
		                           		<div class="tab-pane fade" id="care" role="tabpanel"
		                           			aria-labelledby="care-tab">
		                           			<div class="information-box">
		                           				<ul>
		                           					<li>
		                           						<h5>반품/교환방법</h5>
		                           						<p>마이룸 > 주문관리 > 주문/배송내역 > 주문조회 > 반품/교환 신청, [1:1 상담 >
		                           						반품/교환/환불] 또는 고객센터 (1544-1900) * 오픈마켓, 해외배송 주문, 기프트 주문시
		                           						[1:1 상담>반품/교환/환불] 또는 고객센터 (1544-1900)</p>
		                           					</li>
		                           					<li>
		                           						<h5>반품/교환가능 기간</h5>
		                           						<p>변심반품의 경우 수령 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제점 발견 후
		                           						30일 이내</p>
		                           					</li>
		                           					<li>
		                           						<h5>반품/교환비용</h5>
		                           						<p>변심 혹은 구매착오로 인한 반품/교환은 반송료 고객 부담</p>
		                           					</li>
		                           					<li>
		                           						<h5>반품/교환 불가 사유</h5>
		                           						<p>1) 소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우 (단지 확인을 위한 포장
		                           						훼손은 제외)</p>
		                           						<p>2) 소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 예) 화장품,
		                           						식품, 가전제품(악세서리 포함) 등</p>
		                           						<p>3) 복제가 가능한 상품 등의 포장을 훼손한 경우 예) 음반/DVD/비디오, 소프트웨어,
		                           						만화책, 잡지, 영상 화보집</p>
		                           						<p>4) 소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우 ((1)해외주문도서)</p>
		                           						<p>5) 디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우</p>
		                           						<p>6) 시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</p>
		                           						<p>7) 전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에
		                           						해당되는 경우</p>
		                           						<p>8) 세트상품 일부만 반품 불가 (필요시 세트상품 반품 후 낱권 재구매)</p>
		                           					</li>
		                           					<li>
		                           						<h5>상품 품절</h5>
		                           						<p>공급사(출판사) 재고 사정에 의해 품절/지연될 수 있으며, 품절 시 관련 사항에 대해서는
		                           						이메일과 문자로 안내드리겠습니다.</p>
		                           					</li>
		                           					<li>
		                           						<h5>소비자 피해보상 환불 지연에 따른 배상</h5>
		                           						<p>1) 상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은
		                           						소비자분쟁 해결 기준 (공정거래위원회 고시)에 준하여 처리됨</p>
		                           						<p>2) 대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자
		                           						보호에 관한 법률에 따라 처리함</p>
		                           						<div>*상품 설명에 반품/교환 관련한 안내가 있는 경우 그 내용을 우선으로 합니다. (업체
		                           						사정에 따라 달라질 수 있습니다.)</div>
		                           					</li>
		                           				</ul>
		                           			</div>
		                           		</div>
		                           		<div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
		                           			<div class="review-box">
		                           				<div class="row g-4">
		                           					<div class="col-xl-6">
		                           						<div class="review-title">
		                           							<h4 class="fw-500">Customer reviews</h4>
		                           						</div>
		                           						
		                           						<div class="d-flex">
		                           							<div class="product-rating">
		                           								<ul class="rating">
		                           									<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
		                           									<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
		                           									<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
		                           									<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
		                           									<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
		                           								</ul>
		                           							</div>
		                           							<h6 class="ms-3">4.2 Out Of 5</h6>
		                           						</div>
		                           						
		                           						<div class="rating-box">
		                           							<ul>
		                           								<li>
		                           									<div class="rating-list">
		                           										<h5>5 Star</h5>
		                           										<div class="progress">
			                          											<div class="progress-bar" role="progressbar"
		                           												style="width: 68%" aria-valuenow="100"
		                           												aria-valuemin="0" aria-valuemax="100">68%</div>
		                           										</div>
		                           									</div>
		                           								</li>
		                           								<li>
		                           									<div class="rating-list">
		                           										<h5>4 Star</h5>
		                           										<div class="progress">
		                           											<div class="progress-bar" role="progressbar"
		                           											style="width: 67%" aria-valuenow="100"
		                           											aria-valuemin="0" aria-valuemax="100">67%</div>
		                           										</div>
		                           									</div>
		                           								</li>
		                           								<li>
		                           									<div class="rating-list">
		                           										<h5>3 Star</h5>
		                           										<div class="progress">
		                           											<div class="progress-bar" role="progressbar"
		                           											style="width: 42%" aria-valuenow="100"
		                           											aria-valuemin="0" aria-valuemax="100">42%</div>
		                           										</div>
		                           									</div>
		                           								</li>
		                           								<li>
		                           									<div class="rating-list">
		                           										<h5>2 Star</h5>
		                           										<div class="progress">
		                           											<div class="progress-bar" role="progressbar"
		                           											style="width: 30%" aria-valuenow="100"
		                           											aria-valuemin="0" aria-valuemax="100">30%</div>
		                           										</div>
		                           									</div>
		                           								</li>
		                           								<li>
		                           									<div class="rating-list">
		                           									<h5>1 Star</h5>
		                           										<div class="progress">
		                           											<div class="progress-bar" role="progressbar"
			                          											style="width: 24%" aria-valuenow="100"
		                           											aria-valuemin="0" aria-valuemax="100">24%</div>
		                           										</div>
		                           									</div>
		                           								</li>
		                           							</ul>
		                           						</div>
		                           					</div>
		                           					
		                           					<div class="col-xl-6">
		                           						<div class="review-title">
		                           							<h4 class="fw-500">Add a review</h4>
		                           						</div>
		                           						
		                           						<form action="/review/saveReview" method="POST" enctype="multipart/form-data" onsubmit="return isValid();">
		                           							<input type="hidden" name="productId" value="${product.productId }">
			                          						<div class="row g-4">
			                          							<!-- 평점 넣기 -->
			                          							<div class="col-md-12">
			                          								<div class="form-floating theme-form-floating">
			                          									<div>평점</div>
			                          									<div class="star-rating space-x-4 mx-auto">
					                          								<input type="radio" id="1-stars" name="rating" value=1 />
																			<label for="1-stars" class="star" id="1-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>
					                          								<input type="radio" id="2-stars" name="rating" value=2 />
																			<label for="2-stars" class="star" id="2-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>
					                          								<input type="radio" id="3-stars" name="rating" value=3 />
																			<label for="3-stars" class="star" id="3-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>
					                          								<input type="radio" id="4-stars" name="rating" value=4 />
																			<label for="4-stars" class="star" id="4-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>
					                          								<input type="radio" id="5-stars" name="rating" value=5 checked />
																			<label for="5-stars" class="star" id="5-span"><i class="fa-solid fa-star" style="color: #f9e50b;"></i></label>
																		</div>
			                        								</div>
			                        							</div>
			                          							<!-- 본문 --> 
			                          							<div class="col-12">
			                          								<div class="form-floating theme-form-floating">
				                          								<textarea class="form-control"
					                          								placeholder="Leave a comment here"
			                          										id="floatingTextarea2" style="height: 150px; resize: none;" name="content"></textarea>
			                          									<label for="floatingTextarea2">Write Your Comment</label>
			                          								</div>
			                          							</div>
			                          							<!-- 이미지 넣기 -->
			                          							<!-- <div class="col-md-12">
				                          							<div class="form-floating theme-form-floating">
			                          									<input type="url" class="form-control" id="review1" placeholder="Give your review a title">
			                          									<label for="review1">Review Title</label>
			                          								</div>
			                           							</div> -->
			                           							
			                           							<div class="col-md-12">
								                                   <div class="form-floating theme-form-floating">
								                                   	<div style="color: #4a5568;">파일 업로드</div>
								                                       <div id="insert-files" class="upFileArea">
														    			업로드 할 파일을 드래그 앤 드랍 하세요.
															    		<div id="insert-uploadFiles" class="uploadFiles"></div>
														    		</div>
								                                   </div>
								                               </div>
			                           							
			                           							<div class="col-md-12">
			                           								<div class="form-floating theme-form-floating">
			                           									<button class="btn" style="background-color: #198754; color: #fff;">리뷰 달기</button>
			                           								</div>
			                           							</div>
			                           						</div>
		                           						</form>
		                           					</div>
		                           						
		                           						<!-- 리뷰 글 표시 -->
		                           						<div class="col-12">
		                           							<div class="review-title">
		                           								<h4 class="fw-500">상품 구매 후기</h4>
		                           							</div>
		                           							<div class="review-people">
		                           								<ul class="review-list">
		                           									<c:forEach var="review" items="${reviewList}" varStatus="status">
		                           										<li id="review-${status.count}">
			                           										<div class="people-box">
			                           											<div>
			                           												<div class="people-image">
			                           													<!-- 이미지 영역 -->
		                           														<c:if test="${review.imagesAddr.size() > 0 }">
		                           															<input type="hidden" value="${status.count}">
		                           															<img src="../resources/uploads${review.imagesAddr[0]}"
		                           															class="img-fluid blur-up lazyload review-imgs"
		                           															data-bs-toggle="modal" data-bs-target="#myModal" />
		                           														</c:if>
			                           												</div>
			                           											</div>
			                           											<div class="people-comment">
			                           												<div class="name">${review.author}</div>
			                           												<div class="date-time">
			                           													<h6 class="text-content">${review.createdDate }</h6>
			                           													<div class="product-rating">
			                           														<ul class="rating">
			                           															<c:forEach var="i" begin="1" end="5">
			                           																<c:choose>
			                           																	<c:when test="${i > review.rating }">
			                           																		<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
			                           																	</c:when>
			                           																	<c:otherwise>
			                           																		<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
			                           																	</c:otherwise>
			                           																</c:choose>
			                           															</c:forEach>
			                           														</ul>
			                           													</div>
			                           												</div>
			                           												
			                           												<div class="reply">
			                           													<p>
			                           														${review.content }
			                           														<!-- <a href="javascript:void(0)">Reply</a> -->
			                           														<c:if test="${sessionScope.loginMember.memberId == review.author}">
				                           														<a onclick="updateReviewCheck(${status.count}, ${review.postNo});">수정</a>
				                           														<a onclick="removeReviewCheck(${status.count}, ${review.postNo});" style="top:20px; color:#ff3535;">삭제</a>
			                           														</c:if>
			                           													</p>
			                           												</div>
			                           											</div>
			                           										</div>
			                           									</li>
		                           									</c:forEach>
				                           						</ul>
				                           					</div>
				                           					
				                           					<div>
				                           						<!-- 페이징 -->
				                           						<c:choose>
				                           							<c:when test="${pagingInfo.totalPagingBlockCnt > paingInfo.endNumOfCurrentPagingBlock}">
				                           								<c:forEach var="i" begin="${pagingInfo.startNumOfCurrentPagingBlock}" end="${pagingInfo.endNumOfCurrentPagingBlock}" step="1">
				                           									<li class="page-item active">
				                           										<button type="button" class="btn btn-success paging-btn">${i}</button>
				                           									</li>
				                           								</c:forEach>
				                           							</c:when>
				                           							<c:otherwise>
				                           								<c:forEach var="i" begin="${pagingInfo.startNumOfCurrentPagingBlock}" end="${pagingInfo.totalPageCnt }" step="1">
				                           									<li class="page-item active">
				                           										<button type="button" class="btn btn-success paging-btn">${i}</button>
				                           									</li>
				                           								</c:forEach>
				                           							</c:otherwise>
				                           						</c:choose>
				                           					</div>
				                           				</div>
				                           			</div>
				                           		</div>
			                           		</div>
	                       				</div>
		                    	</div>
						</div>
					</div>
				</div>
			
				<div class="col-xxl-3 col-xl-4 col-lg-5 d-none d-lg-block wow fadeInUp">
					<div class="right-sidebar-box">
						<div class="vendor-box">
							<div class="verndor-contain">
								<div class="vendor-image">
									<img src="/resources/assets/images/product/vendor.png"
										class="blur-up lazyload" alt="">
								</div>
								
								<div class="vendor-name">
									<h5 class="fw-500">Noodles Co.</h5>
									
									<div class="product-rating mt-1">
										<ul class="rating">
											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
											<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
											<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
										</ul>
										<span>(36 Reviews)</span>
									</div>
								</div>
							</div>
							<p class="vendor-detail">Noodles & Company is an American
								fast-casual restaurant that offers international and American
								noodle dishes and pasta.</p>
							
							<div class="vendor-list">
								<ul>
									<li>
										<div class="address-contact">
											<i data-feather="map-pin"></i>
											<h5>
												Address: 
												<span class="text-content">1288 Franklin Avenue</span>
											</h5>
										</div>
									</li>
									<li>
										<div class="address-contact">
											<i data-feather="headphones"></i>
											<h5>
												Contact Seller: 
												<span class="text-content">(+1)-123-456-789</span>
											</h5>
										</div>
									</li>
								</ul>
							</div>
						</div>
						
						<!-- Trending Product -->
						<div class="pt-25">
							<div class="category-menu">
								<h3>Trending Products</h3>
								
								<ul class="product-list product-right-sidebar border-0 p-0">
									<li>
										<div class="offer-product">
											<a href="product-left-thumbnail.html" class="offer-image">
												<img
													src="/resources/assets/images/vegetable/product/23.png"
													class="img-fluid blur-up lazyload" alt="">
											</a>
											
											<div class="offer-detail">
												<div>
													<a href="product-left-thumbnail.html">
														<h6 class="name">Meatigo Premium Goat Curry</h6>
													</a>
													<span>450 G</span>
													<h6 class="price theme-color">$ 70.00</h6>
												</div>
											</div>
										</div>
									</li>
									<li>
										<div class="offer-product">
											<a href="product-left-thumbnail.html" class="offer-image">
												<img
													src="/resources/assets/images/vegetable/product/24.png"
													class="blur-up lazyload" alt="">
											</a>
											<div class="offer-detail">
												<div>
													<a href="product-left-thumbnail.html">
														<h6 class="name">Dates Medjoul Premium Imported</h6>
													</a>
													<span>450 G</span>
													<h6 class="price theme-color">$ 40.00</h6>
												</div>
											</div>
										</div>
									</li>
									<li>
										<div class="offer-product">
											<a href="product-left-thumbnail.html" class="offer-image">
												<img
													src="/resources/assets/images/vegetable/product/25.png"
													class="blur-up lazyload" alt="">
											</a>
											
											<div class="offer-detail">
												<div>
													<a href="product-left-thumbnail.html">
														<h6 class="name">Good Life Walnut Kernels</h6>
													</a>
													<span>200 G</span>
													<h6 class="price theme-color">$ 52.00</h6>
												</div>
											</div>
										</div>
									</li>
									<li class="mb-0">
										<div class="offer-product">
											<a href="product-left-thumbnail.html" class="offer-image">
												<img
													src="/resources/assets/images/vegetable/product/26.png"
													class="blur-up lazyload" alt="">
											</a>
											
											<div class="offer-detail">
												<div>
													<a href="product-left-thumbnail.html">
														<h6 class="name">Apple Red Premium Imported</h6>
													</a>
													<span>1 KG</span>
													<h6 class="price theme-color">$ 80.00</h6>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					
						<!-- Banner Section -->
						<div class="ratio_156 pt-25">
							<div class="home-contain">
								<img src="/resources/assets/images/vegetable/banner/8.jpg"
									class="bg-img blur-up lazyload" alt="">
								<div class="home-detail p-top-left home-p-medium">
									<div>
										<h6 class="text-yellow home-banner">Seafood</h6>
										<h3 class="text-uppercase fw-normal">
											<span class="theme-color fw-bold">Freshes</span> Products
										</h3>
										<h3 class="fw-light">every hour</h3>
										<button onclick="location.href = 'shop-left-sidebar.html';"
											class="btn btn-animation btn-md fw-bold mend-auto">
											Shop Now <i class="fa-solid fa-arrow-right icon"></i>
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
	<!-- Product Left Sidebar End -->


      <!-- Releted Product Section Start -->
      <section class="product-list-section section-b-space">
         <div class="container-fluid-lg">
            <div class="title">
               <h2>Related Products</h2>
               <span class="title-leaf"> <svg class="icon-width">
                        <use
                        xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
               </span>
            </div>
            <div class="row">
               <div class="col-12">
                  <div class="slider-6_1 product-wrapper">
                     <div>
                        <div class="product-box-3 wow fadeInUp">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left.htm"> <img
                                    src="/resources/assets/images/cake/product/11.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Cake</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Chocolate Chip Cookies 250 g</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(5.0)</span>
                                 </div>
                                 <h6 class="unit">500 G</h6>
                                 <h5 class="price">
                                    <span class="theme-color">$10.25</span>
                                    <del>$12.57</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.05s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/2.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>
                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Vegetable</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Fresh Bread and Pastry Flour 200 g</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(4.0)</span>
                                 </div>
                                 <h6 class="unit">250 ml</h6>
                                 <h5 class="price">
                                    <span class="theme-color">$08.02</span>
                                    <del>$15.15</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.1s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/3.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Vegetable</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Peanut Butter Bite Premium Butter
                                       Cookies 600 g</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(2.4)</span>
                                 </div>
                                 <h6 class="unit">350 G</h6>
                                 <h5 class="price">
                                    <span class="theme-color">$04.33</span>
                                    <del>$10.36</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.15s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/4.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Snacks</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">SnackAmor Combo Pack of Jowar Stick
                                       and Jowar Chips</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(5.0)</span>
                                 </div>
                                 <h6 class="unit">570 G</h6>
                                 <h5 class="price">
                                    <span class="theme-color">$12.52</span>
                                    <del>$13.62</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.2s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/5.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Snacks</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Yumitos Chilli Sprinkled Potato Chips
                                       100 g</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(3.8)</span>
                                 </div>
                                 <h6 class="unit">100 G</h6>
                                 <h5 class="price">
                                    <span class="theme-color">$10.25</span>
                                    <del>$12.36</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.25s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/6.png"
                                    class="img-fluid blur-up lazyload" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Vegetable</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Fantasy Crunchy Choco Chip Cookies</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(4.0)</span>
                                 </div>

                                 <h6 class="unit">550 G</h6>

                                 <h5 class="price">
                                    <span class="theme-color">$14.25</span>
                                    <del>$16.57</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

                     <div>
                        <div class="product-box-3 wow fadeInUp" data-wow-delay="0.3s">
                           <div class="product-header">
                              <div class="product-image">
                                 <a href="product-left-thumbnail.html"> <img
                                    src="/resources/assets/images/cake/product/7.png"
                                    class="img-fluid" alt="">
                                 </a>

                                 <ul class="product-option">
                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="View"><a href="javascript:void(0)"
                                       data-bs-toggle="modal" data-bs-target="#view"> <i
                                          data-feather="eye"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Compare"><a href="compare.html"> <i
                                          data-feather="refresh-cw"></i>
                                    </a></li>

                                    <li data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Wishlist"><a href="wishlist.html"
                                       class="notifi-wishlist"> <i data-feather="heart"></i>
                                    </a></li>
                                 </ul>
                              </div>
                           </div>

                           <div class="product-footer">
                              <div class="product-detail">
                                 <span class="span-name">Vegetable</span> <a
                                    href="product-left-thumbnail.html">
                                    <h5 class="name">Fresh Bread and Pastry Flour 200 g</h5>
                                 </a>
                                 <div class="product-rating mt-2">
                                    <ul class="rating">
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                       <li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
                                    </ul>
                                    <span>(3.8)</span>
                                 </div>

                                 <h6 class="unit">1 Kg</h6>

                                 <h5 class="price">
                                    <span class="theme-color">$12.68</span>
                                    <del>$14.69</del>
                                 </h5>
                                 <div class="add-to-cart-box bg-white">
                                    <button class="btn btn-add-cart addcart-button">
                                       Add <span class="add-icon bg-light-gray"> <i
                                          class="fa-solid fa-plus"></i>
                                       </span>
                                    </button>
                                    <div class="cart_qty qty-box">
                                       <div class="input-group bg-white">
                                          <button type="button" class="qty-left-minus bg-gray"
                                             data-type="minus" data-field="">
                                             <i class="fa fa-minus" aria-hidden="true"></i>
                                          </button>
                                          <input class="form-control input-number qty-input"
                                             type="text" name="quantity" value="1">
                                          <button type="button" class="qty-right-plus bg-gray"
                                             data-type="plus" data-field="">
                                             <i class="fa fa-plus" aria-hidden="true"></i>
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!-- Releted Product Section End -->


   </div>

   <jsp:include page="./footer.jsp"></jsp:include>

	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">원본 이미지</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	<div class="fade-img"></div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
  
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
</body>
</html>