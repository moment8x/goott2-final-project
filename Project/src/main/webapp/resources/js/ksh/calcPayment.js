function applyRewards() {
   viewTotalAmount = Number($("#payToAmount").text().replaceAll(",",""));
   let myRewards = Number($('#totalRewards').text());
      if(viewTotalAmount == 0 && rewardBtn == 0) {
         alert('더이상 차감할 금액이 없습니다.');
         return;
      }
      
      if(rewardBtn == 0) {
         
         if(myRewards > viewTotalAmount) {
            $('#usingRewards').val(viewTotalAmount); 
            $('#totalRewards').text(myRewards - viewTotalAmount);
            viewTotalAmount = viewTotalAmount - Number($('#usingRewards').val());
            discountAmount = totalAmount;
      
            calc();
         } else {
            $('#usingRewards').val(myRewards);
            $('#totalRewards').text(0);
            viewTotalAmount = totalAmount - myRewards;
            discountAmount = discountAmount + myRewards;

            calc();
         }
         rewardBtn = 1;
      } else {
         $('#totalRewards').text(myRewards + Number($('#usingRewards').val()));
         discountAmount = discountAmount - Number($('#usingRewards').val());
         viewTotalAmount = viewTotalAmount + Number($('#usingRewards').val());
         $('#usingRewards').val("");
         calc();

         rewardBtn = 0;
      }
      
   };
   
   function applyPoints() {
   viewTotalAmount = Number($("#payToAmount").text().replaceAll(",",""));
   let myTotalPoints = Number($('#totalPoints').text());
   console.log(viewTotalAmount);
   if(viewTotalAmount == 0 && pointBtn == 0) {
      alert('더이상 차감할 금액이 없습니다.');
      return;
   }
         // 처음 눌렀을 때
      if(pointBtn == 0) {
         
         if(myTotalPoints > viewTotalAmount) {
            // 구매가격보다 포인트가 많을 때
            $('#usingPoints').val(viewTotalAmount);
            $('#totalPoints').text(myTotalPoints - viewTotalAmount);
            viewTotalAmount = viewTotalAmount - Number($('#usingPoints').val());
            discountAmount = totalAmount;
            calc();
         } else {
            // 구매가격보다 포인트가 적을 때
            $('#usingPoints').val(myTotalPoints);
            $('#totalPoints').text(0);
            viewTotalAmount = totalAmount - myTotalPoints;
            discountAmount = discountAmount + myTotalPoints;
            calc();
         }
         pointBtn = 1;
      } else {
         // 전액사용 되돌리기
         console.log("엥?");
         $('#totalPoints').text(myTotalPoints + Number($('#usingPoints').val()));
         discountAmount = discountAmount - Number($('#usingPoints').val());
         viewTotalAmount = viewTotalAmount + Number($('#usingPoints').val());
         $('#usingPoints').val("");
         calc();
         pointBtn = 0;
         
      }
   
   };
   
   function calc(index) {
      // 쿠폰은 총 상품 가격 기준으로만 적용
      // 할인금액은 쿠폰+포인트+적립금
      // 토탈은 상품 가격 - 쿠폰 할인 - 포인트 - 적립금
      
      viewTotalAmount = Number($("#payToAmount").text().replaceAll(',',''));
      discountAmount1 = couponAmount + Number($('#usingRewards').val()) + Number($('#usingPoints').val());
      finalTotal = totalAmount + shippingFee - couponAmount - Number($('#usingRewards').val()) - Number($('#usingPoints').val());
      console.log(discountAmount1);
      console.log(finalTotal);
      if(discountAmount1 > totalAmount) {
         console.log("안와?");
         console.log(discountAmount1);
         console.log(totalAmount);
         returnAmount = discountAmount1 - totalAmount; // 돌려줘야할 금액
         
         // 포인트랑 적립금 둘 다 썼을 때
         if($('#usingRewards').val() != "" && $('#usingPoints').val() != "") {
         // 사용하려는 포인트와 적립금을 합친 금액이 돌려줘야할 금액보다 많거나 같을 때
            if(Number($('#usingRewards').val()) + Number($('#usingPoints').val()) >= returnAmount) {
            // 적립금 우선 지급
            if(Number($('#usingRewards').val()) >= returnAmount) {
               // 사용한 적립금이 돌려줘야할 금액보다 많을 때
               if(Number($('#usingRewards').val()) - returnAmount == 0) {
                  $('#usingRewards').val("");
               } else{
                  
               $('#usingRewards').val(Number($('#usingRewards').val()) - returnAmount);
               }
               $('#totalRewards').text(Number($('#totalRewards').text()) + returnAmount);
               discountAmount1 = discountAmount1 - returnAmount;
            } else {
               // 사용한 적립금이 돌려줘야할 금액보다 적을 때 포인트도 같이 줘야됨
               returnAmount = returnAmount - Number($('#usingRewards').val());
               $('#totalRewards').text(Number($('#totalRewards').text()) + Number($('#usingRewards').val()));
               $('#usingRewards').val("");
               if(Number($('#usingPoints').val())-returnAmount == 0) {
                  $('#usingPoints').val("");
               } else {
                  
               $('#usingPoints').val(Number($('#usingPoints').val())-returnAmount);
               }
               $('#totalPoints').text(Number($('#totalPoints').text()) + returnAmount);
               discountAmount1 = discountAmount1 - returnAmount;   
            }
            
            }else {
               // 돌려줘야할 금액이 사용한 적립금과 포인트를 합친것보다 많을 때
               alert("할인금액이 상품 금액을 넘어 포인트와 적립금을 초기화 시켰습니다.");
            }
               finalTotal = totalAmount - couponAmount - Number($('#usingRewards').val()) - Number($('#usingPoints').val());
               $('#discountAmount').text(discountAmount1.toLocaleString('ko-KR'));
               $("#payToAmount").text(finalTotal.toLocaleString('ko-KR'));
               return;
         } 
         // 포인트만 썼을 때
         if($('#usingPoints').val() != "") {
            if(Number($('#usingPoints').val()) >= returnAmount) {
               // 돌려줄수있을 때
               if(Number($('#usingPoints').val())-returnAmount == 0) {
                  $('#usingPoints').val("");
               } else {
               $('#usingPoints').val(Number($('#usingPoints').val())-returnAmount);
               }
               $('#totalPoints').text(Number($('#totalPoints').text()) + returnAmount);
               discountAmount1 = discountAmount1 - returnAmount;
               
            } else {
               //없을 때
               alert("할인금액이 상품 금액을 넘어 포인트와 적립금을 초기화 시켰습니다.");
            }
         }
         // 적립금만 썼을 때
         if($('#usingRewards').val() != "") {
            if(Number($('#usingPoints').val()) >= returnAmount) {
               // 돌려줄수있을 때
               if(Number($('#usingRewards').val()) - returnAmount == 0) {
                  $('#usingRewards').val("");
               } else{
                  
               $('#usingRewards').val(Number($('#usingRewards').val()) - returnAmount);
               }
               $('#totalRewards').text(Number($('#totalRewards').text()) + returnAmount);
               discountAmount1 = discountAmount1 - returnAmount;
               
            } else {
               //없을 때
               alert("할인금액이 상품 금액을 넘어 포인트와 적립금을 초기화 시켰습니다.");
            }
         }
         if(index != null && index != "") {
            console.log(index);
            
         }
         finalTotal = totalAmount + shippingFee - couponAmount - Number($('#usingRewards').val()) - Number($('#usingPoints').val());
         console.log("과연?", finalTotal);
      }
      $('#discountAmount').text(discountAmount1.toLocaleString('ko-KR'));
      $("#payToAmount").text(finalTotal.toLocaleString('ko-KR'));
      
      
   };
   
   function checkNumber(e) {
      let check = /^[0-9]+$/;
      let payToAmount = Number($('#payToAmount').text().replaceAll(",",""));
      
      if(e == 'rewards') {
         if (!check.test($('#usingRewards').val())) {
             alert("숫자만 입력 가능합니다.");
            } else {
               // 처음 눌렀을 때
               if(rewardBtn == 0) {
                  if(Number($('#usingRewards').val()) > Number($('#totalRewards').text()) 
                          || Number($('#usingRewards').val()) > payToAmount) {
                     
                       alert("올바른 값을 입력해주세요");
                       $('#usingRewards').val("");
                  } else {
                       if($('#usingRewards').val() < 10) {
                          alert("10원 이상 사용 가능합니다.");
                          $('#usingRewards').val("");
                          return;
                       }
                       console.log(Math.floor(Number($('#usingPoints').val())/10)*10);
                       $('#usingRewards').val(Math.floor(Number($('#usingRewards').val())/10)*10);
                       $('#totalRewards').text(Number($('#totalRewards').text()) - Number($('#usingRewards').val()));
                       discountAmount = discountAmount + Number($('#usingRewards').val());
                       calc();
                       $('#rewardBtn').text("되돌리기");
                       rewardBtn = 1;
                    }
               } else {
                    $('#totalRewards').text(Number($('#totalRewards').text()) + Number($('#usingRewards').val()));
                    discountAmount = discountAmount - Number($('#usingRewards').val());
                    $('#usingRewards').val("");
                    calc();
                    $('#rewardBtn').text("적용");
                    rewardBtn = 0;
                 } 
            }
      } else {
         if (!check.test($('#usingPoints').val())) {
             alert("숫자만 입력 가능합니다.");
         } else {
            // 처음 눌렀을 때
            if(pointBtn == 0) {
               if(Number($('#usingPoints').val()) > Number($('#totalPoints').text()) 
                       || Number($('#usingPoints').val()) > payToAmount) {
                  
                    alert("올바른 값을 입력해주세요");
                    $('#usingPoints').val("");
               } else {
                    if($('#usingPoints').val() < 10) {
                       alert("10원 이상 사용 가능합니다.");
                       $('#usingPoints').val("");
                       return;
                    }
                    console.log(Math.floor(Number($('#usingPoints').val())/10)*10);
                    $('#usingPoints').val(Math.floor(Number($('#usingPoints').val())/10)*10);
                    $('#totalPoints').text(Number($('#totalPoints').text()) - Number($('#usingPoints').val()));
                    discountAmount = discountAmount + Number($('#usingPoints').val());
                    calc();
                    $('#pointBtn').text("되돌리기");
                    pointBtn = 1;
                 }
            } else {
                 $('#totalPoints').text(Number($('#totalPoints').text()) + Number($('#usingPoints').val()));
                 discountAmount = discountAmount - Number($('#usingPoints').val());
                 $('#usingPoints').val("");
                 calc();
                 $('#pointBtn').text("적용");
                 pointBtn = 0;
              }
         }
      }
   };