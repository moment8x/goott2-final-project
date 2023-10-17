<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>

	<section class="blog spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-5">
					<div class="blog__sidebar">

						<div class="blog__sidebar__item">
							<ul class="nav flex-column">
								<li class="nav-item"><a class="nav-link" href="orderList">주문내역</a></li>
							</ul>

							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
									href="#">회원</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="userInfo">회원정보</a></li>
										<li><a class="dropdown-item" href="address">배송주소록</a></li>
									</ul></li>
							</ul>
							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
									href="#">활동내역</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#">찜</a></li>
										<li><a class="dropdown-item" href="#">작성한 리뷰</a></li>
										<li><a class="dropdown-item" href="#">포인트</a></li>
										<li><a class="dropdown-item" href="#">적립금</a></li>
										<li><a class="dropdown-item" href="#">쿠폰</a></li>
										<li><a class="dropdown-item" href="#">1:1 문의 내역</a></li>
									</ul></li>
							</ul>

						</div>
					</div>
				</div>


				<div class="col-sm-8">
						<div class="checkout__form">
                <h4>비밀번호 확인</h4>
                <form action="userInfoModify" method="post">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="checkout__input">
                            <p>안전한 개인정보 보호를 위해 비밀번호를 입력해 주세요.</p>
                                <p>비밀번호<span>*</span></p>
                                <input type="password">
                            </div>
                            <div>
                            	<button type="submit" class="site-btn" >확인</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
				</div>
			</div>
		</div>

	</section>


	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>