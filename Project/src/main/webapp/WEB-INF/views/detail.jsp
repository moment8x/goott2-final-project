<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<link rel="stylesheet" href="/resources/assets/css/animate.min.css" />
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
	let page = 1;
	let lastPage = 1;
	let fileList = [];
	let deleteFileList = [];
	
   $(function () {
      $('.single-item').slick();
      
      $('.review-imgs').click(function (e) {
    	  let output = "";
    	  let output2 = '';
    	  let index = $(this).prev().val();
    	  let src = `<c:out value='${reviewList}'/>`;
    	  src = src.split("ReviewBoardDTO");
    	  src = src[index].split("imagesAddr=[")[1];
    	  src = src.replaceAll("]", "");
    	  src = src.replaceAll(")", "");
      	  src = src.replaceAll("thumb_", "");
      	  src = src.split(', ');
      	  if (src.length > 1) {
	      	  src.pop();
      	  }
      	  for (let i = 0; i < src.length; i++) {
      		  if (src[i] !== "") {
      			  if (i == 0) {
      			  	output += '<div class="carousel-item active">';
      			  	output2 += '<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>';
      			  } else {
      				output += '<div class="carousel-item">';
      				output2 += '<button type="button" data-bs-target="#demo" data-bs-slide-to="' + i + '"></button>';
      			  }
      			  output += "<img src='../resources/uploads" + src[i] + "'>";
      			  output += '</div>';
      		  }
      	  }
      	  
      	  $('.carousel-inner').html(output);
      	  $('.carousel-indicators').html(output2);
	  });
   
      changeStar();
      
      // 구매량 조절
      $('.qty-input').on("blur", function () {
  		  if (${product.currentQuantity} < $('.qty-input').val()) {
  			  alert("재고량(${product.currentQuantity})보다 많이 구매하실 수 없습니다.");
  			  $('.qty-input').val(1);
  		  }
  	  });
      
      // 첨부파일
      uploadFiles();
      
      // 리뷰 작성하려 할 시 검증!
      $("form").click(function(e) {
    	  console.log("이벤트 버블링...");
         if (${sessionScope.loginMember == null}) {
            if (window.confirm("회원만 리뷰 등록이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
               location.href="/login/";
            } else {
            	$("#floatingTextarea2").attr("readonly", true);
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
                  if (data) {
                	  $("#floatingTextarea2").attr("readonly", false);
                  } else {
                	  $("#floatingTextarea2").attr("readonly", true);
                  }
               }, error : function(data) {
                  $("#floatingTextarea2").attr("readonly", true);
               }
            });
         }
      });
      
      pagination();
      getBestSeller();
      
		$('#submit-btn').click(function(e) {
			let key = "insert";
			if (isValid()) {
				let sendData = {
						"productId" : "${product.productId}",
						"rating" : $('input[name=rating]:checked').val(),
						"content" : $('#floatingTextarea2').val(),
						fileList,
						deleteFileList
				}
				$.ajax({
					url : "/review/saveReview",
					type : "POST",
					contentType : "application/json",
					data : JSON.stringify(sendData),
					dataType : "JSON",
					async : false,
					success : function(data) {
						console.log(data);
						if (data != null) 
							fileList = [];
							deleteFileList = [];
							showUploadedFile(key);
							showRatingBox(data.ratingCount);
							showReview(data);
					}, error : function(data) {
					}
				});
			} else {
				alert("실패");
			}
		});
	});
	
	// rating-box 그리기
	function showRatingBox(ratingCount) {
		let output = "<ul>";
		let index = 0;
		for (let i = 0; i < 5; i++) {
			if (ratingCount[index].rating == i + 1) {
				let percent = ratingCount[index].count / ${product.participationCount} * 100;
				output += '<li><div class="rating-list"><h5>' + (i + 1) +' Star</h5><div class="progress">';
				output += '<div class="progress-bar" role="progressbar" style="width: ' + percent + '%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">'
										+ percent + '%</div>';
				output += '</div></div></li>';
				index++;
			} else {
				output += '<li><div class="rating-list"><h5>' + (i + 1) +' Star</h5><div class="progress">';
				output += '<div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">0%</div>';
				output += '</div></div></li>';
			}
		}
		output += '</ul>';
		$('.rating-box').html(output);
	}
	
	// 관련 상품 장바구니 추가
	function addCartRelated(productId) {
		$.ajax({
			url: "/shoppingCart/insert",
			type: "POST",
			data: {
				productId : productId,
				quantity : 1
			},
			dataType: "JSON",
			async: false,
			success: function(data) {
				if (data.status === "success") {
					newCart(data.cartItems);
				} else if (data.status === "exist") {
					alert("기존에 장바구니에 존재하는 상품입니다.");
					hideModal("cartModal");
				}
			}, error: function(data) {
			}
		});
	}
	
	// 베스트셀러 최신 4개
	function getBestSeller() {
		$.ajax({
			url : "/detail/bestSeller",
			type : "GET",
			dataType : "JSON",
			async : false,
			success : function(data) {
				printBestSeller(data);
			}, error : function(data) {
			}
		});
	}
	
	function printBestSeller(items) {
		output = '';
		for (let item of items) {
			let sellingPrice = item.sellingPrice;
			sellingPrice = sellingPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			output += '<li>';
			output += '<div class="offer-product">';
			output += '<a href="/detail/' + item.productId + '" class="offer-image">';
			output += '<img src="' + item.productImage + '"></a>';
			output += '<div class="offer-detail"><div>';
			output += '<a href="/detail/' + item.productId + '">';
			output += '<h6 class="name">' + item.productName + '</h6></a>';
			output += '<h6 class="price theme-color">' + sellingPrice + '원</h6></div></div></div></li>';
		}
		$('.best-seller').html(output);
	}
	
	// 페이지 이동 버튼 클릭 시 이벤트 함수
	function pagination() {
		$('.paging-btn').click(function(e) {
			page = $(this).html();
			processPage();
		});
		$('.first-btn').click(function(e) {
			page = 1;
			processPage();
		});
		$('.last-btn').click(function(e) {
			page = lastPage;
			processPage();
		});
		$('.prev-btn').click(function(e) {
			if (page % 10 === 0) {
				page = page - 10;
			} else {
				page = (page / 10) * 10 + 1
			}
			processPage();
		});
		$('.next-btn').click(function(e) {
			if (page % 10 === 0) {
				page = page + 1;
			} else {
				page = ((page / 10) + 1) * 10 + 1
			}
			processPage();
		});
	}
	
	// 페이징 처리
	function processPage() {
		let productId = "${product.productId}";
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
           showReview(data);
           paging(data.pagingInfo);
           changeStar();
           lastPage = data.pagingInfo.totalPageCnt;
        }, error: function(data) {
        }
     });
	}
	
	// 페이징 출력
	function paging(pagingInfo) {
		let output = '<nav class="custome-pagination"><ul class="pagination justify-content-center">';	// 페이징
		if (pagingInfo.pageBlockOfCurrentPage == 1) {
			output += '<li class="page-item disabled">';
			output += '<a class="first-btn page-link"><i class="fa-solid fa-angles-left"></i></a></li>';
			output += '<li class="page-item disabled">';
			output += '<a class="prev-btn page-link"><i class="fa-solid fa-chevron-left"></i></a></li>';
		} else {
			output += '<li class="page-item active">';
			output += '<a class="first-btn page-link"><i class="fa-solid fa-angles-left"></i></a></li>';
			output += '<li class="page-item active">';
			output += '<a class="prev-btn page-link"><i class="fa-solid fa-chevron-left"></i></a></li>';
		}
		if (pagingInfo.totalPagingBlockCnt > pagingInfo.endNumOfCurrentPagingBlock) {
			for (let i = pagingInfo.startNumOfCurrentPagingBlock; i <= pagingInfo.endNumOfCurrentPagingBlock; i++) {
				output += '<li class="page-item active">';
				output += '<a class="page-link paging-btn">' + i + '</a></li>';
			}
		} else {
			for (let i = pagingInfo.startNumOfCurrentPagingBlock; i <= pagingInfo.totalPageCnt; i++) {
				output += '<li class="page-item active">';
				output += '<a class="page-link paging-btn">' + i + '</a></li>';
			}
		}
		if (pagingInfo.totalPagingBlockCnt === pagingInfo.pageBlockOfCurrentPage) {
			output += '<li class="page-item disabled">';
			output += '<a class="next-btn page-link"><i class="fa-solid fa-chevron-right"></i></a></li>';
			output += '<li class="page-item disabled">';
			output += '<a class="last-btn page-link"><i class="fa-solid fa-angles-right"></i></a></li>';
		} else {
			output += '<li class="page-item active">';
			output += '<a class="next-btn page-link"><i class="fa-solid fa-chevron-right"></i></a></li>';
			output += '<li class="page-item active">';
			output += '<a class="last-btn page-link"><i class="fa-solid fa-angles-right"></i></a></li>';
		}
			
		output += "</ul></nav>";
		$('.page').html(output);
		pagination();
	}
   
	// 첨부파일 함수
	function uploadFiles() {
		$(".upFileArea").on("dragenter dragover", function(e) {
			e.preventDefault();
		});
		$(".upFileArea").on("drop", function(e) {
			e.preventDefault();
			console.log("flieList", fileList);
			let key = $(this).attr("id").split("-")[0];
			let files = e.originalEvent.dataTransfer.files;
			for (let i = 0; i < files.length; i++) {
				let form = new FormData();
				
				form.append("uploadFile", files[i]);   // 파일의 이름을 컨트롤러단의 MultipartFile 객체명과 맞춘다.
				$.ajax({
					url : "/review/uploadFile",
					type : "post",
					data : form,
					dataType : "json",
					async : false,
					processData : false,   // text데이터에 대해 쿼리스트링 처리를 하지 않겠다.  default = true
					contentType : false,   // application/x-www-form-urlencoded 처리 안함.(인코딩 하지 않음)  default = true
					success : function(data) {
						if (data != null) {
							fileList.push(data);
							showUploadedFile(key);
						}
					}, error : function(data) {
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
         let thumbFileName = $(this).prev().attr("src").split("/resources/uploads")[1].replaceAll("/", "\\");
         deleteFileList.push(thumbFileName);
         showUploadedFile(key);
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
            if (data.status === "success") {
               // 리뷰 수정 시작
               fileList = data.fileList;
               openReviewWriter(index, data.review);
               uploadFiles();
               changeStar();
               showUploadedFile("update");
            } else {
               alert("작성자만 수정 가능합니다.");
               return false;
            }
         }, error: function(data) {
         }
      });
   }
   
   // 리뷰 수정
   function openReviewWriter(index, review) {
      let content = review.content;
      content = content.replaceAll("<br/>", "\n");
      let output = "";      // 글 수정
      let output2 = "";      // 별 수정
      
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
		let rating = $('#review-' + index + ' input:radio[name="updateRating"]:checked').val();
		let content = $('#review-' + index + ' div.reply textarea').val();
		let productId = "${product.productId}";
		let sendData = {
			"postNo" : postNo,
			"rating" : rating,
			"content" : content,
			"productId" : productId,
			"page" : page,
			fileList,
			deleteFileList
		}
		$.ajax({
			url : "/review/update",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(sendData),
			dataType : "JSON",
			async : false,
			success : function(data) {
				showReview(data);
				paging(data.pagingInfo);
				showRatingBox(data.ratingCount);
				$(".this-rating").css("width", (data.product.rating * 20) + "%");
				$('.display-rating').html(data.product.rating + " / 5");
			}, error : function(data) {
			}
		});
   	}
   
   // 리뷰 수정 중 취소 시
   function updateCancel(index, postNo, author, content, rating) {
      let output = "";
            
      output += '<p>' + content;
      
      if ("${sessionScope.loginMember.memberId}" == author) {
         output += '<a onclick="updateReviewCheck(' + index + ', ' + postNo + ');">수정</a>';
         output += '<a onclick="removeReviewCheck(' + index + ', ' + postNo + ');" style="top:20px; color:#ff3535;">삭제</a>';
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
      
      let sendData = {
				fileList
	  }
	  $.ajax({
			url : "/review/refreshFile",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(fileList),
			dataType : "JSON",
			async : true,
			success : function(data) {
			}, error : function(data) {
			}
	  });
      fileList = [];
      deleteList = [];
   }
   
   // 리뷰 삭제 클릭 시
   function removeReviewCheck(index, postNo) {
      let productId = "${product.productId}";
      // 해당 리뷰 삭제 가능한지 확인 후 삭제 가능할 시 삭제..?
      $.ajax({
         url: "/review/delete",
         type: "POST",
         data: {
            "productId" : productId,
            "postNo" : postNo,
            "page" : page
         },
         dataType: "JSON",
         async: false,
         success: function(data) {
            showReview(data);
            paging(data.pagingInfo);
            showRatingBox(data.ratingCount);
         }, error: function(data) {
         }
      });
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
            output += 'data-bs-toggle="modal" data-bs-target="#imgModal" />';
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
	   if (${product.currentQuantity} > $('#qty').val()) {
	      $('#qty').val(parseInt($('#qty').val()) + 1);
	   } else {
		   alert("재고량(${product.currentQuantity})보다 높게 설정이 불가능합니다.");
	   }
   }
   function minusQTY() {
      if ($('#qty').val() > 1) {
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
            if (data.status === "success") {
               newCart(data.cartItems);
            } else if (data.status === "exist") {
               alert("기존에 장바구니에 존재하는 상품입니다.");
               hideModal("cartModal");
            }
         }, error: function(data) {
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
	function showUploadedFile(key) {
		let output = "";
		let deleteList = [];
		for (let deleteData of deleteFileList) {
			deleteList.push(deleteData.split("thumb_")[1]);
		}
		for (let data of fileList){
			let newFileName = data.newFileName;
			newFileName = newFileName.substring(newFileName.lastIndexOf("\\") + 1);
			if (deleteList.includes(newFileName) === false) {
				let name = data.thumbnailFileName.replace("\\", "/");
				output += `<span><img src='../resources/uploads\${name}'/><i class="fa-solid fa-circle-xmark u-img" style="color: #fc1d1d;"></i></span>`;
			}
		}
		if (key === "insert") {
			$('#insert-uploadFiles').html(output);
		} else if (key === "update") {
			$('#update-uploadFiles').html(output);
		}
		uploadFileDelete();
	}
	
	// 모달 종료
	function hideModal(id) {
		document.body.style.overflow = "unset";
		$(".modal-backdrop").remove();
		$("#" + id).hide();
	}
	
	// 페이지 나갈 시
	window.onbeforeunload = function (e) {
		let sendData = {
				fileList
		}
		$.ajax({
			url : "/review/refreshFile",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(fileList),
			dataType : "JSON",
			async : true,
			success : function(data) {
			}, error : function(data) {
			}
		});
		//window.navigator.sendBeacon('/review/refreshFile');
	};
	
	// form버튼으로 페이지 이동 시
	$(document).on("submit", "form", function (e) {
		window.onbeforeunload = null;
	});
</script>
   
<style type="text/css">
	.upFileArea {
	   width: 100%;
	   height: 200px;
	   border: 1px solid black;
	}
	.rating {
		position : relative;
		width : 86.75px;
		padding : 0;
	}
	.rating-fill {
		position : absolute;
		padding : 0;
		z-index : 99;
		display : flex;
		top : 0;
		left : 0;
		overflow : hidden;
	}
	.rating-base {
		z-index : 1;
		padding : 0;
		position : absolute;
		top : 0;
		left : 0;
		display : flex;
	}
	.star-rating input{
	   display: none;
	}
	textarea {
	   resize: none;
	}
	.carousel-item > img {
		width: 100%;
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
      <div class="container-fluid-lg container-main" style="padding: 0 !important;">
         <div class="row">
            <div class="col-xxl-9 col-xl-8 col-lg-7 wow fadeInUp">
               <div class="row g-4">
                  <div class="col-xl-6 wow fadeInUp">
                     <div class="product-left-box">
                        <div class="row g-2">
                           <div class="col-xxl-10 col-lg-12 col-md-10 order-xxl-2 order-lg-1 order-md-2">
                              <div class="single-item">
                                 <c:choose>
                                    <c:when test="${productImages.size() > 0}">
                                       <!-- 이미지 슬라이더 추가 -->
                                          <c:forEach var="productImage" items="${productImages }">
                                             <div class="product-image">
                                                   <img src="${productImage.productImage}" alt="${product.productName }">
                                                </div>
                                          </c:forEach>
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
                     </div>
                     
                     <div class="col-xl-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="right-box-contain">
                           <h2 class="name">${product.productName}</h2>
                           <div class="price-rating">
                            <h3 class="theme-color price"><fmt:formatNumber value="${product.sellingPrice}" pattern="#,###" />원
                                 <del class="text-content"><fmt:formatNumber value="${product.consumerPrice}" pattern="#,###" />원</del>
                                 <span class="offer theme-color">(10% off)</span>
                              </h3>
                              <div class="product-rating custom-rate">
								<div class="rating">
									<ul class="rating-base">
	                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
	                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
	                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
	                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
	                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
									</ul>
									<ul class="rating-fill this-rating" style="width : ${product.rating * 20}%">
	                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
	                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li> 
	                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
	                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
										<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
	                                </ul>
								</div>
								<span class="review">${product.participationCount}개의 리뷰</span>
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
                                      class="btn btn-md bg-dark cart-button text-white w-80" data-bs-toggle="modal" data-bs-target="#cartModal">장바구니</button>
                                   <button onclick="buy();"
                                      class="btn btn-md bg-dark cart-button text-white w-80">바로구매</button>
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
                                                      <h4 class="fw-500">구매 후기</h4>
                                                   </div>
                                                   
                                                   <div class="d-flex">
                                                      <div class="product-rating">
                                                         <div class="rating">
															<ul class="rating-base">
							                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
							                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
							                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
							                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
							                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
															</ul>
															<ul class="rating-fill this-rating" style="width : ${product.rating * 20}%">
							                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
							                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li> 
							                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
							                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
																<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
							                                </ul>
														</div>
                                                      </div>
                                                      <h6 class="display-rating ms-3">${product.rating} / 5</h6>
                                                   </div>
                                                   
                                                   <div class="rating-box">
                                                      <ul>
                                                      	<c:set var="i" value="0"/>
                                                      	<c:forEach begin="1" end="5" step="1" varStatus="status">
                                                      		<c:choose>
                                                      			<c:when test="${ratingCount[i].rating == status.count}">
                                                      				<li>
                                                      					<div class="rating-list">
                                                      						<h5>${status.count} Star</h5>
                                                      						<div class="progress">
                                                      							<div class="progress-bar" role="progressbar"
																				style="width: ${product.participationCount > 0 ? (ratingCount[i].count / product.participationCount * 100) : 0}%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">${ratingCount[i].count / product.participationCount * 100}%</div>
																			</div>
																		</div>
																	</li>
																	<c:set var="i" value="${i + 1}"/>
                                                      			</c:when>
                                                      			<c:otherwise>
                                                      				<li>
                                                      					<div class="rating-list">
                                                      						<h5>${status.count} Star</h5>
                                                      						<div class="progress">
                                                      							<div class="progress-bar" role="progressbar"
																				style="width: 0%" aria-valuenow="100"
																				aria-valuemin="0" aria-valuemax="100">0%</div>
																			</div>
																		</div>
																	</li>
                                                      			</c:otherwise>
                                                      		</c:choose>
                                                      	</c:forEach>
                                                      </ul>
                                                   </div>
                                                </div>
                                                
                                                <div class="col-xl-6">
                                                   <div class="review-title">
                                                      <h4 class="fw-500">리뷰 쓰기</h4>
                                                   </div>
                                                   
                                                   <form id="review-form">
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
                                                              <label for="floatingTextarea2">내용을 작성해주세요.</label>
                                                           </div>
                                                        </div>
                                                         
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
                                                               <button class="btn" type="button" id="submit-btn" style="background-color: #198754; color: #fff;">리뷰 달기</button>
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
                                                                              data-bs-toggle="modal" data-bs-target="#imgModal" />
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
                                                      
                                                      <div class="page">
                                                         <!-- 페이징 -->
                                                         <nav class="custome-pagination">
	                                                         <ul class="pagination justify-content-center">
	                                                         	<!-- arrow btn -->
	                                                         	<c:choose>
	                                                         		<c:when test="${pagingInfo.pageBlockOfCurrentPage == 1}">
	                                                         			<li class="page-item disabled">
	                                                         				<a class="first-btn page-link"><i class="fa-solid fa-angles-left"></i></a>
	                                                         			</li>
	                                                         			<li class="page-item disabled">
	                                                         				<a class="prev-btn page-link"><i class="fa-solid fa-chevron-left"></i></a>
	                                                         			</li>
	                                                         		</c:when>
	                                                         		<c:otherwise>
	                                                         			<li class="page-item active">
	                                                         				<a class="first-btn page-link"><i class="fa-solid fa-angles-left"></i></a>
	                                                         			</li>
	                                                         			<li class="page-item active">
	                                                         				<a type="button" class="prev-btn page-link"><i class="fa-solid fa-chevron-left"></i></a>
	                                                         			</li>
	                                                         		</c:otherwise>
	                                                         	</c:choose>
	                                                         	<!-- 번호 btn -->
	                                                         	<c:choose>
	                                                         		<c:when test="${pagingInfo.totalPagingBlockCnt > paingInfo.endNumOfCurrentPagingBlock}">
	                                                         			<c:forEach var="i" begin="${pagingInfo.startNumOfCurrentPagingBlock}" end="${pagingInfo.endNumOfCurrentPagingBlock}" step="1">
	                                                         				<li class="page-item active">
	                                                         					<a class="page-link paging-btn">${i}</a>
	                                                         				</li>
	                                                         			</c:forEach>
	                                                         		</c:when>
	                                                         		<c:otherwise>
	                                                         			<c:forEach var="i" begin="${pagingInfo.startNumOfCurrentPagingBlock}" end="${pagingInfo.totalPageCnt }" step="1">
	                                                         				<li class="page-item active">
	                                                         					<a class="page-link paging-btn">${i}</a>
	                                                         				</li>
	                                                         			</c:forEach>
	                                                         		</c:otherwise>
	                                                         	</c:choose>
	                                                         	<!-- arrow btn -->
	                                                         	<c:choose>
	                                                         		<c:when test="${pagingInfo.totalPagingBlockCnt == pagingInfo.pageBlockOfCurrentPage}">
	                                                         			<li class="page-item disabled">
	                                                         				<a class="next-btn page-link"><i class="fa-solid fa-chevron-right"></i></a>
	                                                         			</li>
	                                                         			<li class="page-item disabled">
	                                                         				<a class="last-btn page-link"><i class="fa-solid fa-angles-right"></i></a>
	                                                         			</li>
	                                                         		</c:when>
	                                                         		<c:otherwise>
	                                                         			<li class="page-item active">
	                                                         				<a class="next-btn page-link"><i class="fa-solid fa-chevron-right"></i></a>
	                                                         			</li>
	                                                         			<li class="page-item active">
	                                                         				<a class="last-btn page-link"><i class="fa-solid fa-angles-right"></i></a>
	                                                         			</li>
	                                                         		</c:otherwise>
	                                                         	</c:choose>
	                                                         </ul>
                                                         </nav>
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
                     <div class="vendor-list">
                        <ul>
                           <li>
                              <div class="address-contact">
                                 <i data-feather="map-pin"></i>
                                 <h5>
                                    주소: 
                                    <span class="text-content">구로디지털단지 구트아카데미 306</span>
                                 </h5>
                              </div>
                           </li>
                           <li>
                              <div class="address-contact">
                                 <i data-feather="headphones"></i>
                                 <h5>
                                    연락처: 
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
                        <h3>베스트 셀러</h3>
                        <ul class="product-list product-right-sidebar border-0 p-0 best-seller"></ul>
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
               <h2>관련 도서</h2>
               <span class="title-leaf"> <svg class="icon-width">
                        <use xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                    </svg>
               </span>
            </div>
            <div class="row">
               <div class="col-12">
                  <div class="slider-6_1 product-wrapper">
                     <c:forEach var="item" items="${related}">
	                     <div>
	                        <div class="product-box-3 wow fadeInUp">
	                           <div class="product-header">
	                              <div class="product-image">
	                                 <a href="/detail/${item.productId}"> <img
	                                    src="${item.productImage}"
	                                    class="img-fluid blur-up lazyload" alt="">
	                                 </a>
	                              </div>
	                           </div>
	
	                           <div class="product-footer">
	                              <div class="product-detail">
	                                 <span class="span-name">${item.category}</span> <a
	                                    href="/detail/${item.productId}">
	                                    <h5 class="name">${item.productName}</h5>
	                                 </a>
	                                 <div class="product-rating mt-2">
	                                    <div class="rating">
											<ul class="rating-base">
			                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
			                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
			                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
			                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
			                                 	<li><i class="fa-regular fa-star" style="color: #feb221;"></i></li>
											</ul>
											<ul class="rating-fill" style="width : ${item.rating * 20}%">
			                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
			                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li> 
			                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
			                                    <li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
												<li><i class="fa-solid fa-star" style="color: #feb221;"></i></li>
			                                </ul>
										</div>
	                                    <span>(${item.rating})</span>
	                                 </div>
	                                 <h6 class="unit"></h6>
	                                 <h5 class="price">
	                                    <span class="theme-color"><fmt:formatNumber value="${item.sellingPrice}" pattern="#,###" />원</span>
	                                    <del><fmt:formatNumber value="${item.consumerPrice}" pattern="#,###" />원</del>
	                                 </h5>
	                                 <div class="add-to-cart-box bg-white">
 	                                    <button class="btn btn-add-cart addcart-button" data-bs-toggle="modal" data-bs-target="#cartModal"
 	                                    	onclick="addCartRelated('${item.productId}');">
 	                                    	Add
 	                                    	<span class="add-icon bg-light-gray"> <i class="fa-solid fa-plus"></i></span>
	                                    </button>
	                                    <div class="cart_qty qty-box">
	                                       <div class="input-group bg-white">
	                                          <button type="button" class="qty-left-minus bg-gray"
	                                             data-type="minus" data-field="">
	                                             <i class="fa fa-minus" aria-hidden="true"></i>
	                                          </button>
	                                          <!-- <input class="form-control input-number qty-input"
	                                             type="text" name="quantity" value="1"> -->
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
                     </c:forEach>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!-- Releted Product Section End -->


   </div>

   <jsp:include page="./footer.jsp"></jsp:include>
   
	<!-- The Modal -->
	<div class="modal" id="imgModal">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">이미지 상세보기</h4>
					<button type="button" style="border:none" onclick="hideModal('imgModal')">X</button>
				</div>
				<div class="modal-body">
					<!-- Carousel -->
					<div id="demo" class="carousel" data-bs-ride="carousel">
						<!-- Indicators/dots -->
						<div class="carousel-indicators">
							<!-- <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
							<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
							<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button> -->
						</div>

						<!-- The slideshow/carousel -->
						<div class="carousel-inner">
							<!-- <div class="carousel-item"></div> -->
						</div>
					</div>
					<div class="container-fluid mt-3"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
								onclick="hideModal('imgModal');"data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- The Modal -->
	<div class="modal" id="cartModal">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">장바구니 저장 완료</h4>
					<button type="button" style="border:none" onclick="hideModal('cartModal')">X</button>
				</div>
				<div class="modal-body">
					장바구니 페이지로 이동하시겠습니까?
				</div>	
					
				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="location.href='/shoppingCart/shoppingCart'">예</button>
					<button type="button" class="btn btn-default"
							onclick="hideModal('cartModal');"data-dismiss="modal">아니요</button>
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