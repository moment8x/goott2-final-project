<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Fastkart">
    <meta name="keywords" content="Fastkart">
    <meta name="author" content="Fastkart">
    <link rel="icon" href="/resources/assets/images/favicon/1.png" type="image/x-icon">
    <title>Cart</title>

    <!-- Google font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">

    <!-- bootstrap css -->
    <link id="rtl-link" rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/bootstrap.css">

    <!-- font-awesome css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/font-awesome.css">

    <!-- feather icon css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/feather-icon.css">

    <!-- slick css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/slick/slick.css">
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/vendors/slick/slick-theme.css">

    <!-- Iconly css -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/bulk-style.css">

    <!-- Template css -->
    <link id="color-link" rel="stylesheet" type="text/css" href="/resources/assets/css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script>
		let buyInfo = [];
		let isFirst = true;
		let isLogin = "N";
		
		$(function () {
			// 받아 온 장바구니 정보 출력
			spreadView();
			
			if(isLogin != "N") {
			isLogin = "Y";
			}
			console.log(isLogin);
		});
		
		// 선택된 항목 삭제.
		function delCheckedItem() {
			let items = [];
			$("input[name='check_item']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
				items.push($(this).val());
			});
			console.log(items);
			$.ajax({
				url: "/shoppingCart/items",
				type:"POST",
				data:{
					'items':items
				},
				dataType: "json",
				async: false,
				success:function(data) {
					spreadView();
				}, error:function(data) {
					console.log("error");
				}
			});
		}
		
		// 장바구니 목록 불러오기
		function getShoppingCart() {
			let result = null;
			$.ajax({
				url : "/shoppingCart/all",
				type : "GET",
				dataType : "json",
				async : false,
				success : function(data) {
					result = data;
				}, error : function() {
					console.log("help!me!");
				}
			});
			return result;
		}
		
		// 장바구니 내역 화면에 출력
		function spreadView() {
			let data = getShoppingCart();
			let output = "";
			let output2 = "";
			let output3 = "";
			let subtotal = 0;
			let total = 0;
			if (data.status === "success") {
				let items = data.items;
				isLogin = data.isLogin;
				$.each(items, function(i, item) {
					let qty = data.list.list[i].quantity;
					output += `<tr class="product-box-contain">`;
					output += `<td class="product-detail">`;
					output += `<div class="product border-0">`;
					output += `<a href="#" class="product-image"><img src="\${item.productImage}" class="img-fluid blur-up lazyload" alt="\${item.productName}"/></a>`;
					output += `<div class="product-detail">`;
					output += `<ul>`;
					output += `<li class="name"><a href="#">\${item.productName}</a></li>`;
					output += `<li class="text-content"><span class="text-title">Sold By:</span> Fresho</li>`;
					output += `<li class="text-content"><span class="text-title">Quantity</span> - 500 g</li>`;
					output += `<li><h5 class="text-content d-inline-block">Price :</h5>`;
					output += `<span>&#8361;\${item.sellingPrice}</span>`;
					output += `<span class="text-content">&#8361;\${item.consumerPrice}</span></li>`;
					output += `<li><h5 class="saving theme-color">Saving : &#8361;\${item.consumerPrice - item.sellingPrice}</h5></li>`;
					output += `<li class="quantity-price-box">`;
					output += `<div class="cart_qty">`;
					output += `<div class="input-group">`;
					output += `<button type="button" class="btn qty-left-minus" data-type="minus" data-field="">`;
					output += `<i class="fa fa-minus ms-0" aria-hidden="true"></i></button>`;
					output += `<input class="form-control input-number qty-input" type="text" name="quantity" value="0"/>`;
					output += `<button type="button" class="btn qty-right-plus" data-type="plus" data-field="">`;
					output += `<i class="fa fa-plus ms-0" aria-hidden="true"></i></button>`;
					output += `</div></div></li>`;
					output += `<li><h5>Total: $35.10</h5></li></ul></div></div></td>`;
					// 가격
					output += `<td class="price"><h4 class="table-title text-content">Price</h4>`;
					output += `<h5>&#8361;\${item.sellingPrice} <del class="text-content">&#8361;\${item.consumerPrice}</del></h5>`;
					output += `<h6 class="theme-color">You Save : &#8361;\${item.consumerPrice - item.sellingPrice}</h6></td>`;
					// QTY
					if (item.currentQuantity >  0) {
						output += `<td class="quantity"><h4 class="table-title text-content">Qty</h4>`;
						output += `<div class="quantity-price"><div class="cart_qty"><div class="input-group">`;
						output += `<button type="button" class="btn qty-left-minus" onclick="qtyMinus('\${item.productId}', '\${item.sellingPrice}');">`;
						output += `<i class="fa fa-minus ms-0" aria-hidden="true"></i></button>`;
						output += `<input class="form-control input-number qty-input quantity" id="\${item.productId}" type="text" name="quantity" value="\${qty}">`;
						output += `<button type="button" class="btn qty-right-plus" onclick="qtyPlus('\${item.productId}', '\${item.sellingPrice}', '\${item.currentQuantity}');">`;
						output += `<i class="fa fa-plus ms-0" aria-hidden="true"></i></button></div></div></div></td>`;
					} else {
						output += `<td class="quantity"><h4 class="table-title text-content">Qty</h4>`;
						output += `<div class="quantity-price"><div class="cart_qty"><div class="input-group">`;
						output += `<button type="button" class="btn qty-left-minus" onclick="qtyMinus('\${item.productId}', '\${item.sellingPrice}');" disabled>`;
						output += `<i class="fa fa-minus ms-0" aria-hidden="true"></i></button>`;
						output += `<input class="form-control input-number qty-input" id="\${item.productId}" type="text" name="quantity" value="품절" onchange="renewTotal('\${item.productId}', '\${item.sellingPrice}');" disabled>`;
						output += `<button type="button" class="btn qty-right-plus" onclick="qtyPlus('\${item.productId}', '\${item.sellingPrice}', '\${item.currentQuantity}');" disabled>`;
						output += `<i class="fa fa-plus ms-0" aria-hidden="true"></i></button></div></div></div></td>`;
					}
					// 해당 아이템 최종 가격
					output += `<td class="subtotal"><h4 class="table-title text-content">Total</h4>`;
					output += `<h5 id="\${'total' + item.productId}" class="subtotal calc_total">&#8361;\${item.sellingPrice * item.quantity}</h5></td>`;
					// ???
					output += `<td class="save-remove"><h4 class="table-title text-content">Action</h4>`;
					output += `<a class="save notifi-wishlist" href="javascript:void(0)">Save for later</a>`;
					output += `<button class="remove close_button" onclick="deleteItem(this);" value="\${item.productId}">Remove</button></td></tr>`;
					
					// 아오 ㅠㅠ
					if (item.currentQuantity > 0) {
						buyInfo.push({
							productId : item.productId,
							quantity : qty
						})
					}
					
					subtotal += item.sellingPrice * qty;
					buy();
				});
				
				total = subtotal + 3000;
				
				output2 += '<div class="coupon-cart"><h6 class="text-content mb-2">Coupon Apply</h6>';
				output2 += '<div class="mb-3 coupon-box input-group">';
				output2 += '<input type="email" class="form-control" id="exampleFormControlInput1" placeholder="Enter Coupon Code Here...">';
				output2 += '<button class="btn-apply">Apply</button></div></div>';
				output2 += `<ul><li><h4>Subtotal</h4><h4 class="price" id="subtotal">&#8361;` + addComma(subtotal) + `</h4></li>`;
				output2 += '<li><h4>Coupon Discount</h4><h4 class="price">(-) 0.00</h4></li>';
				output2 += '<li class="align-items-start"><h4>Shipping</h4><h4 class="price text-end" id="shipping">&#8361;3,000</h4>';
				output2 += '</li></ul>';
				
			} else if (data.status === "none") {
				output += `<div>등록된 상품이 없습니다.</div>`;
				output += `<div><button>로그인 하기</button></div>`;
			}
			
			console.log(output2);
			
			output3 += '<li class="list-total border-top-0"><h4>Total (USD)</h4>';
			output3 += '<h4 class="price theme-color" id="total_amount">&#8361;' + addComma(total) + '</h4></li>';
			
			$('.tbody').html(output);
			$('.summery-contain').html(output2);
			$('.summery-total').html(output3);
		}
		
		// 결제 form 갱신
		function buy() {
			let output = "";
			for (let i = 0; i < buyInfo.length; i++) {
				output += `<input type="hidden" name="productId" value="\${buyInfo[i].productId}">`;
				output += `<input type="hidden" name="productQuantity" value="\${buyInfo[i].quantity}">`;
				output += `<input type='hidden' name="fromCart" value="Y">`;
				output += `<input type='hidden' name="isLogin" value="\${isLogin}">`;
				
				$('.move-payment').html(output);
			}
			$('.move-payment').html(output);
		}
		
		// 숫자 3자리마다 콤마 찍어주기
		function addComma(dataValue) {
			return Number(dataValue).toLocaleString('en');
		}
		
		// 원화표시 삭제 및 콤마 삭제
		function digitize(prod) {
			$('#total' + prod).html($('#total' + prod).html().substr(1));	// 원화표시 삭제
			$('#subtotal').html($('#subtotal').html().substr(1));
			// 콤마가 있다면
			if($('#total' + prod).html().indexOf(",") != -1){
				$('#total' + prod).html($('#total' + prod).html().replace(/(,)/g, "")); // 콤마를 ""로 replace함
				$('#subtotal').html($('#subtotal').html().replace(/(,)/g, ""));
			}
		}
		function digitizeNormal(price) {
			price = price.substr(1);
			
			if(price.indexOf(",") != -1){
				price = price.replace(/(,)/g, "");
			}
			return price;
		}
		
		// QTY +
		function qtyPlus(prod, price, stock) {
			if (parseInt($('#' + prod).val()) < stock) {
				digitize(prod);
				$('#' + prod).val(Number($('#' + prod).val()) + 1);
				$('#total' + prod).html("&#8361;" + addComma(price * $('#' + prod).val()));
				
				$.each(buyInfo, function(i, info) {
					if (info.productId === prod) {
						info.quantity = $('#' + prod).val();
					}
				});
				
				updateQTY(prod ,$('#' + prod).val());
				subtotal();
				totalAmount();
				buy();
			}
		}
		// QTY -
		function qtyMinus(prod, price) {
			if ($('#' + prod).val() > 0) {
				digitize(prod);
				$('#' + prod).val($('#' + prod).val() - 1);
				$('#total' + prod).html("&#8361;" + addComma(price * $('#' + prod).val()));
				
				$.each(buyInfo, function(i, info) {
					if (info.productId === prod) {
						info.quantity = $('#' + prod).val();
					}
				});
				
				updateQTY(prod ,$('#' + prod).val());
				subtotal();
				totalAmount();
				buy();
			}
		}
		
		// QTY값 DB에 변경
		// (productId, qty)
		function updateQTY(productId, quantity) {
			$.ajax({
				url: "/shoppingCart/updateQTY",
				type: "POST",
				data: {
					"productId" : productId,
					"quantity" : quantity
				},
				dataType: "JSON",
				async: false,
				success: function(data) {
					console.log(data);
				}, error: function(data) {
					console.log(data);
				}
			});
		}
		
		// 구매액(subtotal)
		function subtotal() {
			let sum = 0;
			
			for (let i = 0; i < $('h5.subtotal').length; i++) {
				let temp = document.getElementsByClassName('calc_total')[i].innerHTML;
				temp = digitizeNormal(temp);
				sum += Number(temp);
			}
			$('#subtotal').html("&#8361;" + addComma(sum));
		}
		
		// 총 결제액(total amount)
		function totalAmount() {
			let subtotal = $('#subtotal').html();
			let shippingPay = $('#shipping').html();
			subtotal = Number(digitizeNormal(subtotal));
			shippingPay = Number(digitizeNormal(shippingPay));
			
			$('#total_amount').html("&#8361;" + addComma(subtotal + shippingPay));
		}
		
		// 단일 아이템 삭제
		function deleteItem(elt) {
			let productId = elt.value;
			console.log("elt : ", elt);
			console.log("elt.value : ", elt.value);
			$.ajax({
				url : "/shoppingCart/" + productId,
				type : "DELETE",
				data : {
					"productId" : productId
				},
				dataType : "json",
				async : false,
				success : function(data) {
					console.log(data);
					if (data.status == "success") {
						spreadView();
					}
				}, error : function() {
					console.log("help!me!");
				}
			});
		}
	</script>
	<style>
		.shopping-cart-attr {
			display: flex;
		}
		.shopping-cart-box {
			display: flex;
		}
		.shopping-cart-list {
			display: flex;
		}
		.shopping-cart-list li {
			list-style-type: none;
			margin: 5px;
		}
	</style>
</head>
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
                        <h2>Cart</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Cart</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Cart Section Start -->
    <section class="cart-section section-b-space">
        <div class="container-fluid-lg">
            <div class="row g-sm-5 g-3">
                <div class="col-xxl-9">
                    <div class="cart-table">
                        <div class="table-responsive-xl">
                            <table class="table">
                                <tbody class="tbody">
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-xxl-3">
                    <div class="summery-box p-sticky">
                        <div class="summery-header">
                            <h3>Cart Total</h3>
                        </div>

                        <div class="summery-contain">
                            <!-- <div class="coupon-cart">
                                <h6 class="text-content mb-2">Coupon Apply</h6>
                                <div class="mb-3 coupon-box input-group">
                                    <input type="email" class="form-control" id="exampleFormControlInput1"
                                        placeholder="Enter Coupon Code Here...">
                                    <button class="btn-apply">Apply</button>
                                </div>
                            </div>
                            <ul>
                                <li>
                                    <h4>Subtotal</h4>
                                    <h4 class="price" id="subtotal">&#8361;---</h4>
                                </li>

                                <li>
                                    <h4>Coupon Discount</h4>
                                    <h4 class="price">(-) 0.00</h4>
                                </li>

                                <li class="align-items-start">
                                    <h4>Shipping</h4>
                                    <h4 class="price text-end" id="shipping">&#8361;3,000</h4>
                                </li>
                            </ul> -->
                        </div>

                        <ul class="summery-total">
                            <!-- <li class="list-total border-top-0">
                                <h4>Total (USD)</h4>
                                <h4 class="price theme-color" id="total_amount">&#8361;---</h4>
                            </li> -->
                        </ul>

                        <div class="button-group cart-button">
                            <ul>
                                <li>
                                	<form action="/order/requestOrder" method="post">
	                                	<div class="move-payment"></div>
	                                    <button type="submit" class="btn btn-animation proceed-btn fw-bold">
	                                    Process To Checkout</button>
                                	</form>
                                </li>

                                <li>
                                    <button onclick="location.href = '/';"
                                        class="btn btn-light shopping-button text-dark">
                                        <i class="fa-solid fa-arrow-left-long"></i>Return To Shopping</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Cart Section End -->
	
	<jsp:include page="../footer.jsp"></jsp:include>
	

    <!-- Bg overlay Start -->
    <div class="bg-overlay"></div>
    <!-- Bg overlay End -->

    <!-- latest jquery
    <script src="/resources/assets/js/jquery-3.6.0.min.js"></script>-->

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