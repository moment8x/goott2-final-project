<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta
      name="description"
      content="Fastkart admin is super flexible, powerful, clean &amp; modern responsive bootstrap 5 admin template with unlimited possibilities."
    />
    <meta
      name="keywords"
      content="admin template, Fastkart admin template, dashboard template, flat admin template, responsive admin template, web app"
    />
    <meta name="author" content="pixelstrap" />
    <link rel="icon" href="/resources/boardAssets/images/favicon.png" type="image/x-icon" />
    <link
      rel="shortcut icon"
      href="/resources/boardAssets/images/favicon.png"
      type="image/x-icon"
    />
    <title>Fastkart - Currency Rate</title>

    <!-- Google font-->
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
      rel="stylesheet"
    />

    <!-- Fontawesome css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/font-awesome.css"
    />

    <!-- Linear Icon css -->
    <link rel="stylesheet" href="/resources/boardAssets/css/linearicon.css" />

    <!-- remixicon css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/remixicon.css" />

    <!-- Data Table css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/datatables.css" />

    <!-- Themify icon css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/themify.css"
    />

    <!-- Feather icon css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/feather-icon.css"
    />

    <!-- Plugins css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/scrollbar.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/animate.css"
    />

    <!-- Bootstrap css -->
    <link
      rel="stylesheet"
      type="text/css"
      href="/resources/boardAssets/css/vendors/bootstrap.css"
    />

    <!-- App css -->
   <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/style.css" />
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	    <!-- latest js -->
    <script src="/resources/boardAssets/js/jquery-3.6.0.min.js"></script>
<script>
let fileList = [];
$(function() {
	$("#fileUpload").on("change", function() {
		console.log(this.files.length);
		if(this.files.length <= 3){
			if((fileList.length + this.files.length) <= 3 ){
			for(let i = 0; i < this.files.length; i++){		        	
			let image = new FormData();
			image.append('replyImages', this.files[i]);
			console.log("FormData contents:", this.files[i]);
				$.ajax({
					url: '/etc/replyUploadImage',
					type: 'POST',
					data: image,
					contentType: false,
					processData: false,
					success: function (data) {
						console.log('파일 업로드가 성공적으로 완료되었습니다.');
		                fileList.push(data);
		                console.log(fileList);
		                showFileList();
		            },
		            error: function (error) {
		            	console.log('파일 업로드 중 오류가 발생했습니다.');
		            }
		        });
			}
			} else {
				window.alert("파일은 최대 3개까지만 올리실 수 있습니다.");
			}
	    } else {
	    	window.alert("파일은 3개까지만 올리실 수 있습니다.");
	  	}
	});
	
	$("#myModal").on("dragover", function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	});

	$("#myModal").on("dragenter", function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	});
	
	$("#inputImages, #myModal").on("drop", function(e) {
		e.preventDefault(); 
		e.stopPropagation();
		
		let files = e.originalEvent.dataTransfer.files;
		if(files.length <= 3){
			if((fileList.length + files.length) <= 3 ){
			for(let i = 0; i < files.length; i++){		        	
			let image = new FormData();
			image.append('replyImages', files[i]);
				$.ajax({
					url: '/etc/replyUploadImage',
					type: 'POST',
					data: image,
					contentType: false,
					processData: false,
					success: function (data) {
						console.log('파일 업로드가 성공적으로 완료되었습니다.');
		                fileList.push(data);
		                console.log(fileList);
		                showFileList();
		            },
		            error: function (error) {
		            	console.log('파일 업로드 중 오류가 발생했습니다.');
		            }
		        });
			}
			} else {
				window.alert("파일은 최대 3개까지만 올리실 수 있습니다.");
			}
	    } else {
	    	window.alert("파일은 3개까지만 올리실 수 있습니다.");
	  	}
	});
	
	$("#replyBtn").on("click", function() {
		 $.ajax({
			 url: '/etc/isLogin',
			 type: 'POST',
			 dataType:'text',
			 success: function (data) {
				 if(data == "noLogin"){
					 $("#noLoginModal").show();
				 } else if(data =="login") {
					 $("#myModal").show();
				 }
			 },
			 error: function (error) {
			 }
		});
	});
});

function showFileList() {
	$("#fileListDiv").empty();
	 for (let file of fileList) {
	        let imageSrc = "/resources/productImages" + file.thumbnailFileName;

	        let imageElement = $("<img>").attr("src", imageSrc);

	        $("#fileListDiv").append(imageElement);
	    }
}

function movementNotice(state) {
	 $.ajax({
         url: '/etc/moveNotice', 
         method: 'POST',
         data: {"state" : state,
        	 	"no" : "${board.postNo}"},
         async:false,
         success: function(data) {
        	 console.log(data);
        	 procrssMovement(data);
         },
         error: function(error) {
             console.error('Image upload failed:', error);
         }
     });
}
function procrssMovement(no) {
	if(no != 0 && no != -1){			
	window.location.href="/etc/readNotice?no="+ no;
	} else {
		checkState(no);
	}
}

function checkState(no) {
	let error = "${error}";
	$("#failModal").show();
	$("#errorDiv").html(error);
	if(no == 0){			
		$("#errorMsg").html("이전 페이지가 존재하지 않습니다.")
	} else if(no == -1) {
		$("#errorMsg").html("다음 페이지가 존재하지 않습니다.")
	}
}
function modalClose() {
	$("#failModal").hide();
}
function uploadFiles(tag) {
	console.log(tag.files);
} 
function submitForm() {
	 let replyText = document.getElementById('replyText').value;
	 let queryString = window.location.search;
	 let params = new URLSearchParams(queryString);
	 let parentNo = 0;
	 params.forEach(function(value, key) {
		 if(key == "no"){			 
		 	parentNo = value;
		 }
	});
	
	 $.ajax({
		 url: '/etc/inputNoticeReply',
		 type: 'POST',
		 data: JSON.stringify({
		     parentNo: parentNo,
		     replyText: replyText,
		     replyUpload: fileList
		 }),
		 contentType: 'application/json',
		 success: function (data) {
		 location.reload(true);
		 },
		 error: function (error) {
		 }
	});
}

function modalHide() {
	$("#myModal").hide();
	$("#replyText").val("");
	$("#fileUpload").empty();
	$("#fileListDiv").empty();
}
function loginModalClose() {
	 $("#noLoginModal").hide();
}
</script> 
<style>
#title{
	height : 100px;
	border-bottom: solid 1px rgba(0, 0, 0, 0.2);
}

#content {
	width: 100%;
	height: 150%;
	min-height : 400px;
	padding-bottom: 50px;
	margin-bottom: 50px;
	padding-top: 20px;
}
#listUp {
	padding-bottom: 30px;
}
.listUpBtn {
	background-color: #0da487;
	border: 1px solid #9EC8B9;
	border-radius : 15px;
	width: 100x;
	height: 50px;
	font-weight: bold;
	color: white;
}
#btns {
	display: flex;
	justify-content: space-between;
}
#reply{
	border-bottom: 1px solid rgba(0, 0, 0, 0.2);
	height: 300px;
	margin-bottom: 15px;
}
#replySubj{
	border-bottom: 1px solid rgba(0,0,0,0.4);
	display: flex;
	justify-content: space-between;
	align-items: center;
}
#replyBtn{
	background-color: #0da487;
	border: 1px solid #9EC8B9;
	border-radius : 15px;
	width: 100x;
	height: 50px;
	font-weight: bold;
	color: white;
	margin-bottom: 15px;
}
.modal-body{
	text-align: left; margin-left: 75px; margin-bottom: 10px;
}
#upload img{
	width: 60px;
	height: 60xp;
}
#fileUpload {
    opacity: 0;
    position: absolute;
    z-index: -1;
}
#inputImages{
	cursor: pointer;
}
textarea {
	width: 100%; 
	box-sizing: border-box; 
	max-width: 100%; 
	resize: vertical; 
}
#replies{
	margin: 10px 0;
}
#replyHeader{
	display: flex;
	justify-content: space-between;
	margin-top: 5px;
}
#replyImages {
	margin: 10px 0;
}
#reply{
	height : 100%;
	border-bottom: 1px solid rgba(0,0,0,0.3);
	margin: 10px 0;
}
</style>
</head>
<body>
  <jsp:include page="../header.jsp"></jsp:include>
  
  	<div class="container mt-3" id="title">
  		<h2>${board.title }</h2>
  		<br />
  		<c:choose>
  		<c:when test="${board.categoryId == 3}">
	  		<h3>공지사항</h3>
  		</c:when>
  		<c:when test="${board.categoryId == 4 }">
  			<h5>이벤트</h5>
  		</c:when>
  		</c:choose>
  	</div>
	
	<div class="container mt-3" >
		<div id="content">
	       ${board.content }
		</div>
		<div id="replies">
			<div id="replySubj">
				<h2>댓글 (${replyMap.pagingInfo.totalProducts })</h2>
				<button id="replyBtn" >댓글 작성</button>
			</div>
			<c:forEach items="${replyMap.replyList}" var="reply">
				<div id="reply">
				<div id="replyHeader">
					<div><h4>${reply.author }</h4></div>
					<div>${reply.createdDate }</div>
				</div>
				<div>
				<div id="replyImages">
					<c:forEach items="${reply.thumbnailFileName }" var="thumbnailFileName">
						<img alt="thumbnailFileName" src="/resources/productImages${thumbnailFileName}">		
					</c:forEach>
				</div>
					<div>${reply.content }</div>
				</div>
				</div>
			</c:forEach>
		</div>
		<div id="btns">
			<div id="listUp">
				<a href="/etc/notice">
				<button class="listUpBtn" >목록으로 가기</button>
				</a>
			</div>
			<div id="nextAndPerv">
				<button class="listUpBtn" onclick="movementNotice('prev');">
					이전글
				</button>
				<button class="listUpBtn" onclick="movementNotice('next');">
					다음글
				</button>
			</div>
		</div>
	</div>
	
	<div class="modal" id="failModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog  modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <p id="errorMsg"></p>
                    <div id="errorDiv"></div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="modalClose();"></button>

                    <div class="button-box">
                        <button type="button" class="btn btn--no" data-bs-dismiss="modal" onclick="modalClose();">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	
	<!-- The Modal -->
	<div class="modal" id="myModal">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글을 남겨보세요!</h4>
	        <button type="button" class="btn-close" onclick="modalHide();"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        <div><h3>댓글작성</h3></div>
	        	<textarea rows="10" cols="90" name="replyText" id="replyText"></textarea>
	        	<div><h3>파일 업로드</h3></div>
	        	<div id="upload">
	        		<input type="file" id="fileUpload" multiple="multiple" name="replyImages"/>
	        		<label for="fileUpload" id="inputImages"><img src="/resources/assets/images/add.png" />파일을 선택하시거나 드래그 해 주세요</label>
	        		<div id="fileListDiv"></div>
	        	</div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" onclick="modalHide();">취소</button>
	        <button type="button" class="btn btn-danger" onclick="submitForm();">등록</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
 	<div class="modal" id="noLoginModal" >
        <div class="modal-dialog  modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                   
                	<div style="margin: 30px 0;"><h3>로그인 후 작성하실 수 있습니다.</h3></div>

                    <div class="button-box">
                        <button type="button" class="btn btn--no" data-bs-dismiss="modal" onclick="loginModalClose();">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Bootstrap js -->
    <script src="/resources/boardAssets/js/bootstrap/bootstrap.bundle.min.js"></script>

    <!-- feather icon js -->
    <script src="/resources/boardAssets/js/icons/feather-icon/feather.min.js"></script>
    <script src="/resources/boardAssets/js/icons/feather-icon/feather-icon.js"></script>

    <!-- scrollbar simplebar js -->
    <script src="/resources/boardAssets/js/scrollbar/simplebar.js"></script>
    <script src="/resources/boardAssets/js/scrollbar/custom.js"></script>


    <!-- Sidebar js -->
    <script src="/resources/boardAssets/js/config.js"></script>

    <!-- Plugins js -->
    <script src="/resources/boardAssets/js/sidebar-menu.js"></script>
    <script src="/resources/boardAssets/js/notify/bootstrap-notify.min.js"></script>
    <script src="/resources/boardAssets/js/notify/index.js"></script>

    <!-- Data table js -->
    <script src="/resources/boardAssets/js/jquery.dataTables.js"></script>
    <script src="/resources/boardAssets/js/custom-data-table.js"></script>

    <!-- all checkbox select js -->
    <script src="/resources/boardAssets/js/checkbox-all-check.js"></script>

    <!-- sidebar effect -->
    <script src="/resources/boardAssets/js/sidebareffect.js"></script>

    <!-- Theme js -->
    <script src="/resources/boardAssets/js/script.js"></script>
    
    <jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>
