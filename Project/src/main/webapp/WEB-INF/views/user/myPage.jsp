<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Fastkart" />
<meta name="keywords" content="Fastkart" />
<meta name="author" content="Fastkart" />
<link rel="icon" href="/resources/assets/images/favicon/1.png"
	type="image/x-icon" />
<title>Dear Books</title>

<!-- Google font -->
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;500;600;700;800;900&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;ㅇ0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet" />

<!-- bootstrap css -->
<link id="rtl-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/bootstrap.css" />

<!-- font-awesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/font-awesome.css" />

<!-- feather icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/feather-icon.css" />

<!-- slick css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/vendors/slick/slick-theme.css" />

<!-- Iconly css -->
<link rel="stylesheet" type="text/css"
	href="/resources/assets/css/bulk-style.css" />

<!-- Template css -->
<link id="color-link" rel="stylesheet" type="text/css"
	href="/resources/assets/css/style.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

function sample6_execDaumPostcode(zipCode, userAddr, detailAddr, extraAddress) {
    new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data)
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        	$('#modifyAddress').show()

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
	
	let IMP = window.IMP;      // 생략 가능
	IMP.init("imp54017066"); // 예: imp00000000
	
	// 본인인증
	function identify() {
	      // IMP.certification(param, callback) 호출
	      IMP
	            .certification(
	                  { // param
	                     pg : 'MIIiasTest',//본인인증 설정이 2개이상 되어 있는 경우 필수 
	                     merchant_uid : "ORD20180131-0000011", 
	                     m_redirect_url : "http://localhost:8081/user/myPage", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
	                     popup : false
	                  // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
	                  },
	                  function(rsp) { // callback
	                     if (rsp.success) {
	                        console.log(rsp);
	                        $.ajax({
	                			url : '/user/identityVerificationStatus', // 데이터를 수신받을 서버 주소
	                			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
	                			dataType : 'json',
	                			async : false,
	                			success : function(data) {
	                				console.log(data);
	                			//	if(data == true){
	                			//		location.href = "/user/myPage"
	                			//	}
	                			},
	                			error : function() {
	                			}
	                		});
	                     } else {
	                        console.log("본인인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
	                     }
	                  });
	   }

	$(function() {
		//전화번호변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.editPhoneNumber').click(function() {
			$('.newPhoneNumberEdit').show();
		})
		//핸드폰번호 변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.editCellPhoneNumber').click(function() {
			$('.newCellPhoneNumberEdit').show();
		})
		//이메일 변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.editEmail').click(function() {
			$('.newEmailEdit').show();
		})
		//비밀번호 변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.editUserPwd').click(function () {
			$('.editNewUserPwd').show();
		})
		//환불변경 아이콘 클릭시
		$('.fa-regular.fa-pen-to-square.fa-xl.refund').click(function () {
			$('.editRefund').show()
		})

		// 새 비밀번호 입력 후
		$('#newPwdCheck').blur(function() {
			validUserPwd();
		})
		
		//이메일 변경시 중복검사
		$('#newEmail').change(function () {
			duplicateUserEmail();
		})
		
		//전화번호 중복검사
		$('#newUserPhonNumber').blur(function () {
			duplicatePhoneNumber();
		})
		
		//휴대폰번호 중복검사
		$('#newCellPhoneNumber').blur(function() {
			duplicateCellPhone();
		})
		
		$("#file").on('change',function(){
		  let fileName = $("#file").val();
		  $(".upload-name").val(fileName);
		});
		
		$('.modifyProfileBtn').click(function () {
			$('.cover-icon.filebox').show()
		})
		
		//이메일 코드체크
		$('#checkCode').click(function () {
			$.ajax({
				url : '/user/checkCode', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data : {
					userCode : $('#emailCode').val()
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					console.log(data);
					if(data){
						$('#successEmail').show()	
					}else if(data == false){
						alert("코드가 일치하지 않습니다.")
					}
				},
				error : function() {
				}
			});
								
		})
		
		//주문 상태별 조회
		$("select[id=orderStatusKeyword]").change(function(){
			let beforeDeposit = null;
			let beforeShipping = null;
			let shipping = null;
			let deliveryCompleted = null;
			let cancelList = null;
			let exchangeList = null;
			let returnList = null;		
			let returnApply = null;			
			let exchangeApply = null;			
			
			if($(this).val() == 'beforeDeposit'){
				beforeDeposit = $("select[id=orderStatusKeyword] option:selected").text()				
			}else if($(this).val() == 'beforeShipping'){
				beforeShipping = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'shipping'){
				shipping = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'deliveryCompleted'){
				deliveryCompleted = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'cancelList'){
				cancelList = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'exchangeList'){
				exchangeList = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'returnList'){
				returnList = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'returnApply'){
				returnApply = $("select[id=orderStatusKeyword] option:selected").text()
			}else if($(this).val() == 'exchangeApply'){
				exchangeApply = $("select[id=orderStatusKeyword] option:selected").text()
			}
			
			let orderStatusKeywordText = $("select[id=orderStatusKeyword] option:selected").text()

		  	console.log(orderStatusKeywordText); 
		  	$.ajax({
				url : '/user/searchOrderStatus', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data : {
					beforeDeposit,
					beforeShipping,
					shipping,
					deliveryCompleted,
					cancelList,
					exchangeList,
					returnList,
					exchangeApply,
					returnApply
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					console.log(data);
					if(data != null){
						outputOrder(data.orderStatus)		
						orderStatusPagination(data.pagination)
					}
				},
				error : function() {
				}
			});
		});
		
		//주문 기간별 조회
		$("select[id=orderPeriod]").change(function () {
			let sevenDaysAgo = null;
			let fifteenDaysAgo = null;
			let aMonthAgo = null;
			
			if($(this).val() == 'aMonthAgo'){
				aMonthAgo = $("select[id=orderPeriod] option:selected").text()				
			}else if($(this).val() == 'sevenDaysAgo'){
				sevenDaysAgo = $("select[id=orderPeriod] option:selected").text()
			}else if($(this).val() == 'fifteenDaysAgo'){
				fifteenDaysAgo = $("select[id=orderPeriod] option:selected").text()
			}
			
			let orderPeriodText = $("select[id=orderPeriod] option:selected").text()
			console.log(orderPeriodText);
			
			$.ajax({
				url : '/user/searchOrderStatus', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data : {
					sevenDaysAgo,
					fifteenDaysAgo,
					aMonthAgo,
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					console.log(data);
					if(data != null){
						outputOrder(data.orderStatus)	
						orderStatusPagination(data.pagination) 
					}
				},
				error : function() {
				}
			});
		})
		
	})
	
	//프로필사진 업로드
	function uploadProfile() {
		let fileInput = document.getElementById("file")
		let file = fileInput.files[0]
		
		if(file){
			let formData = new FormData();
			formData.append('uploadFile', file)
			
			$.ajax({
				url : '/user/profileUpload', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data : formData,
				dataType : 'json',
				async : false,
				processData : false,
				contentType : false,
				success : function(data) {
					console.log(data);
					if(data.fileSize > 0){
						location.reload();
					}
				},
				error : function() {
				}
			});
		}
	}

	// 유효성 검사 메세지
	function printMsg(focusId, msgId, msg, isFocus) {
		let divMsg = `<div class='msg'>\${msg}</div>`;
		if (isFocus == true) {
			$(`#\${focusId}`).focus();
		} else if (isFocus == false) {
			divMsg = `<div class='trueMsg'>\${msg}</div>`;
		}
		$(divMsg).insertAfter($(`#\${msgId}`));
		$('.msg').hide(10000);
	}

	//비밀번호 유효성검사
	function validUserPwd() {
		let reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		let pwd = $('#newPwd').val();
		let pwdCheck = $('#newPwdCheck').val();

		if (!reg.test(pwd) && !reg.test(pwdCheck)) {
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			$('.fa-regular.fa-circle-check.fa-lg').hide();
			printMsg('newPwd', 'newPwdCheck',
					'영어, 숫자, 특수문자(!@#$%^*+=-)를 1개이상 포함하여 8-15글자로 입력해주세요.', true)
		} else if (pwd != pwdCheck) {
			$('#newPwd').val('');
			$('#newPwdCheck').val('');
			$('.fa-regular.fa-circle-check.fa-lg').hide();
			printMsg('newPwd', 'newPwdCheck', '비밀번호가 일치하지 않습니다. 다시 입력해주세요.',
					true)
		} else if (reg.test(pwd) && reg.test(pwdCheck) && pwd == pwdCheck) {
			printMsg('', 'newPwdCheck', '', false);
			$('#successPwd').show();
		}
	}
	
	//이메일 중복검사
	function duplicateUserEmail() {
		let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		let tmpEmail = $('#newEmail').val()
	
			$.ajax({
				url : '/user/duplicateUserEmail', // 데이터를 수신받을 서버 주소
				type : 'post', // 통신방식(GET, POST, PUT, DELETE)
				data :{
					tmpEmail
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					console.log(data);
					if (data){
						$('#newEmail').val('');
					//	printMsg("newEmail", "newEmail", "중복된 이메일 입니다.", true)
						$('#errMsg').text("중복된 이메일 입니다.").hide(10000)
						$('.trueMsg').hide();
					}else if(!regExp.test(tmpEmail)){
						$('#newEmail').val('');
						$('#errMsg').text("이메일 형식에 맞지 않습니다.").hide(10000)
						//printMsg("newEmail", "newEmail", "이메일 형식에 맞지 않습니다.", true)
						//$('.trueMsg').hide();
					}else if(data == false && regExp.test(tmpEmail)) {
						printMsg("", "newEmail", "", false)
						$('#sendCodeBtn').show()
						$('.col-12.codeCheck').show()
					}
				},
				error : function() {
				}
			});		
	}
	
	//이메일 유효성&중복검사 체크되면 코드보내기
	function sendCode() {
		let email = $('#newEmail').val();
		let codeText = $('#emailCode').val()
		
		$.ajax({
			url : '/user/sendCode', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data :{
				email
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);	
				if(data){
					alert("코드가 전송되었습니다.")
				}
			},
			error : function() {
			}
		});		
	}
	
	//전화번호 유효성 검사
	function duplicatePhoneNumber() {
		let newPhoneNumber = $('#newUserPhonNumber').val();
		let regPhone = /^\d{2,3}-\d{3,4}-\d{4}$/;
		
		$.ajax({
			url : '/user/duplicatePhoneNumber', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				newPhoneNumber
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				if(data){ //중복
					$('#newUserPhonNumber').val('');
					printMsg("newUserPhonNumber", "newUserPhonNumber", "중복된 전화번호 입니다.", true)
					$('.trueMsg').hide();
				}else if(!regPhone.test(newPhoneNumber)){
					$('#newUserPhonNumber').val('');
					printMsg("newUserPhonNumber", "newUserPhonNumber", "전화번호 형식에 맞지 않습니다.", true)
					$('.trueMsg').hide();
				}else if(data == false && regPhone.test(newPhoneNumber)){
					printMsg("", "newUserPhonNumber", "", false)
					$('#successPhoneNumber').show();			
				}
			},
			error : function() {
			}
		});
	}
	
	//휴대폰번호 유효성 검사
	function duplicateCellPhone() {
		let newCellPhone = $('#newCellPhoneNumber').val();
		let regCellPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		$.ajax({
			url : '/user/duplicateCellPhone', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				newCellPhone
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				if(data){//휴대폰번호 중복
					$('#newCellPhoneNumber').val('');		
					$('.trueMsg').hide();
					printMsg("newCellPhoneNumber", "newCellPhoneNumber", "중복된 휴대폰번호 입니다.", true)
				}else if(!regCellPhone.test(newCellPhone)){ //정규식에 맞지않음
					$('#newCellPhoneNumber').val('');		
					$('.trueMsg').hide();
					printMsg("newCellPhoneNumber", "newCellPhoneNumber", "휴대폰번호 형식에 맞지 않습니다.", true)
				}else if(data == false && regCellPhone.test(newCellPhone)){
					printMsg("", "newCellPhoneNumber", "", false)
					$('#successCellPhoneNumber').show();
				}
			},
			error : function() {
			}
		});
	}
	
	//배송주소록 추가
	function addShippingAddress() {
		let zipCode = $('#addZipNo').val()
		let address = $('#addAddr').val()
		let detailAddress = $('#addAddrDetail').val()
		let recipient = $('#recipient').val()
		let recipientContact = $('#recipientContact').val()
		let basicAddr = "";
		if($('#choiceBasicAddr').is(':checked')){
			basicAddr = $('#choiceBasicAddr').val()
		}else{
			basicAddr = 'N'
		}
		console.log("basicAddr"  + basicAddr);
		$.ajax({
			url : '/user/addShippingAddress', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				zipCode,
				address,
				detailAddress,
				recipient,
				recipientContact,
				basicAddr
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log("추가 확인2");
				console.log(data);
				if(data == true){		
					alert("배송지 추가가 완료되었습니다.")
					location.reload()
				}
			},
			error : function() {
			}
		});
	}
	
	//배송주소록 수정
	function shippingAddrModify(addrSeq) {
		let zipCode = $('#shippingZipNoModify').val()
		let address = $('#shippingAddrModify').val()
		let detailAddress = $('#shippingDetailAddrModify').val()
		let recipient = $('#recipientName').val()
		let recipientContact = $('#editRecipientContact').val()
		console.log("수정 확인1");
		$.ajax({
			url : '/user/shippingAddrModify', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				zipCode,
				address,
				detailAddress,
				recipient,
				recipientContact,
				addrSeq
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				location.reload()
			},
			error : function() {
			}
		});
	}
	
	//수정할 주소록 가져오기
	function editShippingAddr(addrSeq) {
		$.ajax({
			url : '/user/myPage/modifyShippingAddr', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				"addrSeq" : addrSeq
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				outputShippingAddr(data);
			},
			error : function() {
			}
		});
	}
	
	function outputShippingAddr(addr) {
		console.log("id", "${sessionScope.loginMember}");
		let output = `<button type="button" class="btn theme-bg-color btn-md text-white"
			onclick="sample6_execDaumPostcode('shippingZipNoModify', 'shippingAddrModify', 'shippingDetailAddrModify', 'shippingExtraAddress');">주소 찾기</button>`
		output += `<div class="col-xxl-6">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input type="text" class="form-control" id="shippingZipNoModify"
			name="zipCode" value="\${addr.zipCode}" readonly />`
		output += `<label for="shippingZipNoModify">우편번호</label>`	
		output += `</div>`
		output += `</div>`

		output += `<div class="col-xxl-6">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input class="form-control" type="text"
			value="\${addr.address}" name="address"
			id="shippingAddrModify" readonly />`
		output += `<label for="shippingAddrModify">주소</label>`
		output += `</div>`
		output += `</div>`

		output += `<div class="col-xxl-12">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input type="text" class="form-control"
			id="shippingDetailAddrModify"
			value="\${addr.detailAddress}" />`
		output += `<label for="shippingDetailAddrModify">상세주소</label>`
		output += `</div>`
		output += `</div>`
		
		output += `<div class="col-xxl-12">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input type="text" class="form-control"
			id="shippingExtraAddress"/>`
		output += `<label for="shippingExtraAddress">참고항목</label>`
		output += `</div>`
		output += `</div>`
			
		output += `<div class="col-xxl-6">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input type="text" class="form-control" id="recipientName"
			name="recipient" placeholder="받는사람"
			value="\${addr.recipient} " />`
		output += `<label for="recipientName">받는사람</label>`
		output += `</div>`
		output += `</div>`

		output += `<div class="col-xxl-6">`
		output += `<div class="form-floating theme-form-floating">`
		output += `<input type="text" class="form-control"
				id="editRecipientContact" placeholder="받는사람 연락처"
				value="\${addr.recipientContact}" />`
		output += `<label for="editRecipientContact">받는사람 연락처</label>`
		output += `<p>- 포함해서 입력해주세요.</p>`
		output += `</div>`
		output += `</div>`
		
		let outputFooter = `<button type="button" data-bs-dismiss="modal"
			class="btn theme-bg-color btn-md fw-bold text-light"
			onclick="shippingAddrModify(\${addr.addrSeq});">
			변경</button>`
		outputFooter += `<button type="button" class="btn btn-animation btn-md fw-bold"
			data-bs-dismiss="modal">닫기</button>`	

		$('.row.g-4.editAddr').html(output);
		$('.modal-footer.editAddrFooter').html(outputFooter);
	}
	
	function delShippingAddr(addrSeq){
		$.ajax({
			url : '/user/deleteShippingAddr', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				addrSeq
			},
			async : false,
			success : function(data) {
				console.log(data);
				if(data == "success"){
					let addr = $('#' + addrSeq);
					console.log(addr + "삭제")
					addr.fadeOut(300, function () {
						addr.remove();
	                });			
				}
			},
			error : function() {
			}
		});
	}
	
	// 기본배송지 설정
	function setBasicAddr(addrSeq) {
		$.ajax({
			url : '/user/setBasicAddr', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				addrSeq
			},
			async : false,
			success : function(data) {
				console.log(data);
				if(data == "success"){
					alert("기본배송지로 설정되었습니다.")
					location.reload()
				}
			},
			error : function() {
			}
		});
	}
	
	//전화번호 유효성 검사
	function duplicatePhoneNumber() {
		let newPhoneNumber = $('#newUserPhonNumber').val();
		let regPhone = /^\d{2,3}-\d{3,4}-\d{4}$/;
		
		$.ajax({
			url : '/user/duplicatePhoneNumber', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				newPhoneNumber
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				if(data){ //중복
					$('#newUserPhonNumber').val('');
					printMsg("newUserPhonNumber", "newUserPhonNumber", "중복된 전화번호 입니다.", true)
					$('.trueMsg').hide();
				}else if(!regPhone.test(newPhoneNumber)){
					$('#newUserPhonNumber').val('');
					printMsg("newUserPhonNumber", "newUserPhonNumber", "전화번호 형식에 맞지 않습니다.", true)
					$('.trueMsg').hide();
				}else if(data == false && regPhone.test(newPhoneNumber)){
					printMsg("", "newUserPhonNumber", "", false)
					$('#successPhoneNumber').show();			
				}
			},
			error : function() {
			}
		});
	}
	
	//휴대폰번호 유효성 검사
	function duplicateCellPhone() {
		let newCellPhone = $('#newCellPhoneNumber').val();
		let regCellPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		$.ajax({
			url : '/user/duplicateCellPhone', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				newCellPhone
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				if(data){//휴대폰번호 중복
					$('#newCellPhoneNumber').val('');		
					$('.trueMsg').hide();
					printMsg("newCellPhoneNumber", "newCellPhoneNumber", "중복된 휴대폰번호 입니다.", true)
				}else if(!regCellPhone.test(newCellPhone)){ //정규식에 맞지않음
					$('#newCellPhoneNumber').val('');		
					$('.trueMsg').hide();
					printMsg("newCellPhoneNumber", "newCellPhoneNumber", "휴대폰번호 형식에 맞지 않습니다.", true)
				}else if(data == false && regCellPhone.test(newCellPhone)){
					printMsg("", "newCellPhoneNumber", "", false)
					$('#successCellPhoneNumber').show();
				}
			},
			error : function() {
			}
		});
	}
	
	function outputOrder(order) {
		let output = ''
		$.each(order, function(i, e) {
			output += `<div class="product-order-detail" id="productOrderDetail">`
			output += `<a href="/detail/\${e.productId }" class="order-image">`
			output += `<img src="\${e.productImage }" class="blur-up lazyload"
					alt="\${e.productName }" id="productImg" />`
			output += `</a>`
			output += `<div class="order-wrap">`
			output += `<div id="orderWrap">`
			output += `<span class="orderDetailClick">주문번호 : \${e.orderNo }</span>`
			output += `<a href="orderDetail?no=\${e.orderNo }" id="clickDetailOrder">상세보기</a>`
			output += `</div>`	
			let orderTime = formatDate(e.orderTime)
			output += `<p class="text-content" id="orderTime">\${orderTime}</p>`
			output += `<a href="/detail/\${e.productId }">`
			output += `<h3>\${e.productName }</h3>`
			output += `</a>`
			output += `<ul class="product-size">`
			output += `<li>`
			output += `<div class="size-box">`
			output += `<h6 class="text-content">총 수량 :</h6>`
			output += `<h5>\${e.totalOrderCnt }권</h5>`
			output += `</div>`
			output += `</li>`
			output += `<li>`
			output += `<div class="size-box">`
			output += `<h6 class="text-content">결제금액 :</h6>`
			let actualPaymentAmount = Number(e.actualPaymentAmount)
				actualPaymentAmount = actualPaymentAmount.toLocaleString()
			output += `<h5>\${actualPaymentAmount}원</h5>`
			output += `</div>`
			output += `</li>`
			output += `<li>`
			output += `<div class="size-box">`
			output += `<h6 class="text-content">주문상태 :</h6>`
			output += `<h5>\${e.deliveryStatus }</h5>`
			output += `</div>`
			output += `</li>`
			output += `</ul>`
			output += `</div>`
			output += `</div>`
			output += `</div>`
		})
		$('.order-box.dashboard-bg-box').html(output)
	}
	
	//날짜포맷
	function formatDate(date) {
		let orderDate = new Date(date)
		let year = orderDate.getFullYear();
		let month = orderDate.getMonth() + 1;
		let day = orderDate.getDate();
		let dateStr = year+'.'+month+'.'+day;
		
		return dateStr
	}
	
	function orderHistoryPaging(pageNo) {
		$.ajax({
			url : '/user/myPage', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				"pageNo" : pageNo
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				outputOrder(data.orderHistory);
				let page = data.pagination
				let output = `<ul class="pagination justify-content-center">`;
				if(page.pageNo > 1){
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderHistoryPaging(\${page.pageNo - 1}); return false;">`
					output += `<i class="fa-solid fa-angles-left"></i>`
					output += `</a>`
					output += `</li>`			
				}
				
				for (let i = page.startNumOfCurrentPagingBlock; i < page.endNumOfCurrentPagingBlock + 1 ; i++) {
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderHistoryPaging(\${i}); return false;">\${i}</a> `
					output += `</li>`
				}
				if(page.pageNo < page.totalPageCnt){
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderHistoryPaging(\${page.pageNo + 1}); return false;">` 
					output += `<i class="fa-solid fa-angles-right"></i>`
					output += `</a>`
					output += `</li>`			
				}
				
				output += `</ul>`		
				
				$('.custome-pagination').html(output)
				//pagination(data.pagination)
				console.log("현재페이지 : " + pageNo)
			},
			error : function() {
			}
		});
	}
	
	function orderStatusPaging(pageNo) {
		$.ajax({
			url : '/user/searchOrderStatus', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				"pageNo" : pageNo
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data);
				outputOrder(data.orderStatus);
				//pagination(data.pagination)
				let page = data.pagination
				let output = `<ul class="pagination justify-content-center">`;
				if(page.pageNo > 1){
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${page.pageNo - 1}); return false;">`
					output += `<i class="fa-solid fa-angles-left"></i>`
					output += `</a>`
					output += `</li>`			
				}
				
				for (let i = page.startNumOfCurrentPagingBlock; i < page.endNumOfCurrentPagingBlock ; i++) {
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${i}); return false;">\${i}</a> `
					output += `</li>`
				}
				if(page.pageNo < page.totalPageCnt){
					output += `<li class="page-item">`
					output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${page.pageNo + 1}); return false;">` 
					output += `<i class="fa-solid fa-angles-right"></i>`
					output += `</a>`
					output += `</li>`			
				}
				
				output += `</ul>`		
				
				$('.custome-pagination').html(output)
				console.log("현재페이지 : " + pageNo)
			},
			error : function() {
			}
		});
	}
	
	function orderStatusPagination(page) {		
		let output = `<ul class="pagination justify-content-center">`;
		if(page.pageNo > 1){
			output += `<li class="page-item">`
			output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${page.pageNo - 1}); return false;">`
			output += `<i class="fa-solid fa-angles-left"></i>`
			output += `</a>`
			output += `</li>`			
		}
		
		for (let i = page.startNumOfCurrentPagingBlock; i < page.endNumOfCurrentPagingBlock + 1 ; i++) {
			output += `<li class="page-item">`
			output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${i}); return false;">\${i}</a> `
			output += `</li>`
		}
		if(page.pageNo < page.totalPageCnt){
			output += `<li class="page-item">`
			output += `<a class="page-link" href="javascript:void(0);" onclick="orderStatusPaging(\${page.pageNo + 1}); return false;">` 
			output += `<i class="fa-solid fa-angles-right"></i>`
			output += `</a>`
			output += `</li>`			
		}
		
		output += `</ul>`		
		
		$('.custome-pagination').html(output)
	}
	
	//찜 삭제
	function delWishlist(productId) {
		$.ajax({
			url : '/user/delWishlist', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				productId
			},
			dataType : 'text',
			async : false,
			success : function(data) {
				console.log(data);
				if(data == "success"){
					let wishlistItem = $('#' + productId);
	                wishlistItem.fadeOut(300, function () {
	                    wishlistItem.remove();
	                });
				}
			},
			error : function() {
			}
		});
	}
	
	//찜 목록에있는 상품 장바구니 추가
	function addShoppingCart(productId) {
		$.ajax({
			url : '/user/addShoppingCart', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				productId
			},
			dataType : 'text',
			async : false,
			success : function(data) {
				console.log(data);
				if(data == 'success'){
					alert("장바구니에 추가 되었습니다.")
				}
			},
			error : function() {
			}
		});
	}
	
	//리뷰랑 리뷰uf가져오기
	function selectReview(postNo) {
		$.ajax({
			url : '/user/selectModifyReview', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : {
				postNo
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				console.log(data)
				let output = `<div class="modal-body">`
				output += `<table class="table mb-0 productInfo">`;
				output += `<tbody>`;
				output += `<tr>`;
				output += `<td class="product-detail">`;
				output += `<div class="product border-0">`;
				if(data.review.productImage == null){
					output += `<a href="/detail/\${data.review.productId}" class="product-image">`;
					output += `<img src="/resources/assets/images/noimage.jpg" class="img-fluid blur-up lazyload" alt="\${data.review.productName}">`;
					output += `</a>`;
				}else{
					output += `<a href="/detail/\${data.review.productId}" class="product-image">`;
					output += `<img src="\${data.review.productImage}" class="img-fluid blur-up lazyload" alt="\${data.review.productName}" id="reviewProductImg">`;
					output += `</a>`;
				}
				output += `</div>`;
				output += `</td>`;
				output += `<td></td>`;
				output += `</tr>`
				output += `<tr>`
				output += `<td class="name">`
				output += `<a href="/detail/\${data.review.productId}" id="productName">`
				output += `<h4 class="table-title text-content">\${data.review.productName}</h4>` 
				output += `</a>`
				output += `</td>`
				output += `<td class="name">`
				output += `<h4 class="table-title text-content">`
				for(let i = 1; i <6; i++){
					output += `<input type="radio" name="reviewStar" value="\${i}" id="rate\${i}" class='reviewStar'>`	
					output += `<label for="rate\${i}">`
					output += `<i class="fa-regular fa-star" id="rating\${i}" style="color: #0DA487;" onclick="reviewRating('rating\${i}')"></i>`	
					output += `</label>`
				}
				output += `</h4>` 
				output += `</td>`
				output += `</tr>`
				output += `</tbody>`
				output += `</table>`
				output += `<div class="form-floating mb-4 theme-form-floating">`
				output += `<textarea rows="7" cols="62" id="reviewContent">\${data.review.content}</textarea>`
			//	output += `<div>`
			//	output += `<i class="fa-solid fa-circle-exclamation" style="color: #ff0059;"></i>`
			//	output += `몇글자까지 가능?`
			//	output += `</div>`
				output += `</div>`
				output += `<div class="mb-3">`
				output += `<label for="upFile" class="form-label">첨부파일</label>`
				output += `<div class="upFileArea">업로드할 파일을 드래그앤 드랍 하세요.`
				output += `</div>`
				output += `<div class="uploadFile"></div>`
				output += `<div class="modal-footer">`
				output += `<button type="button" class="btn btn-secondary btn-md"
					data-bs-dismiss="modal">닫기</button>`
				output += `<button type="button" class="btn theme-bg-color btn-md text-white"
					onclick="updateReview(\${data.review.postNo}, '\${data.review.productId}')">수정</button>`
				output += `</div>`
				
				let postNo = data.review.postNo
				console.log(postNo)
				
				let output2 = ''
				//DB에 있는 uf출력
				$.each(data.reviewUf, function(i, elt) {
					let name = elt.newFileName.replace("\\", "/")
					console.log(elt.newFileName)
					if(elt.thumbnailFileName != null){ //이미지
						let thumb = elt.thumbnailFileName.replace("\\", "/")
						output2 += `<img src = '/resources/uploads/\${thumb}' class='upImg'  id="\${elt.originalFileName}" />
						<i class="fa-regular fa-square-minus" onclick ='remFile(\${postNo},this);'></i>`;
					}else{
						output2 += `<a href='/resources/uploads/\${name}' id="${postNo}" >\${elt.originalFileName}</a>
						<i class="fa-regular fa-square-minus" onclick ='remFile(this);'></i>`;
					}
				})
				
				$('.viewModifyReview').html(output);
				$('.uploadFile').html(output2);
				
				$('.upFileArea').on("dragenter dragover", function(evt) {
					evt.preventDefault();
				});
					
				$('.upFileArea').on("drop", function(evt) {
					evt.preventDefault();
					
					let files = evt.originalEvent.dataTransfer.files;
					
					for(let i = 0; i < files.length; i++){ 
			            let form = new FormData() //자바스크립트에서 만들었다. form태그를 객체처럼 만들었다.
			            form.append("uploadFile", files[i]); //파일의 이름을 컨트롤러 단의 MultipartFile 매개변수명과 동일하도록 한다.
			            console.log(files[i]);
			         
			            //업로드한 파일이있다면 추가
			            modifyReview(form);
					}
				});
			},
			error : function() {
			}
		});
	}

	//리뷰수정 버튼 누르면
	function updateReview(postNo, productId) {
		let rating = $("input:radio[name='reviewStar']:checked").val();
		let reviewContent = $('#reviewContent').val()
		console.log(rating)
		$.ajax({
	         url: "/user/updateReview",
	         type: "GET",
	         data: {
	            "productId" : productId,
	            "postNo" : postNo,
	            "rating" : rating,
	            "content" : reviewContent
	         },
	         dataType: "JSON",
	         async: false,
	         success: function(data) {
	            console.log(data);
	          //  if (data.status === "success") {
	            //  $('#modifyReviewModal').hide
	           //    location.reload()
	         //   } 
	         }, error: function(data) {
	            console.log("err", data);
	         }
	      });
	}
	
	//리뷰 삭제 버튼 누르면
	function delReview(postNo, productId) {
	      $.ajax({
	         url: "/user/deleteReview",
	         type: "POST",
	         data: {
	            "productId" : productId,
	            "postNo" : postNo,
	         },
	         dataType: "JSON",
	         async: false,
	         success: function(data) {
	            console.log("delete", data);
	            let review = $('#' + productId);
	            review.fadeOut(300, function () {
	            	review.remove();
	            })
	         }, error: function(data) {
	            console.log("err", data);
	         }
	      });
	}
	
	//업로드파일 추가
	function modifyReview(form) {
		$.ajax({
			url : 'modifyReview', // 데이터를 수신받을 서버 주소
			type : 'POST', // 통신방식(GET, POST, PUT, DELETE)
			data : form, 
			dataType : 'json',
			async : false,
			processData : false, //text데이터에 대해 쿼리스트링 처리를 하지 않겠다
			contentType : false, // 파일은 2진수로 되어있어서 인코딩 처리를 안 함. 디폴트는 인코딩 처리해서 서버로 보냄.x-www-form-urlencoded 처리 안 함(인코딩 하지 않음)
			success : function(data) {
				console.log(data);
				
				if(data != null){
					showUploadedFile(data);
				}
			},
		});
	}
	
	//업로드한 파일이있다면 추가
	function showUploadedFile(file) {
		let output = "";
		
		$.each(file, function(i, elt) {
				let name = elt.newFileName.replace("\\", "/");
			if(elt.thumbnailFileName != null){ //이미지
				let thumb = elt.thumbnailFileName.replace("\\", "/");
				output += `<img src = '/resources/uploads/\${thumb}'  id="\${elt.originalFileName}" class='upImg'/>
					<i class="fa-regular fa-square-minus" onclick ='remFile(this);'></i>`;
			}else{
				output += `<a href='/resources/uploads/\${name}' id="\${elt.originalFileName}" >\${elt.originalFileName}</a>
					<i class="fa-regular fa-square-minus" onclick ='remFile(this);'></i>`;
			}

		})
		$('.uploadFile').append(output);
	}

	//별점 아이콘변경
	function reviewRating(id) {
		let reviewRatingId = $(`#\${id}`);
		if (reviewRatingId.hasClass("fa-regular")) {
			reviewRatingId.removeClass("fa-regular").addClass("fa-solid")
		}else if (reviewRatingId.hasClass("fa-solid")) {
			reviewRatingId.removeClass("fa-solid").addClass("fa-regular")
		}
	}
	
	//업로드파일 삭제버튼 눌렀을 때
	function remFile(postNo, fileId) {
		let removeFile = $(fileId).prev().attr('src')
		let removeFileId = $(fileId).prev().attr('id')
		console.log(removeFile)
		//alert(postNo + "번 파일")
		//console.log(thumbFileName + "썸네일 이름!!")
		let thumbFileName = removeFile.split("/resources/uploads")[1]
		console.log(postNo)
		console.log(thumbFileName)
		
		$.ajax({
			url : 'deleteUploadFile', // 데이터를 수신받을 서버 주소
			type : 'post', // 통신방식(GET, POST, PUT, DELETE) 
			data : {
				postNo,
				thumbFileName
			}, 
			dataType : 'text',
			async : false,
			success : function(data) {
				console.log(data);
					$(fileId).prev().remove();
					$(fileId).remove();
			},
		});
	}

</script>
<style>
.modifyProfileBtn {
	background-color: #E0EFEC;
	width: 100px;
	height: 30px;
	border: none;
	border-radius: 50px;
	margin-left: 125px;
}

.filebox {
	margin-top: 10px;
	padding-left: 65px;
}

.filebox .upload-name {
	display: inline-block;
	height: 40px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #dddddd;
	width: 78%;
	color: #999999;
}

.filebox label, .profileBtn {
	display: inline-block;
	padding: 10px 20px;
	color: #fff;
	vertical-align: middle;
	background-color: #999999;
	cursor: pointer;
	height: 40px;
	margin-left: 10px;
	border: none;
	margin-top: 10px;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.wishItemName, .wishItemPrice {
	text-align: center;
}

#writeInquiry {
	margin-left: 800px;
}

.reviewStar, #modifyAddress, .col-12.codeCheck, #sendCodeBtn {
	display: none;
}

.upFileArea {
	width: 100%;
	height: 100px;
	border: 1px dotted #333;
	padding: 10px;
	font-weight: bold;
	color: #d6d2d8;
	font-size: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#reviewProductImg {
	height: 250px;
	margin-left: 140px;
}

#deliveryStatus, #successPwd, #successPhoneNumber,
	#successCellPhoneNumber, #successEmail, #successAddr, #successRefund,
	#checkOrder, .form-floating.theme-form-floating.editEmail {
	display: flex;
}

#productImg {
	width: 184px;
}

.newPhoneNumberEdit, .newEmailEdit, .newCellPhoneNumberEdit,
	.editNewUserPwd, .editRefund, #successPwd, #successPhoneNumber,
	#successCellPhoneNumber, #successEmail, .filebox {
	display: none;
}

.fa-regular.fa-pen-to-square.fa-xl.editPhoneNumber, .fa-regular.fa-pen-to-square.fa-xl.editEmail,
	.fa-regular.fa-pen-to-square.fa-xl.editCellPhoneNumber, .fa-regular.fa-pen-to-square.fa-xl.refund,
	.fa-regular.fa-pen-to-square.fa-xl.editUserPwd {
	cursor: pointer;
}

.msg {
	color: tomato;
	font-weight: bold;
}

.trueMsg {
	font-weight: bold;
}

.col-12.modifyBtn {
	display: flex;
	justify-content: center;
}

.form-floating
.theme-form-floating
.editPhoneNumber, .form-floating
.theme-form-floating
.editEmail, .form-floating
.theme-form-floating
.editCellPhoneNumber, .form-floating
.theme-form-floating
.pwd, #orderStatus {
	display: flex;
}

#authenticationMsg {
	font-size: 18px;
}

.container-fluid-lg.recentOrderHistoy {
	padding-left: 0px;
}

.btn.btn-sm.add-button.w-100.basicAddrBtn {
	background-color: #E0EFEC;
}

.col-xxl-9.recentOrder {
	margin-top: 0px;
}

#deliveryStatus, #reviewBtn {
	gap: 15px;
}

#deliveryStatus Button {
	width: 90px;
	height: 30px;
}

#orderStatus, #checkOrder {
	gap: 7px;
}

#orderStatus Button {
	width: 80px;
	height: 30px;
}

.orderDetailClick {
	font-size: 24px;
}

#curOrderNo {
	font-size: 20px;
}

#intoDetailOrder {
	font-size: 12px;
	border: 2px solid #0DA487;
	border-radius: 10px;
	padding: 5px;
}

#clickDetailOrder {
	width: 64px;
	font-size: 12px;
	border: 2px solid #0DA487;
	border-radius: 10px;
	padding: 5px;
	text-align: center;
}

#orderWrap {
	display: flex;
	gap: 10px;
}

.cart-section.section-b-space.curOrderList {
	padding-bottom: 0px;
}

#selectOrderStatus, #checkOrderPeriod {
	margin-top: 30px;
}

.table.reviewTable {
	border-bottom: 1.5px solid gray;
}

.btn.theme-bg-color.btn-md.text-white.delReview, .btn.theme-bg-color.btn-md.text-white.modifyReview
	{
	width: 25px;
	height: 20px;
}

.btn.theme-bg-color.btn-md.text-white.modifyReview {
	text-align: right;
}

#successEmail {
	margin-top: 10px;
}
</style>
</head>

<body>

	<!-- Loader Start -->

	<!-- Loader End -->

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

	<!-- Breadcrumb Section Start -->
	<section class="breadscrumb-section pt-0">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-12">
					<div class="breadscrumb-contain">
						<h2>MyPage</h2>
						<nav>
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="index.html"> <i
										class="fa-solid fa-house"></i>
								</a></li>
								<li class="breadcrumb-item active" aria-current="page">
									마이페이지</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- User Dashboard Section Start -->
	<section class="user-dashboard-section section-b-space">
		<div class="container-fluid-lg">
			<div class="row">
				<div class="col-xxl-3 col-lg-4">
					<div class="dashboard-left-sidebar">
						<div class="close-button d-flex d-lg-none">
							<button class="close-sidebar">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
						<div class="profile-box">
							<div class="cover-image">
								<img src="/resources/assets/images/deer.png"
									class="img-fluid blur-up lazyload" alt="" />
							</div>

							<div class="profile-contain">
								<div class="profile-image">
									<div class="position-relative">
										<c:choose>
											<c:when test="${memberImg == '' }">
												<img src="/resources/assets/images/profile/user.png"
													class="blur-up lazyload update_img" alt="" />
											</c:when>
											<c:otherwise>
												<img src="/resources/profileUpload/${memberImg}"
													class="blur-up lazyload update_img" alt="" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<button class="modifyProfileBtn">변경</button>
								<div class="cover-icon filebox">
									<input class="upload-name" value="첨부파일" placeholder="첨부파일">
									<label for="file">파일찾기</label> <input type="file"
										onchange="readURL(this,0)" id="file" />
									<button class="profileBtn" onclick="uploadProfile();">
										등록</button>
								</div>

								<div class="profile-name">
									<h3>${userInfo.memberId }</h3>
									<h6 class="text-content">
										<img width="50" height="50"
											src="/resources/assets/images/deerWithMemberGrade.png"
											alt="external-deer-winter-vitaliy-gorbachev-lineal-vitaly-gorbachev" />${userInfo.membershipGrade }</h6>
								</div>
							</div>
						</div>

						<ul class="nav nav-pills user-nav-pills" id="pills-tab"
							role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="pills-dashboard-tab"
									data-bs-toggle="pill" data-bs-target="#pills-dashboard"
									type="button" role="tab" aria-controls="pills-dashboard"
									aria-selected="true">
									<i data-feather="home"></i> Home
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-order-tab"
									data-bs-toggle="pill" data-bs-target="#pills-order"
									type="button" role="tab" aria-controls="pills-order"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>주문내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-cancel-tab"
									data-bs-toggle="pill" data-bs-target="#pills-cancel"
									type="button" role="tab" aria-controls="pills-cancel"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>취소 내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-return-tab"
									data-bs-toggle="pill" data-bs-target="#pills-return"
									type="button" role="tab" aria-controls="pills-return"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>반품 내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-exchange-tab"
									data-bs-toggle="pill" data-bs-target="#pills-exchange"
									type="button" role="tab" aria-controls="pills-exchange"
									aria-selected="false">
									<i data-feather="shopping-bag"></i>교환 내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-profile-tab"
									data-bs-toggle="pill" data-bs-target="#pills-profile"
									type="button" role="tab" aria-controls="pills-profile"
									aria-selected="false">
									<i data-feather="user"></i> 회원정보
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-address-tab"
									data-bs-toggle="pill" data-bs-target="#pills-address"
									type="button" role="tab" aria-controls="pills-address"
									aria-selected="false">
									<i data-feather="map-pin"></i> 배송 주소록
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-wishlist-tab"
									data-bs-toggle="pill" data-bs-target="#pills-wishlist"
									type="button" role="tab" aria-controls="pills-wishlist"
									aria-selected="false">
									<i data-feather="heart"></i> 찜
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-inquiry-tab"
									data-bs-toggle="pill" data-bs-target="#pills-inquiry"
									type="button" role="tab" aria-controls="pills-inquiry"
									aria-selected="false"
									onclick="location.href='/cs/viewInquiry';">
									<i data-feather="help-circle"></i>1:1문의내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-review-tab"
									data-bs-toggle="pill" data-bs-target="#pills-review"
									type="button" role="tab" aria-controls="pills-review"
									aria-selected="false">
									<i data-feather="clipboard"></i>작성한 리뷰
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-card-tab"
									data-bs-toggle="pill" data-bs-target="#pills-card"
									type="button" role="tab" aria-controls="pills-card"
									aria-selected="false">
									<i data-feather="smile"></i>포인트 내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-rewards-tab"
									data-bs-toggle="pill" data-bs-target="#pills-rewards"
									type="button" role="tab" aria-controls="pills-rewards"
									aria-selected="false">
									<i data-feather="smile"></i>적립금 내역
								</button>
							</li>

							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-coupons-tab"
									data-bs-toggle="pill" data-bs-target="#pills-coupons"
									type="button" role="tab"
									aria-controls="pills-coupons
									aria-selected="false">
									<i data-feather="smile"></i>쿠폰 내역
								</button>
							</li>
						</ul>
					</div>
				</div>

				<div class="col-xxl-9 col-lg-8">
					<button
						class="btn left-dashboard-show btn-animation btn-md fw-bold d-block mb-4 d-lg-none">
						Show Menu</button>
					<div class="dashboard-right-sidebar">
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-dashboard"
								role="tabpanel" aria-labelledby="pills-dashboard-tab">
								<div class="dashboard-home">
									<div class="title">
										<h2>마이페이지</h2>
										<span class="title-leaf"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>

									<div class="total-box">
										<div class="row g-sm-4 g-3">
											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="/resources/assets/images/svg/order.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="/resources/assets/images/svg/order.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>포인트</h5>
														<h3>
															<fmt:formatNumber value="${userInfo.totalPoints }"
																type="NUMBER" />
															점
														</h3>
													</div>
												</div>
											</div>

											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="/resources/assets/images/svg/pending.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="/resources/assets/images/svg/pending.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>적립금</h5>
														<h3>
															<fmt:formatNumber value="${userInfo.totalRewards }"
																type="NUMBER" />
															원
														</h3>
													</div>
												</div>
											</div>

											<div class="col-xxl-4 col-lg-6 col-md-4 col-sm-6">
												<div class="totle-contain">
													<img src="/resources/assets/images/svg/wishlist.svg"
														class="img-1 blur-up lazyload" alt="" /> <img
														src="/resources/assets/images/svg/wishlist.svg"
														class="blur-up lazyload" alt="" />
													<div class="totle-detail">
														<h5>쿠폰</h5>
														<h3>
															<fmt:formatNumber value="${userInfo.couponCount }"
																type="NUMBER" />
															개
														</h3>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="dashboard-title">
										<h3>최근 주문내역</h3>
									</div>

									<c:forEach var="curOrder" items="${curOrderHistory }">
										<span id="curOrderNo">주문번호 ${curOrder.orderNo } <a
											href="orderDetail?no=${curOrder.orderNo }"
											id="intoDetailOrder">상세보기</a>
										</span>
										<div id="orderTime">
											<fmt:formatDate value="${curOrder.orderTime }" type="date" />
										</div>
										<section class="cart-section section-b-space curOrderList">
											<div class="container-fluid-lg recentOrderHistoy">
												<div class="row g-sm-5 g-3">
													<div class="col-xxl-9 recentOrder">
														<div class="cart-table">
															<div class="table-responsive-xl">
																<table class="table">
																	<tbody>
																		<tr class="product-box-contain">
																			<td class="product-detail">
																				<div class="product border-0">
																					<a href="/detail/${curOrder.productId }"
																						class="product-image"> <c:choose>
																							<c:when test="${curOrder.productImage != '' }">
																								<img src="${curOrder.productImage }"
																									class="img-fluid blur-up lazyload"
																									alt="${curOrder.productName }" />
																							</c:when>
																							<c:otherwise>
																								<img src="/resources/assets/images/noimage.jpg"
																									class="img-fluid blur-up lazyload"
																									alt="${curOrder.productName }" />
																							</c:otherwise>
																						</c:choose>
																					</a>
																					<c:set var="productNameLength"
																						value="${fn:length(curOrder.productName)}" />
																					<div class="product-detail">
																						<ul>
																							<c:choose>
																								<c:when test="${productNameLength <= 6}">
																									<li class="name"><a
																										href="/detail/${curOrder.productId }">${curOrder.productName }</a></li>
																								</c:when>
																								<c:otherwise>
																									<li class="name"><a
																										href="/detail/${curOrder.productId }">${fn:substring(curOrder.productName, 0, 6)}...</a></li>
																								</c:otherwise>
																							</c:choose>
																						</ul>
																					</div>
																				</div>
																			</td>

																			<td class="product-detail">
																				<div class="product border-0">
																					<div class="product-detail">
																						<ul>
																							<c:forEach var="bankTransfers"
																								items="${bankTransfers }">
																								<c:choose>
																									<c:when
																										test="${curOrder.orderNo == bankTransfers.orderNo && curOrder.paymentMethod == 'bkt'}">
																										<li class="name">총 금액 : <fmt:formatNumber
																												value="${bankTransfers.amountToPay }"
																												type="NUMBER" />원
																										</li>
																									</c:when>

																								</c:choose>
																							</c:forEach>

																							<c:if test="${curOrder.paymentMethod != 'bkt'}">
																								<li class="name">총 금액 : <fmt:formatNumber
																										value="${curOrder.actualPaymentAmount }"
																										type="NUMBER" />원
																								</li>
																							</c:if>
																						</ul>
																						<ul>
																							<li class="name">총 권수 :
																								${curOrder.totalOrderCnt}권</li>
																						</ul>
																						<ul>
																							<li class="name">주문상태 :
																								${curOrder.deliveryStatus }</li>
																						</ul>
																					</div>
																				</div>
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
										</section>
									</c:forEach>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-wishlist"
								role="tabpanel" aria-labelledby="pills-wishlist-tab">
								<div class="dashboard-wishlist">
									<div class="title">
										<h2>My Wishlist</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>

									<div class="row g-sm-4 g-3">
										<c:forEach var="item" items="${wishlist }">
											<div class="col-xxl-3 col-lg-6 col-md-4 col-sm-6"
												id="${item.productId }">
												<div class="product-box-3 theme-bg-white h-100">
													<div class="product-header">
														<div class="product-image">
															<a href="/detail/${item.productId }"> <img
																src="${item.productImage }"
																class="img-fluid blur-up lazyload"
																alt="${item.productName }" />
															</a>

															<div class="product-header-top">
																<button class="btn wishlist-button close_button"
																	onclick="delWishlist('${item.productId }');">
																	<i data-feather="x"></i>
																</button>
															</div>
														</div>
													</div>

													<div class="product-footer">
														<div class="product-detail">
															<a href="/detail/${item.productId }">
																<h5 class="name wishItemName">${item.productName }</h5>
															</a>


															<h5 class="price wishItemPrice">
																<span class="theme-color"> <fmt:formatNumber
																		value="${item.sellingPrice }" type="NUMBER" /> 원
																</span>
																<del>
																	<fmt:formatNumber value="${item.consumerPrice }"
																		type="NUMBER" />
																	원
																</del>
															</h5>
															<div class="add-to-cart-box mt-2">
																<button class="btn btn-add-cart addcart-button"
																	onclick="addShoppingCart('${item.productId }');"
																	tabindex="0">Add</button>

															</div>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-order" role="tabpanel"
								aria-labelledby="pills-order-tab">
								<div class="dashboard-order">
									<div class="title">
										<h2>주문내역</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
										<div id="checkOrder">
											<div class="col-12" id="selectOrderStatus">
												<div class="form-floating theme-form-floating">
													<select class="form-select" id="orderStatusKeyword"
														aria-label="Floating label select example">
														<option value="allList">전체</option>
														<option value="beforeDeposit">입금전</option>
														<option value="beforeShipping">출고전</option>
														<option value="shipping">배송중</option>
														<option value="deliveryCompleted">배송완료</option>
														<option value="returnApply">반품신청</option>
														<option value="exchangeApply">교환신청</option>
														<option value="cancelList">취소</option>
														<option value="exchangeList">교환</option>
														<option value="returnList">반품</option>
													</select> <label for="floatingSelect">주문상태별 조회</label>
												</div>
											</div>

											<div class="col-12" id="checkOrderPeriod">
												<div class="form-floating theme-form-floating">
													<select class="form-select" id="orderPeriod"
														aria-label="Floating label select example">
														<option value="allList">전체</option>
														<option value="sevenDaysAgo">일주일</option>
														<option value="fifteenDaysAgo">15일</option>
														<option value="aMonthAgo">1개월</option>
													</select> <label for="floatingSelect">주문기간별 조회</label>
												</div>
											</div>
										</div>

									</div>
									<div class="order-contain orderHistory">
										<div class="order-box dashboard-bg-box">
											<c:forEach var="order" items="${orderList }">
												<div class="product-order-detail" id="productOrderDetail">
													<c:choose>
														<c:when test="${order.productImage != '' }">
															<a href="/detail/${order.productId }" class="order-image">
																<img src="${order.productImage }"
																class="blur-up lazyload" alt="${order.productName }"
																id="productImg" />
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${order.productId }" class="order-image">
																<img src="/resources/assets/images/noimage.jpg"
																class="blur-up lazyload" alt="noImg" id="productImg" />
															</a>
														</c:otherwise>
													</c:choose>

													<div class="order-wrap">
														<div id="orderWrap">
															<span class="orderDetailClick">주문번호 :
																${order.orderNo }</span> <a
																href="orderDetail?no=${order.orderNo }"
																id="clickDetailOrder">상세보기</a>
														</div>
														<p class="text-content" id="orderTime">
															<fmt:formatDate value="${order.orderTime }" type="date" />

														</p>

														<a href="/detail/${order.productId }">
															<h3>${order.productName }</h3>
														</a>
														<ul class="product-size">
															<li>
																<div class="size-box">
																	<h6 class="text-content">총 수량 :</h6>
																	<h5>${order.totalOrderCnt }권</h5>
																</div>
															</li>

															<li>
																<div class="size-box">
																	<h6 class="text-content">결제금액 :</h6>
																	<c:forEach var="bankTransfers"
																		items="${bankTransfers }">
																		<c:choose>
																			<c:when
																				test="${order.orderNo == bankTransfers.orderNo && order.paymentMethod == 'bkt'}">
																				<h5>
																					<fmt:formatNumber
																						value="${bankTransfers.amountToPay}" type="NUMBER" />
																					원
																				</h5>
																			</c:when>
																		</c:choose>
																	</c:forEach>
																	<c:if test="${order.paymentMethod != 'bkt'}">
																		<h5>
																			<fmt:formatNumber
																				value="${order.actualPaymentAmount}" type="NUMBER" />
																			원
																		</h5>
																	</c:if>
																</div>
															</li>

															<li>
																<div class="size-box">
																	<h6 class="text-content">주문상태 :</h6>
																	<h5>${order.deliveryStatus }</h5>
																</div>
															</li>

															<li>
																<div class="size-box">
																	<div id="orderStatus">

																		<c:if test="${order.deliveryStatus eq '배송중' }">
																			<button class="btn theme-bg-color text-white m-0"
																				type="button" id="button-addon1">
																				<span>배송조회</span>
																			</button>
																			<div>${order.invoiceNumber }</div>
																		</c:if>

																		<c:if test="${order.deliveryStatus eq '배송완료' }">
																			<div>배송완료</div>
																		</c:if>

																	</div>
																</div>
															</li>
														</ul>
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>

								<nav class="custome-pagination">
									<ul class="pagination justify-content-center">

										<!--  	<c:if test="${page.pageNo > 1 }">
											<li class="page-item"><a class="page-link" href="#"
												
												onclick="orderHistoryPaging(${page.pageNo -1}); return false;">
													<i class="fa-solid fa-angles-left"></i>
											</a></li>
										</c:if>-->

										<c:forEach var="i"
											begin="${page.startNumOfCurrentPagingBlock }"
											end="${page.endNumOfCurrentPagingBlock }">
											<li class="page-item"><a class="page-link"
												onclick="orderHistoryPaging(${i}); return false;" href="#">${i }</a></li>
										</c:forEach>

										<c:if test="${page.pageNo < page.totalPageCnt }">
											<li class="page-item"><a class="page-link"
												onclick="orderHistoryPaging(${page.pageNo +1}); return false;"
												href="#"> <i class="fa-solid fa-angles-right"></i>
											</a></li>
										</c:if>

									</ul>
								</nav>
							</div>

							<div class="tab-pane fade show" id="pills-cancel" role="tabpanel"
								aria-labelledby="pills-cancel">
								<div class="dashboard-order">
									<div class="title">
										<h2>취소 내역</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>


									</div>
									<div class="order-contain orderHistory">
										<div class="order-box dashboard-bg-box">
											<c:forEach var="cancel" items="${cancelList }">
												<div class="product-order-detail" id="productOrderDetail">
													<c:choose>
														<c:when test="${cancel.productImage != '' }">
															<a href="/detail/${cancel.productId }"
																class="order-image"> <img
																src="${cancel.productImage }" class="blur-up lazyload"
																alt="${cancel.productName }" id="productImg" />
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${cancel.productId }"
																class="order-image"> <img
																src="/resources/assets/images/noimage.jpg"
																class="blur-up lazyload" alt="noImg" id="productImg" />
															</a>
														</c:otherwise>
													</c:choose>

													<div class="order-wrap">
													<p class="text-content">취소번호 :
																${cancel.cancelId }</p>
														<p class="text-content" id="orderTime">
															<fmt:formatDate value="${cancel.requestTime }"
																type="date" />

														</p>

														<a href="/detail/${cancel.productId }">
															<h3>${cancel.productName }</h3>
														</a>
														<ul class="product-size">
															<li>
																<div class="size-box">
																	<h6 class="text-content">취소금액 :</h6>
																	<h5>
																		<fmt:formatNumber value="${cancel.amount}"
																			type="NUMBER" />
																		원
																	</h5>
																</div>
															</li>

															<li>
																<div class="size-box">
																	<h5>${cancel.processingStatus }</h5>
																</div>
															</li>
														</ul>
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-return" role="tabpanel"
								aria-labelledby="pills-return">
								<div class="dashboard-order">
									<div class="title">
										<h2>반품 내역</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>


									</div>
									<div class="order-contain orderHistory">
										<div class="order-box dashboard-bg-box">
											<c:forEach var="returnList" items="${returnList }">
												<div class="product-order-detail" id="productOrderDetail">
													<c:choose>
														<c:when test="${returnList.productImage !=''}">
															<a href="/detail/${returnList.productId }"
																class="order-image"> <img
																src="${returnList.productImage }"
																class="blur-up lazyload"
																alt="${returnList.productName }" id="productImg" />
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${returnList.productId }"
																class="order-image"> <img
																src="/resources/assets/images/noimage.jpg"
																class="blur-up lazyload" alt="noImg" id="productImg" />
															</a>
														</c:otherwise>
													</c:choose>

													<div class="order-wrap">
													<p class="text-content" id="orderTime">반품 번호 : ${returnList.returnsId }</p>
														<p class="text-content" id="orderTime">
															<fmt:formatDate value="${returnList.requestTime }"
																type="date" />

														</p>

														<a href="/detail/${returnList.productId }">
															<h3>${returnList.productName }</h3>
														</a>
														<ul class="product-size">
															<li>
																<div class="size-box">
																	<h5>${returnList.processingStatus }</h5>
																</div>
															</li>
															<li>
																<div class="size-box">
																	<h6 class="text-content">회수 우편번호 :</h6>
																	<h5>${returnList.returnShippingAddressZipNo }</h5>
																</div>
															</li>
															<li>
																<div class="size-box">
																	<h6 class="text-content">회수 주소 :</h6>
																	<h5>${returnList.returnShippingAddressAddr }</h5>
																</div>
															</li>
															<li>
																<div class="size-box">
																	<h6 class="text-content">회수 상세주소 :</h6>
																	<h5>${returnList.returnShippingAddressDetailAddr }</h5>
																</div>
															</li>
															<c:if
																test="${returnList.returnShippingAddressReturnMsg.equal('')}">
																<li>
																	<div class="size-box">
																		<h6 class="text-content">메세지 :</h6>
																		<h5>${returnList.returnShippingAddressReturnMsg }</h5>
																	</div>
																</li>
															</c:if>
														</ul>
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-exchange"
								role="tabpanel" aria-labelledby="pills-exchange">
								<div class="dashboard-order">
									<div class="title">
										<h2>교환 내역</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>


									</div>
									<div class="order-contain orderHistory">
										<div class="order-box dashboard-bg-box">
											<c:forEach var="exchange" items="${exchangeList }">
												<div class="product-order-detail" id="productOrderDetail">
													<c:choose>
														<c:when test="${exchange.productImage != '' }">
															<a href="/detail/${exchange.productId }"
																class="order-image"> <img
																src="${exchange.productImage }" class="blur-up lazyload"
																alt="${exchange.productName }" id="productImg" />
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${exchange.productId }"
																class="order-image"> <img
																src="/resources/assets/images/noimage.jpg"
																class="blur-up lazyload" alt="noImg" id="productImg" />
															</a>
														</c:otherwise>
													</c:choose>

													<div class="order-wrap">
													<p class="text-content" id="orderTime">교환 번호 : ${exchange.returnsId }</p>
														<p class="text-content" id="orderTime">
															<fmt:formatDate value="${exchange.requestTime }"
																type="date" />

														</p>

														<a href="/detail/${exchange.productId }">
															<h3>${exchange.productName }</h3>
														</a>
														<ul class="product-size">

															<li>
																<div class="size-box">
																	<h5>${exchange.processingStatus }</h5>
																</div>
															</li>
															<li>
																<div class="size-box">
																	<h6 class="text-content">회수 주소 :</h6>
																	<h5>${exchange.returnShippingAddressZipNo }</h5>
																	<h5>${exchange.returnShippingAddressAddr }</h5>
																	<h5>${exchange.returnShippingAddressDetailAddr }</h5>
																</div>
															</li>
															<c:if
																test="${exchange.returnShippingAddressReturnMsg != ''}">
																<li>
																	<div class="size-box">
																		<h6 class="text-content">메세지 :</h6>
																		<h5>${exchange.returnShippingAddressReturnMsg }</h5>
																	</div>
																</li>
															</c:if>

															<li>
																<div class="size-box">
																	<h6 class="text-content">교환 주소 :</h6>
																	<h5>${exchange.exchangeShippingAddressZipNo }</h5>
																	<h5>${exchange.exchangeShippingAddressAddr }</h5>
																	<h5>${exchange.exchangeShippingAddressDetailAddr }</h5>
																</div>
															</li>
															<c:if
																test="${exchange.exchangeShippingAddressExchangeMsg != ''}">
																<li>
																	<div class="size-box">
																		<h6 class="text-content">메세지 :</h6>
																		<h5>${exchange.exchangeShippingAddressExchangeMsg }</h5>
																	</div>
																</li>
															</c:if>

														</ul>
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-profile"
								role="tabpanel" aria-labelledby="pills-profile-tab">
								<div class="dashboard-profile">
									<div class="title">
										<h2>회원정보 수정</h2>
										<span class="title-leaf"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>
									</div>

									<div class="profile-about dashboard-bg-box">
										<div class="row">
											<div class="col-xxl-7">
												<div class="dashboard-title mb-3">
													<h3>${userInfo.memberId }</h3>
												</div>

												<div class="input-box">
													<div class="row g-4">
														<form class="row g-4" action="modifyUser" method="post">

															<div class="col-12">
																<div class="form-floating theme-form-floating pwd">
																	<input type="password" class="form-control"
																		id="userPwd" value="●●●●●●●●" readonly /> <label
																		for="userPwd">비밀번호</label> <i
																		class="fa-regular fa-pen-to-square fa-xl editUserPwd"></i>
																</div>
															</div>


															<div class="col-12 editNewUserPwd">
																<div class="form-floating theme-form-floating">
																	<input type="password" class="form-control" id="newPwd"
																		name="password" placeholder="새 비밀번호" /> <label
																		for="newPwd">새 비밀번호</label>
																	<div class="col-12">영어, 숫자, 특수문자 (!@#$%^*+=-) 를
																		1개이상 포함하여 8-15글자로 입력해주세요.</div>
																</div>
															</div>

															<div class="col-12 editNewUserPwd">
																<div class="form-floating theme-form-floating">
																	<input type="password" class="form-control"
																		id="newPwdCheck" placeholder="새 비밀번호 확인 " /> <label
																		for="newPwdCheck">새 비밀번호 확인</label>
																	<div id="successPwd">
																		<i class="fa-regular fa-circle-check fa-lg"
																			style="color: #0e997e"></i>
																		<button class="btn theme-bg-color btn-md text-white"
																			type="submit">변경</button>
																	</div>

																</div>
															</div>
														</form>


														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userName"
																	placeholder="이름" value="${userInfo.name }" readonly />
																<label for="userName">이름</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<input type="text" class="form-control" id="userBirth"
																	value="${userInfo.dateOfBirth }" placeholder="생년월일"
																	readonly /> <label for="userBirth">생년월일</label>
															</div>
														</div>

														<div class="col-12">
															<div class="form-floating theme-form-floating">
																<c:choose>
																	<c:when test="${fn:contains(userInfo.gender,'F')}">
																		<input type="text" class="form-control"
																			id="userGender" value="여자" placeholder="성별" readonly />
																		<label for="userGender">성별</label>
																	</c:when>
																	<c:otherwise>
																		<input type="text" class="form-control"
																			id="userGender" value="남자" placeholder="성별" readonly />
																		<label for="userGender">성별</label>
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
														<form class="row g-4" action="modifyUser" method="post">
															<div class="col-12">
																<div
																	class="form-floating theme-form-floating editPhoneNumber">
																	<input type="text" class="form-control"
																		id="userPhonNumber" value="${userInfo.phoneNumber }"
																		placeholder="전화번호" readonly /> <label
																		for="userPhonNumber">전화번호</label> <i
																		class="fa-regular fa-pen-to-square fa-xl editPhoneNumber"></i>
																</div>
															</div>

															<div class="col-12 newPhoneNumberEdit">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control"
																		id="newUserPhonNumber" name="phoneNumber"
																		placeholder="새 전화번호" /> <label
																		for="newUserPhonNumber">새 전화번호</label>
																	<h5>-포함해서 입력해주세요.</h5>
																	<div id="successPhoneNumber">
																		<i class="fa-regular fa-circle-check fa-lg"
																			style="color: #0e997e"></i>
																		<button class="btn theme-bg-color btn-md text-white"
																			type="submit">변경</button>
																	</div>
																</div>
															</div>
														</form>

														<form class="row g-4" action="modifyUser" method="post">
															<div class="col-12">
																<div
																	class="form-floating theme-form-floating editCellPhoneNumber">
																	<input type="text" class="form-control"
																		id="cellPhoneNumber"
																		value="${userInfo.cellPhoneNumber }"
																		placeholder="휴대폰 번호" readonly /> <label
																		for="cellPhoneNumber">휴대폰 번호</label> <i
																		class="fa-regular fa-pen-to-square fa-xl editCellPhoneNumber"></i>
																</div>
															</div>

															<div class="col-12 newCellPhoneNumberEdit">
																<div
																	class="form-floating theme-form-floating editCellPhoneNumber">
																	<input type="text" class="form-control"
																		id="newCellPhoneNumber" name="cellPhoneNumber"
																		placeholder="새 휴대폰 번호" /> <label
																		for="newCellPhoneNumber">새 휴대폰 번호</label>
																	<h5>-포함해서 입력해주세요.</h5>
																	<div id="successCellPhoneNumber">
																		<i class="fa-regular fa-circle-check fa-lg"
																			style="color: #0e997e"></i>
																		<button class="btn theme-bg-color btn-md text-white"
																			type="submit">변경</button>
																	</div>
																</div>
															</div>
														</form>

														<form class="row g-4" action="modifyUser" method="post">
															<div class="col-12">
																<div class="form-floating theme-form-floating editEmail">
																	<input type="email" class="form-control" id="userEmail"
																		value="${userInfo.email }" placeholder="이메일" readonly />
																	<label for="userEmail">이메일</label> <i
																		class="fa-regular fa-pen-to-square fa-xl editEmail"></i>
																</div>
															</div>

															<div class="col-12 newEmailEdit">
																<div class="form-floating theme-form-floating editEmail">
																	<input type="text" class="form-control" id="newEmail"
																		name="email" placeholder="이메일" /> <label
																		for="newEmail">새 이메일</label>
																	<button type="button"
																		class="btn theme-bg-color btn-md text-white"
																		id="sendCodeBtn" onclick="sendCode();">코드전송</button>
																</div>
																<div id="errMsg"></div>
																<div class="col-12 codeCheck">
																	<input type="text" class="form-control" id="emailCode"
																		placeholder="코드" />
																	<button type="button"
																		class="btn theme-bg-color btn-md text-white"
																		id="checkCode">코드확인</button>
																</div>
																<div class="col-12" id="successEmail">
																	<button class="btn theme-bg-color btn-md text-white"
																		type="submit">변경</button>
																</div>

															</div>
														</form>

														<form class="row g-4" action="modifyUser" method="post">

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="button"
																		class="btn theme-bg-color btn-md text-white"
																		onclick="sample6_execDaumPostcode('modifyZipNo', 'modifyUserAddr', 'modifyDetailAddr', 'modifyExtraAddress')"
																		value="주소 찾기"><br>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" id="modifyZipNo"
																		value="${userInfo.zipCode}" name="zipCode"
																		class="form-control" placeholder="우편번호" readonly><label
																		for="modifyZipNo">우편번호</label>
																</div>
															</div>


															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" id="modifyUserAddr"
																		class="form-control" name="address"
																		value="${userInfo.address}" placeholder="주소" readonly>
																	<label for="modifyAddr">주소</label>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" id="modifyDetailAddr"
																		class="form-control" name="detailedAddress"
																		value="${userInfo.detailedAddress}" placeholder="상세주소"><label
																		for="modifyDetailAddr">상세주소</label>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" id="modifyExtraAddress"
																		class="form-control" placeholder="참고항목"><label
																		for="modifyExtraAddress">참고항목</label>
																</div>
															</div>

															<div class="col-12" id="modifyAddress">
																<div class="form-floating theme-form-floating">
																	<div id="successAddr">
																		<button class="btn theme-bg-color btn-md text-white"
																			type="submit">주소 변경</button>
																	</div>
																</div>
															</div>
														</form>

														<form class="row g-4" action="modifyUser" method="post">
															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control" id="refundBank"
																		value="${userInfo.refundBank}" placeholder="환불은행"
																		readonly /> <label for="refundBank">환불은행</label>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control"
																		id="accountHolder" value="${userInfo.accountHolder}"
																		placeholder="예금주" readonly /> <label
																		for="accountHolder">예금주</label>
																</div>
															</div>

															<div class="col-12">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control"
																		id="refundAccount" value="${userInfo.refundAccount}"
																		placeholder="환불계좌" readonly /> <label
																		for="refundAccount">환불계좌</label> <i
																		class="fa-regular fa-pen-to-square fa-xl refund"></i>
																</div>
															</div>

															<div class="col-12 editRefund">
																<div class="form-floating theme-form-floating">
																	<select class="form-select"
																		id="floatingSelect2 newRefundBank" name="refundBank"
																		aria-label="Floating label select example">
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

															<div class="col-12 editRefund">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control"
																		name="accountHolder" id="editAccountHolder"
																		value="${userInfo.accountHolder}" placeholder="예금주" />
																	<label for="accountHolder">예금주</label>
																</div>
															</div>

															<div class="col-12 editRefund">
																<div class="form-floating theme-form-floating">
																	<input type="text" class="form-control"
																		id="newRefundAccount" name="refundAccount"
																		placeholder="환불계좌" /> <label for="newRefundAccount">환불계좌</label>
																	<p>14자 이내로 입력해주세요.</p>
																	<div id="successRefund">
																		<button class="btn theme-bg-color btn-md text-white"
																			type="submit">변경</button>
																	</div>
																</div>
															</div>
														</form>

														<div class="col-12">
															<div class="forgot-box">
																<div class="form-check ps-0 m-0 remember-box">
																	<c:choose>
																		<c:when
																			test="${fn:contains(userInfo.identityVerificationStatus,'Y')}">
																			<input class="checkbox_animated check-box"
																				type="checkbox" id="authentication" checked disabled />
																			<label class="form-check-label" for="authentication"><span
																				id="authenticationMsg">본인인증</span></label>
																		</c:when>
																		<c:otherwise>
																			<button class="btn theme-bg-color btn-md text-white"
																				type="button" onclick="identify();">본인인증</button>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>

														<div class="col-12 modifyBtn">
															<button
																class="btn theme-bg-color btn-md text-white delUser"
																type="button" onclick="location.href='withdrawal';">탈퇴</button>
														</div>
													</div>
												</div>

											</div>

											<div class="col-xxl-5">
												<div class="profile-image">
													<img
														src="/resources/assets/images/inner-page/dashboard-profile.png"
														class="img-fluid blur-up lazyload" alt="" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-address"
								role="tabpanel" aria-labelledby="pills-address-tab">
								<div class="dashboard-address">
									<div class="title title-flex">
										<div>
											<h2>배송주소록</h2>

											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>

										<button
											class="btn theme-bg-color text-white btn-sm fw-bold mt-lg-0 mt-3"
											data-bs-toggle="modal" data-bs-target="#add-address">
											<i data-feather="plus" class="me-2"></i> 배송지 추가
										</button>
									</div>

									<div class="row g-sm-4 g-3">
										<c:forEach var="addr" items="${userAddrList }">

											<div class="col-xxl-4 col-xl-6 col-lg-12 col-md-6" id="${addr.addrSeq }">

												<div class="address-box">
													<div>

														<c:if test="${fn:contains(addr.basicAddr,'Y')}">
															<div class="label">
																<label>기본배송지</label>
															</div>
														</c:if>


														<div class="table-responsive address-table">
															<table class="table">
																<tbody>
																	<tr>
																		<td colspan="2" id="addrRecipient">${addr.recipient}</td>
																	</tr>

																	<tr>
																		<td colspan="2" id="addrRecipientContact">${addr.recipientContact}</td>
																	</tr>

																	<tr>
																		<td>우편번호 :</td>
																		<td>
																			<p id="addrZipCode">${addr.zipCode }</p>
																		</td>
																	</tr>

																	<tr>
																		<td>주소 :</td>
																		<td id="addrAddress">${addr.address }</td>
																	</tr>

																	<tr>
																		<td>상세주소 :</td>
																		<td id="addrDetailAddress">${addr.detailAddress }</td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>

													<c:if test="${fn:contains(addr.basicAddr,'N')}">
														<button class="btn btn-sm add-button w-100 basicAddrBtn"
															onclick="setBasicAddr(${addr.addrSeq});">
															<i data-feather=check class="me-2"></i> 기본배송지로 설정
														</button>
													</c:if>
													<div class="button-group">
														<button class="btn btn-sm add-button w-100"
															data-bs-toggle="modal" data-bs-target='#editProfile'
															onclick="editShippingAddr(${addr.addrSeq});">
															<i data-feather="edit"></i> Edit
														</button>
														<button class="btn btn-sm add-button w-100" type="button"
															onclick="delShippingAddr(${addr.addrSeq});">
															<i data-feather="trash-2"></i> Remove
														</button>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-card" role="tabpanel"
								aria-labelledby="pills-card-tab">
								<div class="dashboard-card">
									<div class="title title-flex">
										<div>
											<h2>포인트 내역</h2>
											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>
									</div>

									<div class="row g-4">
										<div class="container mt-3">
											<table class="table">
												<thead>
													<tr>
														<th>등록일</th>
														<th>상세내용</th>
														<th>포인트</th>
														<th>남은 포인트</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="pl" items="${pointLog }">
														<tr>
															<td><fmt:formatDate value="${pl.date }" type="date" /></td>
															<td>${pl.reason }</td>
															<td><fmt:formatNumber value="${pl.point }"
																	type="NUMBER" />점</td>
															<td><fmt:formatNumber value="${pl.balance }"
																	type="NUMBER" />점</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-coupons"
								role="tabpanel" aria-labelledby="pills-coupons-tab">
								<div class="dashboard-card">
									<div class="title title-flex">
										<div>
											<h2>쿠폰 내역</h2>
											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>
									</div>

									<div class="row g-4">
										<div class="container mt-3">
											<table class="table">
												<thead>
													<tr>
														<th>얻은 날짜</th>
														<th>쿠폰 이름</th>
														<th>쿠폰 쿠폰번호</th>
														<th>만료 날짜</th>
														<th>사용 날짜</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="cl" items="${couponLog }">
														<tr>
															<td><fmt:formatDate value="${cl.obtainedDate }"
																	type="date" /></td>
															<td>${cl.couponName }</td>
															<td>${cl.couponNumber }</td>
															<td><fmt:formatDate value="${cl.expirationDate }"
																	type="date" /></td>
															<td><fmt:formatDate value="${cl.usedDate }"
																	type="date" /></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>

							<div class="tab-pane fade show" id="pills-rewards"
								role="tabpanel" aria-labelledby="pills-rewards-tab">
								<div class="dashboard-card">
									<div class="title title-flex">
										<div>
											<h2>적립금 내역</h2>
											<span class="title-leaf"> <svg
													class="icon-width bg-gray">
                            <use
														xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                          </svg>
											</span>
										</div>
									</div>

									<div class="row g-4">
										<div class="container mt-3">
											<table class="table">
												<thead>
													<tr>
														<th>등록일</th>
														<th>상세내용</th>
														<th>적립금</th>
														<th>남은 적립금</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="rl" items="${rewardLog }">
														<tr>
															<td><fmt:formatDate value="${rl.date }" type="date" /></td>
															<td>${rl.reason }</td>
															<td><fmt:formatNumber value="${rl.reward }"
																	type="NUMBER" />원</td>
															<td><fmt:formatNumber value="${rl.balance }"
																	type="NUMBER" />원</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							
							<div class="tab-pane fade show" id="pills-review"
								role="tabpanel" aria-labelledby="pills-review">
								<div class="dashboard-order">
									<div class="title">
										<h2>작성한 리뷰</h2>
										<span class="title-leaf title-leaf-gray"> <svg
												class="icon-width bg-gray">
                          <use
													xlink:href="/resources/assets/svg/leaf.svg#leaf"></use>
                        </svg>
										</span>


									</div>
									<div class="order-contain orderHistory">
										<div class="order-box dashboard-bg-box">
											<c:forEach var="review" items="${reviewList }">
												<div class="product-order-detail" id="productOrderDetail">
													<c:choose>
														<c:when test="${review.productImage != '' }">
															<a href="/detail/${review.productId }"
																class="order-image"> <img
																src="${review.productImage }" class="blur-up lazyload"
																alt="${review.productName }" id="productImg" />
															</a>
														</c:when>
														<c:otherwise>
															<a href="/detail/${review.productId }"
																class="order-image"> <img
																src="/resources/assets/images/noimage.jpg"
																class="blur-up lazyload" alt="noImg" id="productImg" />
															</a>
														</c:otherwise>
													</c:choose>

													<div class="order-wrap">
														<p class="text-content" id="orderTime">
															<fmt:formatDate value="${review.createdDate }"
																type="date" />

														</p>

														<a href="/detail/${review.productId }">
															<h3>${review.productName }</h3>
														</a>
														<ul class="product-size">

															<li>
																<div class="size-box">
																	<h5><c:forEach begin="1" end="${review.rating }">
																	<i class="fa-solid fa-star" style="color: #0DA487;"></i>
																</c:forEach></h5>
																</div>
															</li>
															<li>
																<div class="size-box">
																	<h5>${review.content }</h5>
																</div>
															</li>
															<li>
																<div class="size-box" id="reviewBtn">
																	<button type="button"
																	class="btn theme-bg-color btn-md text-white modifyReview"
																	data-bs-toggle="modal"
																	data-bs-target="#modifyReviewModal"
																	onclick="selectReview(${review.postNo})">수정</button>
																	<button type="button"
																	class="btn theme-bg-color btn-md text-white delReview"
																	onclick="delReview(${review.postNo }, '${review.productId }');">삭제</button>
																</div>
															</li>
														</ul>
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>
						</div>
	</section>
	<!-- User Dashboard Section End -->

	<!-- Footer Section Start -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- Footer Section End -->

	<!-- Deal Box Modal Start
	
	Deal Box Modal End -->

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

	<!-- Add address modal box start -->
	<div class="modal fade theme-modal" id="add-address" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">배송지 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipient"
							name="recipient" placeholder="받는사람" /><label for="recipient">받는사람</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="recipientContact"
							name="recipientContact" placeholder="받는사람 연락처" /><label
							for="recipientContact">받는사람 연락처</label>
						<p>- 포함해서 입력해주세요.</p>
					</div>

					<div>
						<button type="button" class="btn theme-bg-color btn-md text-white"
							onclick="sample6_execDaumPostcode('addZipNo', 'addAddr', 'addAddrDetail', 'addExtraAddress');">주소
							검색</button>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control addZipNo" id="addZipNo"
							name="zipCode" placeholder="우편번호" readonly /><label
							for="addZipNo">우편번호</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control addAddr" id="addAddr"
							name="address" placeholder="주소" readonly /><label for="addAddr">주소</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control addAddrDetail"
							id="addAddrDetail" name="detailAddress" placeholder="상세 주소" /><label
							for="addAddrDetail">상세주소</label>
					</div>

					<div class="form-floating mb-4 theme-form-floating">
						<input type="text" class="form-control" id="addExtraAddress"
							placeholder="참고 항목" /><label for="addExtraAddress">참고항목</label>
					</div>

					 <input class="checkbox_animated check-box" type="checkbox"
						id="choiceBasicAddr" name="basicAddr" value="Y"/> <label
						class="form-check-label" for="choiceBasicAddr"><span
						id="choiceBasicAddr">기본배송지로 설정</span></label> 
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="addShippingAddress();" data-bs-dismiss="modal">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Add address modal box end -->

	<!-- Location Modal Start -->
	<div class="modal fade theme-modal" id="modifyReviewModal"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">리뷰수정</h5>

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="viewModifyReview"></div>
				<!--  	<div class="modal-body modifyReview">
					<table class="table mb-0 productInfo">
						<tbody>
							<tr>
								<td class="product-detail">
									<div class="product border-0">
										<a href="/detail/" class="product-image"> <img
											src="/resources/assets/images/noimage.jpg"
											class="img-fluid blur-up lazyload" alt="">
										</a>
									</div>
								</td>
								<td></td>
							</tr>
							<tr>
								<td class="name">
									<h4 class="table-title text-content">상품이름</h4> <a
									href="/detail/" id="productName"></a>
								</td>
								<td class="name">
									<h4 class="table-title text-content">별점</h4> 
								</td>
							</tr>
						</tbody>
					</table>
					<div class="form-floating mb-4 theme-form-floating">
						content<input type="text" class="form-control" id="exchangeReason"
							value="상품 하자" name="reason" readonly="readonly" />
						<div class="deliverMsg">
							<i class="fa-solid fa-circle-exclamation" style="color: #ff0059;"></i>
							상품에 하자가 있는 경우에만 교환이 가능합니다.
						</div>
					</div>
				</div>
				<div class="uploadFile"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-md"
						data-bs-dismiss="modal" onclick="btnCancel();">닫기</button>
					<button type="button" class="btn theme-bg-color btn-md text-white"
						onclick="updateReview()">수정</button>
				</div>-->
			</div>
		</div>
	</div>
	<!-- Location Modal End -->

	<!-- Edit Profile Start -->

	<div class="modal fade theme-modal" id='editProfile' tabindex="-1"
		aria-labelledby="exampleModalLabel2" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel2">배송지 수정</h5>
					<div>${memberShippingAddr}</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-4 editAddr"></div>
				</div>
				<div class="modal-footer editAddrFooter"></div>
			</div>
		</div>
	</div>
	<!-- Edit Profile End -->

	<!-- Edit Card Start -->
	<div class="modal fade theme-modal" id="editCard" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel8">Edit Card</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-body">
					<div class="row g-4">
						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="finame"
										value="Mark" /> <label for="finame">First Name</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-6">
							<form>
								<div class="form-floating theme-form-floating">
									<input type="text" class="form-control" id="laname"
										value="Jecno" /> <label for="laname">Last Name</label>
								</div>
							</form>
						</div>

						<div class="col-xxl-4">
							<form>
								<div class="form-floating theme-form-floating">
									<select class="form-select" id="floatingSelect12"
										aria-label="Floating label select example">
										<option selected>Card Type</option>
										<option value="kindom">Visa Card</option>
										<option value="states">MasterCard Card</option>
										<option value="fra">RuPay Card</option>
										<option value="china">Contactless Card</option>
										<option value="spain">Maestro Card</option>
									</select> <label for="floatingSelect12">Card Type</label>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-animation btn-md fw-bold"
						data-bs-dismiss="modal">Cancel</button>
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light">
						Update Card</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Edit Card End -->

	<!-- Remove Profile Modal Start 
	<div class="modal fade theme-modal remove-profile" id="removeProfile"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header d-block text-center">
					<h5 class="modal-title w-100" id="exampleModalLabel22">삭제하시겠습니까?</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-animation btn-md fw-bold"
						data-bs-dismiss="modal">No</button>
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light"
						data-bs-target="#removeAddress" data-bs-toggle="modal">
						Yes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade theme-modal remove-profile" id="removeAddress"
		tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-center" id="exampleModalLabel12">
						삭제되었습니다.</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="modal-footer pt-0">
					<button type="button"
						class="btn theme-bg-color btn-md fw-bold text-light"
						onclick="location.reload();" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>-->
	<!-- Remove Profile Modal End -->

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

	<!-- Wizard js -->
	<script src="/resources/assets/js/wizard.js"></script>

	<!-- Slick js-->
	<script src="/resources/assets/js/slick/slick.js"></script>
	<script src="/resources/assets/js/slick/custom_slick.js"></script>

	<!-- Quantity js -->
	<script src="/resources/assets/js/quantity-2.js"></script>

	<!-- Nav & tab upside js -->
	<script src="/resources/assets/js/nav-tab.js"></script>

	<!-- script js -->
	<script src="/resources/assets/js/script.js"></script>
</body>
</html>
