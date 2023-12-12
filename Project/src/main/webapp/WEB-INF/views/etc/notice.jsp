<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script>
	function validAdmin() {	
		$.ajax({
			url : '/etc/isAdmin',
			type : 'GET',
			async : false,
			success : function(data) {
				progress(data);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	function progress(data) {
		if("NoLogin" == data){
			$("#rejectModal").show();
		} else {
			window.location.href = "/etc/writeNotice";
		}
	}
	function hideModal() {
		$("#rejectModal").hide();
	}
</script> 
<style>
#writeBtn{
	width: 100px;
	height: 50px;
	position: absolute;
	border: none;
	color: white;
}
.table-responsive{
	width: 80%;
	height : 1100px;
	margin: auto;
}
</style>
  </head>
  <jsp:include page="../header.jsp"></jsp:include>

  <body>
    <!-- tap on top start -->
    <div class="tap-top">
      <span class="lnr lnr-chevron-up"></span>
    </div>
    <!-- tap on tap end -->

    <!-- page-wrapper Start -->
    <div class="page-wrapper compact-wrapper" id="pageWrapper">
      <!-- Page Body Start -->
      <div >
        <!-- Container-fluid starts-->
        <div class="page-body">
          <div class="container-fluid">
            <div class="row">
              <div class="col-sm-12">
                <div class="card card-table">
                  <!-- Table Start -->
                  <div class="card-body">
                    <div class="title-header option-title">
                      <h5>공지 사항</h5>
                      <form class="d-inline-flex">
                        <a href="create-role.html" class="align-items-center btn btn-theme d-flex" >
                          <i data-feather="plus"></i>Add Role
                        </a>
                      </form>
                    </div>
                    <div>
                      <div class="table-responsive">
                        <table id="table_id" class="table role-table all-package theme-table" >
                          <thead>
                            <tr>
                              <th>이벤트/공지사항</th>
                              <th>제목</th>
                              <th>작성일</th>
                              <th>수정 및 삭제</th>
                            </tr>
                          </thead>
                          
                          <c:forEach items="${list }" var="board" >
                          <tbody>
                            <tr>
                            <c:choose>
	                            <c:when test="${board.categoryId == 3 }">
        	                      <td>공지사항</td>
    	                        </c:when>
    	                        <c:otherwise>
    	                        	<td>이벤트</td>
    	                        </c:otherwise>
                            </c:choose>
                            
                              <td><a href="/etc/readNotice?no=${board.postNo }">${board.title }</a></td>
                              <td>${board.createdDate }</td>
                           
                              <td>
                                <ul>
                                  <li>
                                    <a href="javascript:void(0)">
                                      <i class="ri-pencil-line"></i>
                                    </a>
                                  </li>

                                  <li>
                                    <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#exampleModalToggle" >
                                      <i class="ri-delete-bin-line"></i>
                                    </a>
                                  </li>
                                </ul>
                              </td>
                            </tr>
                          </tbody>
                          </c:forEach>
                        </table>
                  		<button onclick="validAdmin();" id="writeBtn" type="button" class="btn btn-primary">글 작성</button>
                      </div>
                    </div>
                  </div>
                  <!-- Table End -->
                </div>
              </div>
            </div>
          </div>
          <!-- Container-fluid Ends-->

        </div>
      </div>
      <!-- Page Body End -->
      
      <!-- Modal Start -->
      <div
        class="modal fade"
        id="staticBackdrop"
        data-bs-backdrop="static"
        data-bs-keyboard="false"
        tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-body">
              <h5 class="modal-title" id="staticBackdropLabel">Logging Out</h5>
              <p>Are you sure you want to log out?</p>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
              <div class="button-box">
                <button
                  type="button"
                  class="btn btn--no"
                  data-bs-dismiss="modal"
                >
                  No
                </button>
                <button type="button" class="btn btn--yes btn-primary">
                  Yes
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Modal End -->
    </div>
    <!-- page-wrapper End-->

    <!-- Delete Modal Box Start -->
    <div
      class="modal fade theme-modal remove-coupon"
      id="exampleModalToggle"
      aria-hidden="true"
      tabindex="-1"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header d-block text-center">
            <h5 class="modal-title w-100" id="exampleModalLabel22">
              Are You Sure ?
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            >
              <i class="fas fa-times"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="remove-box">
              <p>
                The permission for the use/group, preview is inherited from the
                object, object will create a new permission for this object
              </p>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-animation btn-md fw-bold"
              data-bs-dismiss="modal"
            >
              No
            </button>
            <button
              type="button"
              class="btn btn-animation btn-md fw-bold"
              data-bs-target="#exampleModalToggle2"
              data-bs-toggle="modal"
              data-bs-dismiss="modal"
            >
              Yes
            </button>
          </div>
        </div>
      </div>
    </div>

    <div
      class="modal fade theme-modal remove-coupon"
      id="exampleModalToggle2"
      aria-hidden="true"
      tabindex="-1"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title text-center" id="exampleModalLabel12">
              Done!
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            >
              <i class="fas fa-times"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="remove-box text-center">
              <div class="wrapper">
                <svg
                  class="checkmark"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 52 52"
                >
                  <circle
                    class="checkmark__circle"
                    cx="26"
                    cy="26"
                    r="25"
                    fill="none"
                  />
                  <path
                    class="checkmark__check"
                    fill="none"
                    d="M14.1 27.2l7.1 7.2 16.7-16.8"
                  />
                </svg>
              </div>
              <h4 class="text-content">It's Removed.</h4>
            </div>
          </div>
          <div class="modal-footer">
            <button
              class="btn btn-primary"
              data-bs-toggle="modal"
              data-bs-dismiss="modal"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- Delete Modal Box End -->

	<!-- The Modal -->
	<div class="modal" id="rejectModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">관리자만 작성할 수 있습니다.</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="hideModal();"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        권한이 없습니다.
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="hideModal();" style="color:white;">Close</button>
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
