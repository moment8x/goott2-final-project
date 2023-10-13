<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(function () {
		// 받아 온 장바구니 정보 출력
		getShoppingCart();
	});
	
	// 선택된 항목 삭제.
	function delCheckedItem() {
		let items = [];
		$("input[name='check_item']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
			items.push($(this).val());
		});
		$.ajax({
			url: "/shopingCart/delItems",
			type:"POST",
			data:{
				'items':items
			},
			dataType: "json",
			contentType:"application/x-www-form-urlencoded;charset=utf-8", //한글 깨짐 방지
			async: false,
			success:function(data) {
				
			}
		});
	}
	
	// 시작
	function getShoppingCart() {
		let output = "";
		<c:choose>
			<c:when test="${items.size() > 0 }">
				let output2 = "<div><input type='checkbox' name='check_all_items'/><ul><li>상품명</li><li>소비자가</li><li>공급가</li><li>판매가</li><li>isbn</li><li>상품 이미지</li></ul></div>";
				$('.shopping-cart-attr').html(output2);
				<c:forEach var="item" items="${items }">
					output += `<div class="shopping-cart-box">`;
					output += `<input type="checkbox" name="select_item" value="${item.product_id}" />`;
					output += `<ul class="shopping-cart-list">`;
					output += `<li>상품명 : ${item.product_name }</li>`;
					output += `<li>소비자가 :${item.consumer_price }</li>`;
					output += `<li>공급가 : ${item.supply_price }</li>`;
					output += `<li>판매가 : ${item.selling_price }</li>`;
					output += `<li>isbn : ${item.isbn }</li>`;
					output += `<li>상품 이미지 : ${item.product_image }</li>`;
					output += `<li>상품 정보(이미지) : ${item.product_info_image }</li>`;
					output += `</ul><button class="btn-del" onclick="deleteItem(this);" value=${item.product_id}>x</button></div>`;
				</c:forEach>
			</c:when>
			<c:otherwise>
				output += `<div>등록된 상품이 없습니다.</div>`;
				output += `<div><button>로그인 하기</button></div>`;
			</c:otherwise>
		</c:choose>
		$('.shopping-cart-items').html(output);
	}
	
	// ajax 이후 DOM 갱신
	function reGetShoppingCart(items) {
		let output = "";
		console.log(items);
		console.log("items 길이 : ",items.length);
		if (items.length > 0) {
			let output2 = "<div><button>선택 삭제</button></div>";
			output2 = "<div><input type='checkbox' name='check_all_items'/><ul><li>상품명</li><li>소비자가</li><li>공급가</li><li>판매가</li><li>isbn</li><li>상품 이미지</li></ul></div>";
			$('.shopping-cart-attr').html(output2);
			$.each(items, function(i, item) {
				output += `<div class="shopping-cart-box">`;
				output += `<input type="checkbox" name="check_item" value="\${item.product_id}" />`;
				output += `<ul class="shopping-cart-list">`;
				output += `<li>상품명 : \${item.product_name }</li>`;
				output += `<li>소비자가 :\${item.consumer_price }</li>`;
				output += `<li>공급가 : \${item.supply_price }</li>`;
				output += `<li>판매가 : \${item.selling_price }</li>`;
				output += `<li>isbn : \${item.isbn }</li>`;
				output += `<li>상품 이미지 : \${item.product_image }</li>`;
				output += `<li>상품 정보(이미지) : \${item.product_info_image }</li>`;
				output += `</ul><button class="btn-del" onclick="deleteItem(this);" value="\${item.product_id}">x</button></div>`;
			});
		} else {
			output += `<div>등록된 상품이 없습니다.</div>`;
			output += `<div><button>로그인 하기</button></div>`;
		}
		$('.shopping-cart-items').html(output);
	}
	
	// 단일 아이템 삭제
	function deleteItem(elt) {
		let productId = elt.value;
		$.ajax({
			url : "/shoppingCart/delItem",
			type : "post",
			data : {
				"productId" : productId
			},
			dataType : "json",
			async : false,
			success : function(data) {
				console.log(data);
				if (data.status == "success") {
					reGetShoppingCart(data.items);
				}
			}, error : function() {
				console.log("help!me!");
			}
		});
	}
	
	// 체크된 items 삭제
	
	// items 일괄 삭제
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


	<div class="container">
		<div class="shopping-cart-area">
			<div class="shopping-cart-attr"></div>
			<div class="shopping-cart-items"></div>
		</div>
		<!-- 장바구니 금액 표기란 -->
		<div class="payments_info_area">
			<div class="payments_info_box">
				<ul class="payments_info_list">
					<li>
						상품금액
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
					<li>
						배송비
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
				</ul>
			</div>
			<div class="payments_info_box">
				<ul class="payments_info_list">
					<li>
						결제 예정 금액
						<div class="right_box">
							<span class="price"></span>원
						</div>
					</li>
					<li>
						적립 예정 포인트
						<div class="right_box">
							<span class="price"></span>P
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>