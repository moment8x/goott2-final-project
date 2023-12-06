<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="/resources/js/ksh/addr.js"></script>
<script src="/resources/js/ksh/calcPayment.js"></script>
<script src="/resources/js/ksh/payment.js"></script>
<script>
   let couponQty = $('.categoryKeys').length;
   let itemLen = $(".summery-contain").find("li").length; // 상품 종류
   let viewTotalAmount = 0;
   // let viewTotalAmount = Number('${requestScope.paymentInfo.totalAmount}');
   let couponAmount = 0;
   let couponDiscoutAmount = 0;
   let discountCount = 0;
   let output = "";
   let discountAmount = 0;   
   let totalAmount = Number('${requestScope.paymentInfo.totalAmount}');
   let shippingFee = Number('${requestScope.paymentInfo.shippingFee}');
   let IMP = window.IMP;
   IMP.init("${impKey}") // 예: 'imp00000000a'
   let isPaid = false;
   let orderId = ('${requestScope.orderId}');
   let productCategory = '${requestScope.productCategory}';
   productCategories = productCategory.substr(1).slice(0, -1).replaceAll(" ", "").split(',');
   let products = [];
   let couponNumbers = [];
   let createName = "";
   let couponIndex = [];
   let couponProduct = [];
   let j = 0;
   let deliveryMessage = "";
   let rewardBtn = 0; 
   let pointBtn = 0;
   $(function() {
	   itemLen = $(".summery-contain").find("li").length; // 상품 종류
      
      $("#orderNo").val(orderId);
      $("#memberId").val('${requestScope.member.memberId}');
   
      $("#deliveryStatus").val("결제완료");
      $("#payToAmount").text((totalAmount + shippingFee - discountAmount).toLocaleString('ko-KR'));
      $('#discountAmount').text(discountAmount.toLocaleString('ko-KR'));
      $('#subTotal').text(totalAmount.toLocaleString('ko-KR'));
      $('#shippingFee').text(shippingFee.toLocaleString('ko-KR'));
   	  console.log(itemLen);
      for(i=0; i<itemLen; i++) {
    	  let localePrice = (Number($('#productPrice'+i).text())).toLocaleString('ko-KR');
    	  $('#productPrice'+i).text(localePrice);
      }
      for (i=0; i<$('.categoryKeys').length; i++) {   // 쿠폰 갯수만큼 돌아라
         console.log(productCategories);
         j=0;
         couponProduct = [];
         couponIndex[i] = new Object();
         productCategories.forEach(function(item, index){   // 상품 갯수만큼 돌아라
            if(($('#categoryKey'+i).val().indexOf(item)) != -1 || $('#categoryKey'+i).val().indexOf('ALL') != -1) {
               // 일치하는 카테고리 존재
               console.log("쿠폰카테고리",$('#categoryKey'+i).val());
               console.log("상품카테고리",item);
               $('#couponSelect').attr('style', 'display:');
               $('#couponShow').text("쿠폰 선택");
               $('#categoryKey'+i).attr('style','display:');
               if(($('#categoryKey'+i).val().indexOf(item)) != -1) {
               console.log("야호");
                  couponIndex[i].no = i;
                  couponIndex[i].name = $('#categoryKey'+i).text();
                  couponIndex[i].index = [];
                  couponProduct[j] = index;
                  couponIndex[i].index = couponProduct.slice();
                  j++;
                  console.log(couponIndex);
               }
            } else {   // 일치하지 않으면
               console.log($('#categoryKey'+i).val());
               console.log(item);
               couponIndex[i].name = $('#categoryKey'+i).text();
               console.log("되나?")
            }
         })
      }
      $("#couponSelect").on("change", function(){
         
         couponQty = $('.categoryKeys').length;   // 쿠폰 갯수
         let selectedCoupon = $("option:selected", this).text();
         if($("option:selected", this).text() == "쿠폰 초기화") {
            selectedCoupon = "";
            output = "";
            couponAmount = 0;
            //totalAmount = Number('${requestScope.paymentInfo.totalAmount}');
            discountCount = 0;
            for(let i = 0; i<couponIndex.length; i++) {
               if(couponIndex[i].no != null) {
                  $('#categoryKey'+i).css("display","");
               }
            }
            calc();
         } else {
            if(Number($("#payToAmount").text().replaceAll(",","")) == 0) {
               alert("더이상 차감할 금액이 없습니다.");
               //$('#couponSelect option:eq(0)').prop('selected',true);
               return;
            }
            
         let selectedIndex = $("option:selected", this).attr("id").slice(-1);   // ex) categoryKey0
         if(discountCount <= couponQty-1) {
            
         //let discountMethod = $('#discountMethod'+selectedIndex).text();
         let couponDiscountAmount = Number($('#discountAmount'+selectedIndex).text());
            //if (discountMethod == "P") {
               // 그 상품에만 적용
               console.log(couponIndex.length);
               for(let i = 0; i<couponIndex.length; i++) {
               console.log(couponIndex[i]);
                  if(selectedIndex == couponIndex[i].no) {
                     for(let k = 0; k < couponIndex[i].index.length; k++) {   
                     couponAmount += Math.round(((Number($('#productPrice'+couponIndex[i].index[k]).text().replaceAll(",",""))*Number($('#productQty'+couponIndex[i].index[k]).text())) * (couponDiscountAmount/100)) / 10) * 10;
                     console.log(couponAmount);
                     }
                     $('#categoryKey'+selectedIndex).css("display","none");
                     console.log("오잉?",'#categoryKey'+selectedIndex);
                  }
               }
               //couponDiscountAmount = Math.floor((totalAmount - (totalAmount * (discountAmount/100)))/10)*10;
            //} else {
               //couponDiscountAmount = totalAmount - discountAmount;
               //couponAmount += couponDiscountAmount;
             //}
               discountCount++;
               calc(selectedIndex);
         }
         // $('#categoryKey'+selectedIndex).attr("style","display: none"); 
            if(output.indexOf(selectedCoupon) == -1) {
               output += '<button type="button" class="greenBtn saveCoupon">'+selectedCoupon+'</button>';
            }
         }
          $('#selectedCoupon').html(output);
      });
   
      $("#selectMessage").on("change", function(){

  		if($("option:selected", this).text() == "직접입력") {
  			$('#directInput').attr('style', 'display:');
  			console.log("hi");
  		} else {
  			$('#directInput').attr('style', 'display:none');	
  		}
  		});
      
      
   });
   
   
   
   function packData() {
      for(i=0; i<itemLen; i++) {
         products[i] = new Object();
         products[i].orderNo = orderId;
         products[i].productId = $(".summery-contain").find("li").eq(i).attr("id");
         products[i].productQuantity = $('#productQty'+i).text();
         products[i].productPrice = $('#productPrice'+i).text().replaceAll(",","");
         products[i].productStatus = $("#deliveryStatus").val();
         products[i].productOrderNo = orderId + "-"+(i+1);
      }
         $('#addRecipient').val($('#recipient').text());
         $('#addAddress').val($('#address').text());
         $('#addDetailAddress').val($('#detailAddress').text());
         $('#addZipCode').val($('#zipCode').text());
         $('#addRecipientContact').val($('#recipientContact').text());
      
      
      console.log($('#selectedCoupon').find("button").length);
      if($('#selectedCoupon').find("button").length > 0) {
         
      for (i=0; i<$('#selectedCoupon').find("button").length; i++) {
         
         let couponNumber = $('#selectedCoupon').find("button:eq("+i+")").text().split("-")[1];
         
         console.log(couponNumber);
         couponNumbers[i] = couponNumber;
         
      }
      } else {
         couponNumbers[0] = "N";
      }
      
      if(itemLen > 1) {
         createName = $('#productName0').text()+" 외 "+(itemLen - 1)+"개";
      } else {
         createName = $('#productName0').text();
      }
      
      if($("select[name=deliveryMessage] option:selected").text() == "직접입력") {
    	  console.log('여기오냐');
    	  deliveryMessage = $('#directInput').val();
      } else {
    	  deliveryMessage = $("select[name=deliveryMessage] option:selected").text();
      }
      console.log(deliveryMessage);
      console.log(createName);
      console.log(products);
      console.log(couponNumbers);
   }
   
   

   function identify() {
      // IMP.certification(param, callback) 호출
      IMP
            .certification(
                  { // param
                     pg : 'MIIiasTest',//본인인증 설정이 2개이상 되어 있는 경우 필수 
                     merchant_uid : "ORD20180131-0000011", // 주문 번호
                     m_redirect_url : "http://localhost:8081/order/nonMemberOrder?productId=S000208719388", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                     popup : false
                  // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
                  },
                  function(rsp) { // callback
                     if (rsp.success) {
                        alert("본인인증 성공");
                        console.log(rsp);
                     } else {
                        alert("본인인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                     }
                  });
   }

   

   function checkPayMethod() {
	   let payNo = "";
	   let objAmountToPay = 0;
      if ($("input[name='payMethod']").is(':checked')) {
         // 전체 radio 중에서 하나라도 체크되어 있는지 확인
         // 아무것도 선택안되어있으면, false
         let payMethod = $("input[name='payMethod']:checked").val();
         if($('#payToAmount').text() == '0') {	// 포인트랑 적립금만 사용해서 결제할 때
        	 console.log("?");
				payMethod = "ptr";	
	        	 payNo = "ptr_"
		                  + ((String(new Date().getTime())).substring(1));
	        	 let objAmountToPay = 0;
	        	 $("#deliveryStatus").val("결제완료");
				} else if(payMethod == "bkt") {
					$("#deliveryStatus").val("입금전");
					payNo = "bkt_"
		                  + ((String(new Date().getTime())).substring(1));
					objAmountToPay = Number($('#payToAmount').text().replaceAll(",",""));
				}
         // score의 라디오 중 체크된 것의 값만 가져옴
         // 아무것도 선택안되어있으면, undefined
         console.log(payMethod);
         if (payMethod == "bkt"  || payMethod == "ptr") { 
            packData();
            obj = {
               "paymentNumber" : payNo, // 결제번호 생성 코드 필요
               "orderNo" : orderId, // 주문번호
               "paymentMethod" : payMethod, // 결제수단
               "totalAmount" : totalAmount, // 총 상품 금액
               "shippingFee" : shippingFee, // 배송비
               "usedPoints" : Number($('#usingPoints').val()), // 사용한 포인트
               "usedReward" : Number($('#usingRewards').val()), // 사용한 적립금
               "amountToPay" : objAmountToPay, // (total+배송비-포인트-적립금-쿠폰할인금액)
               "actualPaymentAmount" : 0, // 실 결제 금액(무통장입금과 재화결제(포인트, 적립금)은 default 0)
               "recipientName" : $("#recipient").text(),
               "phoneNumber" : $('#recipientContact').text(),
               products,
               couponNumbers,
               orderHistory : {
             		  "recipientName" : $('#recipient').text(),
             		  "recipientPhoneNumber" : $('#recipientContact').text(),
             		  "zipCode" : $('#zipCode').text(),
             		  "shippingAddress" : $('#address').text(),
             		  "detailedShippingAddress" : $('#detailAddress').text().replaceAll("\n",""),
             		  "deliveryMessage" : deliveryMessage,
               }
            };
            console.log(obj);
                     
            $.ajax({
               url : "/pay/output",
               type : "POST",
               contentType : "application/json",
               data : JSON.stringify(obj),
               async : false,
               success : function(result) {
                  isPaid = true;
                  console.log(result);
                  if (isPaid) {
                     // 주문 완료 페이지에 필요한 것 - 작업중!!!!!!!!!!!!!
                     $("#requestOrder").submit();
                  }
                  // alert("결제 완료");
               },
               error : function(error) {
                  alert("결제 실패" + error);
               }
            })
         } else {
            packData();
            kg_pay();
         }
      }
   }

   function changeAddr() {
      if($('input[name=jack]').is(':checked')) {
         
      let checkVal = $('input[name=jack]:checked').val();
      $('#recipient').text($('#recipient'+checkVal).text());
      $('#address').text($('#address'+checkVal).text());
      $('#detailAddress').text($('#detailAddress'+checkVal).text());
      $('#zipCode').text($('#zipCode'+checkVal).text());
      $('#recipientContact').text($('#recipientContact'+checkVal).text());
      $("#myAddrModal").hide();
      } else {
         alert("변경할 배송지를 선택해주세요.")
      }
   }
   
   function showAddrModal() {
      $("#myAddrModal").show();
   }
   
 
   
   function inputRewards() {
      if($('#usingRewards').val() == "") {
         alert("사용하실 적립금을 입력해주세요");
         $("input:checkbox[name='checkRewards']").prop("checked", false);
      } else {
         checkNumber('rewards');   
      }
         
      }
   
   function inputPoints() {
      
      if($('#usingPoints').val() == "") {
         alert("사용하실 포인트를 입력해주세요");
         $("input:checkbox[name='checkRewards']").prop("checked", false);
      } else {
         checkNumber('points');
      }
   }
   
   function closeAddrModal() {
	   $("#myAddrModal").hide();
   }
   
</script>
<style>
#iframeSon {
	width: 100%;
	background-color: white;
}

.greenBtn {
	background-color: #0da487;
	color: white;
	"
}
</style>
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
	<section class="breadscrumb-section pt-0">

		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>Checkout</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">Checkout</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Checkout section Start -->
	<section class="checkout-section-2 section-b-space">
		       <form action="orderComplete" method="post" id="requestOrder">
 
		<input type="hidden" name="orderNo" id="orderNo" value=""> <input
			type="hidden" name="memberId" value="" id="memberId"><input
			type="hidden" name="deliveryStatus" id="deliveryStatus" value="">
			</form>
		<div class="container-fluid-lg">
			<div class="row g-sm-4 g-3">
				<div class="col-lg-8">
					<div class="left-sidebar-checkout">
						<div class="checkout-detail-box">
							<ul>
								<li>
									<div class="checkout-icon">
										<lord-icon target=".nav-item"
											src="https://cdn.lordicon.com/ggihhudh.json"
											trigger="loop-on-hover"
											colors="primary:#121331,secondary:#646e78,tertiary:#0baf9a"
											class="lord-icon"> </lord-icon>
									</div>

									<div class="checkout-box">
										<div class="checkout-title">
											<h4>배송지</h4>
											<!-- 모달 시작 -->
											<!-- Button to Open the Modal -->
											<button onclick="showAddrModal()" type="button"
												class="btn btn-primary" data-bs-toggle="modal"
												data-bs-target="myAddrModal">다른 배송지</button>

											<!-- The Modal -->
											<div class="modal" id="myAddrModal">
												<div class="modal-dialog">
													<div class="modal-content">

														<!-- Modal Header -->
														<div class="modal-header">
															<h4 class="modal-title">배송지 선택</h4>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal" onclick="closeAddrModal()"></button>
														</div>

														<!-- Modal body -->
														<div class="modal-body">
															<div class="checkout-detail">
																<c:forEach var="addr"
																	items="${requestScope.shippingAddr }"
																	varStatus="status">
																	<div class="row g-4">
																		<div class="col-12">
																			<div class="delivery-address-box">
																				<div>
																					<div class="form-check">
																						<input class="form-check-input" type="radio"
																							name="jack" id="${status.index }"
																							value="${status.index }">
																					</div>

																					<div class="label">
																						<label>${addr.recipient }</label>
																					</div>

																					<ul class="delivery-address-detail">
																						<li>
																							<h4 class="fw-500" id="recipient${status.index }">${addr.recipient }</h4>
																						</li>

																						<li>
																							<p class="text-content">
																								<span class="text-title">주소 : </span><span
																									id="address${status.index }">${addr.address }</span>
																							</p>
																							<p id="detailAddress${status.index }">${addr.detailAddress }
																							</p>
																						</li>

																						<li>
																							<h6 class="text-content">
																								<span class="text-title">우편번호 :</span> <span
																									id="zipCode${status.index }">${addr.zipCode }</span>
																							</h6>
																						</li>

																						<li>
																							<h6 class="text-content mb-0">
																								<span class="text-title">휴대폰 :</span> <span
																									id="recipientContact${status.index }">${addr.recipientContact }</span>
																							</h6>
																						</li>
																					</ul>
																				</div>
																			</div>

																		</div>


																	</div>
																</c:forEach>
																
															</div>
														</div>

														<!-- Modal footer -->
														<div class="modal-footer">
															<button type="button" class="btn btn-danger"
																data-bs-dismiss="modal" onclick="closeAddrModal()">Close</button>
															<button type="button" class="btn btn-primary"
																data-bs-dismiss="modal">작성</button>
															<button type="button" class="btn btn-success"
																onclick="changeAddr()">변경</button>

														</div>

													</div>
												</div>
											</div>
											<!-- 모달 끝 -->

										</div>

										<div class="checkout-detail">
											<div class="row g-4">
												<div class="col-8">
													<div class="delivery-address-box">
														<div>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="jack"
																	id="flexRadioDefault1">
															</div>

															<div class="label">
																<label id="recipientLabel">${requestScope.basicAddr.recipient }</label>
															</div>

															<ul class="delivery-address-detail">
																<li>
																	<h4 class="fw-500" id="recipient">${requestScope.basicAddr.recipient }</h4>
																</li>

																<li>
																	<p class="text-content">
																		<span class="text-title">주소 : </span><span
																			id="address">${requestScope.basicAddr.address }</span>
																	</p>
																	<p id="detailAddress">${requestScope.basicAddr.detailAddress }
																	</p>
																</li>

																<li>
																	<h6 class="text-content">
																		<span class="text-title">우편번호 :</span> <span
																			id="zipCode">${requestScope.basicAddr.zipCode }</span>
																	</h6>
																</li>

																<li>
																	<h6 class="text-content mb-0">
																		<span class="text-title">휴대폰 :</span> <span
																			id="recipientContact">${requestScope.basicAddr.recipientContact }</span>
																	</h6>
																</li>
																<li>
																<div class="col-12">
																			<div class="select-option">
																				<div class="form-floating theme-form-floating">
																					<select class="form-select theme-form-select"
																						aria-label="Default select example"
																						name="deliveryMessage" id="selectMessage">
																						<option value="없음">배송메시지를 선택해 주세요.</option>
																						<option>배송 전 연락주세요.</option>
																						<option>부재 시 연락주세요.</option>
																						<option>부재 시 경비실에 맡겨주세요.</option>
																						<option>문 앞에 놓아주세요.</option>
																						<option>직접입력</option>
																					</select>
																				</div>
																			</div>
																		</div>
																</li>
																<li><input type="text" class="form-control"
																		id="directInput" name="directMessage" placeholder="" style="display:none"></li>
															</ul>
															
														</div>
														
													</div>
												</div>
												<div class="col-xxl-6 col-lg-12 col-md-6"
													style="display: none">
													<div class="delivery-address-box">
														<div>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="jack"
																	id="flexRadioDefault1">
															</div>

															<div class="label">
																<label id="recipientLabel">${requestScope.basicAddr.recipient }</label>
															</div>

															<ul class="delivery-address-detail">
																<li><input class="fw-500" id="addRecipient"
																	name="recipientName" value="" /></li>

																<li><input class="text-content"
																	name="shippingAddress" id="addAddress" value="" /> <span
																	class="text-title">주소 : </span> <input
																	id="addDetailAddress" name="detailedShippingAddress"
																	value="" /></li>

																<li><input class="text-content" id="addZipCode"
																	name="zipCode" value=""> <span
																	class="text-title">우편번호 :</span></li>

																<li><input class="text-content mb-0"
																	id="addRecipientContact" name="recipientPhoneNumber"
																	value="" /> <span class="text-title">휴대폰 :</span></li>
															</ul>
														</div>
													</div>
												</div>

												<!--  <div class="col-xxl-6 col-lg-12 col-md-6">
                                                    <div class="delivery-address-box">
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="jack"
                                                                    id="flexRadioDefault2" checked="checked">
                                                            </div>

                                                            <div class="label">
                                                                <label>Office</label>
                                                            </div>

                                                            <ul class="delivery-address-detail">
                                                                <li>
                                                                    <h4 class="fw-500">Jack Jennas</h4>
                                                                </li>

                                                                <li>
                                                                    <p class="text-content"><span
                                                                            class="text-title">Address
                                                                            :</span>Nakhimovskiy R-N / Lastovaya Ul.,
                                                                        bld. 5/A, appt. 12
                                                                    </p>
                                                                </li>

                                                                <li>
                                                                    <h6 class="text-content"><span
                                                                            class="text-title">Pin Code :</span>
                                                                        +380</h6>
                                                                </li>

                                                                <li>
                                                                    <h6 class="text-content mb-0"><span
                                                                            class="text-title">Phone
                                                                            :</span> + 380 (0564) 53 - 29 - 68</h6>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>-->
											</div>
										</div>
									</div>
								</li>

								<li>
									<div class="checkout-icon">
										<lord-icon target=".nav-item"
											src="https://cdn.lordicon.com/oaflahpk.json"
											trigger="loop-on-hover" colors="primary:#0baf9a"
											class="lord-icon"> </lord-icon>
									</div>
									<div class="checkout-box">
										<div class="checkout-title">
											<h4>할인수단</h4>
										</div>
										<div>${requestScope.couponInfos }</div>

										<div class="checkout-detail">
											<div class="row g-4">
												<div class="col-xxl-6">
													<div class="delivery-option">
														<div class="delivery-category">
															<div class="shipment-detail">
																<div class="form-check custom-form-check hide-check-box">
																	<c:choose>
																		<c:when test="${requestScope.couponInfos != null }">
																			<input class="form-check-input" type="checkbox"
																				name="standard" id="couponCheck" readonly>
																			<label class="form-check-label" for="standard"
																				id="couponShow"> 적용 가능한 쿠폰이 없습니다.</label>
																			<c:forEach var="coupon"
																				items="${requestScope.couponInfos }"
																				varStatus="status">
																				<div id="discountAmount${status.index }"
																					style="display: none">${coupon.discountAmount}</div>

																				<div id="couponName${status.index }"
																					style="display: none">${coupon.couponName}</div>
																			</c:forEach>
																			<select id="couponSelect" style="display: none">
																				<option>쿠폰 초기화</option>
																				<c:forEach var="coupon"
																					items="${requestScope.couponInfos }"
																					varStatus="status">
																					<option class="categoryKeys"
																						id="categoryKey${status.index }"
																						style="display: none"
																						value="${coupon.categoryKey}">${coupon.couponName}-${coupon.couponNumber}</option>
																				</c:forEach>
																			</select>
																			<div id="selectedCoupon"></div>
																		</c:when>
																		<c:otherwise>
																			<input class="form-check-input" type="checkbox"
																				name="standard" id="standard" readonly>
																			<label class="form-check-label" for="standard">보유한
																				쿠폰이 없습니다.</label>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="col-xxl-6">
													<div class="delivery-option">
														<div class="delivery-category">
															<div class="shipment-detail">
																<div class="form-check custom-form-check hide-check-box">
																	<c:choose>
																		<c:when
																			test="${requestScope.member.totalPoints == '0' }">
																			<input class="form-check-input" type="checkbox"
																				name="standard" id="usingPoints" value="0" readonly>
																			<label class="form-check-label" for="standard">보유한
																				포인트가 없습니다.</label>
																		</c:when>
																		<c:otherwise>
																			<input class="form-check-input" type="checkbox"
																				name="standard" id="standard" readonly>
																			<label class="form-check-label" for="standard">보유
																				포인트 <span id="totalPoints">${requestScope.member.totalPoints}</span>
																				&nbsp;&nbsp;&nbsp;
																			</label>
																			<input id="usingPoints" value="">
																			<label><button type="button" class="greenBtn"
																					onclick="applyPoints()">전액사용</button></label>
																			<label><button id=pointBtn type="button"
																					class="greenBtn" onclick="inputPoints()">적용</button></label>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="col-xxl-6">
													<div class="delivery-option">
														<div class="delivery-category">
															<div class="shipment-detail">
																<div class="form-check custom-form-check hide-check-box">
																	<c:choose>
																		<c:when
																			test="${requestScope.member.totalRewards == '0' }">
																			<input class="form-check-input" type="checkbox"
																				name="standard" id="usingRewards" value="0" readonly>
																			<label class="form-check-label" for="standard">보유한
																				적립금이 없습니다.</label>
																		</c:when>
																		<c:otherwise>
																			<input class="form-check-input" type="checkbox"
																				name="checkRewards" id="standard"
																				onclick="inputRewards()" readonly>
																			<label class="form-check-label" for="standard">보유
																				적립금 <span id="totalRewards">${requestScope.member.totalRewards }</span>
																				&nbsp;&nbsp;&nbsp;
																			</label>
																			<input id="usingRewards" value="">
																			<label><button type="button"
																					onclick="applyRewards()"
																					style="background-color: #0da487; color: white;">전액사용</button></label>
																			<label><button id="rewardBtn" type="button"
																					class="greenBtn" onclick="inputRewards()">적용</button></label>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
												</div>

												<!--  <div class="col-xxl-6">
                                       <div class="delivery-option">
                                          <div class="delivery-category">
                                             <div class="shipment-detail">
                                                <div
                                                   class="form-check mb-0 custom-form-check show-box-checked">
                                                   <input class="form-check-input" type="radio"
                                                      name="standard" id="future"> <label
                                                      class="form-check-label" for="future">Future
                                                      Delivery Option</label>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>-->

												<!-- <div class="col-12 future-box">
                                       <div class="future-option">
                                          <div class="row g-md-0 gy-4">
                                             <div class="col-md-6">
                                                <div class="delivery-items">
                                                   <div>
                                                      <h5 class="items text-content">
                                                         <span>3 Items</span>@ $693.48
                                                      </h5>
                                                      <h5 class="charge text-content">
                                                         Delivery Charge $34.67
                                                         <button type="button" class="btn p-0"
                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                            title="Extra Charge">
                                                            <i class="fa-solid fa-circle-exclamation"></i>
                                                         </button>
                                                      </h5>
                                                   </div>
                                                </div>
                                             </div>

                                             <div class="col-md-6">
                                                <form class="form-floating theme-form-floating date-box">
                                                   <input type="date" class="form-control"> <label>Select
                                                      Date</label>
                                                </form>
                                             </div>
                                             
                                          </div>
                                       </div>
                                    </div>-->
											</div>
										</div>
									</div>
								</li>

								<li>
									<div class="checkout-icon">
										<lord-icon target=".nav-item"
											src="https://cdn.lordicon.com/qmcsqnle.json"
											trigger="loop-on-hover"
											colors="primary:#0baf9a,secondary:#0baf9a" class="lord-icon">
										</lord-icon>
									</div>
									<div class="checkout-box">
										<div class="checkout-title">
											<h4>Payment Option</h4>
										</div>

										<div class="checkout-detail">
											<div class="accordion accordion-flush custom-accordion"
												id="accordionFlushExample">
												<div class="accordion-item">
													<div class="accordion-header" id="flush-headingFour">
														<div class="accordion-button collapsed"
															data-bs-toggle="collapse"
															data-bs-target="#flush-collapseFour">
															<div class="custom-form-check form-check mb-0">
																<label class="form-check-label" for="cash"><input
																	class="form-check-input mt-0" type="radio"
																	name="payMethod" id="cash" checked> 신용카드</label>
															</div>
														</div>
													</div>
													<div id="flush-collapseFour"
														class="accordion-collapse collapse show"
														data-bs-parent="#accordionFlushExample">
														<div class="accordion-body">
															<p class="cod-review">
																Pay digitally with SMS Pay Link. Cash may not be
																accepted in COVID restricted areas. <a
																	href="javascript:void(0)">Know more.</a>
															</p>
														</div>
													</div>
												</div>

												<div class="accordion-item">
													<div class="accordion-header" id="flush-headingOne">
														<div class="accordion-button collapsed"
															data-bs-toggle="collapse"
															data-bs-target="#flush-collapseOne">
															<div class="custom-form-check form-check mb-0">
																<label class="form-check-label" for="credit"><input
																	class="form-check-input mt-0" type="radio"
																	name="payMethod" id="credit"> 카카오페이</label>
															</div>
														</div>
													</div>
													<div id="flush-collapseOne"
														class="accordion-collapse collapse"
														data-bs-parent="#accordionFlushExample">
														<div class="accordion-body">
															<div class="row g-2">
																<div class="col-12">
																	<div class="payment-method">
																		<div
																			class="form-floating mb-lg-3 mb-2 theme-form-floating">
																			<input type="text" class="form-control" id="credit2"
																				placeholder="Enter Credit & Debit Card Number">
																			<label for="credit2">Enter Credit & Debit
																				Card Number</label>
																		</div>
																	</div>
																</div>

																<div class="col-xxl-4">
																	<div
																		class="form-floating mb-lg-3 mb-2 theme-form-floating">
																		<input type="text" class="form-control" id="expiry"
																			placeholder="Enter Expiry Date"> <label
																			for="expiry">Expiry Date</label>
																	</div>
																</div>

																<div class="col-xxl-4">
																	<div
																		class="form-floating mb-lg-3 mb-2 theme-form-floating">
																		<input type="text" class="form-control" id="cvv"
																			placeholder="Enter CVV Number"> <label
																			for="cvv">CVV Number</label>
																	</div>
																</div>

																<div class="col-xxl-4">
																	<div
																		class="form-floating mb-lg-3 mb-2 theme-form-floating">
																		<input type="password" class="form-control"
																			id="password" placeholder="Enter Password"> <label
																			for="password">Password</label>
																	</div>
																</div>

																<div class="button-group mt-0">
																	<ul>
																		<li>
																			<button class="btn btn-light shopping-button">Cancel</button>
																		</li>

																		<li>
																			<button class="btn btn-animation">Use This
																				Card</button>
																		</li>
																	</ul>
																</div>
															</div>
														</div>
													</div>
												</div>

												<div class="accordion-item">
													<div class="accordion-header" id="flush-headingTwo">
														<div class="accordion-button collapsed"
															data-bs-toggle="collapse"
															data-bs-target="#flush-collapseTwo">
															<div class="custom-form-check form-check mb-0">
																<label class="form-check-label" for="banking"><input
																	class="form-check-input mt-0" type="radio"
																	name="payMethod" id="banking">네이버페이</label>
															</div>
														</div>
													</div>
													<div id="flush-collapseTwo"
														class="accordion-collapse collapse"
														data-bs-parent="#accordionFlushExample">
														<div class="accordion-body">
															<h5 class="text-uppercase mb-4">Select Your Bank</h5>
															<div class="row g-2">
																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank1"> <label class="form-check-label"
																			for="bank1">Industrial & Commercial Bank</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank2"> <label class="form-check-label"
																			for="bank2">Agricultural Bank</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank3"> <label class="form-check-label"
																			for="bank3">Bank of America</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank4"> <label class="form-check-label"
																			for="bank4">Construction Bank Corp.</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank5"> <label class="form-check-label"
																			for="bank5">HSBC Holdings</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="bank6"> <label class="form-check-label"
																			for="bank6">JPMorgan Chase & Co.</label>
																	</div>
																</div>

																<div class="col-12">
																	<div class="select-option">
																		<div class="form-floating theme-form-floating">
																			<select class="form-select theme-form-select"
																				aria-label="Default select example">
																				<option value="hsbc">HSBC Holdings</option>
																				<option value="loyds">Lloyds Banking Group</option>
																				<option value="natwest">Nat West Group</option>
																				<option value="Barclays">Barclays</option>
																				<option value="other">Others Bank</option>
																			</select> <label>Select Other Bank</label>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>

												<div class="accordion-item">
													<div class="accordion-header" id="flush-headingThree">
														<div class="accordion-button collapsed"
															data-bs-toggle="collapse"
															data-bs-target="#flush-collapseThree">
															<div class="custom-form-check form-check mb-0">
																<label class="form-check-label" for="wallet"><input
																	class="form-check-input mt-0" type="radio"
																	name="payMethod" id="wallet" value="bkt">무통장입금</label>
															</div>
														</div>
													</div>
													<div id="flush-collapseThree"
														class="accordion-collapse collapse"
														data-bs-parent="#accordionFlushExample">
														<div class="accordion-body">
															<h5 class="text-uppercase mb-4">Select Your Wallet</h5>
															<div class="row">
																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<label class="form-check-label" for="amazon"><input
																			class="form-check-input mt-0" type="radio"
																			id="amazon">Amazon Pay</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="gpay"> <label class="form-check-label"
																			for="gpay">Google Pay</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="airtel"> <label class="form-check-label"
																			for="airtel">Airtel Money</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="paytm"> <label class="form-check-label"
																			for="paytm">Paytm Pay</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="jio"> <label class="form-check-label"
																			for="jio">JIO Money</label>
																	</div>
																</div>

																<div class="col-md-6">
																	<div class="custom-form-check form-check">
																		<input class="form-check-input mt-0" type="radio"
																			id="free"> <label class="form-check-label"
																			for="free">Freecharge</label>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="right-side-summery-box">
						<div class="summery-box-2">
							<div class="summery-header">
								<h3>Order Summery</h3>
							</div>
							<ul class="summery-contain">
								<c:forEach var="info" items="${requestScope.productInfos }"
									varStatus="status">
									<input type="hidden" name="products" value="${info.productId }" />
									<li id="${info.productId }"><img
										src="${info.productImage }"
										class="img-fluid blur-up lazyloaded checkout-image" alt="">
										<h4>
											<span id="productName${status.index }">${info.productName }</span>
											X<span id="productQty${status.index }">${info.productQuantity }</span>
										</h4>
										<h4 class="price">
											<span id="productPrice${status.index }" class="productsPrice">${info.sellingPrice }</span>원
										</h4></li>
								</c:forEach>

								<!-- <li><img
                              src="/resources/assets/images/vegetable/product/2.png"
                              class="img-fluid blur-up lazyloaded checkout-image" alt="">
                              <h4>
                                 Eggplant <span>X 3</span>
                              </h4>
                              <h4 class="price">$12.23</h4></li>

                           <li><img
                              src="/resources/assets/images/vegetable/product/3.png"
                              class="img-fluid blur-up lazyloaded checkout-image" alt="">
                              <h4>
                                 Onion <span>X 2</span>
                              </h4>
                              <h4 class="price">$18.27</h4></li>

                           <li><img
                              src="/resources/assets/images/vegetable/product/4.png"
                              class="img-fluid blur-up lazyloaded checkout-image" alt="">
                              <h4>
                                 Potato <span>X 1</span>
                              </h4>
                              <h4 class="price">$26.90</h4></li>

                           <li><img
                              src="/resources/assets/images/vegetable/product/5.png"
                              class="img-fluid blur-up lazyloaded checkout-image" alt="">
                              <h4>
                                 Baby Chili <span>X 1</span>
                              </h4>
                              <h4 class="price">$19.28</h4></li>

                           <li><img
                              src="/resources/assets/images/vegetable/product/6.png"
                              class="img-fluid blur-up lazyloaded checkout-image" alt="">
                              <h4>
                                 Broccoli <span>X 2</span>
                              </h4>
                              <h4 class="price">$29.69</h4></li> -->
							</ul>

							<ul class="summery-total">
								<li>
									<h4>총 상품 가격</h4>
									<h4 class="price">
										<span id="subTotal">${requestScope.paymentInfo.totalAmount }</span>원
									</h4>

								</li>

								<li>
									<h4>배송비</h4>
									<h4 class="price">
										<span id="shippingFee"></span>원
									</h4>

								</li>
								<li>
									<h4>할인 금액(포인트, 적립금)</h4>
									<h4 class="price">
										<span id="discountAmount"></span>원
									</h4>

								</li>

								<li class="list-total">
									<h4>결제 금액</h4>
									<h4 class="price">
										<span id="payToAmount">${requestScope.paymentInfo.totalAmount }</span>원
									</h4>

								</li>
							</ul>
						</div>

						<div class="checkout-offer">
							<div class="offer-title">
								<div class="offer-icon">
									<img src="/resources/assets/images/inner-page/offer.svg"
										class="img-fluid" alt="">
								</div>
								<div class="offer-name">
									<h6>Notification</h6>
								</div>
							</div>

							<ul class="offer-detail">
								<li>
									<p>카드를 제외한 결제 수단으로(간편결제 ex:카카오페이 등) 결제할 시 추후 부분취소의 경우 전체 취소
										후 재결제가 필요합니다.</p>
								</li>
								<!--  <li>
                              <p>combo: Royal Cashew Californian, Extra Bold 100 gm + BB
                                 Royal Honey 500 gm</p>
                           </li>-->
							</ul>
						</div>

						<button
							class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
							type="button" onclick="checkPayMethod()">결제하기</button>
						<div class="checkout-offer" id="iframeParent">
							<label for="acc-or" class="offer-name"> 위 주문내용을 확인하였으며,
								결제에 동의합니다. <input type="checkbox" id="acc-or"> <span
								class="checkmark"></span>
							</label>
							<iframe id="iframeSon" src="../resources/terms.txt"></iframe>
							<!-- 약관 -->
						</div>
						<!--  <button
                        class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
                        type="button" onclick="cancelPayment()">취소하기</button>-->
						<button type="button"
							class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
							onclick="identify()">본인 인증</button>
						<button type="button"
							class="btn theme-bg-color text-white btn-md w-100 mt-4 fw-bold"
							onclick="packData()">테스트</button>
					</div>
				</div>
			</div>
		</div>
		<!--   </form> -->
	</section>
	<!-- Checkout section End -->
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

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">Add a new
						address</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="fname"
								placeholder="Enter First Name"> <label for="fname">First
								Name</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="text" class="form-control" id="lname"
								placeholder="Enter Last Name"> <label for="lname">Last
								Name</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="email" class="form-control" id="email"
								placeholder="Enter Email Address"> <label for="email">Email
								Address</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<textarea class="form-control" placeholder="Leave a comment here"
								id="address" style="height: 100px"></textarea>
							<label for="address">Enter Address</label>
						</div>
					</form>

					<form>
						<div class="form-floating mb-4 theme-form-floating">
							<input type="email" class="form-control" id="pin"
								placeholder="Enter Pin Code"> <label for="pin">Pin
								Code</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						data-bs-dismiss="modal">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->
	<jsp:include page="../footer.jsp"></jsp:include>
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

	<!-- Lordicon Js -->
	<script src="/resources/assets/js/lusqsztk.js"></script>

	<!-- Bootstrap js-->
	<script src="/resources/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/bootstrap/popper.min.js"></script>
	<script src="/resources/assets/js/bootstrap/bootstrap-notify.min.js"></script>

	<!-- feather icon js-->
	<script src="/resources/assets/js/feather/feather.min.js"></script>
	<script src="/resources/assets/js/feather/feather-icon.js"></script>

	<!-- Lazyload Js -->
	<script src="/resources/assets/js/lazysizes.min.js"></script>

	<!-- Delivery Option js -->
	<script src="/resources/assets/js/delivery-option.js"></script>

	<!-- Slick js-->
	<script src="/resources/assets/js/slick/slick.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- Quantity js -->
	<script src="/resources/assets/js/quantity.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>

</body>
</html>