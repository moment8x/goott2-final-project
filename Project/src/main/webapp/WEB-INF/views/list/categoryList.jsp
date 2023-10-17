<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- 임시 제이쿼리 -->
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		let view = "${sort}";
		let sort = "${view}";
		let queryString = "view=" + view + "&sort="+sort;
		
		$(".filter__option").on("click", function() {
			let cliked = $(event.target);
			if(cliked.hasClass("icon_grid-2x2")){
				$('.grid_list').show();
				$('.list-group').hide();
				view = "grid";
			} else {
				$('.grid_list').hide();
				$('.list-group').show();
				view = "list";
			}
			
			queryString = "view=" + view + "&sort="+sort;
			
		})
		
		$(".filter__sort").on("change", function() {
			let changed = $(".vi")
			console.log(changed + "!!!!");
			$.ajax({
			    url: '/list/categoryList/'+"${key }",
			    type: 'GET',
			    data: queryString,
			    dataType: 'json',
			    async:false,
			    succes: function(data){
			        // 전송에 성공하면 이 콜백 함수를 실행 (data 에는 응답받은 데이터가 저장된다)
			    },
			    error: function(){
			        // 전송에 실패하면 이 콜백 함수를 실행
			    }
			});
		});
	});
</script>
<style type="text/css">
.product__pagination{
	position: relative;
	left: 400px;
}

.categories_button{
	font-size: 24px;
}
.list-group-item.product {
    display: flex;
    align-items: center;
}

.list-group-item img {
	width: 140px;
	height: 201.594px;
}

.categories_button {
	display: flex;
	flex-direction : column;
	position: absolute;
    top: 50%; /* 세로 중앙 정렬 */
    right: 0; /* 오른쪽 끝에 배치 */
    transform: translateY(-50%); /* 세로 중앙 정렬을 위해 음수 값으로 translateY 사용 */
    margin-right: 30px; 
}
.sidebar__item a{
	text-decoration: none;
}
.product__item__text a{
	text-decoration: none;
}
.list-group-item a{
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-5">
					<div class="sidebar">
						<div class="sidebar__item">
							<c:choose>
								<c:when
									test="${beforeCategory.category_key == 'KOR' || beforeCategory.category_key == 'ENG' || beforeCategory.category_key == 'JAP' }">
									<a href="../category/${beforeCategory.category_key }">
										<h4>
											<img width="30" height="25" src="https://img.icons8.com/ios-glyphs/30/back.png"
												alt="back" />${beforeCategory.category_name}</h4>
									</a>
								</c:when>
								<c:otherwise>
									<a href="../categoryList/${beforeCategory.category_key }">
										<h4>
											<img width="30" height="25"
												src="https://img.icons8.com/ios-glyphs/30/back.png"
												alt="back" />${beforeCategory.category_name}</h4>
									</a>
								</c:otherwise>
							</c:choose>

							<ul>
								<c:choose>
									<c:when test="${productCategory != 'fail'}">
										<c:forEach var="category" items="${productCategory}">
											<li><a href="../categoryList/${category.category_key }">${category.category_name}</a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<h1>1</h1>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
					</div>
				</div>
				<!-- 상품 목록 리스트 -->
				<div class="col-lg-9 col-md-7">
					<div class="product__discount">
						<div class="section-title product__discount__title">
							<h2>${nowCategory.category_name }</h2>
						</div>
						
					</div>
					<div class="filter__item">
						<div class="row">
							<div class="col-lg-4 col-md-5">
								<div class="filter__sort">
									<span>Sort By</span> <select>
										<option value="latest">최신순</option>
										<option value="sales">판매량순</option>
										<option value="hprice">높은가격순</option>
										<option value="rprice">낮은가격순</option>
									</select>
								</div>
							</div>
							<div class="col-lg-4 col-md-4">
								<div class="filter__found">
									<h6>
										<span>16</span> Products found
									</h6>
								</div>
							</div>
							<div class="col-lg-4 col-md-3">
								<div class="filter__option">
									<span class="icon_grid-2x2"></span> <span class="icon_ul"></span>
								</div>
							</div>
						</div>
					</div>
						<!-- 보여주기 방식 1 grid -->
					<div class="row grid_list">
						<c:forEach var="product" items="${products }">
							<div class="col-lg-4 col-md-6 col-sm-6">
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" ="${product_iamge}">
	                                    <ul class="product__item__pic__hover">
	                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
	                                        <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
	                                    </ul>
	                                </div>
	                                <div class="product__item__text">
	                                    <h6><a href="#">${product.product_name }</a></h6>
	                                    <span>
											<fmt:formatNumber value="${product.selling_price}" pattern="#,###원"/>
										</span>
										<del>
											<span>
												<fmt:formatNumber value="${product.consumer_price}" pattern="#,###원"/>
											</span>
										</del>
	                                </div>
	                            </div>
	                        </div>
						</c:forEach>
                    </div>    
						<!-- 보여주기 방식 2 ul -->
						<div class="container mt-3">
							<div class="list-group" style="display:none;">
								<c:forEach var="product" items="${products }">
									<div class="list-group-item product">
										<div class="book_image">
											<a href="../detail/"+${product.product_id}> 
												<c:choose>
													<c:when test="${product.product_image ne ''}">
														<img src="${product.product_image}"
															alt="${product.product_name }">
													</c:when>
													<c:otherwise>
														<img src="../../../resources/img/product/product-1.jpg">
													</c:otherwise>
												</c:choose>
											</a>
										</div>
										<div class="book_intro">
											<a href="../detail/"+${product.product_id}>
												<div class="pName">${product.product_name }</div>
											</a>
											<div class="author">
												<div>${product.original_author }</div>
												<span>${product.publication_date }</span>
											</div>
											<div class="consumer_price">
												<span>
												    <fmt:formatNumber value="${product.selling_price}" pattern="#,###원"/>
												</span>
												<span>
												    <fmt:formatNumber value="${product.consumer_price}" pattern="#,###원"/>
												</span>
											</div>
											<div>
												<span>${product.page_count }p</span>
											</div>
										</div>
										<div class="categories_button">
											<a href="#"><i class="fa fa-heart"></i></a>
	                                     	<a href="#"><i class="fa fa-shopping-cart"></i></a>
	                                     </div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div>`${queryString }`!!!!!!!!!!!!!!!!!</div>
					<div class="product__pagination">
						<c:if test="${paging_info.pageNo > 1}">					
							<a href="/list/categoryList/${key }?page=${paging_info.pageNo - 1}&${queryString}"><i class="fa fa-long-arrow-left"></i></a>
						</c:if>
						<c:choose>
						<c:when test="${paging_info.totalPagingBlockCnt > paging_info.endNumOfCurrentPagingBlock }">
							<c:forEach var="i" begin="${paging_info.startNumOfCurrentPagingBlock}" end="${paging_info.endNumOfCurrentPagingBlock }" step="1">
								<a href="/list/categoryList/${key }?page=${i}">${i}</a> 
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="${paging_info.startNumOfCurrentPagingBlock}" end="${paging_info.totalPagingBlockCnt }" step="1">
								<a href="/list/categoryList/${key }?page=${i}&${queryString}">${i}</a> 
							</c:forEach>
						</c:otherwise>
						</c:choose>
						<c:if test="${paging_info.pageNo < paging_info.totalPageCnt }">					
							<a href="/list/categoryList/${key }?page=${paging_info.pageNo + 1}"><i class="fa fa-long-arrow-right"></i></a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>