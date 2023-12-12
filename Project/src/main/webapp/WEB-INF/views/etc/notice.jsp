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
	function modalInfo(no){
		$(".deleteNotice").attr("id",no);
	}
	function deleteNotice(tag) {
		$.ajax({
			url : '/etc/deleteNotice',
			type : 'POST',
			data : {"postNo" : tag.id},
			async : false,
			success : function(data) {
				process(data);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	function process(data) {
		$("#deleteModal").hide();
		if(data == "success"){
			window.location.href="/etc/notice";
		}

	}
	function beforePaging() {
		if(page > 10){
		page = (Math.floor(page / 10)-1)* 10 + 1;
		getProduct(checkedList ,checkedLang, sort, page);
		 $(".page-"+page).addClass("clicked");
		} else {
			return false;
		}
	}
	function afterPaging() {
		if(Math.ceil(page / 10) < (totalPagingBlockCnt/10)){
		page = Math.floor((page - 1) / 10) * 10 + 11;
		getProduct(checkedList ,checkedLang, sort, page);
		 $(".page-"+page).addClass("clicked");
		} else {
			return false;
		}
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
                              <c:if test="${isAdmin == 'admin' }">
                              	<th>수정 및 삭제</th>
                              </c:if>
                            </tr>
                          </thead>
                          
                          <c:forEach items="${boardMap.boardList }" var="board" >
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
                           
                           	<c:if test="${isAdmin == 'admin' }">
                              <td>
                                <ul>
                                  <li>
                                    <a href="/etc/writeNotice?postNo=${board.postNo }">
                                      <i class="ri-pencil-line"></i>
                                    </a>
                                  </li>

                                  <li>
                                    <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="modalInfo(${board.postNo});">
                                      <i class="ri-delete-bin-line"></i>
                                    </a>
                                  </li>
                                </ul>
                              </td>
                              </c:if>
                            </tr>
                          </tbody>
                          </c:forEach>
                        </table>
                        <div>
                        <c:if test="${isAdmin == 'admin' }">
                  			<button onclick="validAdmin();" id="writeBtn" type="button" class="btn btn-primary">글 작성</button>
                  		</c:if>
                  		<nav class="custome-pagination">
						<ul class="pagination justify-content-center">
							<li class="page-item">
							<c:if test="${boardMap.pagingInfo.pageNo > 10 }">
								<a class="page-link" href="/list/categoryList/${key }?page=${boardMap.pagingInfo.startNumOfCurrentPagingBlock - 10}" >
									<i class="fa-solid fa-angles-left"></i>
								</a>
							</c:if>
							</li>
							<c:choose>
								<c:when
									test="${boardMap.pagingInfo.totalPagingBlockCnt > boardMap.pagingInfo.endNumOfCurrentPagingBlock }">
									<c:forEach var="i"
										begin="${boardMap.pagingInfo.startNumOfCurrentPagingBlock}"
										end="${boardMap.pagingInfo.endNumOfCurrentPagingBlock }" step="1">
										<li class="page-item active"><a class="page-link link${i}"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i"
										begin="${boardMap.pagingInfo.startNumOfCurrentPagingBlock}"
										end="${boardMap.pagingInfo.totalPagingBlockCnt }" step="1">
										<li class="page-item active"><a class="page-link"
											href="/list/categoryList/${key }?page=${i}">${i}</a></li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<li class="page-item">
								<c:if test="${boardMap.pagingInfo.totalPageCnt > boardMap.pagingInfo.endNumOfCurrentPagingBlock}">
								<a class="page-link" href="/list/categoryList/${key }?page=${boardMap.pagingInfo.startNumOfCurrentPagingBlock + 10}">
								<i class="fa-solid fa-angles-right"></i>
								</a>
							</c:if>
							</li>
						</ul>
					</nav>
                        </div>
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

    <!-- Delete Modal Box Start -->
    <div
      class="modal fade theme-modal remove-coupon"
      id="deleteModal"
      aria-hidden="true"
      tabindex="-1"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header d-block text-center">
            <h5 class="modal-title w-100" id="exampleModalLabel22">
              삭제하시겠습니까?
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
                삭제하실 경우 영구히 제거됩니다.
              </p>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-animation btn-md fw-bold"
              data-bs-dismiss="modal"
            >
              취소
            </button>
            <button
              type="button"
              class="btn btn-animation btn-md fw-bold deleteNotice" 
              onclick="deleteNotice(this);"
            >
              삭제
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
