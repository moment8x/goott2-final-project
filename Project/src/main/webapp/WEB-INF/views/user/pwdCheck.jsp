<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dear Books</title>
<script type="text/javascript">
	function pwdCheck(){
		$.ajax({
			url : '/user/withdrawal', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			async : false,
			data : {
				password : $('#pwdCheck').val()
			},
			dataType : 'text',
			success : function(data) {
				console.log(data);
				if(data == 'success'){
					location.href='/';
				}
			},
			error : function() {
			}
		});
	}
</script>
<style type="text/css">
 .deer{
 	text-align: center;
 }
</style>
</head>
<body>
	<!-- Header Start -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Header End -->

	<!-- mobile fix menu start -->
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
						<h2>비밀번호 확인</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">비밀번호
									확인</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Fresh Vegetable Section Start -->
	<section class="fresh-vegetable-section section-lg-space">
		<div class="container-fluid-lg">
			<div class="row gx-xl-5 gy-xl-0 g-3 ratio_148_1">
				<div class="col-xl-6 col-12">




					<div class="fresh-image deer">
						<div>
							<img class="deer" src="/resources/assets/images/deer.png"
								alt="deer">
						</div>
					</div>


				</div>

				<div class="col-xl-6 col-12">
					<div class="fresh-contain p-center-left">
						<div>
							<div class="review-title">
								<h2>비밀번호 확인</h2>
							</div>

							<div class="delivery-list">
								<p class="text-content">안전한 개인정보보호를 위해 비밀번호를 입력해 주세요.</p>

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<input type="password" class="form-control" id="pwdCheck"
											name="password" placeholder="비밀번호" /> <label
											for="비밀번호">비밀번호</label>
										<div>
											<button class="btn theme-bg-color btn-md text-white"
												type="button" onclick="pwdCheck();">확인</button>
										</div>
									</div>
								</div>

								<ul class="delivery-box">
									<li>
										<div class="delivery-box">
											<div class="delivery-icon">
												<img src="/resources/assets/svg/3/leaf.svg"
													class="blur-up lazyload" alt="">
											</div>

											<div class="delivery-detail">
												<h5 class="text">
													<a href="myPage">마이페이지로</a>
												</h5>
											</div>
										</div>
									</li>

									<li>
										<div class="delivery-box">
											<div class="delivery-icon">
												<img src="/resources/assets/svg/3/leaf.svg"
													class="blur-up lazyload" alt="">
											</div>

											<div class="delivery-detail">
												<h5 class="text">
													<a href="/">메인페이지로</a>
												</h5>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Fresh Vegetable Section End -->

	<!-- Client Section Start -->

	<!-- Client Section End -->

	<!-- Team Section Start -->

	<!-- Team Section End -->

	<!-- Review Section Start -->

	<!-- Review Section End -->

	<!-- Blog Section Start -->

	<!-- Blog Section End -->

	<!-- Footer Section Start -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Footer Section End -->

	<!-- Bg overlay Start -->
	<div class="bg-overlay"></div>
	<!-- Bg overlay End -->

	<!-- latest jquery-->
	<script src="/resources/assets/js/jquery-3.6.0.min.js"></script>

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
	<script src="/resources/assets/js/slick/slick-animation.min.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>

</body>
</html>