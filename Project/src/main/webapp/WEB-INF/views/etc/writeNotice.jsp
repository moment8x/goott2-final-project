<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <!-- meta data -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fastkart - Add New Product</title>
    <!-- Google font -->
    <link
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">

	 <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.css" rel="stylesheet">
    <!-- Plugins css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/animate.css">
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/chartist.css">
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/date-picker.css">

    <!-- Bootstrap css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/bootstrap.css">

    <!-- Bootstrap-tag input css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/vendors/bootstrap-tagsinput.css">

    <!-- App css -->
    <link rel="stylesheet" type="text/css" href="/resources/boardAssets/css/style.css">
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
</head>
<script>
let tempUploadFile = [];
$(function() {
	$('#summernote').summernote({
		height: 700, 
		 minHeight: null,           
		 maxHeight: null,            
		 focus: true,                  
		 lang: "ko-KR",
		 callbacks: {
			 onImageUpload : function(files){
				 for (let i = 0; i< files.length; i++){					 
				 	if(!isDuplicateImage(files[i])){
				 		uploadImage(files[i]);
				 	}
				 }
			 }
		 }
	});
	checkState();
});
function checkState() {
	let state = "${state}";
	let error = "${error}";
	if(state == "fail"){
		$("#failModal").show();
		$("#errorDiv").html(error);
	}
}
function modalClose() {
	$("#failModal").hide();
}
function isDuplicateImage(file) {
	return tempUploadFile.includes(file.name);
}

function uploadImage(file) {
	   var formData = new FormData();
	    formData.append('image', file);
	    
	 $.ajax({
         url: '/etc/uploadImage', 
         method: 'POST',
         data: formData,
         async:false,
         processData: false,
         contentType: false,
         dataType : 'json',
         success: function(data) {
        	 tempUploadFile.push(data.originalFileName);
        	 console.log(data);
        	 let thumb = "<img src='/resources/productImages/" + data.newFileName + "' />"
            //$('#summernote').summernote('insertImage', thumb);
        	 $('#summernote').summernote('focus');
             document.execCommand('insertHTML', false, thumb);
         },
         error: function(error) {
             console.error('Image upload failed:', error);
         }
     });
}
</script>
<style>
#subBtn{
	background-color : #663355;
	border : none;
	width: 80px;
	height: 50px;
	color: white;
	font-size: large;
	font-weight: bold;
	float: right;
}
</style>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

    <!-- tap on top start -->
    <div class="tap-top">
        <span class="lnr lnr-chevron-up"></span>
    </div>
    <!-- tap on tap end -->

    <!-- page-wrapper start -->
    <div class="page-wrapper compact-wrapper" id="pageWrapper">
        <!-- Page Body start -->
        <div class="page-body-wrapper">

            <div class="page-body">

                <!-- New Product Add Start -->
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-sm-8 m-auto">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="card-header-2">
                                                <h5>공지사항/이벤트 글 작성</h5>
                                            </div>
                                            
                                            <c:choose>
                                            <c:when test="${board == 'noBoard' }">
                                            <form class="theme-form theme-form-2 mega-form" method="post" action="/etc/saveNotice">
                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-3 mb-0">제목</label>
                                                    <div class="col-sm-9">
                                                        <input class="form-control" type="text"
                                                            placeholder="Product Name" name="subj">
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="col-sm-3 col-form-label form-label-title">게시 글 타입</label>
                                                    <div class="col-sm-9">
                                                        <select class="js-example-basic-single w-100" name="state">
                                                            <option disabled>Static Menu</option>
                                                            <option>공지사항</option>
                                                            <option>이벤트</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="mb-4 row align-items-center">
                                                    <label class="col-sm-3 col-form-label form-label-title">내용</label>
                                                    	<textarea id="summernote" name="editordata"></textarea>		
                                                   </div>
                                                   <button id="subBtn" type="submit">저장</button>
                                            </form>
                                            </c:when>
                                            <c:when test="${board != 'noBoard'}">
                                              <form class="theme-form theme-form-2 mega-form" method="post" action="/etc/modifyNotice">
                                              	<input type="hidden" value="${board.postNo }" name="postNo"/>
                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-3 mb-0">제목</label>
                                                    <div class="col-sm-9">
                                                        <input class="form-control" type="text"
                                                            placeholder="Product Name" name="subj" value="${board.title }" readonly="readonly">
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="col-sm-3 col-form-label form-label-title">게시 글 타입</label>
                                                    <div class="col-sm-9">
                                                        <select class="js-example-basic-single w-100" name="state">
                                                            <option disabled>Static Menu</option>
                                                            <c:choose>
                                                            <c:when test="${board.categoryId == 3}">
	                                                            <option selected="selected">공지사항</option>
    	                                                        <option>이벤트</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                               <option>공지사항</option>
    	                                                       <option selected="selected">이벤트</option>
                                                            </c:otherwise>
                                                            </c:choose>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="mb-4 row align-items-center">
                                                    <label class="col-sm-3 col-form-label form-label-title">내용</label>
                                                    	<textarea id="summernote" name="editordata">${board.content }</textarea>		
                                                   </div>
                                                   <button id="subBtn" type="submit">저장</button>
                                            </form>
                                            </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- New Product Add End -->
            </div>
            <!-- Container-fluid End -->
        </div>
        <!-- Page Body End -->
    </div>
    <!-- page-wrapper End -->
    <!-- Modal Start -->
    <div class="modal" id="failModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog  modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <p>글 작성에 실패하셨습니다.</p>
                    <div id="errorDiv"></div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="modalClose();"></button>

                    <div class="button-box">
                        <button type="button" class="btn btn--no" data-bs-dismiss="modal" onclick="modalClose();">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal End -->

    <!-- latest js -->
    <script src="/resources/boardAssets/js/jquery-3.6.0.min.js"></script>

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

    <!-- bootstrap tag-input js -->
    <script src="/resources/boardAssets/js/bootstrap-tagsinput.min.js"></script>
    <script src="/resources/boardAssets/js/sidebar-menu.js"></script>

    <!-- customizer js -->
    <script src="/resources/boardAssets/js/customizer.js"></script>


    <!-- Plugins js -->
    <script src="/resources/boardAssets/js/notify/bootstrap-notify.min.js"></script>
    <script src="/resources/boardAssets/js/notify/index.js"></script>


    <!-- sidebar effect -->
    <script src="/resources/boardAssets/js/sidebareffect.js"></script>

    <!-- Theme js -->
    <script src="/resources/boardAssets/js/script.js"></script>
    
    
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>