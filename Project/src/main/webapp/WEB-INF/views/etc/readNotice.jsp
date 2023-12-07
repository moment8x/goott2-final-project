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
<script>
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
		let error = "${error}"
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
	border-bottom: solid 1px rgba(0, 0, 0, 0.2);
	padding-bottom: 50px;
	margin-bottom: 50px;
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
		<div id="btns">
			<div id="listUp">
				<a href="/etc/notice">
				<button class="listUpBtn">목록으로 가기</button>
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
