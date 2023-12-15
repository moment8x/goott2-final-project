function goPopup() {
		/* 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.*/
		var pop = window.open("jusoPopup", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.

		
		
		// 배송주소록 추가 주소찾기
		let addZipNo = null
		let addAddr = null
		let addAddrDetail = null

		if(document.querySelector("#addZipNo")){
			addZipNo = document.querySelector("#addZipNo")
			addZipNo.value = zipNo;
		}
		if(document.querySelector("#addAddr")){
			addAddr = document.querySelector("#addAddr")
			addAddr.value = roadAddrPart1;
		}
		if(document.querySelector("#addAddrDetail")){
			addAddrDetail = document.querySelector("#addAddrDetail")
			addAddrDetail.value = addrDetail
		}
	}