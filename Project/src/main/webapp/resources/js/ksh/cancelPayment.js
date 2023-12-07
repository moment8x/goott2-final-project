// 검증 실패로 인한 취소
	function failVerification() {
		rc = {
			"imp_uid" : "imp_651936891989",
			"amount" : 200,
			"checksum" : 200,
			"reason" : "사후검증 실패로 인한 취소 테스트",
		}
		$.ajax({
			url : "/pay/cancel",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(rc),
			async : false,
			success : function(result) {
				console.log(result);
				alert("사후검증 결과 위조된 금액으로 취소 처리됐습니다.");
			},
			error : function(error) {
				alert("취소 실패" + error);

			}

		})
	}

	// 취소
	function cancelPayment() {
		rc = {
			"imp_uid" : "imp_651959197008",
			"amount" : 200,
			"checksum" : 200,
			"reason" : "전체 환불",
		}
		$.ajax({
			url : "/pay/cancel",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(rc),
			async : false,
			success : function(result) {
				console.log(result);
				alert("취소 완료");
			},
			error : function(error) {
				alert("취소 실패" + error);
			}
		})
	}