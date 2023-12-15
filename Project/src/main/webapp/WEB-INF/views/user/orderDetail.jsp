<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<title>Dear Books</title>

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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
   src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

//카카오 주소검색
function sample6_execDaumPostcode(zipCode, userAddr, detailAddr, extraAddress) {
    new daum.Postcode({
        oncomplete: function(data) {
           console.log(data)
           
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            let addr = ''; // 주소 변수
            let extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById(`\${extraAddress}`).value = extraAddr;
            
            } else {
                document.getElementById(`\${extraAddress}`).value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById(`\${zipCode}`).value = data.zonecode;
            document.getElementById(`\${userAddr}`).value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById(`\${detailAddr}`).focus();
        }
    }).open();
}

$(function () {
	let orderTime = $('.detailOrderOrderTime').text().substring(0,21)
	$('.detailOrderOrderTime').text(orderTime)
	
	let icOrderTime = $('.infoContent.detailOrderOrderTime').text().substring(0,21)
	$('.infoContent.detailOrderOrderTime').text(icOrderTime)

})

//개별 체크박스 누르면 전체선택 체크
function isChecked(className) {
	if ($(`.checkbox_animated.check-box.\${className}:checked`).length == $(`.checkbox_animated.check-box.\${className}`).length) {
		console.log("모두 체크됨")
		$("input[name=order]").prop("checked", true);
	}
}

//교환 신청 버튼 누르면
function applyExchange() {	
		//회수주소
		let returnZipNo = $('#collectZipNo').val();
		let returnAddr = $('#collectAddr').val()
		let returnDetailAddr = $('#collecDetailAddr').val()
		let returnMsg = $('#collecMsg').val()
		
		//교환주소
		let exchangeZipNo = $('#exchangeZipNo').val();
		let exchangeAddr = $('#exchangeAddr').val()
		let exchangeDetailAddr = $('#exchangeDetailAddr').val()
		let exchangeMsg = $('#exchangeMsg').val()
		
		let detailedOrderId = []
		let selectQty = []
		let orderNo = `${detailOrder.orderNo}`;
		let exchangeReason = $('#exchangeReason').val()
		
		$('.form-control.cancelQty').each(function() {
		 let qty = $(this).val()
			if(qty != 0){
	 			selectQty.push(qty) 				
			}
	 	})
		
	$(".checkbox_animated.check-box.selectExchange:checked").each(function() {
		detailedOrderId.push($(this).val())
		$.ajax({
			url : '/user/applyExchange', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			contentType: 'application/json',
			data : JSON.stringify({
				returnZipNo,
				returnAddr,
				returnDetailAddr,
				returnMsg,
				exchangeZipNo,
				exchangeAddr,
				exchangeDetailAddr,
				exchangeMsg,
				detailedOrderId,
				orderNo,
				exchangeReason
			}),
			dataType : 'text',
			async : false,
			success : function(data) {
				console.log(data);
				if(data == 'success'){
					location.reload()
				}
			},
			error : function(error) {
				console.log(error)
			}
		});
	})
	
}

//반품 신청 버튼 누르면
function applyReturn() {
	let refundBank = $('#returnBank').text();
	let refundAccount = $('#returnAccount').text();
	let accountHolder = $('#returnHolder').text();
	let zipNo = $('#returnZipNo').val();
	let addr = $('#returnAddr').val()
	let detailAddr = $('#returnDetailAddr').val()
	let returnReason = $('#returnReason').val()
	let detailedOrderId = []
	let selectQty = []
	let couponName = []
	let orderNo = '${detailOrder.orderNo}';
	let returnMsg = $('#returnMsg').val()
	
	 $('.form-control.cancelQty').each(function() {
			 let qty = $(this).val()
	 			if(qty != 0){
		 			selectQty.push(qty) 				
	 			}
		 })
		 
		  $('.refundCoupon').each(function () {
			 couponName.push($(this).text())
		})
	
	$(".checkbox_animated.check-box.selectReturn:checked").each(function() {
		detailedOrderId.push($(this).val())
		console.log(detailedOrderId)
		$.ajax({
			url : '/user/returnOrder', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			contentType: 'application/json',
			data : JSON.stringify({
				refundBank,
				refundAccount,
				accountHolder,
				zipNo,
				addr,
				detailAddr,
				returnReason,
				detailedOrderId,
				orderNo
			}),
			dataType : 'text',
			async : false,
			success : function(data) {
				console.log(data);
				if(data == 'success'){
					location.reload()
				}
			},
			error : function(error) {
				console.log(error)
			}
		});
	})
}


//취소 버튼을 누르면
function orderCancel(){
	let reason = $('#cancelReason').val();
    if (reason.trim() === '') {
        alert('사유를 입력해주세요.');
        return false;
     }		
		let orderNo = `${detailOrder.orderNo}`;
		let refundBank = $('#changeRefundBank').text();
		let refundAccount = $('#changeRefundAccount').text();
		let accountHolder = $('#changeAccountHolder').text();
		let actualRefundAmount = $('#refundAmount').text().replace(",", "").replace("원", ""); // 할인후 금액(돌려줄 환불액)
		let selectQty = []
		let detailedOrderId = []
		let couponName = []
		
		 $('.form-control.cancelQty').each(function() {
			 let qty = $(this).val()
	 			if(qty != 0){
		 			selectQty.push(qty) 				
	 			}
		 })
		 
		  $('.refundCoupon').each(function () {
			 couponName.push($(this).text())
		})
		 
		$(".checkbox_animated.check-box.selectOrderCancel:checked").each(function() {
			detailedOrderId.push($(this).val())
			
		console.log("selectQty" + selectQty)	
		console.log("detailedOrderId" +detailedOrderId)
		console.log("actualRefundAmount" +actualRefundAmount)
		
		$.ajax({
			url : '/user/cancelOrder', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			contentType: 'application/json',
			data : JSON.stringify({
				orderNo,
				refundBank,
				refundAccount,
				accountHolder,
				actualRefundAmount,
				selectQty,
				detailedOrderId,
				reason
			}),
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				if(data.status == 'success'){
					//if(data.remainingQuantity != 0){
					//	$('.text-title.remainingQuantity').text("취소 수량 : " + data.remainingQuantity)
						location.reload()
				//	}
				}
			},
			error : function(error) {
				console.log(error)
			}
		});
	})
		
}

	//상품 선택하고 수량 입력하면 환불 계산
	function selectOrderCancel(className, amountId, rewardId, pointId) {
		let orderNo = `${detailOrder.orderNo}`;
	    let orderQty = `${orderQty}` // 총 주문 수량
	    let actualAmount = Number(${detailOrder.actualPaymentAmount}) // 카드 실결제금액
	    let bktActualAmount = Number(${bankTransfer.amountToPay}) // 무통장 실결제금액
	    let totalQty = calculateTotalQuantity(); //입력한 총 수량		
 		let selectQty = []
 		let detailedOrderId = []
 		let refundAmount = 0
 		let productStatus = []
 		
	    $('.productStatus').each(function() {
 		    productStatus.push($(this).text());
 		});
	    console.log(productStatus)
	    
 		$('.totalCancelQty').text("선택한 상품 수량 : " + totalQty + "권")
 		console.log('총 수량:', totalQty);
 		
 		 $('.form-control.cancelQty').each(function() {
 			let qty = $(this).val()
 			if(qty != 0){
	 			selectQty.push(qty) 				
 			}
 		})
	 		 console.log(selectQty)
	 		 
	 	$(`.checkbox_animated.check-box.\${className}:checked`).each(function() {	 
	 		detailedOrderId.push($(this).val())
	 		console.log(detailedOrderId)
	 		$.ajax({
	 		      url: "/user/calcRefundAmount", // 데이터를 수신받을 서버 주소
	 		      type: "post", // 통신방식(GET, POST, PUT, DELETE)
	 		      contentType: 'application/json',
	 		      data: JSON.stringify({
	 		    	 detailedOrderId, 
	 		    	  orderNo,
	 		    	  selectQty
	 		      }),
	 		      dataType: "json",
	 		      async: false,
	 		      success: function (data) {
	 		        console.log(data);
	 		       
	 		        let paymentMethod = "${detailOrder.paymentMethod}" // 결제수단
	 		       	let usedCouponName = $('.infoContent.usedCoupon').text() //사용한 쿠폰이름
	 		       	let usedReward = ${detailOrder.usedReward} // 사용한 적립금
	 		    	let usedPoint = ${detailOrder.usedPoints} // 사용한 포인트
	 		    	
	
	 		  		 //개별취소시 쿠폰환불이 가능한지
	 		  		 $.each(data.couponsHistory, function(i, elt){
	 			  		 if(data.status == "okCoupon"){
	 			  			  $('.refundCoupon').text(elt.couponName)
	 			  		  }else if(data.status == "noCoupon"){
	 			  			$('.refundCoupon').text("없음")
	 			  		  }	  		
	 		  		 })
	 		  		 
	 		  		//전체선택 체크박스 체크되고 총 취소상품 수량이랑 총 주문 수량이랑 일치한다면 => 전체취소
	 		  		if($(".checkbox_animated.check-box.selectAll").is(":checked") && totalQty == orderQty){
	 		  			console.log("전체취소한당")
	 		  			//쿠폰
	 		  			if(data.couponsHistory == null){
	 		  				$('.refundCoupon').text("없음")
	 		  			}else{
	 		  				$('.refundCoupon').text(usedCouponName)			
	 		  			}
	 		  			//환불금액
	 		  			if(productStatus.length == 0){
	 		  				if(paymentMethod == "bkt"){
	 		  					$(`#\${amountId}`).text(bktActualAmount.toLocaleString()+ "원")	
	 		  				}else{
	 		  					$(`#\${amountId}`).text(actualAmount.toLocaleString()+ "원")
	 		  				}
	 		  			}else{
		 		  			for(let i = 0; i < productStatus.length; i++){
			 		  			if(productStatus[i] != "입금전" && paymentMethod == "bkt"){
			 			  			$(`#\${amountId}`).text(bktActualAmount.toLocaleString()+ "원")		  				
			 		  			}else if(productStatus[i] != "입금전" && paymentMethod != "bkt"){
			 		  				$(`#\${amountId}`).text(actualAmount.toLocaleString()+ "원")		
			 		  			}else if(productStatus[i] == "입금전"){
			 		  				$(`#\${amountId}`).text("0 원")
			 		  			}	  				
		 		  			}	 		  				
	 		  			}
	 		  			//적립금
	 		  			$(`#\${rewardId}`).text(usedReward.toLocaleString()+ "원")
	 		  			//포인트
	 		  			 $(`#\${pointId}`).text(usedPoint.toLocaleString()+ "점") 
	 		  		}else{
	 		  			console.log("부분취소한당")

	 		  			refundAmount += data.calcRefund.refundAmount
	 		  			let refundReward = data.calcRefund.refundReward
	 		  			let refundPoint = data.calcRefund.refundPoint
	 		  			
	 		  			if(productStatus.length == 0){
	 		  				$(`#\${amountId}`).text(refundAmount.toLocaleString()+ "원")
	 		  			}else{
		 		  			for(let i = 0; i < productStatus.length; i++){
			 		  			if(productStatus[i] != "입금전"){
				 		  			//환불금액
				 			  		$(`#\${amountId}`).text(refundAmount.toLocaleString()+ "원")		  					
			 		  			}else{
			 		  				$(`#\${amountId}`).text("0 원")	 		  						 		  				
			 		  			}
		 		  			}	 		  				
	 		  			}
	 		  			
	 		  			//적립금
	 		  			$(`#\${rewardId}`).text(refundReward.toLocaleString()+ "원")
	 		  			//포인트
	 		  			 $(`#\${pointId}`).text(refundPoint.toLocaleString()+ "점") 
	 		  		}
	 		  	//	for(let i = 0; i < selectQty.length; i++){
		 		//  		if(selectQty[i] > data.cancelOrder.productQuantity){
		 		//  			console.log(i)
		 		//  			console.log(selectQty[i])
		 		//  			console.log(data.cancelOrder.productQuantity)
		 		 // 			alert("주문 수량보다 많이 입력 할 수 없습니다.")
		 		//  			$('.totalCancelQty').text("취소 상품 수량 : " + 0)
		 		//  			$(`#\${amountId}`).text("0 원")
		 		 // 		}	  		  	 		  			
	 		  	//	}
	 		      },
	 		      error: function (error) {
	 		    	  console.log(error);
	 		      },
	 		    });
	 	})
	}
	
	//환불 예정 포인트, 적립금 구하기
	//function calculate(n, k, usedAmount) { // 총 주문 수량, 입력한 총 수량, 포인트, 적립금
	//	return ((n - k) / n) * usedAmount
	//}
	
	//취소 수량 입력받아서 총 수량 구하기
	function calculateTotalQuantity() {
		let totalQuantity = 0;

		$('.form-control.cancelQty').each(function() {
		let quantity = parseFloat($(this).val()) || 0; 
		totalQuantity += quantity;
		});

		 return totalQuantity;
	}

//배송주소록 수정
function shippingAddrModify() {
	let zipCode = $('#editZipNo').val()
	let shippingAddress = $('#editAddr').val()
	let detailedShippingAddress = $('#editAddrDetail').val()
	let recipientName = $('#recipient').val()
	let recipientPhoneNumber = $('#recipientContact').val()
	let deliveryMessage = $('#editDeliveryMsg').val()
	let orderNo = "${detailOrder.orderNo }"

	$.ajax({
		url : '/user/editDeliveryAddress', // 데이터를 수신받을 서버 주소
		type : 'post', // 통신방식(GET, POST, PUT, DELETE)
		data : {
			zipCode,
			shippingAddress,
			detailedShippingAddress,
			recipientName,
			recipientPhoneNumber,
			deliveryMessage,
			orderNo
		},
		dataType : 'text',
		async : false,
		success : function(data) {
			console.log(data);
			if(data == 'success'){
				location.reload()
			}
		},
		error : function() {
		}
	});
}

// 출고전, 입금전 배송주소록에서 배송지 선택해서 변경
function editBasicShippingAddress() {
		let addrSeq = $('input[name="checkAddr"]:checked').val()
		let deliveryMessage = $('#changeDeliveryMessage').val()
		let orderNo = "${detailOrder.orderNo}"
		
		 $.ajax({
				url : '/user/selectBasicAddr', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data : {
					addrSeq,
					deliveryMessage,
					orderNo
				},
				dataType : 'text',
				async : false,
				success : function(data) {
					console.log(data);
					if(data == 'success'){
						location.reload()
					}
				},
				error : function() {
				}
			});
}

//취소 주문한 상품 전체선택
function selectAll(id) {
	if($(`#\${id}`).is(':checked')) {
		$("input[name=order]").prop("checked", true);
	} else {
		$("input[name=order]").prop("checked", false);
	}
}

function selectAllReturn() {
	if($("#selectAllReturnOrder").is(':checked')) {
		$("input[name=order]").prop("checked", true);
	} else {
		$("input[name=order]").prop("checked", false);
	}
}



function showRefund() {
	$('.editRefund').show()
}

//취소 무통장 환불 정보 변경
function editRefundAccount() {
	let refundBank = $("select[name=refundBank]").val()
	let accountHolder = $('#accountHolder').val();
	let refundAccount = $('#refundAccount').val();
	
	console.log(refundBank + accountHolder + refundAccount)
	
	$('#changeRefundBank').text(refundBank);
	$('#changeRefundAccount').text(refundAccount)
	$('#changeAccountHolder').text(accountHolder)
	
	$('.editRefund').hide()
}

//반품 무통장 환불 정보 변경
function editRturnAccount() {
	let refundBank = $("select[name=selectReturnBank]").val()
	let accountHolder = $('#changeReturnAccountHolder').val();
	let refundAccount = $('#changeReturnAccount').val();
	
	console.log(refundBank + accountHolder + refundAccount)
	
	$('#returnBank').text(refundBank);
	$('#returnAccount').text(refundAccount)
	$('#returnHolder').text(accountHolder)
	
	$('.editRefund').hide()
}

</script>
<style type="text/css">
.completeBtn Button, .btn.theme-bg-color.text-white.m-0.productStatusBtn
	{
	width: 60px;
	height: 25px;
}

.completeBtn Button span, .btn.theme-bg-color.text-white.m-0.productStatusBtn span
	{
	font-size: 12px;
}

.btn.theme-bg-color.text-white.btn-sm.fw-bold.mt-lg-0.mt-3.changeAddr {
	font-size: 12px;
	width: 80px;
	height: 25px;
	margin-top: 10px;
}

.name.productStatusBtn, .completeBtn {
	display: flex;
	height: 126px;
	align-items: center;
	gap: 5px;
}

.col-xxl-3.col-lg-4.orderInfo {
	width: 850px;
}

.moveBtn {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.infoTitle {
	font-weight: bold;
}

.infoContent {
	font-size: 8px;
}

.col-xxl-6.col-lg-12.col-sm-6.addrInfo {
	margin-bottom: 10px;
}

.detailOrderBtn {
	display: flex;
	justify-content: center;
	gap: 10px;
	vertical-align: middle;
}

.table.mb-0.productInfo {
	border-bottom: 0.5px solid #E7E7E7;
	padding-bottom: 50px;
	padding-top: 10px;
}

.deliverMsg {
	font-weight: bold;
}

.form-floating.mb-4.theme-form-floating.changeDeliveryMessage {
	border-top: 0.5px solid #E7E7E7;
	padding-top: 10px;
}

.basicAddr {
	font-size: 12px;
	border: 2px solid #0DA487;
	border-radius: 10px;
	padding: 3px;
}

#orderTime {
	margin-bottom: 30px;
}

.couponsHistory {
	display: flex;
	gap: 5px;
}

#cancelOrderImg {
	width: 80px;
}

#cancelQty {
	width: 50px;
	height: 20px;
}

.totalCancelQty {
	font-size: 16px;
	text-align: center;
	margin: 5px;
}

.pb-0.refundList {
	margin-right: 10px;
	margin-bottom: 10px;
}

.editRefund {
	display: none;
}

#selectOrder {
	display: flex;
	margin-left: 10px;
	gap: 10px;
	justify-content: center;
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

	<!-- Cart Section Start -->
	<section class="cart-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row g-sm-4 g-3">
				<div class="col-xxl-9 col-lg-8">
					<div class="cart-table order-table order-table-2">
						<div class="table-responsive">
							<h3>주문번호 ${detailOrder.orderNo }</h3>

							<h4 id="orderTime" class="detailOrderOrderTime">
								<fmt:formatDate value="${detailOrder.orderTime }" type="date" />
							</h4>
							<c:forEach var="order" items="${detailOrderInfo }">
								<table class="table mb-0 productInfo">
									<tbody>
										<tr>
											<td class="product-detail">
												<div class="product border-0">

													<c:choose>
														<c:when test="${order.productImage != '' }">
															<a href="/detail/${order.productId }"
																class="product-image"> <img
																src="${order.productImage }"
																class="img-fluid blur-up lazyload"
																alt="${order.productName }">
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${order.productId }"
																class="product-image"> <img
																src="/resources/assets/images/noimage.jpg"
																class="img-fluid blur-up lazyload"
																alt="${order.productName }">
															</a>
														</c:otherwise>
													</c:choose>

													<c:set var="productNameLength"
														value="${fn:length(order.productName)}" />

													<div class="product-detail">
														<ul>
															<c:choose>
																<c:when test="${productNameLength <= 7}">
																	<li class="name"><a
																		href="/detail/${order.productId }" id="productName">${order.productName }</a></li>
																</c:when>
																<c:otherwise>
																	<li class="name"><a
																		href="/detail/${order.productId }" id="productName">${fn:substring(order.productName, 0, 7)}...</a></li>
																</c:otherwise>
															</c:choose>
														</ul>
													</div>
												</div>
											</td>

											<td class="price">
												<h4 class="table-title text-content">상품금액</h4>
												<h6 class="theme-color productPrice">
													<fmt:formatNumber value="${order.productPrice * order.productQuantity }"
														type="NUMBER" />
													원
												</h6>
											</td>

											<td class="name">
												<h4 class="table-title text-content">수량</h4>
												<h4 class="text-title">${order.productQuantity }</h4>
												<h4 class="text-title remainingQuantity"></h4>
											</td>
											<c:choose>
												<c:when
													test="${order.productStatus eq '출고전' || order.productStatus eq '입금전' || order.productStatus eq '결제완료' ||
													order.productStatus eq '부분취소'}">
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td class="name productStatusBtn">
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															data-bs-toggle="modal" data-bs-target="#cancel-order"
															type="button" id="button-addon1">
															<span>취소</span>
														</button>
													</td>
												</c:when>

												<c:when
													test="${order.productStatus eq '출고완료' || order.productStatus eq '배송중' }">
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td class="name productStatusBtn">
														<button
															class="btn theme-bg-color text-white m-0 productStatusBtn"
															type="button" id="button-addon1">
															<span>배송조회</span>
														</button>
														<div>${order.productInvoiceNumber }</div>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '주문취소' }">
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<div>주문 취소</div>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '반품신청' }">
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<div>반품신청</div>
													</td>
												</c:when>
												<c:when test="${order.productStatus eq '교환신청' }">
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td>
														<div>교환신청</div>
													</td>
												</c:when>

												<c:otherwise>
													<td class="name">
														<h4 class="table-title text-content">상품상태</h4>
														<h5>${order.productStatus }</h5>
													</td>
													<td class="completeBtn">
														<button class="btn theme-bg-color text-white m-0"
															onclick="location.href='/detail/${order.productId }';"
															type="button" id="button-addon1">
															<span>리뷰작성</span>
														</button>
														<button class="btn theme-bg-color text-white m-0"
															data-bs-toggle="modal" data-bs-target="#exchange-order"
															type="button" id="button-addon1">
															<span>교환</span>
														</button>
														<button class="btn theme-bg-color text-white m-0"
															data-bs-toggle="modal" data-bs-target="#return-order"
															type="button" id="button-addon1">
															<span>반품</span>
														</button>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</tbody>
								</table>
							</c:forEach>

							<div class="col-xxl-3 col-lg-4 orderInfo">
								<div class="row g-4">
									<div class="col-lg-12 col-sm-6 orderInfo">
										<div class="summery-box">
											<div class="summery-header">
												<h3>배송정보</h3>
												<h5 class="ms-auto theme-color"></h5>
											</div>

											<c:choose>
												<c:when test="">
													<c:otherwise>
													</c:otherwise>
												</c:when>
											</c:choose>
											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="pb-0">
													<h4 class="infoTitle">받는사람 :</h4>
													<h4 class="infoContent">${detailOrder.recipientName }</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">받는사람 연락처 :</h4>
													<h4 class="infoContent">${detailOrder.recipientPhoneNumber }</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">주소</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.zipCode }</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.shippingAddress }</h4>
												</li>
												<li class="pb-0">
													<h4 class="infoContent">${detailOrder.detailedShippingAddress }</h4>
												</li>
												<c:choose>
													<c:when test="${detailOrder.deliveryMessage == '' }">
														<li class="pb-0">
															<h4 class="infoTitle">배송메세지 :</h4>
															<h4 class="infoContent">없음</h4>
														</li>
													</c:when>
													<c:otherwise>
														<li class="pb-0">
															<h4 class="infoTitle">배송메세지 :</h4>
															<h4 class="infoContent">${detailOrder.deliveryMessage }</h4>
														</li>
													</c:otherwise>
												</c:choose>
												<li class="deliverMsg"><i
													class="fa-solid fa-circle-exclamation"
													style="color: #ff0059;"></i> 출고전 / 입금전 / 결제완료 상품에 대해서만 배송지
													변경이 가능합니다.</li>
												<c:forEach var="order" items="${detailOrderInfo }" begin="0"
													end="0">
													<c:if
														test="${order.productStatus eq '출고전' || order.productStatus eq '입금전' || order.productStatus eq '결제완료'}">
														<li>
															<button
																class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
																data-bs-toggle="modal" data-bs-target="#change-address">
																<i data-feather="edit" class="me-2"></i> 배송지 변경
															</button>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</div>

									<div class="col-lg-12 col-sm-6 orderInfo">
										<div class="summery-box">
											<div class="summery-header d-block">
												<h3>결제정보</h3>
											</div>
											<ul class="summery-contain pb-0 border-bottom-0">
												<li class="pb-0">
													<h4 class="infoTitle">배송비 :</h4>
													<h4 class="infoContent">
														<fmt:formatNumber value="${detailOrder.shippingFee }"
															type="NUMBER" />
														원
													</h4>
												</li>

												<li class="pb-0">
													<h4 class="infoTitle">총 금액(할인전 금액) :</h4>
													<h4 class="infoContent">
														<fmt:formatNumber value="${detailOrder.totalAmount }"
															type="NUMBER" />
														원
													</h4>
												</li>

												<c:if test="${detailOrder.usedPoints != 0 }">
													<li class="pb-0">
														<h4 class="infoTitle">사용한 포인트 :</h4>
														<h4 class="infoContent">
															<fmt:formatNumber value="${detailOrder.usedPoints }"
																type="NUMBER" />
															점
														</h4>
													</li>
												</c:if>

												<c:if test="${detailOrder.usedReward != 0 }">
													<li class="pb-0">
														<h4 class="infoTitle">사용한 적립금 :</h4>
														<h4 class="infoContent">
															<fmt:formatNumber value="${detailOrder.usedReward }"
																type="NUMBER" />
															원
														</h4>
													</li>
												</c:if>
												<li class="pb-0"><c:if
														test="${not empty couponHistory}">
														<h4 class="infoTitle">사용한 쿠폰 :</h4>
														<div class="couponsHistory">

															<h4 class="infoContent usedCoupon">${couponHistory.couponName }</h4>
															<h4 class="infoContent usedCouponWithP">
																<fmt:formatNumber
																	value="${couponHistory.couponDiscount}" type="NUMBER" />
																원
															</h4>

														</div>
													</c:if></li>

											</ul>

											<ul class="summery-total">
												<li class="list-total border-top-0 pt-2">
													<h4 class="fw-bold">결제금액</h4> <c:choose>
														<c:when test="${detailOrder.paymentMethod eq 'bkt' }">
															<h4 class="fw-bold">
																<fmt:formatNumber value="${bankTransfer.amountToPay}"
																	type="NUMBER" />
																원
															</h4>
														</c:when>
														<c:otherwise>
															<h4 class="fw-bold">
																<fmt:formatNumber
																	value="${detailOrder.actualPaymentAmount }"
																	type="NUMBER" />
																원
															</h4>
														</c:otherwise>
													</c:choose>
												</li>
											</ul>

											<c:choose>
												<c:when test="${detailOrder.paymentMethod eq 'bkt' }">
													<ul class="summery-contain pb-0 border-bottom-0">
														<li class="pb-0">
															<h4 class="infoTitle">결제수단 :</h4> <c:if
																test="${detailOrder.paymentMethod eq 'bkt' }">
																<h4 class="infoContent">무통장 입금</h4>
															</c:if>
														</li>

														<li class="pb-0">
															<h4 class="infoTitle">결제 상태 :</h4>
															<h4 class="infoContent">${detailOrder.paymentStatus }</h4>
														</li>

														<li class="pb-0">
															<h4 class="infoTitle">입금 계좌 :</h4>
															<h4 class="infoContent">${bankTransfer.depositedAccount }</h4>
														</li>

														<li class="pb-0">
															<h4 class="infoTitle">입금자명 :</h4>
															<h4 class="infoContent">${bankTransfer.payerName }</h4>
														</li>

													</ul>
												</c:when>

												<c:otherwise>		
													<ul class="summery-contain pb-0 border-bottom-0">
														<li class="pb-0">
															<h4 class="infoTitle">결제수단 :</h4>
															<c:choose>
															<c:when test="${detailOrder.paymentMethod eq 'ptr' }">
																<h4 class="infoContent">포인트 / 적립금 사용</h4>
															</c:when>
															<c:otherwise>
															<h4 class="infoContent">${detailOrder.paymentMethod}</h4>
															</c:otherwise> 
															</c:choose>
														</li>

														<li class="pb-0">
															<h4 class="infoTitle">결제 상태 :</h4>
															<h4 class="infoContent">${detailOrder.paymentStatus }</h4>
														</li>


														<li class="pb-0">
															<h4 class="infoTitle">결제시간 :</h4>
															<h4 class="infoContent detailOrderOrderTime">
																<fmt:formatDate value="${detailOrder.paymentTime }"
																	type="date" />
															</h4>
														</li>


														<c:if test="${detailOrder.cardName != null}">
															<li class="pb-0">
																<h4 class="infoTitle">결제카드 :</h4>
																<h4 class="infoContent">${detailOrder.cardName }</h4>
															</li>
														</c:if>

														<c:if test="${detailOrder.cardNumber != null}">
															<li class="pb-0">
																<h4 class="infoTitle">카드번호 :</h4>
																<h4 class="infoContent">${detailOrder.cardNumber }</h4>
															</li>
														</c:if>

													</ul>
												</c:otherwise>
											</c:choose>

										</div>
									</div>
								</div>
							</div>
							<div class="moveBtn">
								<button class="btn theme-bg-color text-white m-0" type="button"
									id="button-addon1" onclick="location.href='myPage';">
									<span>마이페이지로</span>
								</button>
								<button class="btn theme-bg-color text-white m-0" type="button"
									id="button-addon1" onclick="location.href='/';">
									<span>메인페이지로</span>
								</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!-- Cart Section End -->

	<!-- Footer Section Start -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Footer Section End -->

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipient"
							value="${detailOrder.recipientName }" name="recipient"
							placeholder="받는사람" /><label for="recipient">받는사람</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipientContact"
							value="${detailOrder.recipientPhoneNumber }"
							name="recipientContact" placeholder="받는사람 연락처" /><label
							for="recipientContact">받는사람 연락처</label>
						<p>- 포함해서 입력해주세요.</p>
					</div>

					<div>
						<button type="button" class="btn theme-bg-color btn-md text-white"
							onclick="sample6_execDaumPostcode('editZipNo', 'editAddr', 'editAddrDetail', 'editExtraAddress');">주소
							검색</button>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editZipNo" id="editZipNo"
							value="${detailOrder.zipCode }" name="zipCode" placeholder="우편번호"
							readonly /><label for="editZipNo">우편번호</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editAddr" id="editAddr"
							value="${detailOrder.shippingAddress }" name="address"
							placeholder="주소" readonly /><label for="editAddr">주소</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editAddrDetail"
							value="${detailOrder.detailedShippingAddress }"
							id="editAddrDetail" name="detailAddress" placeholder="상세주소" /><label
							for="editAddrDetail">상세주소</label>
					</div>
					
					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control"
							id="editExtraAddress" name="detailAddress" placeholder="참고항목" /><label
							for="editExtraAddress">참고항목</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control editDeliveryMsg"
							value="${detailOrder.deliveryMessage }" id="editDeliveryMsg"
							name="deliveryMessage" placeholder="배송메세지" /><label
							for="editDeliveryMsg">배송메세지</label>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="shippingAddrModify();" data-bs-dismiss="modal">변경</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="change-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 변경</h5>
					<button
						class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
						data-bs-toggle="modal" data-bs-target="#add-address">
						<i data-feather="plus" class="me-2"></i> 새로운 배송지
					</button>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<c:forEach var="addr" items="${userAddrList }">
						<div class="col-xxl-6 col-lg-12 col-sm-6 addrInfo">
							<div class="contact-detail-box">
								<div class="contact-icon"></div>
								<div class="contact-detail-title">
									<h4 id="doRecipient">
										<i class="fa-solid fa-location-dot"></i> ${addr.recipient }
										<c:if test="${fn:contains(addr.basicAddr,'Y')}">
											<span class="basicAddr">기본배송지</span>
										</c:if>
										<input class="form-check-input" type="radio"
											value="${addr.addrSeq }" id="checkAddr" name="checkAddr" />
									</h4>
								</div>

								<div class="contact-detail-contain">
									<div id="doRecipientContact">${addr.recipientContact }</div>
									<div id="doZipCode">${addr.zipCode }</div>
									<div id="doAddress">${addr.address }</div>
									<div id="doDetailAddress">${addr.detailAddress }</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<div
						class="form-floating mb-4 theme-form-floating changeDeliveryMessage">
						<input type="text" class="form-control changeDeliveryMessage"
							id="changeDeliveryMessage" name="deliveryMessage"
							placeholder="배송메세지" /><label for="changeDeliveryMessage">배송메세지</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="editBasicShippingAddress();" data-bs-dismiss="modal">변경</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- 주문 취소 modal box start -->
	<div class="modal fade theme-modal" id="cancel-order" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">취소</h5>

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<input class="checkbox_animated check-box selectAll" type="checkbox"
						name="order" id="selectAllOrder" onclick="selectAll('selectAllOrder');"
						 /> <label
						class="form-check-label" for="selectAllOrder"><span>전체선택</span></label>
					<c:forEach var="order" items="${detailOrderInfo }">
						<table class="table mb-0 productInfo">
							<c:if
								test="${order.productStatus == '출고전' || order.productStatus == '입금전' || order.productStatus == '결제완료' || order.productStatus == '부분취소'}">
								<tbody>
									<tr>
										<td class="product-detail">
											<div class="product border-0">
												<c:choose>
													<c:when test="${order.productImage != '' }">
														<input
															class="checkbox_animated check-box selectOrderCancel"
															type="checkbox" value="${order.detailedOrderId }"
															name="order" onchange="isChecked('selectOrderCancel')"
															id="${order.productId }" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="${order.productImage }" id="cancelOrderImg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:when>
													<c:otherwise>
														<input
															class="checkbox_animated check-box selectOrderCancel"
															type="checkbox" value="${order.detailedOrderId }"
															 name="order" onchange="isChecked('selectOrderCancel')"
															id="${order.productId }" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="/resources/assets/images/noimage.jpg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:otherwise>
												</c:choose>
												<c:set var="productNameLength"
													value="${fn:length(order.productName)}" />
												<c:choose>
													<c:when test="${productNameLength <= 5}">
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${order.productName }</a>
														</td>
													</c:when>
													<c:otherwise>
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${fn:substring(order.productName, 0, 5)}...</a>
														</td>
													</c:otherwise>
												</c:choose>
											</div>

										</td>

										<td class="price">
											<h4 class="table-title text-content">상품금액</h4>
											<h6 class="theme-color refundProductPrice">
												<fmt:formatNumber value="${order.productPrice * order.productQuantity}"
													type="NUMBER" />
												원
											</h6>
										</td>

										<td class="name">
											<h4 class="table-title text-content">수량</h4> <input
											type="text" class="form-control cancelQty" id="cancelQty"
											onchange="selectOrderCancel('selectOrderCancel', 'refundAmount', 'refundReward', 'refundPoint');" value="0"/>

										</td>

										<td class="name">
											<h4 class="table-title text-content">상품상태</h4>
											<h5 class="productStatus">${order.productStatus }</h5>
										</td>

									</tr>
								</tbody>
							</c:if>
						</table>
					</c:forEach>
					<div class="totalCancelQty"></div>
					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="cancelReason"
							name="reason" placeholder="취소 사유" /><label for="cancelReason">취소
							사유</label>
						<p>* 필수 항목 입니다.</p>
					</div>

					<c:choose>
						<c:when test="${detailOrder.paymentMethod eq 'bkt'}">
							<ul class="summery-contain pb-0 border-bottom-0">
								<li class="pb-0 refundList">
									<h4>결제수단</h4> <c:if
										test="${detailOrder.paymentMethod eq 'bkt' }">
										<span>무통장 입금</span>
									</c:if>
								</li>

								<li class="pb-0 refundList">
									<h4>환불은행</h4> <span id="changeRefundBank">${userInfo.refundBank }</span>
								</li>

								<li class="pb-0 refundList">
									<h4>환불계좌</h4> <span id="changeRefundAccount">${userInfo.refundAccount }</span>
								</li>

								<li class="pb-0 refundList">
									<h4>예금주</h4> <span id="changeAccountHolder">${userInfo.accountHolder }</span>
								</li>

								<li class="pb-0 refundList">
									<button class="btn theme-bg-color btn-md text-white"
										onclick="showRefund();" type="button">변경</button>
								</li>

							</ul>
							
							<div class="editRefund">

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<input type="text" class="form-control" id="accountHolder"
											placeholder="예금주" /> <label for="accountHolder">예금주</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<input type="text" class="form-control" id="refundAccount"
											placeholder="환불계좌" /> <label for="refundAccount">환불계좌</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<select class="form-select" id="floatingSelect2 newRefundBank"
											name="refundBank" aria-label="Floating label select example">
											<option selected>환불받으실 은행을 선택해주세요.</option>
											<option value="KB국민은행">KB국민은행</option>
											<option value="신한은행">신한은행</option>
											<option value="우리은행">우리은행</option>
											<option value="하나은행">하나은행</option>
											<option value="SC제일은행">SC제일은행</option>
											<option value="씨티은행">씨티은행</option>
											<option value="NH농협은행">NH농협은행</option>
											<option value="수협은행">수협은행</option>
											<option value="케이뱅크">케이뱅크</option>
											<option value="카카오뱅크">카카오뱅크</option>
											<option value="토스뱅크">토스뱅크</option>
											<option value="대구은행">대구은행</option>
											<option value="BNK부산은행">BNK부산은행</option>
											<option value="경남은행">경남은행</option>
											<option value="광주은행">광주은행</option>
											<option value="전북은행">전북은행</option>
											<option value="제주은행">제주은행</option>
											<option value="우체국">우체국</option>
											<option value="새마을금고">새마을금고</option>
										</select> <label for="floatingSelect">환불은행</label>
									</div>
								</div>

								<div class="col-12">
									<button class="btn theme-bg-color btn-md text-white"
										onclick="editRefundAccount();" type="button">변경</button>
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<ul class="summery-contain pb-0 border-bottom-0">

								<li class="pb-0 refundList">
									<h4>결제수단</h4> <span>${detailOrder.paymentMethod}</span>
								</li>

								<c:if test="${detailOrder.cardName != null}">
									<li class="pb-0 refundList">
										<h4>결제카드</h4> <span>${detailOrder.cardName }</span>
									</li>
								</c:if>

								<c:if test="${detailOrder.cardNumber != null}">
									<li class="pb-0 refundList">
										<h4>카드번호</h4> <span>${detailOrder.cardNumber }</span>
									</li>
								</c:if>

							</ul>
						</c:otherwise>
					</c:choose>
				
					<ul class="summery-contain pb-0 border-bottom-0">

						<li class="pb-0 refundList">
							<h4>환불 금액</h4> <span id="refundAmount"></span>

						</li>
						
						<c:choose>
							<c:when test="${detailOrder.usedPoints != 0 }">
								<li class="pb-0 refundList">
									<h4>환불 포인트</h4> <span id="refundPoint"> </span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pb-0 refundList">
									<h4>환불 포인트</h4> <span id="refundPoint">0점</span>
								</li>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${detailOrder.usedReward != 0 }">
								<li class="pb-0 refundList">
									<h4>환불 적립금</h4> <span id="refundReward"> </span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pb-0 refundList">
									<h4>환불 적립금</h4> <span id="refundReward">0원</span>
								</li>
							</c:otherwise>
						</c:choose>
						
						<li class="pb-0 refundList"><c:if
								test="${couponHistory != null}">
								<h4>환불 예정 쿠폰</h4>

								<div class="couponsHistory">
									<span class="refundCoupon"></span>
								</div>

							</c:if></li>

					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="return orderCancel();">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 주문 취소 modal box end -->

	<!-- 반품 modal box start -->
	<div class="modal fade theme-modal selectAll" id="return-order" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">반품</h5>

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<input class="checkbox_animated check-box" type="checkbox"
						name="order" id="selectAllReturnOrder"
						onclick="selectAllReturn();"/> <label
						class="form-check-label" for="selectAllReturnOrder"><span>전체선택</span></label>
					<c:forEach var="order" items="${detailOrderInfo }">
						<table class="table mb-0 productInfo">
							<c:if test="${order.productStatus == '배송완료'}">
								<tbody>
									<tr>
										<td class="product-detail">
											<div class="product border-0">
												<c:choose>
													<c:when test="${order.productImage != '' }">
														<input
															class="checkbox_animated check-box selectReturn"
															type="checkbox" value="${order.detailedOrderId }"
															name="order" onchange="isChecked('selectReturn')"
															id="selectOrderCancel" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="${order.productImage }" id="cancelOrderImg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:when>
													<c:otherwise>
														<input
															class="checkbox_animated check-box selectReturn"
															type="checkbox" value="${order.detailedOrderId }"
															name="order" onchange="isChecked('selectReturn')"
															id="selectOrderCancelWithNoImg" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="/resources/assets/images/noimage.jpg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:otherwise>
												</c:choose>
												<c:set var="productNameLength"
													value="${fn:length(order.productName)}" />
												<c:choose>
													<c:when test="${productNameLength <= 5}">
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${order.productName }</a>
														</td>
													</c:when>
													<c:otherwise>
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${fn:substring(order.productName, 0, 5)}...</a>
														</td>
													</c:otherwise>
												</c:choose>
											</div>

										</td>

										<td class="price">
											<h4 class="table-title text-content">상품금액</h4>
											<h6 class="theme-color productPrice">
												<fmt:formatNumber value="${order.productPrice }"
													type="NUMBER" />
												원
											</h6>
										</td>

										<td class="name">
											<h4 class="table-title text-content">수량</h4> <input
											type="text" class="form-control cancelQty" id="cancelQty"
											value="0" onchange="selectOrderCancel('selectReturn', 'refundAmountOfReturn', 'refundRewardOfReturn', 'refundPointOfReturn');" />

										</td>

										<td class="name">
											<h4 class="table-title text-content">상품상태</h4>
											<h5>${order.productStatus }</h5>
										</td>

									</tr>
								</tbody>
							</c:if>
						</table>
					</c:forEach>
					<div class="totalCancelQty"></div>
					<div class="form-floating mb-4 theme-form-floating">
						반품 사유<input type="text" class="form-control" id="returnReason"
							value="상품 하자" name="reason" readonly="readonly" />
						<div class="deliverMsg">
							<i class="fa-solid fa-circle-exclamation" style="color: #ff0059;"></i>
							상품에 하자가 있는 경우에만 반품이 가능합니다.
						</div>
					</div>

					<h4>회수 주소 
					<i data-feather="edit" class="me-2" onclick="sample6_execDaumPostcode('returnZipNo', 'returnAddr', 'returnDetailAddr', 'returnExtraAddress');"></i></h4>
					<ul class="summery-contain pb-0 border-bottom-0">
						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.zipCode }"
							id="returnZipNo" name="zipCode" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.shippingAddress }"
							id="returnAddr" name="shippingAddress" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control"
							value="${detailOrder.detailedShippingAddress }"
							id="returnDetailAddr" name="detailedShippingAddress" /></li>
							
						<li class="pb-0 refundList"><input type="text"
							class="form-control"
							value="${detailOrder.detailedShippingAddress }" id="returnExtraAddress" /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.deliveryMessage }"
							id="returnMsg" name="deliveryMessage" placeholder="메세지" /></li>

					</ul>


					<c:choose>
						<c:when test="${detailOrder.paymentMethod eq 'bkt' }">
							<ul class="summery-contain pb-0 border-bottom-0">
								<li class="pb-0 refundList">
									<h4>결제수단</h4> <c:if
										test="${detailOrder.paymentMethod eq 'bkt' }">
										<span>무통장 입금</span>
									</c:if>
								</li>

								<li class="pb-0 refundList">
									<h4>환불은행</h4> <span id="returnBank">${userInfo.refundBank }</span>
								</li>

								<li class="pb-0 refundList">
									<h4>환불계좌</h4> <span id="returnAccount">${userInfo.refundAccount }</span>
								</li>

								<li class="pb-0 refundList">
									<h4>예금주</h4> <span id="returnHolder">${userInfo.accountHolder }</span>
								</li>

								<li class="pb-0 refundList">
									<button class="btn theme-bg-color btn-md text-white"
										onclick="showRefund();" type="button">변경</button>
								</li>

							</ul>

							<div class="editRefund">

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<input type="text" class="form-control"
											id="changeReturnAccountHolder" placeholder="예금주" /> <label
											for="changeReturnAccountHolder">예금주</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<input type="text" class="form-control"
											id="changeReturnAccount" placeholder="환불계좌" /> <label
											for="changeReturnAccount">환불계좌</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-floating theme-form-floating">
										<select class="form-select" id="floatingSelect2"
											name="selectReturnBank"
											aria-label="Floating label select example">
											<option>환불받으실 은행을 선택해주세요.</option>
											<option value="KB국민은행">KB국민은행</option>
											<option value="신한은행">신한은행</option>
											<option value="우리은행">우리은행</option>
											<option value="하나은행">하나은행</option>
											<option value="SC제일은행">SC제일은행</option>
											<option value="씨티은행">씨티은행</option>
											<option value="NH농협은행">NH농협은행</option>
											<option value="수협은행">수협은행</option>
											<option value="케이뱅크">케이뱅크</option>
											<option value="카카오뱅크">카카오뱅크</option>
											<option value="토스뱅크">토스뱅크</option>
											<option value="대구은행">대구은행</option>
											<option value="BNK부산은행">BNK부산은행</option>
											<option value="경남은행">경남은행</option>
											<option value="광주은행">광주은행</option>
											<option value="전북은행">전북은행</option>
											<option value="제주은행">제주은행</option>
											<option value="우체국">우체국</option>
											<option value="새마을금고">새마을금고</option>
										</select> <label for="floatingSelect">환불은행</label>
									</div>
								</div>

								<div class="col-12">
									<button class="btn theme-bg-color btn-md text-white"
										onclick="editRturnAccount();" type="button">변경</button>
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<ul class="summery-contain pb-0 border-bottom-0">

								<li class="pb-0 refundList">
									<h4>결제수단</h4> <span>${detailOrder.paymentMethod}</span>
								</li>

								<c:if test="${detailOrder.cardName != null}">
									<li class="pb-0 refundList">
										<h4>결제카드</h4> <span>${detailOrder.cardName }</span>
									</li>
								</c:if>

								<c:if test="${detailOrder.cardNumber != null}">
									<li class="pb-0 refundList">
										<h4>카드번호</h4> <span>${detailOrder.cardNumber }</span>
									</li>
								</c:if>

							</ul>
						</c:otherwise>
					</c:choose>

					<ul class="summery-contain pb-0 border-bottom-0">

						<li class="pb-0 refundList">
							<h4>환불 금액</h4> <span id="refundAmountOfReturn"></span>

						</li>

						<c:choose>
							<c:when test="${detailOrder.usedPoints != 0 }">
								<li class="pb-0 refundList">
									<h4>환불 포인트</h4> <span id="refundPointOfReturn"> </span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pb-0 refundList">
									<h4>환불 포인트</h4> <span id="refundPointOfReturn">0점</span>
								</li>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${detailOrder.usedReward != 0 }">
								<li class="pb-0 refundList">
									<h4>환불 적립금</h4> <span id="refundRewardOfReturn"> </span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pb-0 refundList">
									<h4>환불 적립금</h4> <span id="refundRewardOfReturn">0원</span>
								</li>
							</c:otherwise>
						</c:choose>
						
						<li class="pb-0 refundList"><c:if
								test="${couponHistory != null}">
								<h4>환불 예정 쿠폰</h4>

								<div class="couponsHistory">
									<span class="refundCoupon"></span>
								</div>

							</c:if></li>

					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="applyReturn();">신청</button>
				</div>
			</div>
		</div>
	</div>
	<!--  반품 modal box end -->

	<!-- 교환 modal box start -->
	<div class="modal fade theme-modal" id="exchange-order" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">교환</h5>

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<input class="checkbox_animated check-box selectAll" type="checkbox"
						name="order" id="selectAllExchangeOrder"
						onclick="selectAll('selectAllExchangeOrder');"/> <label
						class="form-check-label" for="selectAllExchangeOrder"><span>전체선택</span></label>
					<c:forEach var="order" items="${detailOrderInfo }">
						<table class="table mb-0 productInfo">
							<c:if test="${order.productStatus == '배송완료'}">
								<tbody>
									<tr>
										<td class="product-detail">
											<div class="product border-0">
												<c:choose>
													<c:when test="${order.productImage != '' }">
														<input
															class="checkbox_animated check-box selectExchange"
															type="checkbox" value="${order.detailedOrderId }"
															onchange="isChecked('selectExchange')" name="order"
															id="selectOrderCancel" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="${order.productImage }" id="cancelOrderImg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:when>
													<c:otherwise>
														<input
															class="checkbox_animated check-box selectExchange"
															type="checkbox" value="${order.detailedOrderId }"
															onchange="isChecked('selectExchange')" name="order"
															id="selectOrderCancelWithNoImg" />
														<a href="/detail/${order.productId }"
															class="product-image"> <img
															src="/resources/assets/images/noimage.jpg"
															class="img-fluid blur-up lazyload"
															alt="${order.productName }">
														</a>
													</c:otherwise>
												</c:choose>
												<c:set var="productNameLength"
													value="${fn:length(order.productName)}" />
												<c:choose>
													<c:when test="${productNameLength <= 5}">
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${order.productName }</a>
														</td>
													</c:when>
													<c:otherwise>
														<td class="name">
															<h4 class="table-title text-content">상품이름</h4> <a
															href="/detail/${order.productId }" id="productName">${fn:substring(order.productName, 0, 5)}...</a>
														</td>
													</c:otherwise>
												</c:choose>
											</div>

										</td>

										<td class="price">
											<h4 class="table-title text-content">상품금액</h4>
											<h6 class="theme-color productPrice">
												<fmt:formatNumber value="${order.productPrice }"
													type="NUMBER" />
												원
											</h6>
										</td>

										<td class="name">
											<h4 class="table-title text-content">수량</h4> <input
											type="text" class="form-control cancelQty" id="cancelQty"
											value="0" />

										</td>

										<td class="name">
											<h4 class="table-title text-content">상품상태</h4>
											<h5>${order.productStatus }</h5>
										</td>

									</tr>
								</tbody>
							</c:if>
						</table>
					</c:forEach>
					<div class="totalCancelQty"></div>
					<div class="form-floating mb-4 theme-form-floating">
						교환 사유<input type="text" class="form-control" id="exchangeReason"
							value="상품 하자" name="reason" readonly="readonly" />
						<div class="deliverMsg">
							<i class="fa-solid fa-circle-exclamation" style="color: #ff0059;"></i>
							상품에 하자가 있는 경우에만 교환이 가능합니다.
						</div>
					</div>

					<h4>회수 주소 <i data-feather="edit" class="me-2" 
							onclick="sample6_execDaumPostcode('collectZipNo', 'collectAddr', 'collecDetailAddr', 'collecExtraAddress');"></i></h4>
					<ul class="summery-contain pb-0 border-bottom-0">
						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.zipCode }"
							id="collectZipNo" name="zipCode" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.shippingAddress }"
							id="collectAddr" name="shippingAddress" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control"
							value="${detailOrder.detailedShippingAddress }"
							id="collecDetailAddr" name="detailedShippingAddress" /></li>
							
						<li class="pb-0 refundList"><input type="text"
							class="form-control" id="collecExtraAddress"/></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.deliveryMessage }"
							id="collecMsg" name="collecMsg" placeholder="메세지" /></li>
					</ul>

					<h4>교환 받을 주소 
						<i data-feather="edit" class="me-2" 
							onclick="sample6_execDaumPostcode('exchangeZipNo', 'exchangeAddr', 'exchangeDetailAddr', 'exchangeExtraAddress');"></i>
					</h4>
					<ul class="summery-contain pb-0 border-bottom-0">	
						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.zipCode }"
							id="exchangeZipNo" name="exchangeZipNo" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.shippingAddress }"
							id="exchangeAddr" name="exchangeAddr" readonly /></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control"
							value="${detailOrder.detailedShippingAddress }"
							id="exchangeDetailAddr" name="exchangeDetailAddr" /></li>
							
						<li class="pb-0 refundList"><input type="text"
							class="form-control"
							value="${detailOrder.detailedShippingAddress }" id="exchangeExtraAddress"/></li>

						<li class="pb-0 refundList"><input type="text"
							class="form-control" value="${detailOrder.deliveryMessage}"
							id="exchangeMsg" name="exchangeMsg" placeholder="메세지" /></li>
					</ul>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="applyExchange();">신청</button>
				</div>
			</div>
		</div>
	</div>
	<!--  교환 modal box end -->

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
	<script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>
	<script src="/resources/assets/js/bootstrap/popper.min.js"></script>

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
</body>
</html>