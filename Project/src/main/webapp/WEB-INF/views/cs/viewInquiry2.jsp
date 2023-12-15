<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Fastkart admin is super flexible, powerful, clean &amp; modern responsive bootstrap 5 admin template with unlimited possibilities.">
<meta name="keywords"
	content="admin template, Fastkart admin template, dashboard template, flat admin template, responsive admin template, web app">
<meta name="author" content="pixelstrap">
<link rel="icon" href="/resources/boardAssets/images/favicon.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="/resources/boardAssets/images/favicon.png" type="image/x-icon">
<title>Fastkart - All Category</title>
<!-- Google font-->
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">

<!-- Fontawesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/font-awesome.css">

<!-- Linear Icon css -->
<link rel="stylesheet" href="/resources/boardAssets/css/linearicon.css">

<!-- remixicon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/remixicon.css">

<!-- Data Table css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/datatables.css">

<!-- Themify icon css-->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/themify.css">

<!-- Feather icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/feather-icon.css">

<!-- Plugins css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/scrollbar.css">
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/animate.css">

<!-- Bootstrap css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/bootstrap.css">

<!-- App css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/style.css">
<style>
.pagination2 {
	display: flex;
	margin-left: auto;
}

.pagination2 button {
	
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
</head>

<body>
	<!-- tap on top start -->
	<div class="tap-top">
		<span class="lnr lnr-chevron-up"></span>
	</div>
	<!-- tap on tap end -->






	<!-- All User Table Start -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<div class="card card-table">
					<div class="card-body">
						<div class="title-header option-title">
							<h5>나의 문의 내역</h5>
							<form class="d-inline-flex">
								<a href="add-new-category.html"
									class="align-items-center btn btn-theme d-flex"> <i
									data-feather="plus-square"></i>Add New
								</a>
							</form>
						</div>

						<div class="table-responsive category-table">
							<table class="table all-package theme-table" id="table_id">
								<thead>
									<tr>
										<th>제목</th>
										<th>상태</th>
										<th>삭제</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="inquiry" items="${requestScope.myInquiries }">
										<tr>
											<td onclick="detailInquiry('${inquiry.postNo}');"><c:if test="${inquiry.step == 1 }"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ↳ </c:if>${inquiry.title }</td>
											<c:choose>
												<c:when test="${inquiry.answerStatus == 'y'}">
													<td onclick="detailInquiry('${inquiry.postNo}');">답변완료</td>
													<td>
														<ul>
															<li><a href="javascript:void(0)"
																data-bs-toggle="modal"
																data-bs-target="#exampleModalToggle"> <i
																	class="ri-delete-bin-line"
																	onclick="alert('답변완료 된 건은 삭제 불가합니다.')"></i>
															</a></li>
														</ul>
													</td>
												</c:when>
												<c:otherwise>
													<td onclick="detailInquiry('${inquiry.postNo}');">문의접수</td>
													<td>
														<ul>
															<li><a href="javascript:void(0)"
																data-bs-toggle="modal"
																data-bs-target="#exampleModalToggle"> <i
																	class="ri-delete-bin-line"
																	onclick="location.href='/cs/delete?postNo=${inquiry.postNo}'"></i>
															</a></li>
														</ul>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
									<c:forEach items="${requestScope.adminAnswer }" var="answer">
									<c:if test=""></c:if>
									</c:forEach>

									<!--  <tr>
                                                    <td>Size</td>

                                                    <td>S, M, L, XL</td>

                                                    <td>
                                                        <ul>
                                                            <li>
                                                                <a href="javascript:void(0)">
                                                                    <i class="ri-pencil-line"></i>
                                                                </a>
                                                            </li>

                                                            <li>
                                                                <a href="javascript:void(0)" data-bs-toggle="modal"
                                                                    data-bs-target="#exampleModalToggle">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Material</td>

                                                    <td>Cotton, Polyster</td>

                                                    <td>
                                                        <ul>
                                                            <li>
                                                                <a href="javascript:void(0)">
                                                                    <i class="ri-pencil-line"></i>
                                                                </a>
                                                            </li>

                                                            <li>
                                                                <a href="javascript:void(0)" data-bs-toggle="modal"
                                                                    data-bs-target="#exampleModalToggle">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Style</td>

                                                    <td>classic, mordern, ethnic, western</td>

                                                    <td>
                                                        <ul>
                                                            <li>
                                                                <a href="javascript:void(0)">
                                                                    <i class="ri-pencil-line"></i>
                                                                </a>
                                                            </li>

                                                            <li>
                                                                <a href="javascript:void(0)" data-bs-toggle="modal"
                                                                    data-bs-target="#exampleModalToggle">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Meat Type</td>

                                                    <td>Fresh, Frozen, Marinated</td>

                                                    <td>
                                                        <ul>
                                                            <li>
                                                                <a href="javascript:void(0)">
                                                                    <i class="ri-pencil-line"></i>
                                                                </a>
                                                            </li>

                                                            <li>
                                                                <a href="javascript:void(0)" data-bs-toggle="modal"
                                                                    data-bs-target="#exampleModalToggle">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr> -->
								</tbody>
							</table>
						</div>
					</div>
					<!-- 요기  -->
					<div class="pagination2">

						<ul class="pagination">
							<c:if test="${param.pageNo > 1 }">
								<li class="page-item"><a class="page-link"
									href="/cs/viewInquiry?pageNo=${param.pageNo - 1 }&viewPostCntPerPage=${param.viewPostCntPerPage}">Previous</a></li>
							</c:if>
							<c:forEach var="i"
								begin="${requestScope.pagingInfo.startNumOfCurrentPagingBlock }"
								end="${requestScope.pagingInfo.endNumOfCurrentPagingBlock }"
								step="1">

								<li class="page-item"><a class="page-link"
									href="/cs/viewInquiry?pageNo=${i }&viewPostCntPerPage=${param.viewPostCntPerPage}">${i }</a></li>
							</c:forEach>
							<c:if
								test="${param.pageNo < requestScope.pagingInfo.totalPageCnt}">
								<li class="page-item"><a class="page-link"
									href="/cs/viewInquiry?pageNo=${param.pageNo + 1 }&viewPostCntPerPage=${param.viewPostCntPerPage}">Next</a></li>
							</c:if>
						</ul>

						<button type="button" class="btn btn-primary"
							onclick="location.href='makeInquiry';">글쓰기</button>


					</div>
				</div>
			</div>
		</div>
		<!-- All User Table Ends-->

		<div class="container-fluid">
			<!-- footer start-->
			<footer class="footer">
				<div class="footer-copyright text-center">
					<p class="mb-0">Copyright 2022 © Fastkart theme by pixelstrap</p>
				</div>
			</footer>
			<!-- footer end-->
		</div>


		<!-- Modal Start -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1">
			<div class="modal-dialog  modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-body">
						<h5 class="modal-title" id="staticBackdropLabel">Logging Out</h5>
						<p>Are you sure you want to log out?</p>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
						<div class="button-box">
							<button type="button" class="btn btn--no" data-bs-dismiss="modal">No</button>
							<button type="button" class="btn  btn--yes btn-primary">Yes</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal End -->


		<!-- Delete Modal Box Start -->
		<div class="modal fade theme-modal remove-coupon"
			id="exampleModalToggle" aria-hidden="true" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header d-block text-center">
						<h5 class="modal-title w-100" id="exampleModalLabel22">Are
							You Sure ?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fas fa-times"></i>
						</button>
					</div>
					<div class="modal-body">
						<div class="remove-box">
							<p>The permission for the use/group, preview is inherited
								from the object, object will create a new permission for this
								object</p>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-animation btn-sm fw-bold"
							data-bs-dismiss="modal">No</button>
						<button type="button" class="btn btn-animation btn-sm fw-bold"
							data-bs-target="#exampleModalToggle2" data-bs-toggle="modal"
							data-bs-dismiss="modal">Yes</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade theme-modal remove-coupon"
			id="exampleModalToggle2" aria-hidden="true" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title text-center" id="exampleModalLabel12">Done!</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close">
							<i class="fas fa-times"></i>
						</button>
					</div>
					<div class="modal-body">
						<div class="remove-box text-center">
							<div class="wrapper">
								<svg class="checkmark" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 52 52">
                                <circle class="checkmark__circle"
										cx="26" cy="26" r="25" fill="none" />
                                <path class="checkmark__check"
										fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8" />
                            </svg>
							</div>
							<h4 class="text-content">It's Removed.</h4>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Delete Modal Box End -->

		<!-- latest js -->
		<script src="/resources/boardAssets/js/jquery-3.6.0.min.js"></script>

		<!-- Bootstrap js -->
		<script
			src="/resources/boardAssets/js/bootstrap/bootstrap.bundle.min.js"></script>

		<!-- feather icon js -->
		<script
			src="/resources/boardAssets/js/icons/feather-icon/feather.min.js"></script>
		<script
			src="/resources/boardAssets/js/icons/feather-icon/feather-icon.js"></script>

		<!-- scrollbar simplebar js -->
		<script src="/resources/boardAssets/js/scrollbar/simplebar.js"></script>
		<script src="/resources/boardAssets/js/scrollbar/custom.js"></script>

		<!-- customizer js -->
		<script src="/resources/boardAssets/js/customizer.js"></script>

		<!-- Sidebar js -->
		<script src="/resources/boardAssets/js/config.js"></script>

		<!-- Plugins JS -->
		<script src="/resources/boardAssets/js/sidebar-menu.js"></script>
		<script src="/resources/boardAssets/js/notify/bootstrap-notify.min.js"></script>
		<script src="/resources/boardAssets/js/notify/index.js"></script>

		<!-- Data table js -->
		<script src="/resources/boardAssets/js/jquery.dataTables.js"></script>
		<script src="/resources/boardAssets/js/custom-data-table.js"></script>

		<!-- sidebar effect -->
		<script src="/resources/boardAssets/js/sidebareffect.js"></script>

		<!-- Theme js -->
		<script src="/resources/boardAssets/js/script.js"></script>
</body>

</html>