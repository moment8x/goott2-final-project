<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
		window.onpageshow = function (e) {
			if (e.persisted) {
				//BFCache로 복원된 상태
				console.log("chk");
				location.reload();
			} else {
				console.log("nbb");
			}
		}
		
		$(function () {
			// 받아 온 장바구니 정보 출력
			spreadView();
			
			// QTY 입력으로 변경 시
			$('.qty-input').blur(function() {
				let prod = $(this).attr("id");
				let price = $(this).prev().val();
				let maxium = $(this).next().val();
				
				if ($(this).val() > maxium) {
					$(this).val(maxium);
					alert("재고량(" + maxium + ")보다 높은 수를 입력하실 수 없습니다.");
				} else {
					digitize(prod);
					$('#total' + prod).html(addComma(price * $('#' + prod).val()) + "원");
					
					updateQTY(prod, $(this).val());
				}
			});
			
			// checked 속성이 false일 시 금액에 포함X
			$('input[type="checkbox"]').click(function (e) {
				let subtotal = $('#subtotal').text().replace('원','').replace(/(,)/g, '');
				let shipping = 0;
				let total = $('#total_amount').text().replace('원',"").replace(/(,)/g, '');
				let productId = $(this).val();
				let id = "total" + productId;	// 선택된 상품의 가격을 찾기 위한 id
				let isChecked = $('#' + productId).prop('disabled');
				
				if (!$(this).is(":checked")) {
					subtotal = subtotal - $('#' + id).html().replace('원','').replace(/(,)/g, '');
				} else {
					subtotal = parseInt(subtotal) + parseInt($('#' + id).html().replace('원','').replace(/(,)/g, ''));
				}
				if (subtotal < 10000) {
					shipping = 3000;
				}
				
				total = subtotal + shipping;
				
				$('#subtotal').html(addComma(subtotal) + '원');
				$('#shipping').html(addComma(shipping) + '원');
				$('#total_amount').html(addComma(total) + '원');
				$('#' + productId).prop("disabled", isChecked ? false : true);
				$('#' + productId).next().next().prop("disabled", isChecked ? false : true);
				$('#' + productId).prev().prev().prop("disabled", isChecked ? false : true);
			});
			
			// 선택 취소 시 buyInfo에서 제외, 선택 시 buyInfo에 추가
			$('.check-it').change(function () {
				let productId = $(this).attr("id");
				productId = productId.replace("check", "");
				if ($(this).is(':checked')) {
					buyInfo.push({
						"productId" : productId,
						"quantity" : $(productId).val()
					})
				} else {
					let index = 0;
					for (let data of buyInfo) {
						if (data.productId == productId) {
							buyInfo.splice(index, 1);
							break;
						}
						index++;
					}
				}
				buy();
			}); 
		});
		
		// 선택된 항목 삭제.
		function delCheckedItem() {
			let items = [];
			$("input[name='check_item']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
				items.push($(this).val());
			});
			$.ajax({
				url: "/shoppingCart/items",
				type:"POST",
				data:{
					'itemNames' : items
				},
				dataType: "json",
				async: false,
				success:function(data) {
					if (data.status != 'fail') {
						spreadView();
						buy();
						newCart(data.cartItems);
					}
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
			let shipping = 0;
			if (data.status === "success") {
				let items = data.list.items;
				isLogin = data.isLogin;
				$.each(items, function(i, item) {
					let productName = item.productName;
					if (productName.length > 15) {
						productName = productName.substring(0, 25) + "<br/>" + productName.substring(25);
					}
					let qty = data.list.list[i].quantity;
					output += `<tr class="product-box-contain">`;
					// 체크박스
					output += `<td class="product-checkbox" style="min-width:15px;"><input id="check\${item.productId}" class="checkbox_animated check-it" type="checkbox" name="check_item" value="\${item.productId}" checked/></td>`;
					// 이미지, 책 제목
					output += `<td class="product-detail">`;
					output += `<div class="product border-0">`;
					output += `<a href="/detail/\${item.productId}" class="product-image"><img src="\${item.productImage}" class="img-fluid blur-up lazyload" alt="\${item.productName}"/></a>`;
					output += `<div class="product-detail">`;
					output += `<ul>`;
					output += `<li class="name"><a href="/detail/\${item.productId}">\${productName}</a></li>`;
					// 가격
					output += `<td class="price"><h4 class="table-title text-content">가격</h4>`;
					output += '<h5>' + item.sellingPrice.toLocaleString('ko-KR') + "원"
					output += '<del class="text-content">' + item.consumerPrice.toLocaleString('ko-KR') + '원</del></h5>';
					output += '<h6 class="theme-color">할인된 금액 : '
					output += (item.consumerPrice - item.sellingPrice).toLocaleString('ko-KR') + '원</h6></td>';
					// QTY
					if (item.currentQuantity >  0) {
						output += `<td class="quantity"><h4 class="table-title text-content">수량</h4>`;
						output += `<div class="quantity-price"><div class="cart_qty"><div class="input-group">`;
						output += `<button type="button" class="btn qty-left-minus" onclick="qtyMinus('\${item.productId}', '\${item.sellingPrice}');">`;
						output += `<i class="fa fa-minus ms-0" aria-hidden="true"></i></button>`;
						output += `<input type="hidden" value="\${item.sellingPrice}">`;
						output += `<input class="form-control input-number qty-input quantity" id="\${item.productId}" type="text" name="quantity" value="\${item.quantity}">`;
						output += `<input type="hidden" value="\${item.currentQuantity}">`;
						output += `<button type="button" class="btn qty-right-plus" onclick="qtyPlus('\${item.productId}', '\${item.sellingPrice}', '\${item.currentQuantity}');">`;
						output += `<i class="fa fa-plus ms-0" aria-hidden="true"></i></button></div></div></div></td>`;
					} else {
						output += `<td class="quantity"><h4 class="table-title text-content">수량</h4>`;
						output += `<div class="quantity-price"><div class="cart_qty"><div class="input-group">`;
						output += `<button type="button" class="btn qty-left-minus" onclick="qtyMinus('\${item.productId}', '\${item.sellingPrice}');" disabled>`;
						output += `<i class="fa fa-minus ms-0" aria-hidden="true"></i></button>`;
						output += `<input class="form-control input-number qty-input" id="\${item.productId}" type="text" name="quantity" value="품절" onchange="renewTotal('\${item.productId}', '\${item.sellingPrice}');" disabled>`;
						output += `<button type="button" class="btn qty-right-plus" onclick="qtyPlus('\${item.productId}', '\${item.sellingPrice}', '\${item.currentQuantity}');" disabled>`;
						output += `<i class="fa fa-plus ms-0" aria-hidden="true"></i></button></div></div></div></td>`;
					}
					// 해당 아이템 최종 가격
					output += `<td class="subtotal"><h4 class="table-title text-content">소계</h4>`;
					output += `<h5 id="\${'total' + item.productId}" class="subtotal calc_total">`;
					output += (item.sellingPrice * item.quantity).toLocaleString('ko-KR') + '원</h5></td>';
					
					output += '<td class="save-remove" style="min-width:20px;"><h4 class="table-title text-content">장바구니 삭제</h4>';
					output += `<button class="remove close_button" onclick="deleteItem(this);" value="\${item.productId}">`
					output += '<i class="fa-regular fa-trash-can"></i></button></td></tr>';
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
				if (subtotal < 10000) {
					shipping = 3000;
				}
				total = subtotal + shipping;
				
				output2 += `<ul><li><h4>구매 가격</h4><h4 class="price" id="subtotal">` + addComma(subtotal) + `원</h4></li>`;
				output2 += '<li class="align-items-start"><h4>배송비</h4><h4 class="price text-end" id="shipping">' + addComma(shipping) + '원</h4>';
				output2 += '</li></ul>';
			} else if (data.status === "none") {
				output += '<div><h4 style="text-align:center;"">등록된 상품이 없습니다.</h4></div>';
				
				output2 += `<ul><li><h4>구매 가격</h4><h4 class="price" id="subtotal">0원</h4></li>`;
				output2 += '<li class="align-items-start"><h4>배송비</h4><h4 class="price text-end" id="shipping">0원</h4>';
				output2 += '</li></ul>';
			}
			
			output3 += '<li class="list-total border-top-0"><h4>총 계</h4>';
			output3 += '<h4 class="price theme-color" id="total_amount">' + addComma(total) + '원</h4></li>';
			
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
			}
			$('.move-payment').html(output);
		}
		
		// 숫자 3자리마다 콤마 찍어주기
		function addComma(dataValue) {
			return Number(dataValue).toLocaleString('en');
		}
		
		// 콤마 삭제
		function digitize(prod) {
			// 콤마가 있다면
			if($('#total' + prod).html().indexOf(",") != -1){
				$('#total' + prod).html($('#total' + prod).html().replace(/(,)/g, "")); // 콤마를 ""로 replace함
				$('#subtotal').html($('#subtotal').html().replace(/(,)/g, ""));
			}
		}
		function digitizeNormal(price) {
			price = price.substr(0, price.lastIndexOf("원"));
			
			if(price.indexOf(",") != -1){
				price = price.replace(/(,)/g, "");
			}
			return price;
		}
		
		// QTY +
		// #prod : input태그, price : 가격, stock : 재고량
		function qtyPlus(prod, price, stock) {
			if (parseInt($('#' + prod).val()) < stock) {
				digitize(prod);
				$('#' + prod).val(Number($('#' + prod).val()) + 1);
				$('#total' + prod).html(addComma(price * $('#' + prod).val()) + "원");
				
				$.each(buyInfo, function(i, info) {
					if (info.productId === prod) {
						info.quantity = $('#' + prod).val();
					}
				});
				
				updateQTY(prod ,$('#' + prod).val());
			}
		}
		// QTY -
		function qtyMinus(prod, price) {
			if ($('#' + prod).val() > 0) {
				digitize(prod);
				$('#' + prod).val($('#' + prod).val() - 1);
				$('#total' + prod).html(addComma(price * $('#' + prod).val()) + "원");
				
				$.each(buyInfo, function(i, info) {
					if (info.productId === prod) {
						info.quantity = $('#' + prod).val();
					}
				});
				
				updateQTY(prod ,$('#' + prod).val());
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
					if (data.status === "success") {
						subtotal(productId);
						totalAmount();
						buy();
					} else if (data.status === "problem") {
						alert("재고 이상의 수량을 입력할 수 없습니다.");
						location.reload();
					}
				}, error: function(data) {
					console.log(data);
				}
			});
		}
		
		// 구매액(subtotal)
		function subtotal(productId) {
			let sum = 0;
			for (let i = 0; i < $('h5.subtotal').length; i++) {
				let elt = document.getElementsByClassName('calc_total')[i];
				let id = elt.id.replace("total", "");
				if (!$('#' + id).is(":disabled")) {
					let temp = elt.innerHTML;
					temp = digitizeNormal(temp);
					sum += Number(temp);
				}
			}
			if (sum < 10000) {
				$('#shipping').html(addComma(3000) + "원");
			} else {
				$('#shipping').html("0원");
			}
			$('#subtotal').html(addComma(sum) + "원");
		}
		
		// 총 결제액(total amount)
		function totalAmount() {
			let subtotal = $('#subtotal').html();
			let shippingPay = $('#shipping').html();
			subtotal = Number(digitizeNormal(subtotal));
			shippingPay = Number(digitizeNormal(shippingPay));
			
			$('#total_amount').html(addComma(subtotal + shippingPay) + "원");
		}
		
		// 단일 아이템 삭제
		function deleteItem(elt) {
			let productId = elt.value;
			$.ajax({
				url : "/shoppingCart/" + productId,
				type : "DELETE",
				data : {
					"productId" : productId
				},
				dataType : "json",
				async : false,
				success : function(data) {
					if (data.status == "success") {
						spreadView();
						newCart(data.cartItems);
						buy();
					}
				}, error : function() {
					console.log("help!me!");
				}
			});
		}
		
		// 전체 선택
		function addChecked() {
			const checkboxes = document.getElementsByName('check_item');
		  
			checkboxes.forEach((checkbox) => {
				checkbox.checked = true;
			})
		}
		
		// 전체 선택 해제
		function AllUnchecked() {
			const checkboxes = document.getElementsByName('check_item');
			  
			checkboxes.forEach((checkbox) => {
				checkbox.checked = false;
			})
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
                    <span>장바구니</span>
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
                        <h2>장바구니</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="/index.html">
                                        <i class="fa-solid fa-house"></i>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">장바구니</li>
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
        	<div>
        		<button onclick="addChecked();">전체 선택</button>
        		<button onclick="AllUnchecked();">전체 선택 해제</button>
        		<button onclick="delCheckedItem();">선택 삭제</button>
        	</div>
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

                        <div class="summery-contain"></div>

                        <ul class="summery-total"></ul>

                        <div class="button-group cart-button">
                            <ul>
                                <li>
                                	<form action="/order/requestOrder" method="post">
	                                	<div class="move-payment"></div>
	                                    <button type="submit" class="btn btn-animation proceed-btn fw-bold">
	                                    결제하기</button>
                                	</form>
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