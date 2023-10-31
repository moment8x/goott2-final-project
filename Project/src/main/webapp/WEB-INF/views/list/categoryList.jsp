<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	})

	function parse(data) {
		console.log(data);
		$.each(data.list_product, function(i, product) {
			console.log(i);
			if(product.product_image != null){
			$('#pImage' + (i+1)).attr("src",product.product_image);				
			} else {
				$('#pImage' + (i+1)).attr("src","/resources/assets/images/deer.png");
			}
			$('#publisher' + (i+1)).html(product.publisher);
			$('#pName'+ (i+1)).html(product.product_name);
			$('#pIntro'+ (i+1)).html(product.introduction_detail);
			$('#page' + (i+1)).html(product.page_count+"p");
			$('#sPrice'+ (i+1)).html(product.selling_price.toLocaleString()+"원");
			$('#cPrice'+ (i+1)).html(product.consumer_price.toLocaleString()+"원");
		console.log($('#pImage' + (i+1)).attr("src"));
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
						<h2>${nowCategory.category_name }</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page"><a
									href="/list/category/${categoryLang.category_key }">${categoryLang.category_name }</a></li>
								<li class="breadcrumb-item active" aria-current="page">${nowCategory.category_name }</li>
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
											onclick="location.href='/list/categoryList/${category.category_key }'"
											id="${loop.index }">
											${category.category_name }<img
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
									<li class="grid-btn d-xxl-inline-block d-none active"><a
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
												<c:when test="${product.product_image != null}">
													<a href="/detail/${product.product_id}"> <img id="pImage${loop.index + 1 }"
														src="${product.product_image}"
														class="img-fluid blur-up lazyload" alt="">
													</a>
													</c:when>
													<c:otherwise>
													<a href="/detail/${product.product_id}"> <img id="pImage${loop.index + 1 }"
														src="/resources/assets/images/deer.png"
														class="img-fluid blur-up lazyload" alt="">
													</a>
													</c:otherwise>
													</c:choose>
													<ul class="product-option">
														
															<li data-bs-toggle="tooltip" data-bs-placement="top"
															title="바로 구매"><a href="/order/requestOrder?product_id='${product.product_id }'"><i data-feather="credit-card"></i>
															</a></li>
														

														<li  data-bs-toggle="tooltip" data-bs-placement="top"
															title="장바구니" ><a href="/shoppingCart/insert?product_id='${product.product_id }"><i data-feather="shopping-cart"></i></a>
														</li>

														<li data-bs-toggle="tooltip" data-bs-placement="top"
															title="Wishlist"><a href="wishlist.html"
															class="notifi-wishlist"> <i data-feather="heart"></i>
														</a></li>
													</ul>
												</div>
											</div>
											<div class="product-footer">
												<div class="product-detail">
													<span class="span-name" id="publisher${loop.index + 1 }">${product.publisher }</span> <a
														href="product-left-thumbnail.html">
														<h5 class="name" id="pName${loop.index + 1 }">${product.product_name }</h5>
													</a>
													<p class="text-content mt-1 mb-2 product-content" id="pIntro${loop.index + 1 }">${product.introduction_detail }</p>
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
													<h6 class="unit" id="page${loop.index + 1 }">${product.page_count }p</h6>
													<h5 class="price">
														<span class="theme-color" id="sPrice${loop.index + 1 }"><fmt:formatNumber
																value="${product.selling_price}" pattern="#,###원" /></span>
														<del id="cPrice${loop.index + 1 }">
															<fmt:formatNumber value="${product.consumer_price}"
																pattern="#,###원" />
														</del>
													</h5>
													<div class="add-to-cart-box bg-white"></div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
					<nav class="custome-pagination">
						<ul class="pagination justify-content-center">
							<li class="page-item disabled"><a class="page-link"
								href="javascript:void(0)" tabindex="-1" aria-disabled="true">
									<i class="fa-solid fa-angles-left"></i>
							</a></li>
							<c:choose>
								<c:when
									test="${paging_info.totalPagingBlockCnt > paging_info.endNumOfCurrentPagingBlock }">
									<c:forEach var="i"
										begin="${paging_info.startNumOfCurrentPagingBlock}"
										end="${paging_info.endNumOfCurrentPagingBlock }" step="1">
										<li class="page-item active"><a class="page-link"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i"
										begin="${paging_info.startNumOfCurrentPagingBlock}"
										end="${paging_info.totalPagingBlockCnt }" step="1">
										<li class="page-item active"><a class="page-link"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<li class="page-item"><a class="page-link"
								href="javascript:void(0)"> <i
									class="fa-solid fa-angles-right"></i>
							</a></li>
						</ul>
					</nav>
				</div>
			</div>
	</section>
	<!-- Shop Section End -->

	<!-- Quick View Modal Box Start -->
	<div class="modal fade theme-modal view-modal" id="view" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-xl modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header p-0">
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-sm-4 g-2">
						<div class="col-lg-6">
							<div class="slider-image">
								<img src="/resources/assets/images/product/category/1.jpg"
									class="img-fluid blur-up lazyload" alt="" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Quick View Modal Box End -->

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


</body>
</html>