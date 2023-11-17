<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dear Books</title>
<script type="text/javascript">
	
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
                        <h2>회원탈퇴</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">회원 탈퇴</li>
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
                                <h2>탈퇴하시겠습니까?</h2>
                            </div>

                            <div class="delivery-list">
                                <p class="text-content">
                                	회원 아이디에 대해서는 서비스 이용의 혼선 방지, 법령에서 규정하는 회원 거래 정보의 보존 기간 동안의 보관 의무의 이행, 
                                	기타 안정적인 서비스 제공을 위하여 필요한 정보이므로 탈퇴 후 동일 아이디로의 재가입은 허용되지 않습니다.
                                </p>

                                <ul class="delivery-box">
                                    <li>
                                        <div class="delivery-box">
                                            <div class="delivery-icon">
                                                <img src="/resources/assets/svg/3/leaf.svg" class="blur-up lazyload" alt="">
                                            </div>

                                            <div class="delivery-detail">
                                                <h5 class="text"><a href="myPage">마이페이지로</a></h5>
                                            </div>
                                        </div>
                                    </li>

                                <!--     <li>
                                        <div class="delivery-box">
                                            <div class="delivery-icon">
                                                <img src="/resources/assets/svg/3/leaf.svg" class="blur-up lazyload" alt="">
                                            </div>

                                            <div class="delivery-detail">
                                                <h5 class="text"><a href="#">포인트/적립금/쿠폰 확인하러 가기</a></h5>
                                            </div>
                                        </div>
                                    </li> -->

                                    <li>
                                        <div class="delivery-box">
                                            <div class="delivery-icon">
                                                <img src="/resources/assets/svg/3/leaf.svg" class="blur-up lazyload" alt="">
                                            </div>

                                            <div class="delivery-detail">
                                                <h5 class="text"><a href="/">메인페이지로</a></h5>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li>
                                    	<button class="btn btn-animation ms-xxl-auto mt-xxl-0 mt-3 btn-md fw-bold withdrawalBtn" 
                                    		onclick="location.href='pwdCheck';">
			                              탈퇴
			                            </button>
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