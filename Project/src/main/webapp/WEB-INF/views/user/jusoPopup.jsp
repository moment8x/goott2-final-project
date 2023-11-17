<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
	request.setCharacterEncoding("UTF-8");  // 한글깨지면 주석제거
	
	String confmKey = "devU01TX0FVVEgyMDIzMTExNzE3MDM0OTExNDI4NzU="; // 검색API 승인키
	String domain = "http://www.juso.go.kr"; // 인터넷망
	// ※ 행정망 내에서 운영되는 시스템도 이용 가능합니다. 행정망 서비스를 위한 API 요청URL은 별도로 문의 주시기 바랍니다.(1588-0061)
	String resultType = "4"; // 검색결과 화면 출력유(1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명)
%>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script language="javascript">
//특수문자, 특정문자열(sql예약어) 제거
function checkSearchedWord(obj){
	obj.value = obj.value+" ";
	//특수문자 제거
	if(obj.value.length >0){
		var expText = /[%=><]/ ;
		if(expText.test(obj.value) == true){
			obj.value = obj.value.split(expText).join(""); 
		}
		//체크 문자열
		var sqlArray = new Array( //sql 예약어
			"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION",  "FETCH", "DECLARE", "TRUNCATE"
		);
		
		var regex;
		var regex_plus ;
		for(var i=0; i<sqlArray.length; i++){
			regex = new RegExp("\\s" + sqlArray[i] + "\\s","gi") ;
			if (regex.test(obj.value)) {
				obj.value =obj.value.replace(regex, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
			regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
			if (regex_plus.test(obj.value)) {
				obj.value =obj.value.replace(regex_plus, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
		}
	}
	return obj.value = obj.value;
}

function searchUrlJuso(){
	$("#resultData").hide();
	var frm = document.AKCFrm;
	frm.keyword.value = checkSearchedWord(frm.keyword); // 특수문자 및 sql예약어 제거, 20160912
	//$("#keyword").val(validateJuso($("#keyword").val())); //공백 및 특수문자 제거
	//$("#keyword").val(regExpCheckJuso($("#keyword").val()));
	
	$.ajax({
		 url :"<%=domain %>/addrlink/addrLinkApiJsonp.do"  //인터넷망
		,type:"post"
		,data:$("#AKCFrm").serialize()
		,dataType:"jsonp"
		,crossDomain:true
		,success:function(xmlStr){
			if(navigator.appName.indexOf("Microsoft") > -1){
				var xmlData = new ActiveXObject("Microsoft.XMLDOM");
				xmlData.loadXML(xmlStr.returnXml)
			}else{
				var xmlData = xmlStr.returnXml;
			}
			$(".popSearchNoResult").html("");
			var errCode = $(xmlData).find("errorCode").text();
			var errDesc = $(xmlData).find("errorMessage").text();
			
			var totalCount = $(xmlData).find("totalCount").text();
			var currentPage = $(xmlData).find("currentPage").text();
			
			if( parseInt(totalCount) > 1000 && currentPage == "1" )
				alert("검색 결과가 너무 많습니다(1,000건 이상)\n검색어 예를 참조하여 검색하시기 바랍니다.");
			
			if(errCode != "0"){
				alert(errDesc);
			}else{
				if(xmlStr != null){
					makeList(xmlData);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    	//alert("에러발생");
	    	alert("검색에 실패하였습니다 \n 다시 검색하시기 바랍니다.");
	    }
	});
		
}


function makeList(xmlStr){
	
	var htmlStr = "";
	if( $(xmlStr).find("totalCount").text() == "0" ){

		htmlStr +=' ';
		htmlStr += '<div class="popSearchNoResult" style="margin-top:10px; margin-bottom:5px;">';
		htmlStr += '	검색된 내용이 없습니다.';
		htmlStr += '</div>';
		htmlStr +='';
		
	}else{
		
		htmlStr += '<p class="text-guide">도로명주소 검색 결과 <strong>('+ $(xmlStr).find("totalCount").text()+'건)</strong></p>';
		htmlStr += '<table class="data-col" style="margin-top:3px;">';
		htmlStr += '	<caption>검색 결과</caption>';
		htmlStr += '	<colgroup>';
		htmlStr += '		<col style="width:8%">';
		htmlStr += '		<col>';
		htmlStr += '		<col style="width:11%">';
		htmlStr += '		<col style="width:14%">';
		htmlStr += '	</colgroup>';
		htmlStr += '	<thead>';
		htmlStr += '		<tr>';
		htmlStr += '			<th scope="col">No</th>';
		htmlStr += '			<th scope="col">도로명주소</th>';
		htmlStr += '			<th scope="col">&nbsp;</th>';
		htmlStr += '			<th scope="col">우편번호</th>';
		htmlStr += '		</tr>';
		htmlStr += '	</thead>';
		htmlStr += '	<tbody>';
        
		var currentPage = parseInt($(xmlStr).find("currentPage").text());
		var countPerPage = parseInt($(xmlStr).find("countPerPage").text());
		var listNum = (currentPage*countPerPage)-(--countPerPage);
		var num = 0; 
		$(xmlStr).find("juso").each(function(){
			num++;
			
			var resultType = "<%= resultType%>"; 

			htmlStr += '<tr>';
			htmlStr +='	<td class="subj" style="text-align:center;">'+(listNum++)+'</td>';
				
			if( resultType == "1" ){

				htmlStr += '	<td class="subj" colspan="2" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
				htmlStr += '		<a href="javascript:setMaping(\''+num+'\')">';
				htmlStr += '			<div tabindex="6">';
				htmlStr += '				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
				htmlStr += '			</div>';
				htmlStr += '		</a>';
				htmlStr += '		<span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr += '	</td>';
				
			}else if( resultType == "2" ){
				
				htmlStr += '	<td class="subj" colspan="2" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
				htmlStr += '		<a href="javascript:setMaping(\''+num+'\')">';
				htmlStr += '			<div tabindex="6">';
				htmlStr += '				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
				htmlStr +='				<span style="font-size:11px;">[지번] <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span></span>';
				htmlStr += '			</div>';
				htmlStr += '		</a>';
				htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr += '	</td>';				
				
			}else if( resultType == "3" ){
				
				htmlStr +='	<td class="subj" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
				htmlStr +='		<a href="javascript:setMaping(\''+num+'\')">';
				htmlStr +='			<div tabindex="6">';
				htmlStr +='				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
				htmlStr +='			</div>';
				htmlStr +='		</a>';
				htmlStr +='		<div id="detListDivX'+num+'" style="display:none;"><span style="font-size:11px;"> [상세건물명]'+$(this).find('detBdNmList').text()+' </span></div>';
				htmlStr += '		<span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
				htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr +='	</td>';
				htmlStr +='	<td class="subj" style="text-align:center;">';
				htmlStr +='		<div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('detBdNmList').text() != ""){
					htmlStr +='<a href="javascript:addrJuminRenew('+num+');">상세건물</br>보기</a>';
				}
				htmlStr +='		</div>';
				htmlStr +='		<div id="detDivX'+num+'" style="display:none;"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +='	</td>';				
				
			}else{
				
				htmlStr +='	<td class="subj" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
				htmlStr +='		<a href="javascript:setMaping(\''+num+'\')">';
				htmlStr +='			<div tabindex="6">';
				htmlStr +='				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
				htmlStr +='				<span style="font-size:11px;">[지번] <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span></span>';
				htmlStr +='			</div>';
				htmlStr +='		</a>';
				htmlStr +='		<div id="detListDivX'+num+'" style="display:none;"><span style="font-size:11px;"> [상세건물명]'+$(this).find('detBdNmList').text()+' </span></div>';
				htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
				htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
				htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
				htmlStr +='	</td>';
				htmlStr +='	<td class="subj" style="text-align:center;">';
				htmlStr +='		<div id="detDiv'+num+'" style="font-size:12px;">';
				if($(this).find('detBdNmList').text() != ""){
					htmlStr +='<a href="javascript:addrJuminRenew('+num+');">상세건물</br>보기</a>';
				}
				htmlStr +='		</div>';
				htmlStr +='		<div id="detDivX'+num+'" style="display:none;"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
				htmlStr +='	</td>';
				
			}
			
			htmlStr +='	<td class="subj" style="text-align:center" id="zipNoTd'+num+'"> ';
			htmlStr +='		<div id="zipNoDiv'+num+'">'+$(this).find('zipNo').text()+'</div>';
			htmlStr +='	</td>';
			htmlStr +='	<input type="hidden" id="admCdHid'+num+'" value="'+$(this).find('admCd').text()+'">';
			htmlStr +='	<input type="hidden" id="rnMgtSnHid'+num+'" value="'+$(this).find('rnMgtSn').text()+'">';
			htmlStr +='	<input type="hidden" id="bdMgtSnHid'+num+'" value="'+$(this).find('bdMgtSn').text()+'">';
			htmlStr +='	<input type="hidden" id="detBdNmListHid'+num+'" value="'+$(this).find('detBdNmList').text()+'"> ';
			htmlStr +='	<input type="hidden" id="bdNmHid'+num+'" value="'+$(this).find('bdNm').text()+'"> ';
			htmlStr +='	<input type="hidden" id="bdKdcdHid'+num+'" value="'+$(this).find('bdKdcd').text()+'"> ';
			htmlStr +='	<input type="hidden" id="siNmHid'+num+'" value="'+$(this).find('siNm').text()+'">';
			htmlStr +='	<input type="hidden" id="sggNmHid'+num+'" value="'+$(this).find('sggNm').text()+'"> ';
			htmlStr +='	<input type="hidden" id="emdNmHid'+num+'" value="'+$(this).find('emdNm').text()+'"> ';
			htmlStr +='	<input type="hidden" id="liNmHid'+num+'" value="'+$(this).find('liNm').text()+'"> ';
			htmlStr +='	<input type="hidden" id="rnHid'+num+'" value="'+$(this).find('rn').text()+'"> ';
			htmlStr +='	<input type="hidden" id="udrtYnHid'+num+'" value="'+$(this).find('udrtYn').text()+'">  ';
			htmlStr +='	<input type="hidden" id="buldMnnmHid'+num+'" value="'+$(this).find('buldMnnm').text()+'">  ';
			htmlStr +='	<input type="hidden" id="buldSlnoHid'+num+'" value="'+$(this).find('buldSlno').text()+'">  ';
			htmlStr +='	<input type="hidden" id="mtYnHid'+num+'" value="'+$(this).find('mtYn').text()+'">  ';
			htmlStr +='	<input type="hidden" id="lnbrMnnmHid'+num+'" value="'+$(this).find('lnbrMnnm').text()+'">   ';
			htmlStr +='	<input type="hidden" id="lnbrSlnoHid'+num+'" value="'+$(this).find('lnbrSlno').text()+'">  ';
			htmlStr +='	<input type="hidden" id="emdNoHid'+num+'" value="'+$(this).find('emdNo').text()+'">  ';
			htmlStr +='</tr> ';				
		});
		
		htmlStr += '	</tbody>';
		htmlStr += "</table>";
		htmlStr += '<div class="paginate" id="pageApi"></div>';
	}
	
	$(".popSearchNoResult").addClass("result");
	$(".popSearchNoResult").html(htmlStr);
	$(".result").show();
	$("#resultData").hide();
	$("#searchContentBox").css("height","");
	$("#searchContentBox").css("height","365px");
	pageMake(xmlStr);
	
}
function setParent(){
	var rtRoadAddr = $.trim($("#rtRoadAddr").val());
	var rtAddrPart1 = $.trim($("#rtAddrPart1").val());
	var rtAddrPart2 = $.trim($("#rtAddrPart2").val());
	var rtEngAddr = $.trim($("#rtEngAddr").val());
	var rtJibunAddr = $.trim($("#rtJibunAddr").val());
	var rtAddrDetail = $.trim($("#rtAddrDetail").val());
	var rtZipNo = $.trim($("#rtZipNo").val());
	var rtAdmCd = $.trim($("#rtAdmCd").val());
	var rtRnMgtSn = $.trim($("#rtRnMgtSn").val());
	var rtBdMgtSn = $.trim($("#rtBdMgtSn").val());
	var rtDetBdNmList = $.trim($("#rtDetBdNmList").val());
	var rtBdNm = $.trim($("#rtBdNm").val());
	var rtBdKdcd = $.trim($("#rtBdKdcd").val());
	var rtSiNm = $.trim($("#rtSiNm").val());
	var rtSggNm = $.trim($("#rtSggNm").val());
	var rtEmdNm = $.trim($("#rtEmdNm").val());
	var rtLiNm = $.trim($("#rtLiNm").val());
	var rtRn = $.trim($("#rtRn").val());
	var rtUdrtYn = $.trim($("#rtUdrtYn").val());
	var rtBuldMnnm = $.trim($("#rtBuldMnnm").val());
	var rtBuldSlno = $.trim($("#rtBuldSlno").val());
	var rtMtYn = $.trim($("#rtMtYn").val());
	var rtLnbrMnnm = $.trim($("#rtLnbrMnnm").val());
	var rtLnbrSlno = $.trim($("#rtLnbrSlno").val());
	var rtEmdNo = $.trim($("#rtEmdNo").val());
	
	var rtRoadFullAddr = rtAddrPart1;
	if(rtAddrDetail != "" && rtAddrDetail != null){
		rtRoadFullAddr += ", " + rtAddrDetail;
	}
	if(rtAddrPart2 != "" && rtAddrPart2 != null){
		rtRoadFullAddr += " " + rtAddrPart2;
	}
	
	// IE에서 opener관련 오류가 발생하는 경우, 부모창에서 지정한 이름으로 opener를 재정의
	if(opener == null || opener == undefined) opener = window.open("", "jusoPopup");
	
	opener.jusoCallBack(rtRoadFullAddr, rtAddrPart1, rtAddrDetail, rtAddrPart2, rtEngAddr, rtJibunAddr, rtZipNo, rtAdmCd, rtRnMgtSn, rtBdMgtSn, rtDetBdNmList, rtBdNm, rtBdKdcd, rtSiNm, rtSggNm, rtEmdNm, rtLiNm, rtRn, rtUdrtYn, rtBuldMnnm, rtBuldSlno, rtMtYn, rtLnbrMnnm, rtLnbrSlno, rtEmdNo);
	window.open("about:blank","_self").close();
	
}

function setMaping(idx){
	$("#searchContentBox").css("height","365px");  // 로고 위치 지정
	
	var roadAddr = $("#roadAddrDiv"+idx).text()
	var addrPart1 = $("#roadAddrPart1Div"+idx).text();
	var addrPart2 = $("#roadAddrPart2Div"+idx).text();
	var engAddr = $("#engAddrDiv"+idx).text();
	var jibunAddr = $("#jibunAddrDiv"+idx).text();
	var zipNo = $("#zipNoDiv"+idx).text();
	var admCd = $("#admCdHid"+idx).val();
	var rnMgtSn = $("#rnMgtSnHid"+idx).val();
	var bdMgtSn = $("#bdMgtSnHid"+idx).val();
	var detBdNmList = $("#detBdNmListHid"+idx).val();
	var bdNm = $("#bdNmHid"+idx).val();
	var bdKdcd = $("#bdKdcdHid"+idx).val();
	var siNm = $("#siNmHid"+idx).val();
	var sggNm = $("#sggNmHid"+idx).val();
	var emdNm = $("#emdNmHid"+idx).val();
	var liNm = $("#liNmHid"+idx).val();
	var rn = $("#rnHid"+idx).val();
	var udrtYn = $("#udrtYnHid"+idx).val();
	var buldMnnm = $("#buldMnnmHid"+idx).val();
	var buldSlno = $("#buldSlnoHid"+idx).val();
	var mtYn = $("#mtYnHid"+idx).val();
	var lnbrMnnm = $("#lnbrMnnmHid"+idx).val();
	var lnbrSlno = $("#lnbrSlnoHid"+idx).val();
	var emdNo = $("#emdNoHid"+idx).val();
	
	$("#rtRoadAddr").val(roadAddr);
	$("#rtAddrPart1").val(addrPart1);
	$("#rtAddrPart2").val(addrPart2);
	$("#rtEngAddr").val(engAddr);
	$("#rtJibunAddr").val(jibunAddr);
	$("#rtZipNo").val(zipNo);
	$("#rtAdmCd").val(admCd);
	$("#rtRnMgtSn").val(rnMgtSn);
	$("#rtBdMgtSn").val(bdMgtSn);
	$("#rtDetBdNmList").val(detBdNmList);
	$("#rtBdNm").val(bdNm);
	$("#rtBdKdcd").val(bdKdcd);
	$("#rtSiNm").val(siNm);
	$("#rtSggNm").val(sggNm);
	$("#rtEmdNm").val(emdNm);
	$("#rtLiNm").val(liNm);
	$("#rtRn").val(rn);
	$("#rtUdrtYn").val(udrtYn);
	$("#rtBuldMnnm").val(buldMnnm);
	$("#rtBuldSlno").val(buldSlno);
	$("#rtMtYn").val(mtYn);
	$("#rtLnbrMnnm").val(lnbrMnnm);
	$("#rtLnbrSlno").val(lnbrSlno);
	$("#rtEmdNo").val(emdNo);

	$(".result").hide();
	$("#resultData").show();
	
	$("#addrPart1").html(addrPart1);
	$("#addrPart2").html(addrPart2);
	$("#rtAddrDetail").focus();
}

function init(){
	var browerName = navigator.appName;
	var browerAgent = navigator.userAgent;
	self.resizeTo(570, 520);
	
}

$(document).ready(function(){
	placeHolder();
	$('#searchRdNm').bind('click', function(){
	    $('.popWrap3').css({'display':'block','top':'21px','right':'121px'});
    });
	$('#popupClose2').bind('click', function(){
    	$('.popWrap3').css('display','none');
    });
	
	$('.choIdx a').click(function(event){
		$('.choIdx a').removeClass('on');
		if($(this).hasClass('off')){
			return;
		}else{
			$(this).addClass('on');
			event.preventDefault();
			var target =this.hash;
			var $target=$(target);
			var top = $(target).position().top-106;
			if(prevPosition ==0){
				$('#roadNameList2').scrollTop(top);
				prevPosition = top;
			}else{
				$('#roadNameList2').scrollTop(prevPosition+top);
				prevPosition = prevPosition + top;
			}
			
			if($('#roadNameList2')[0].scrollHeight - $('#roadNameList2').scrollTop() == $('#roadNameList2').innerHeight()){
				prevPosition = $('#roadNameList2').scrollTop();
			}
		}
	});
	$('#roadNameList2').children().css('display','none');
	$('#roadNameList2').scroll(function(){prevPosition = this.scrollTop;});
});
window.onresize = placeHolderPoint;

function placeHolderPoint(){
	$(":input[placeholderTxt]").each(function(){
		var labelId = "label"+this.id;
		var objVal = $(this).val();
		var placeTxt = $(this).attr("placeholderTxt");
		var left = parseInt($(this).offset().left);
		var top = parseInt($(this).offset().top);
		
		$("#"+labelId).css({"left":left+"px","top":top+"px"});
	});
}

function placeHolder(){
	$(":input[placeholderTxt]").each(function(){
		var labelId = "label"+this.id;
		var objVal = $(this).val();
		var placeTxt = $(this).attr("placeholderTxt");
		var left = parseInt($(this).offset().left);
		var top = parseInt($(this).offset().top);
		$(this).after("<label for='"+this.id+"' id='"+labelId+"' style ='position:absolute;left:"+left+"px;top:"+top+"px; font-size:15px;color:#1898d2;font-weight:bold; padding-left:10px;padding-top:11px;'><b>"+placeTxt+"</b></label>");
		
		if(objVal !=""){
			$("#"+labelId).hide();
		}
		
		$(this).focus(function(){
			$("#"+labelId).hide();
		});
		
		$(this).blur(function(){ 
			if($(this).val() == ""){
				$("#"+labelId).show();
			}
		});
	});
}

function addrDetailChk(){
	var evtCode = (window.netscape) ? ev.which : event.keyCode;
	if(evtCode == 63 || evtCode == 35 || evtCode == 38 || evtCode == 43 || evtCode == 92 || evtCode == 34){ // # & + \ " 문자제한
		alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
		if(event.preventDefault){
			event.preventDefault();
		}else{
			event.returnValue=false;
		}
	}
}

function addrDetailChk1(obj){
	if(obj.value.length > 0){
		var expText = /^[^?#&+\"\\]+$/;
		if(expText.test(obj.value) != true){
			alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
			obj.value="";
		}
	}
}

function popClose(){
	window.close();
}

function addrJuminRenew(idx){
	$("#detDivX"+idx).show();
	$("#detListDivX"+idx).show();
	$("#detDiv"+idx).hide();
	
	var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
	if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
		docHeight += 60;
		$("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
	}else{
    	$("#searchContentBox").css("365px");// 로고 위치 지정
    }
}
function addrJuminRenewX(idx){
	$("#detDivX"+idx).hide();
	$("#detListDivX"+idx).hide();
	$("#detDiv"+idx).show();
	
	var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
	if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
		docHeight += 60;
		$("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
	}else{
    	$("#searchContentBox").css("365px");// 로고 위치 지정
    }
}

$(function(){
    var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
    
    if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
    	docHeight += 60;
    	$("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
    }else{
    	$("#searchContentBox").css("365px");// 로고 위치 지정
    }
    
    $("#keyword").focus();
    
    $("#keyword").on("keydown", function(event){
    		if (event.which == 13) {    
			event.keyCode = 0;  
			$("#currentPage").val(1);
			searchUrlJuso(); 
		}
    });
});

function trim(strSource) {
	return strSource.replace(/(^\s*)|(\s*$)/g, ""); 
}
</script>

<style>
 html { overflow-y:hidden; }
</style>

<body onload="init();" class ="visualSection"> 
	<form name="rtForm" id="rtForm" method="post">
		<input type="hidden" name="inputYn" id="inputYn" value="Y"/>  
		<input type="hidden" name="roadFullAddr" id="roadFullAddr"/>  
		<input type="hidden" name="roadAddrPart1" id="roadAddrPart1"/>
		<input type="hidden" name="roadAddrPart2" id="roadAddrPart2"/>
		<input type="hidden" name="engAddr" id="engAddr"/>            
		<input type="hidden" name="jibunAddr" id="jibunAddr"/>        
		<input type="hidden" name="zipNo" id="zipNo"/>                
		<input type="hidden" name="addrDetail" id="addrDetail"/>
		<input type="hidden" name="admCd" id="admCd" />
		<input type="hidden" name="rnMgtSn" id="rnMgtSn" />
		<input type="hidden" name="bdMgtSn" id="bdMgtSn" />
		
		<input type="hidden" name="detBdNmList" id="detBdNmList" /> 
		<input type="hidden" name="bdNm" id="bdNm" /> 
		<input type="hidden" name="bdKdcd" id="bdKdcd" /> 
		<input type="hidden" name="siNm" id="siNm" /> 
		<input type="hidden" name="sggNm" id="sggNm" /> 
		<input type="hidden" name="emdNm" id="emdNm" /> 
		<input type="hidden" name="liNm" id="liNm" /> 
		<input type="hidden" name="rn" id="rn" /> 
		<input type="hidden" name="udrtYn" id="udrtYn" /> 
		<input type="hidden" name="buldMnnm" id="buldMnnm" /> 
		<input type="hidden" name="buldSlno" id="buldSlno" /> 
		<input type="hidden" name="mtYn" id="mtYn" /> 
		<input type="hidden" name="lnbrMnnm" id="lnbrMnnm" /> 
		<input type="hidden" name="lnbrSlno" id="lnbrSlno" /> 
		<input type="hidden" name="emdNo" id="emdNo" /> 
	</form>

	<form name="AKCFrm" id="AKCFrm" method="post">
		<input type="hidden" name="iframe"  value=""   />
		<input type="hidden" name="confmKey" value="<%=confmKey %>" />
		<input type="hidden" name="encodingType"   value=""   />
		<input type="hidden" name="cssUrl" value="" />
		<input type="hidden" name="resultType" value="<%=resultType %>" />
		<input type="hidden" name="currentPage" id="currentPage" value="1" />
		<input type="hidden" name="countPerPage" value="5" />
		
		<input type="hidden" name="rtRoadAddr"  id="rtRoadAddr"  />
		<input type="hidden" name="rtAddrPart1" id="rtAddrPart1" />
		<input type="hidden" name="rtAddrPart2" id="rtAddrPart2" />
		<input type="hidden" name="rtEngAddr"   id="rtEngAddr"   />
		<input type="hidden" name="rtJibunAddr" id="rtJibunAddr" />
		<input type="hidden" name="rtZipNo" id="rtZipNo" />
		<input type="hidden" name="rtAdmCd" id="rtAdmCd" />
		<input type="hidden" name="rtRnMgtSn" id="rtRnMgtSn" />
		<input type="hidden" name="rtBdMgtSn" id="rtBdMgtSn" />
		
		<input type="hidden" name="rtDetBdNmList" id="rtDetBdNmList" />
		<input type="hidden" name="rtBdNm" id="rtBdNm" />
		<input type="hidden" name="rtBdKdcd" id="rtBdKdcd" />
		<input type="hidden" name="rtSiNm" id="rtSiNm" />
		<input type="hidden" name="rtSggNm" id="rtSggNm" />
		<input type="hidden" name="rtEmdNm" id="rtEmdNm" />
		<input type="hidden" name="rtLiNm" id="rtLiNm" />
		<input type="hidden" name="rtRn" id="rtRn" />
		<input type="hidden" name="rtUdrtYn" id="rtUdrtYn" />
		<input type="hidden" name="rtBuldMnnm" id="rtBuldMnnm" />
		<input type="hidden" name="rtBuldSlno" id="rtBuldSlno" />
		<input type="hidden" name="rtMtYn" id="rtMtYn" />
		<input type="hidden" name="rtLnbrMnnm" id="rtLnbrMnnm" />
		<input type="hidden" name="rtLnbrSlno" id="rtLnbrSlno" />
		<input type="hidden" name="rtEmdNo" id="rtEmdNo" />
		
		<input type="hidden" name ="searchType"    id="searchType" />
		<input type="hidden" name ="dsgubuntext"   id="dsgubuntext" />   
		<input type="hidden" name ="dscity1text"   id="dscity1text" />
		<input type="hidden" name ="dscounty1text" id="dscounty1text" />
		<input type="hidden" name ="dsemd1text"    id="dsemd1text" />
		<input type="hidden" name ="dsri1text"     id="dsri1text" />
		<input type="hidden" name ="dsrd_nm1text"  id="dsrd_nm1text" />
		<input type="hidden" name ="dssan1text"    id="dssan1text" />
	
		<div class="pop-address-search" style="width: 100%;" >
			<div class="pop-address-search-inner" style="border: 0px;">
			<div style="height: 365px;" id="searchContentBox">
				<fieldset>
					<legend>도로명주소 검색</legend>		
					<span class="wrap">
						<input type="text" class="popSearchInput" style="font-size: 13px; font-weight: bold; ime-mode:active;" title="검색어를 입력하세요" name="keyword" id="keyword" placeholder="도로명주소, 건물명 또는 지번입력" value=""  tabindex="1"/>
						<input type="button" title="검색"  tabindex="2" onclick="javascript:$('#currentPage').val(1);  searchUrlJuso();" style=" cursor: pointer;"/>
					</span>
					<a class="close" href="javascript:popClose();" title="창닫기" tabindex="3">닫기</a>
				</fieldset>
				<p class="guide" style="margin-top:3px;">검색어 예 : 도로명(반포대로 58), 건물명(독립기념관), 지번(삼성동 25)</p>
				
				
				<!-- nodata -->
	            <div class="popSearchNoResult" style="margin-top:10px; margin-bottom:5px;"></div>
                <!-- //nodata -->

				<!-- 상세주소 -->
				<div class="detail"  style="display:none;" id="resultData">
					<p><strong>상세주소 입력</strong></p>
					<table class="data-row">
						<caption>주소 입력</caption>
						<colgroup>
							<col style="width:20%"></col>
							<col></col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">도로명주소</th>
								<td id="addrPart1" style="font-size:15px; height:20px; line-height:20px;"></td>
							</tr>
							<tr>
								<th scope="row"><label for="inputPopAddress">상세주소입력</label></th>
								<td>
									<input type="text" name="rtAddrDetail" id="rtAddrDetail" style="width: 100%; font-size: 13px;" onkeypress="addrDetailChk();" onkeyup="addrDetailChk1(this);" title="상세주소"/>
									<div id="addrPart2" style="font-size: 13px; line-height: 2em;"></div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btns-submit">
						<a class="btn-bl" href="javascript:setParent();">주소입력</a>
					</div>
				</div>
			</div>
				<!-- //상세주소 입력 -->
			<div class="logo" style="display: block;" >&nbsp;</div>
			</div>
		</div>
		</form>
</body>
</html>