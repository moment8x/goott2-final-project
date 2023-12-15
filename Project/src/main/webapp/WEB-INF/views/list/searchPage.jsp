<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Right Sidebar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<script>
   let checkedList = [];
   let checkedLang = [];
   let sort = "aToz";
   let page = 1;
   let totalPageCnt = 0;
$(function() {
   totalPageCnt = "${paging.totalPageCnt}";
   
   $('.key-category input[type="checkbox"]').on("change", function() {
      if($(this).prop("checked")){
         checkedList.push($(this).val());

         getProduct(checkedList,checkedLang, sort, 1);
      } else {
         if(checkedList.includes($(this).val())){
            checkedList.splice(checkedList.indexOf($(this).val()), 1);
            getProduct(checkedList,checkedLang, sort, page);
         }
      }
   });
   
   $(".pagingBtnDiv").on("click", "button" , function() {
      page = $(this).html();
      getProduct(checkedList ,checkedLang, sort, page);
      $(".pagingBtnDiv button").removeClass("clicked"); 
       $(".page-"+page).addClass("clicked");
   });
   
   $('.lang-category input[type="checkbox"]').on("change", function() {
      if($(this).prop("checked")){
         checkedLang.push($(this).val());

         getProduct(checkedList,checkedLang, sort, 1);
      } else {
         if(checkedLang.includes($(this).val())){
            checkedLang.splice(checkedLang.indexOf($(this).val()), 1);

            getProduct(checkedList,checkedLang, sort, page);
         }
      }
   });
   
   $('#dropDownUl a').on("click", function() {
      sort = $(this).attr("id");
      getProduct(checkedList ,checkedLang, sort, page);
   });
   
});
function setPagingLink() {
   for(let i = 1; i < 11; i++){
      $('.link'+i).attr("href",($(".link"+i).attr("href")+"&active="+activeClass));
   }
}

function getProduct(listCategory, listLang, sortValue, pageValue) {
   let val = getParamsVal();
   $.ajax({
      url : '/list/searchPageWithFilter',
      type : 'POST',
      data : {
         "val" : val,
         "checkedList[]" : listCategory,
         "checkedLang[]" : listLang,
         "sort" : sortValue,
         "page" : pageValue
      },
      dataType : 'json',
      async : false,
      success : function(data) {
         // 전송에 성공하면 이 콜백 함수를 실행 (data 에는 응답받은 데이터가 저장된다)
         parse(data.pList);
         makePageButton(data.paging);
      },
      error : function() {
         // 전송에 실패하면 이 콜백 함수를 실행
      }
   });
}
function getParamsVal() {
   let queryString = decodeURIComponent(window.location.search);
   let val = queryString.split("=")[1];
   return val
}
function parse(data) {
   let output = "";
   $.each(data, function(i, product) {
           output += `<div><div class="product-box-3 h-100 wow fadeInUp"><div class="product-header"><div class="product-image">`
           output += `<a href="product-left-thumbnail.html"><img src="\${product.productImage }"class="img-fluid blur-up lazyload" alt=""></a>`
            output += `<ul class="product-option">`
           output += `<li data-bs-toggle="tooltip" data-bs-placement="top" id="payModalBtn" value="\${product.productId }" title="바로 구매"> <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#view"><i data-feather="credit-card"></i></a></li>`
           output += `<li  data-bs-toggle="tooltip" data-bs-placement="top" title="장바구니" ><a href="/shoppingCart/insert?product_id='\${product.productId }"><i data-feather="shopping-cart"></i></a></li>`
         output += `<li data-bs-toggle="tooltip" data-bs-placement="top"title="Wishlist"><a href="wishlist.html"class="notifi-wishlist"> <i data-feather="heart"></i></a></li>`
         output += `</ul></div></div>`
         output += `<div class="product-footer"><div class="product-detail"><span class="span-name">Vegetable</span><a href="product-left-thumbnail.html"><h5 class="name">\${product.productName }</h5></a>`
         output += `<p class="text-content mt-1 mb-2 product-content">\${product.introductionIntro }</p>`
         output += `<div class="product-rating mt-2"><ul class="rating">`
         output += `<li><i data-feather="star" class="fill"></i></li><li><i data-feather="star" class="fill"></i></li><li><i data-feather="star" class="fill"></i></li><li><i data-feather="star" class="fill"></i></li><li><i data-feather="star"></i></li></ul><span>(4.0)</span>`
         let sellPrice = product.sellingPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         let consumerPrice = product.consumerPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
         output += `</div><h6 class="unit">\${product.pageCount }</h6><h5 class="price"><span class="theme-color"><span class="theme-color">\${sellPrice}원</span><del>\${consumerPrice}원</del></h5></div></div></div></div>`
   })
   $(".product-list-section").html(output);
   feather.replace();
}
function pagingbutton(button) {
   page = button.innerHTML;
   getProduct(checkedList ,checkedLang, sort, page);
   $(".pagingBtnDiv .page-link").removeClass("clicked"); 
    $(button).addClass("clicked");
}
function beforePaging() {
   if(page > 10){
   page = (Math.floor(page / 10)-1)* 10 + 1;
   getProduct(checkedList ,checkedLang, sort, page);
    $(".page-"+page).addClass("clicked");
   } else {
      return false;
   }
}
function afterPaging() {
   if(Math.ceil(page / 10) < (totalPageCnt/10)){
   page = Math.floor((page - 1) / 10) * 10 + 11;
   getProduct(checkedList ,checkedLang, sort, page);
    $(".page-"+page).addClass("clicked");
   } else {
      return false;
   }
}
function makePageButton(paging) {

   let output = "";
   if (paging.totalPageCnt > paging.endNumOfCurrentPagingBlock){
      for(let i = paging.startNumOfCurrentPagingBlock; i <paging.endNumOfCurrentPagingBlock+1; i++){   
         output += `<li class="page-item active">`;
         output += `<button class="page-link page-\${i}">\${i}</button>`;
         output += `</li>`;
      }
   } else {
      for(let i = paging.startNumOfCurrentPagingBlock; i <paging.totalPageCnt+1; i++){   
         output += `<li class="page-item active">`;
         output += `<button class="page-link page-\${i}">\${i}</button>`;
         output += `</li>`;
      }
   }
      $(".pagingBtnDiv").html(output);
      
}

</script>
<style>
.clicked {
   background-color: white !important;
   color: black !important;
}
</style>
<body>
<jsp:include page="../header.jsp"></jsp:include>

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
                        <h2>검색 결과</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Shop Right Sidebar</li>
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
                    <div class="left-box right-box wow fadeInUp">
                        <div class="shop-left-sidebar shop-right-sidebar">
                            <div class="back-button">
                                <h3><i class="fa-solid fa-arrow-left"></i> Back</h3>
                            </div>

                            <div class="accordion custome-accordion" id="accordionExample">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#collapseOne" aria-expanded="true"
                                            aria-controls="collapseOne">
                                            <span>Categories</span>
                                        </button>
                                    </h2>
                                    <div id="collapseOne" class="accordion-collapse collapse show"
                                        aria-labelledby="headingOne">
                                        <div class="accordion-body">
                                            <ul class="category-list custom-padding custom-height"> 
                                            <c:forEach var="category" items="${categories }" varStatus="loop">  
                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box key-category">
                                                        <input class="checkbox_animated" type="checkbox" id="categories${loop.index }" value="${category.categoryKey }">
                                                        <label class="form-check-label" for="categories${loop.index }">
                                                            <span class="name">${category.categoryName }</span>
                                                            <span class="number" style="margin-right: 10px;">${category.categoryCount }</span>
                                                        </label>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingTwo">
                                        <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseTwo"
                                            aria-expanded="false" aria-controls="collapseTwo">
                                            <span>언어별</span>
                                        </button>
                                    </h2>
                                    <div id="collapseTwo" class="accordion-collapse collapse show"
                                        aria-labelledby="headingTwo">
                                        <div class="accordion-body">
                                            <ul class="category-list custom-padding lang-category">
                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box ">
                                                        <input class="checkbox_animated" type="checkbox" id="ko" value="KOR">
                                                        <label class="form-check-label" for="ko">
                                                            <span class="name">국내 도서</span>
                                                            <span class="number">${lang[0] }</span>
                                                        </label>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox" id="en"  value="ENG">
                                                        <label class="form-check-label" for="en">
                                                            <span class="name">해외 도서</span>
                                                            <span class="number">${lang[1] }</span>
                                                        </label>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox" id="ja"  value="JAP">
                                                        <label class="form-check-label" for="ja">
                                                            <span class="name">일본 도서</span>
                                                            <span class="number">${lang[2] }</span>
                                                        </label>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingThree">
                                        <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseThree"
                                            aria-expanded="false" aria-controls="collapseThree">
                                            <span>Price</span>
                                        </button>
                                    </h2>
                                    <div id="collapseThree" class="accordion-collapse collapse show"
                                        aria-labelledby="headingThree">
                                        <div class="accordion-body">
                                            <div class="range-slider">
                                                <input type="text" class="js-range-slider" value="">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingSix">
                                        <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseSix"
                                            aria-expanded="false" aria-controls="collapseSix">
                                            <span>Rating</span>
                                        </button>
                                    </h2>
                                    <div id="collapseSix" class="accordion-collapse collapse show"
                                        aria-labelledby="headingSix">
                                        <div class="accordion-body">
                                            <ul class="category-list custom-padding">
                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox">
                                                        <div class="form-check-label">
                                                            <ul class="rating">
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                            </ul>
                                                            <span class="text-content">(5 Star)</span>
                                                        </div>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox">
                                                        <div class="form-check-label">
                                                            <ul class="rating">
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                            </ul>
                                                            <span class="text-content">(4 Star)</span>
                                                        </div>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox">
                                                        <div class="form-check-label">
                                                            <ul class="rating">
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                            </ul>
                                                            <span class="text-content">(3 Star)</span>
                                                        </div>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox">
                                                        <div class="form-check-label">
                                                            <ul class="rating">
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                            </ul>
                                                            <span class="text-content">(2 Star)</span>
                                                        </div>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox">
                                                        <div class="form-check-label">
                                                            <ul class="rating">
                                                                <li>
                                                                    <i data-feather="star" class="fill"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                                <li>
                                                                    <i data-feather="star"></i>
                                                                </li>
                                                            </ul>
                                                            <span class="text-content">(1 Star)</span>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingFour">
                                        <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseFour"
                                            aria-expanded="false" aria-controls="collapseFour">
                                            <span>Discount</span>
                                        </button>
                                    </h2>
                                    <div id="collapseFour" class="accordion-collapse collapse show"
                                        aria-labelledby="headingFour">
                                        <div class="accordion-body">
                                            <ul class="category-list custom-padding">
                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox"
                                                            id="flexCheckDefault">
                                                        <label class="form-check-label" for="flexCheckDefault">
                                                            <span class="name">upto 5%</span>
                                                            <span class="number">(06)</span>
                                                        </label>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox"
                                                            id="flexCheckDefault1">
                                                        <label class="form-check-label" for="flexCheckDefault1">
                                                            <span class="name">5% - 10%</span>
                                                            <span class="number">(08)</span>
                                                        </label>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox"
                                                            id="flexCheckDefault2">
                                                        <label class="form-check-label" for="flexCheckDefault2">
                                                            <span class="name">10% - 15%</span>
                                                            <span class="number">(10)</span>
                                                        </label>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox"
                                                            id="flexCheckDefault3">
                                                        <label class="form-check-label" for="flexCheckDefault3">
                                                            <span class="name">15% - 25%</span>
                                                            <span class="number">(14)</span>
                                                        </label>
                                                    </div>
                                                </li>

                                                <li>
                                                    <div class="form-check ps-0 m-0 category-list-box">
                                                        <input class="checkbox_animated" type="checkbox"
                                                            id="flexCheckDefault4">
                                                        <label class="form-check-label" for="flexCheckDefault4">
                                                            <span class="name">More than 25%</span>
                                                            <span class="number">(13)</span>
                                                        </label>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
                <div class="col-custome-9">
                    <div class="show-button">
                        <div class="filter-button-group mt-0">
                            <div class="filter-button d-inline-block d-lg-none">
                                <a><i class="fa-solid fa-filter"></i> Filter Menu</a>
                            </div>
                        </div>

                        <div class="top-filter-menu">
                            <div class="category-dropdown">
                                <h5 class="text-content">Sort By :</h5>
                                <div class="dropdown">
                                    <button class="dropdown-toggle" type="button" id="dropdownMenuButton1"
                                        data-bs-toggle="dropdown">
                                        <span>이름 순</span> <i class="fa-solid fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" id="dropDownUl">
                                        <li>
                                            <a class="dropdown-item" id="aToz" href="javascript:void(0)">이름 순</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" id="low" href="javascript:void(0)">낮은 가격순</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" id="high" href="javascript:void(0)">높은 가격순</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" id="pop" href="javascript:void(0)">인기순</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div
                        class="row g-sm-4 g-3 row-cols-xxl-4 row-cols-xl-3 row-cols-lg-2 row-cols-md-3 row-cols-2 product-list-section list-style">
                     <c:choose>
                        <c:when test="${products == 'notSearch' }">
                           <div class="product-box-3 h-100 wow fadeInUp" style="height:200px; align-items: center; text-align: center;"><h2>검색에 해당하는 상품이 존재하지 않습니다.</h2></div>
                        </c:when>
                        <c:otherwise>
                           <c:forEach var="product" items="${products }">
                              <div>
                            <div class="product-box-3 h-100 wow fadeInUp">
                                <div class="product-header">
                                    <div class="product-image">
                                        <a href="product-left-thumbnail.html">
                                            <img src="${product.productImage }"
                                                class="img-fluid blur-up lazyload" alt="">
                                        </a>
                                        <ul class="product-option">
                                       <li data-bs-toggle="tooltip" data-bs-placement="top" id="payModalBtn" value="${product.productId }"
                                          title="바로 구매"> <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#view"><i data-feather="credit-card"></i>
                                       </a></li>
                                          

                                    <li  data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="장바구니" ><a href="/shoppingCart/insert?product_id='${product.productId }"><i data-feather="shopping-cart"></i></a>
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
                                        <span class="span-name">Vegetable</span>
                                        <a href="product-left-thumbnail.html">
                                            <h5 class="name">${product.productName }</h5>
                                        </a>
                                        <c:choose>
                                           <c:when test="${product.introductionIntro != null }">
                                              <p class="text-content mt-1 mb-2 product-content">${product.introductionIntro }</p>
                                           </c:when>
                                        </c:choose>
                                        <div class="product-rating mt-2">
                                            <ul class="rating">
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star" class="fill"></i>
                                                </li>
                                                <li>
                                                    <i data-feather="star"></i>
                                                </li>
                                            </ul>
                                            <span>(4.0)</span>
                                        </div>
                                        <h6 class="unit">${product.pageCount }</h6>
                                        <h5 class="price"><span class="theme-color">
                                        <fmt:formatNumber value="${product.sellingPrice}" pattern="#,###원" /> 
                                        <del><fmt:formatNumber value="${product.consumerPrice}" pattern="#,###원" /></del>
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                           </c:forEach>
                        </c:otherwise>
                     </c:choose>
                        </div>
                    </div>
               
                    <nav class="custome-pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item paging-left-arrow">
                                <button class="page-link" tabindex="-1" aria-disabled="true" onclick="return beforePaging();">
                                    <i class="fa-solid fa-angles-left"></i>
                                </button>
                            </li>
                            <div class="pagingBtnDiv">
                            <c:set var="val" value="${param.val }" />
                            <c:choose>
                            <c:when test="${paging.totalPageCnt > paging.endNumOfCurrentPagingBlock }">
                               <c:forEach var="i" begin="${paging.startNumOfCurrentPagingBlock}" end="${paging.endNumOfCurrentPagingBlock }" step="1">
                                  <li class="page-item active">
                                         <button class="page-link page-${i}">${i}</button>
                                    </li>
                            </c:forEach>
                            </c:when>
                            <c:otherwise>
                               <c:forEach var="i" begin="${paging.startNumOfCurrentPagingBlock}" end="${paging.totalPageCnt }" step="1">
                                  <li class="page-item active">
                                      <button class="page-link plink${i}" >${i}</button>
                                  </li>
                               </c:forEach>
                            </c:otherwise>
                            </c:choose>
                            </div>
                            <li class="page-item paging-right-arrow">
                                <button class="page-link" onclick="return afterPaging();">
                                    <i class="fa-solid fa-angles-right"></i>
                                </button>
                            </li>
                        </ul>
                    </nav>
                </div>

                
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
                  <div class="col-lg-6" style="display: flex">
                     <div class="slider-image">
                        <img src="https://media.istockphoto.com/id/1437657408/ko/%EB%B2%A1%ED%84%B0/%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B2%A9%EB%A6%AC%EB%90%9C-%EC%88%98%EC%B1%84%ED%99%94-%EC%95%84%EA%B8%B0-%EC%82%AC%EC%8A%B4-%EA%B7%80%EC%97%AC%EC%9A%B4-%EC%82%BC%EB%A6%BC-%EB%8F%99%EB%AC%BC-%EC%86%90%EC%9C%BC%EB%A1%9C-%EA%B7%B8%EB%A6%B0-%EA%B7%B8%EB%A6%BC-%ED%82%A4%EC%A6%88-%EB%94%94%EC%9E%90%EC%9D%B8.jpg?s=1024x1024&w=is&k=20&c=U3NghfcvPpFArhj6oAg9-6iVjW4pINKHcjNHFarbEzk="
                           class="img-fluid blur-up lazyload" alt="" />
                     </div>
                     <div>
                      <c:choose>
                         <c:when test="${sessionScope.loginMember != null }">
                            <a href="/order/requestOrder?product_id="+pId+"&isLogin=Y" id="MemberLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
                         </c:when>
                         <c:otherwise>
                            <a href="" id="loginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F4BF96;" onclick="">회원 구매</button></a>
                           <a href="" id="noLoginPay"><button type="button" class="btn buttonBuyMember" style="background-color: #F9B572;" onclick="">비 회원 구매</button></a>
                         </c:otherwise>
                      </c:choose>                                    
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- Quick View Modal Box End -->
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
      <script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>
    <script src="/resources/assets/js/bootstrap/popper.min.js"></script>
</body>

</html>