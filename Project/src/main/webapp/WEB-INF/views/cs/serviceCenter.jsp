<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>FAQ</title>

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
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
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
	<section class="faq-breadscrumb pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>고객센터</h2>
						<p>무엇을 도와드릴까요? 디어북스 고객센터입니다.</p>
						<div class="faq-form-tag">
							<div class="input-group">
								<i class="fa-solid fa-magnifying-glass"></i> <input
									type="search" class="form-control"
									id="exampleFormControlInput1" placeholder="name@example.com">
								<div class="dropdown">
									<button class="btn btn-md faq-dropdown-button dropdown-toggle"
										type="button" id="dropdownMenuButton1"
										data-bs-toggle="dropdown">
										All Product <i class="fa-solid fa-angle-down ms-2"></i>
									</button>
									<ul class="dropdown-menu faq-dropdown-menu dropdown-menu-end">
										<li><a class="dropdown-item" href="#">Action</a></li>
										<li><a class="dropdown-item" href="#">Another action</a></li>
										<li><a class="dropdown-item" href="#">Something else
												here</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Faq Question section Start -->
	<section class="faq-contain">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="slider-4-2 product-wrapper">
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/start.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>자주 묻는 질문</h3>
									<p>Bring to the table win-win survival strategies to ensure
										proactive domination.</p>
								</div>
							</div>
						</div>
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/price.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>공지사항</h3>
									<p>Curabitizzle fizzle break yo neck, yall quis fo shizzle
										mah nizzle fo rizzle.</p>
								</div>
							</div>
						</div>
						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/help.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3><a href="/cs/makeInquiry">1:1 문의접수</a></h3>
									<p>Lorizzle ipsizzle boom shackalack sit get down get down.</p>
								</div>
							</div>
						</div>

						<div>
							<div class="faq-top-box">
								<div class="faq-box-icon">
									<img src="/resources/assets/images/inner-page/faq/contact.png"
										class="blur-up lazyload" alt="">
								</div>

								<div class="faq-box-contain">
									<h3>
										<a href="/cs/viewInquiry">1:1 문의내역</a>
									</h3>
									<p>Gizzle fo shizzle bow wow wow bizzle leo bibendizzle
										check out this.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Faq Question section End -->

	<!-- Faq Section Start -->
	<section class="faq-box-contain section-b-space">
		<div class="container">
			<div class="row">
				<div class="col-xl-5">
					<div class="faq-contain">
						<h2>Frequently Asked Questions</h2>
						<p>
							We are answering most frequent questions. No worries if you not
							find exact one. You can find out more by searching or continuing
							clicking button below or directly <a href="contact-us.html"
								class="theme-color text-decoration-underline">contact our
								support.</a>
						</p>
					</div>
				</div>

				<div class="col-xl-7">
					<div class="faq-accordion">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										What is Fastkart and why was the name changed? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>Fastkart is leading the charge in transforming India’s
											vast, unorganised grocery landscape through cutting-edge
											technology and innovation. Blinkit is India’s largest and
											most convenient hyper-local delivery company, which enables
											you to order grocery, fruits & vegetables, and other daily
											essential products, directly via your mobile or web browser.</p>

										<p>
											To know the reason why we changed our brand name from Grofers
											to Fastkart, read this <span class="fw-bold">blog
												post.</span>
										</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										How to remove the impurities of Graphene oxide? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>Discover, Explore & Understanding The Product
											Description Maecenas ullamcorper eros libero, facilisis
											tempor mi dapibus vel. Sed ut felis ligula. Pellentesque
											vestibulum, tellus id euismod aliquet, justo velit tincidunt
											justo, nec pulvinar tortor elit vitae urna.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										How long will delivery take? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>Discover, Explore & Understanding The Product
											Description Maecenas ullamcorper eros libero, facilisis
											tempor mi dapibus vel. Sed ut felis ligula. Pellentesque
											vestibulum, tellus id euismod aliquet, justo velit tincidunt
											justo, nec pulvinar tortor elit vitae urna.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFour">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFour"
										aria-expanded="true" aria-controls="collapseFour">
										How do I find my Windows Product key? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse"
									aria-labelledby="headingFour"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>The product key is located inside the product
											packaging, on the receipt or confirmation page for a digital
											purchase or in a confirmation e-mail that shows you purchased
											Windows. If you purchased a digital copy from Microsoft
											Store, you can locate your product key in your Account under
											Digital Content.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFive">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFive"
										aria-expanded="false" aria-controls="collapseFive">
										I've downloaded an ISO file, now what? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseFive" class="accordion-collapse collapse"
									aria-labelledby="headingFive"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>You can use the ISO file to create bootable media for
											installation or recovery. You can also install Windows on
											your current device by opening the ISO file, selecting the
											Setup and following the instructions.</p>

										<p>To create bootable media such as a bootable USB drive
											or DVD, you will need an ISO burning or mounting software. We
											recommend always using a blank USB or blank DVD because
											contents may be deleted when creating a bootable image.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSix">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseSix"
										aria-expanded="false" aria-controls="collapseSix">
										What's the difference between 32-bit and 64-bit versions of
										Windows? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseSix" class="accordion-collapse collapse"
									aria-labelledby="headingSix" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>The terms 32-bit and 64-bit refer to the way a
											computer's processor (also called a CPU) handles information.
											The 64-bit version of Windows handles large amounts of random
											access memory (RAM) more effectively than a 32-bit system.
											Not all devices can run the 64-bit versions of Windows.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSeven">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseSeven"
										aria-expanded="true" aria-controls="collapseSeven">
										Questionnaire on online shopping behavior during COVID-19. <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseSeven" class="accordion-collapse collapse"
									aria-labelledby="headingSeven"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>Fastkart is leading the charge in transforming India’s
											vast, unorganised grocery landscape through cutting-edge
											technology and innovation. Blinkit is India’s largest and
											most convenient hyper-local delivery company, which enables
											you to order grocery, fruits & vegetables, and other daily
											essential products, directly via your mobile or web browser.</p>

										<p>
											To know the reason why we changed our brand name from Grofers
											to Fastkart, read this <span class="fw-bold">blog
												post.</span>
										</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingEight">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseEight"
										aria-expanded="false" aria-controls="collapseEight">
										How Can I Get More Attention From Customers? <i
											class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseEight" class="accordion-collapse collapse"
									aria-labelledby="headingEight"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>There are many variations of passages of Lorem Ipsum
											available, but the majority have suffered alteration in some
											form, by injected humour, or randomised words which don't
											look even slightly believable. If you are going to use a
											passage of Lorem Ipsum, you need to be sure there isn't
											anything embarrassing hidden in the middle of text.</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingNine">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseNine"
										aria-expanded="false" aria-controls="collapseNine">
										What is payment method? <i class="fa-solid fa-angle-down"></i>
									</button>
								</h2>
								<div id="collapseNine" class="accordion-collapse collapse"
									aria-labelledby="headingNine"
									data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<p>simply dummy text of the printing and typesetting
											industry. Lorem Ipsum has been the industry's standard dummy
											text ever since the 1500s, when an unknown printer took a
											galley of type and scrambled it to make a type specimen book.
											It has survived not only five centuries, but also the leap
											into electronic typesetting, remaining essentially unchanged.
											It was popularised in the 1960s with the release of Letraset
											sheets containing Lorem Ipsum passages, and more recently
											with desktop publishing software like Aldus PageMaker
											including versions of Lorem Ipsum</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Faq Section End -->
	<!-- Location Modal Start -->
	<div class="modal location-modal fade theme-modal" id="locationModal"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Choose your
						Delivery Location</h5>
					<p class="mt-1 text-content">Enter your address and we will
						specify the offer for your area.</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="location-list">
						<div class="search-input">
							<input type="search" class="form-control"
								placeholder="Search Your Area"> <i
								class="fa-solid fa-magnifying-glass"></i>
						</div>

						<div class="disabled-box">
							<h6>Select a Location</h6>
						</div>

						<ul class="location-select custom-height">
							<li><a href="javascript:void(0)">
									<h6>Alabama</h6> <span>Min: $130</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Arizona</h6> <span>Min: $150</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>California</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Colorado</h6> <span>Min: $140</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Florida</h6> <span>Min: $160</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Georgia</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Kansas</h6> <span>Min: $170</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Minnesota</h6> <span>Min: $120</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>New York</h6> <span>Min: $110</span>
							</a></li>

							<li><a href="javascript:void(0)">
									<h6>Washington</h6> <span>Min: $130</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Location Modal End -->

	<!-- Deal Box Modal Start -->
	<div class="modal fade theme-modal deal-modal" id="deal-box"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<div>
						<h5 class="modal-title w-100" id="deal_today">Deal Today</h5>
						<p class="mt-1 text-content">Recommended deals for you.</p>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="deal-offer-box">
						<ul class="deal-offer-list">
							<li class="list-1">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/10.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-2">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/11.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-3">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/12.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>

							<li class="list-1">
								<div class="deal-offer-contain">
									<a href="shop-left-sidebar.html" class="deal-image"> <img
										src="/resources/assets/images/vegetable/product/13.png"
										class="blur-up lazyload" alt="">
									</a> <a href="shop-left-sidebar.html" class="deal-contain">
										<h5>Blended Instant Coffee 50 g Buy 1 Get 1 Free</h5>
										<h6>
											$52.57
											<del>57.62</del>
											<span>500 G</span>
										</h6>
									</a>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Deal Box Modal End -->

	<!-- Tap to top start -->
	<div class="theme-option">
		<div class="back-to-top">
			<a id="back-to-top" href="#"> <i class="fas fa-chevron-up"></i>
			</a>
		</div>
	</div>
	<!-- Tap to top end -->

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
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>


	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>