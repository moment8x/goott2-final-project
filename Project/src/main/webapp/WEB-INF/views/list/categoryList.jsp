<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/assets/css/animate.min.css" />
<title>Insert title here</title>
<script src="https://unpkg.com/feather-icons"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".grid-option ul li").on("click", function() {
			let clickedClass = $(this).attr("class").split("active")[0];
			useState(clickedClass);
		});

		$('#payModalBtn').on("click", function() {
			let pId = $(this).attr("value");
			console.log("pid" + pId)
			$.ajax({
				url : '/list/isLogin',
				type : 'GET',
				dataType : 'json',
				async : false,
				success : function(data) {
					payLink(data, pId);

				},
				error : function() {
					// 전송에 실패하면 이 콜백 함수를 실행
				}
			});
		});

		$('.dropdown-item').on("click", function(evt) {
			let sortBy = $(this).attr('id');
			let key = "${key}"
			$.ajax({
				url : '/list/sort' + "?key=" + key + "&sortBy=" + sortBy,
				type : 'GET',
				dataType : 'json',
				async : false,
				success : function(data) {
					// 전송에 성공하면 이 콜백 함수를 실행 (data 에는 응답받은 데이터가 저장된다)
					parse(data);
				},
				error : function() {
					// 전송에 실패하면 이 콜백 함수를 실행
				}
			});
		});

		insertSort();
		changeGrid();
	});

	function payLink(data, pId) {
		if (data.isLogin == "loginOK") {
			$('#memberLoginPay').attr("href", "/order/requestOrder?productId=" + pId + "&isLogin=Y&qty=1");
		} else {
			$('#loginPay').attr("href", "/login/");
			$('#noLoginPay').attr("href", "/order/requestOrder?productId=" + pId + "&isLogin=N&qty=1");
		}
	}

	function parse(data) {
		$.each(data.listProduct, function(i, product) {
			if(product.productImage != null){
			$('#pImage' + (i+1)).attr("src",product.productImage);				
			} else {
				$('#pImage' + (i + 1)).attr("src",
						"/resources/assets/images/deer.png");
			}
			$('#publisher' + (i+1)).html(product.publisher);
			$('#pName'+ (i+1)).html(product.productName);
			$('#pIntro'+ (i+1)).html(product.introductionDetail);
			$('#page' + (i+1)).html(product.pageCount+"p");
			$('#sPrice'+ (i+1)).html(product.sellingPrice.toLocaleString()+"원");
			$('#cPrice'+ (i+1)).html(product.consumerPrice.toLocaleString()+"원");
		})

	}

	function insertSort() {
		let sortBy = "${sortBy}";
		switch (sortBy) {
		case "new":
			$('#sort').html("최신순");
			break;
		case "sell":
			$('#sort').html("판매순");
			break;
		case "high":
			$('#sort').html("높은 가격순");
			break;
		case "low":
			$('#sort').html("낮은 가격순");
			break;
		}
	}
	

	function changeGrid() {
		console.log("${active}");
		let active = "${active}";
		$("." + active).attr("class", (active + " active"));
	}

	function useState(active) {
		let activeClass = active;

		for (let i = 1; i < 11; i++) {
			$('.link' + i).attr("href",
					($(".link" + i).attr("href") + "&active=" + activeClass));
		}
	}
	function shoppingcart(pId) {
		$.ajax({
			url : '/shoppingCart/insert',
			type : 'POST',
			data : {
				"productId" : pId,
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				// 전송에 성공하면 이 콜백 함수를 실행 (data 에는 응답받은 데이터가 저장된다)
				openShoppingModal(data);
				newCart(data.cartItems);
			},
			error : function() {
				// 전송에 실패하면 이 콜백 함수를 실행
			}
		});
	}

	function openShoppingModal(data) {
		if (data.status == 'success') {
			$(".modal-body").html("저장에 성공하셨습니다.");
			$("#shoppingCartModal").show();
		} else if (data.status == 'exist') {
			$(".modal-body").html("이미 저장된 상품입니다.");
			$("#shoppingCartModal").show();
		} else if (data.status == "fails") {
			$(".modal-body").html("저장에 실패하셨습니다.");
			$("#shoppingCartModal").show();
		}
	}

	function shoppingClose() {
		$("#shoppingCartModal").hide();
	}

	//-----------------------------------------------------------민정 --------------------------------------------------------------
	function likeDisLike(productId) {
		let likeDislikeId = $(`#\${productId}`);
		let member = '${sessionScope.loginMember.memberId}'
		if (member == "") {
			alert("로그인이 필요한 서비스 입니다.");
			location.href = '/login/';
		} else if (likeDislikeId.hasClass("fa-regular")) {
			likeDislikeId.removeClass("fa-regular").addClass("fa-solid");
			console.log(productId + "좋아요")

			$.ajax({
				url : '/wish/likeProduct',
				type : 'POST',
				data : {
					"productId" : productId,
				},
				dataType : 'text',
				async : false,
				success : function(data) {
					console.log(data)

				},
				error : function(error) {

				}
			});

		} else if (likeDislikeId.hasClass("fa-solid")) {
			likeDislikeId.removeClass("fa-solid").addClass("fa-regular");
			console.log(productId + "싫어요")

			$.ajax({
				url : '/wish/disLikeProduct',
				type : 'POST',
				data : {
					"productId" : productId,
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					console.log(productId + " 좋아요")

				},
				error : function() {
					// 전송에 실패하면 이 콜백 함수를 실행
				}
			});
		}
	}
	//--------------------------------------------------------민정 끝-----------------------------------------------------------------
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- mobile fix menu start  -->
	<div class="mobile-menu d-md-none d-block mobile-cart">
		<ul>
			<li class="active"><a href="index.html"> <i
					class="iconly-Home icli"></i> <span>Home</span>
			</a></li>

			<li class="mobile-category"><a href="javascript:void(0)"> <i
					class="iconly-Category icli js-link"></i> <span>Category</span>
			</a></li>

			<li><a href="search.html" class="search-box"> <i
					class="iconly-Search icli"></i> <span>Search</span>
			</a></li>

			<li><a href="wishlist.html" class="notifi-wishlist"> <i
					class="iconly-Heart icli"></i> <span>My Wish</span>
			</a></li>

			<li><a href="cart.html"> <i
					class="iconly-Bag-2 icli fly-cate"></i> <span>Cart</span>
			</a></li>
		</ul>
	</div>
	<!-- mobile fix menu end -->

	<!-- Breadcrumb Section Start -->
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>${nowCategory.categoryName }</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page"><a
									href="/list/category/${categoryLang.categoryKey }">${categoryLang.categoryName }</a></li>
								<li class="breadcrumb-item active" aria-current="page">${nowCategory.categoryName }</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shop Section Start -->
	<section class="section-b-space shop-section">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-custome-3">
					<div class="left-box wow fadeInUp">
						<div class="shop-left-sidebar">
							<ul class="nav nav-pills mb-3 custom-nav-tab" id="pills-tab"
								role="tablist">
								<c:forEach var="category" items="${productCategory }"
									varStatus="loop">
									<li class="nav-item" role="presentation">
										<button class="nav-link active" id="pills-vegetables"
											data-bs-toggle="pill" data-bs-target="#pills-vegetable"
											type="button" role="tab" aria-selected="true"
											onclick="location.href='/list/categoryList/${category.categoryKey }'"
											id="${loop.index }">
											${category.categoryName }<img
												src="/resources/assets/images/books.png"
												class="blur-up lazyload" alt="">
										</button>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-custome-9">
					<div class="show-button">
						<div class="filter-button d-inline-block d-lg-none">
							<a><i class="fa-solid fa-filter"></i> Filter Menu</a>
						</div>

						<div class="top-filter-menu">
							<div class="category-dropdown">
								<h5 class="text-content">Sort By :</h5>
								<div class="dropdown">
									<button class="dropdown-toggle" type="button"
										id="dropdownMenuButton1" data-bs-toggle="dropdown">
										<span id="sort">최신순</span> <i class="fa-solid fa-angle-down"></i>
									</button>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
										<li><a class="dropdown-item" id="new">최신순</a></li>
										<li><a class="dropdown-item" id="sell">판매량순</a></li>
										<li><a class="dropdown-item" id="high">높은 가격순</a></li>
										<li><a class="dropdown-item" id="low">낮은 가격순</a></li>
									</ul>
								</div>
							</div>

							<div class="grid-option d-none d-md-block">
								<ul>
									<li class="three-grid"><a href="javascript:void(0)"> <img
											src="/resources/assets/svg/grid-3.svg"
											class="blur-up lazyload" alt="">
									</a></li>
									<li class="grid-btn d-xxl-inline-block d-none"><a
										href="javascript:void(0)"> <img
											src="/resources/assets/svg/grid-4.svg"
											class="blur-up lazyload d-lg-inline-block d-none" alt="">
											<img src="/resources/assets/svg/grid.svg"
											class="blur-up lazyload img-fluid d-lg-none d-inline-block"
											alt="">
									</a></li>
									<li class="list-btn"><a href="javascript:void(0)"> <img
											src="/resources/assets/svg/list.svg" class="blur-up lazyload"
											alt="">
									</a></li>
								</ul>
							</div>
						</div>
					</div>

					<div
						class="row g-sm-4 g-3 row-cols-xxl-4 row-cols-xl-3 row-cols-lg-2 row-cols-md-3 row-cols-2 product-list-section">
						<c:choose>
							<c:when test="${products != null }">
								<c:forEach var="product" items="${products }" varStatus="loop">
									<div>
										<div class="product-box-3 h-100 wow fadeInUp">
											<div class="product-header">
												<div class="product-image">
												<c:choose>
												<c:when test="${product.productImage != null}">
													<a href="/detail/${product.productId}"> <img id="pImage${loop.index + 1 }"
														src="${product.productImage}"
														class="img-fluid blur-up lazyload" alt="">
													</a>
													</c:when>
													<c:otherwise>
													<a href="/detail/${product.productId}"> <img id="pImage${loop.index + 1 }"
														src="/resources/assets/images/deer.png"
														class="img-fluid blur-up lazyload" alt="">
													</a>
													</c:otherwise>
													</c:choose>
													
													<ul class="product-option">
															<li data-bs-toggle="tooltip" data-bs-placement="top" id="payModalBtn" value="${product.productId }"
															title="바로 구매"> <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#view"><i data-feather="credit-card"></i>
															</a></li>
														

														<li  data-bs-toggle="tooltip" data-bs-placement="top"
															title="장바구니" ><a href="javascript:void(0)" onclick="shoppingcart('${product.productId}');"><i data-feather="shopping-cart"></i></a>
														</li>
														
														<c:set var="shouldRender" value="true" />
														<c:forEach var="wish" items="${wishlist }">
															<c:set var="productId" value="${product.productId }"></c:set>
															<c:set var="wishProduct" value="${wish.productId}"></c:set>

															<c:choose>
																<c:when
																	test="${sessionScope.loginMember.memberId != '' && productId eq wishProduct}">
																	<c:set var="shouldRender" value="false" />
																	<li data-bs-toggle="tooltip" data-bs-placement="top"
																		value="${product.productId }" title="찜 삭제"><a
																		href="javascript:void(0)"
																		class="notifi-wishlist likeProduct"> <i
																			id="${product.productId}" class="fa-solid fa-heart"
																			style="color: #ff007b;"
																			onclick="likeDisLike('${product.productId}');"></i>
																	</a></li>
																</c:when>
															</c:choose>
														</c:forEach>

														<c:if test="${shouldRender}">
															<li data-bs-toggle="tooltip" data-bs-placement="top"
																value="${product.productId }" title="찜"><a
																href="javascript:void(0)" class="notifi-wishlist"> <i
																	id="${product.productId}" class="fa-regular fa-heart"
																	style="color: #ff007b;"
																	onclick="likeDisLike('${product.productId}');"></i>
															</a></li>
														</c:if>


													</ul>
												</div>
											</div>
											<div class="product-footer">
													<a href="/detail/${product.productId }">
												<div class="product-detail">
													<span class="span-name" id="publisher${loop.index + 1 }">${product.publisher }</span>
														<h5 class="name" id="pName${loop.index + 1 }">${product.productName }</h5>													
													<p class="text-content mt-1 mb-2 product-content" id="pIntro${loop.index + 1 }">${product.introductionDetail }</p>
													<div class="product-rating mt-2">
														<!-- 나중에 리뷰 보고 만들기 -->
														<ul class="rating">
															<li><i data-feather="star" class="fill"></i></li>
															<li><i data-feather="star" class="fill"></i></li>
															<li><i data-feather="star" class="fill"></i></li>
															<li><i data-feather="star" class="fill"></i></li>
															<li><i data-feather="star"></i></li>
														</ul>
														<span>(4.0)</span>
													</div>
													<h6 class="unit" id="page${loop.index + 1 }">${product.pageCount }p</h6>
													<h5 class="price">
														<span class="theme-color" id="sPrice${loop.index + 1 }"><fmt:formatNumber
																value="${product.sellingPrice}" pattern="#,###원" /></span>
														<del id="cPrice${loop.index + 1 }">
															<fmt:formatNumber value="${product.consumerPrice}"
																pattern="#,###원" />
														</del>
													</h5>
													<div class="add-to-cart-box bg-white"></div>
												</div>
												</a>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
					<nav class="custome-pagination">
						<ul class="pagination justify-content-center">
							<li class="page-item">
							<c:if test="${pagingInfo.pageNo > 10 }">
								<a class="page-link" href="/list/categoryList/${key }?page=${pagingInfo.startNumOfCurrentPagingBlock - 10}" >
									<i class="fa-solid fa-angles-left"></i>
								</a>
							</c:if>
							</li>
							<c:choose>
								<c:when
									test="${pagingInfo.totalPageCnt > pagingInfo.endNumOfCurrentPagingBlock }">
									<c:forEach var="i"
										begin="${pagingInfo.startNumOfCurrentPagingBlock}"
										end="${pagingInfo.endNumOfCurrentPagingBlock }" step="1">
										<li class="page-item active"><a class="page-link link${i}"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i"
										begin="${pagingInfo.startNumOfCurrentPagingBlock}"
										end="${pagingInfo.totalPageCnt }" step="1">
										<li class="page-item active"><a class="page-link"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<li class="page-item">
							<c:if test="${pagingInfo.totalPageCnt > pagingInfo.endNumOfCurrentPagingBlock}">
								<a class="page-link" href="/list/categoryList/${key }?page=${pagingInfo.startNumOfCurrentPagingBlock + 10}">
								<i class="fa-solid fa-angles-right"></i>
								</a>
							</c:if>
							</li>
						</ul>
					</nav>
				</div>
			</div>
	</section>
	<!-- Shop Section End -->

	
	<!-- The Modal -->
	<div class="modal fade" id="view" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">Modal Heading</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        <div>
				<c:choose>
					<c:when test="${sessionScope.loginMember != null }">
						<a href="" id="memberLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
					</c:when>
					<c:otherwise>
						<a href="" id="loginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
						<a href="" id="noLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F9B572;" onclick="">비 회원 구매</button></a>
					</c:otherwise>
				</c:choose>												
			</div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>

	<div class="modal" id="shoppingCartModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Modal Heading</h4>
					<button type="button" class="btn-close" onclick="shoppingClose()"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">Modal body..</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="shoppingClose()">Close</button>
				</div>

			</div>
		</div>
	</div>


	<!-- Price Range Js -->
	<script src="/resources/assets/js/ion.rangeSlider.min.js"></script>

	<!-- sidebar open js -->
	<script src="/resources/assets/js/filter-sidebar.js"></script>


	<!-- WOW js -->
	<script src="/resources/assets/js/wow.min.js"></script>
	<script src="/resources/assets/js/custom-wow.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>


	<jsp:include page="../footer.jsp"></jsp:include>

    <script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>
    <script src="/resources/assets/js/bootstrap/popper.min.js"></script>


</body>
</html>