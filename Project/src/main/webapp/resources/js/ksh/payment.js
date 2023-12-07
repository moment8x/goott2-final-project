function kg_pay() {
        console.log("!!");
        IMP.request_pay({ // 결제 정보 채우기
          pg : "html5_inicis",
          pay_method : "card",
          merchant_uid : orderId, // 주문번호
          name : createName, 
          amount : Number($('#payToAmount').text().replaceAll(",","")), // 숫자 타입
          buyer_email : "",
          buyer_name : $('#recipient').text(),
          buyer_tel : $('#recipientContact').text(),
          buyer_addr : $('#address').text(),
          buyer_postcode :  $('#zipCode').text(),
        }, function(rsp) { // callback
          //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
          if (rsp.success) { // 결제 내역 받기
            // 결제 검증 ajax        
              // 결제 내역 저장 ajax
              obj = {
                "paymentNumber" : rsp.imp_uid, // 결제번호
                "orderNo" : rsp.merchant_uid, // 주문번호
                "paymentMethod" : rsp.pay_method, // 결제수단
                "totalAmount" : totalAmount, // 총 상품 금액, 수정 필요
                "shippingFee" : shippingFee, // 배송비
                "usedPoints" : Number($('#usingPoints').val()), // 사용한 포인트
                "usedReward" : Number($('#usingRewards').val()), // 사용한 적립금
                //"actualPaymentAmount" : data.response.amount, // 실 결제 금액
                //"paymentTime" : data.response.paidAt,// 결제 시각
                "amountToPay" : rsp.paid_amount,
                //"cardName" : data.response.cardName,
                //"cardNumber" : data.response.cardNumber,   주석 처리 한 것은 백에서 작업.
                "recipientName" : $("#recipient").text(),
                "impUid" : rsp.imp_uid,
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
              }
              $.ajax({
                url : "/pay/output/",
                type : "POST",
                contentType : "application/json",
                data : JSON.stringify(obj),
                async : false,
                success : function(result) {
                  isPaid = true;
                  console.log("ajax 결과 : ", isPaid);
                  if (isPaid) {
                     console.log("띠용?");
                    $("#requestOrder").submit();
                  }
                  // alert("결제 완료");
                },
                error : function(error) {
                  console.log(error);
                  alert("검증 실패로 인해 결제가 취소되었습니다.")
                },
              })
            } else {
            alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
          }
        })
      }