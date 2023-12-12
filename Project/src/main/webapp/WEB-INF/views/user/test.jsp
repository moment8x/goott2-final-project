<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
let point = ${detailOrder.usedPoints} //결제 할 때 사용한 포인트
  let reward = ${detailOrder.usedReward} //결제 할 때 사용한 적립금
  
  let productPrice = data.selectCancelOrder.productPrice;
let amount = ${detailOrder.actualPaymentAmount } // 카드 실 결제금액
let bktAmount = Number(${bankTransfer.amountToPay }) // 무통장 실 결제금액
  let refundPoint = 0;
  let refundReward = 0;
 
  let today = new Date()
  let couponWithP = $('.infoContent.usedCouponWithP').text().replace(",", "").replace("원", "").trim()
  let refudnCouponWithP = 0
  let products = data.selectCancelOrder;
  
  console.log(couponWithP)
  
  console.log("총 주문 갯수 " + orderQty)
  
  if(totalQty > orderQty){
	  totalQty = 0
	  refundPoint = 0
	  refundReward = 0
  	alert("주문 수량 보다 많이 입력 할 수 없습니다.")
  }else if(totalQty != orderQty){
	  refundPoint = calculate(orderQty, totalQty, point)
	  refundReward = calculate(orderQty, totalQty, reward)
	  refudnCouponWithP = calculate(orderQty, totalQty, couponWithP)
	  
	  bktRefundAmount += productPrice - refundPoint - refundReward - refudnCouponWithP
	  refundAmount += productPrice - refundPoint - refundReward - refudnCouponWithP
	  
	console.log(bktRefundAmount)
	console.log(refundAmount)
  }else if(totalQty == orderQty){
	  refundPoint = point;
	  refundReward = reward;
	  bktRefundAmount = bktAmount
	  refundAmount = amount
	  console.log(amount)
	  console.log(refundAmount)
  }  
  
  console.log("환불 포인트 : " +refundPoint)
  console.log("환불 적립금 : " +refundReward)
  
  $('#refundPoint').text(Math.floor(refundPoint).toLocaleString()+ "점") 
  $('#refundReward').text(Math.floor(refundReward).toLocaleString()+ "원") 
  $('#refundAmount').text(refundAmount.toLocaleString()+ "원")
$('#refundAmount').text(bktRefundAmount.toLocaleString()+ "원")

  $('#returnRefundPoint').text(Math.floor(refundPoint).toLocaleString()+ "점") 
  $('#returnRefundReward').text(Math.floor(refundReward).toLocaleString()+ "원") 
  if(data.selectCancelOrder.paymentMethod == 'bkt'){
	  $('#returnRefundAmount').text(bktRefundAmount.toLocaleString()+ "원")	  			  
  }else{
	  $('#returnRefundAmount').text(refundAmount.toLocaleString()+ "원")	  			  
  }

</script>
</head>
<body>

</body>
</html>