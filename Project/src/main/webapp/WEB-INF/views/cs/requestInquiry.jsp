<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<!-- meta data -->
<meta charset="UTF-8">
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
<title>Fastkart - Add New Product</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">

<!-- Linear Icon css -->
<link rel="stylesheet" href="/resources/boardAssets/css/linearicon.css">

<!-- Fontawesome css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/font-awesome.css">

<!-- Themify icon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/themify.css">

<!--Dropzon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/dropzone.css">

<!-- Feather icon css-->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/feather-icon.css">

<!-- remixicon css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/remixicon.css">

<!-- Select2 css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/select2.min.css">

<!-- Plugins css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/scrollbar.css">
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/animate.css">
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/chartist.css">
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/date-picker.css">

<!-- Bootstrap css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/bootstrap.css">

<!-- Bootstrap-tag input css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/vendors/bootstrap-tagsinput.css">

<!-- App css -->
<link rel="stylesheet" type="text/css"
	href="/resources/boardAssets/css/style.css">


<style>
.inquiryTextArea {
	border-radius: 6px;
	font-size: 14px;
	line-height: 22px;
	letter-spacing: -0.01em;
	font-family: "Noto Sans KR", sans-serif;
	background-color: #fff;
	box-sizing: border-box;
	transition: background 0.2s ease-out, border-color 0.2s ease-out;
	outline: 0;
	overflow-y: auto;
	resize: none;
}

.upFileArea, .detailUpFileArea {
	width: 100%;
	height: 100px;
	border: 1px solid;
	border-color: #efefef;
	background-color: #f9f9f6 !important;
}

.removeImgBtn {
	border: none;
	background-color: #f9f9f6 !important;
}

/* .imgList {
display:flex;
	width: 80px;
}

.uploadFiles, .insertFiles {
	display: flex;
} */
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

	<!-- tap on top start -->
	<div class="tap-top">
		<span class="lnr lnr-chevron-up"></span>
	</div>
	<!-- tap on tap end -->

	<!-- page-wrapper start -->

	<!-- Page Sidebar Start-->
	<!-- <div class="sidebar-wrapper">
            <div id="sidebarEffect"></div>
                <div>
                    <div class="logo-wrapper logo-wrapper-center">
                        <a href="index.html" data-bs-original-title="" title="">
                            <img class="img-fluid for-white" src="assets/images/logo/full-white.png" alt="logo">
                        </a>
                        <div class="back-btn">
                            <i class="fa fa-angle-left"></i>
                        </div>
                        <div class="toggle-sidebar">
                            <i class="ri-apps-line status_toggle middle sidebar-toggle"></i>
                        </div>
                    </div>
                    <div class="logo-icon-wrapper">
                        <a href="index.html">
                            <img class="img-fluid main-logo main-white" src="assets/images/logo/1-white.png" alt="logo">
                            <img class="img-fluid main-logo main-dark" src="assets/images/logo/logo-white.png"
                                alt="logo">
                        </a>
                    </div>
                    <nav class="sidebar-main">
                        <div class="left-arrow" id="left-arrow">
                            <i data-feather="arrow-left"></i>
                        </div>

                        <div id="sidebar-menu">
                            <ul class="sidebar-links" id="simple-bar">
                                <li class="back-btn"></li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="index.html">
                                        <i class="ri-home-line"></i>
                                        <span>Dashboard</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-store-3-line"></i>
                                        <span>Product</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="products.html">Prodcts</a>
                                        </li>

                                        <li>
                                            <a href="add-new-product.html">Add New Products</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-list-check-2"></i>
                                        <span>Category</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="category.html">Category List</a>
                                        </li>

                                        <li>
                                            <a href="add-new-category.html">Add New Category</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-list-settings-line"></i>
                                        <span>Attributes</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="attributes.html">Attributes</a>
                                        </li>

                                        <li>
                                            <a href="add-new-attributes.html">Add Attributes</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-user-3-line"></i>
                                        <span>Users</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="all-users.html">All users</a>
                                        </li>
                                        <li>
                                            <a href="add-new-user.html">Add new user</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-user-3-line"></i>
                                        <span>Roles</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="role.html">All roles</a>
                                        </li>
                                        <li>
                                            <a href="create-role.html">Create Role</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="media.html">
                                        <i class="ri-price-tag-3-line"></i>
                                        <span>Media</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-archive-line"></i>
                                        <span>Orders</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="order-list.html">Order List</a>
                                        </li>
                                        <li>
                                            <a href="order-detail.html">Order Detail</a>
                                        </li>
                                        <li>
                                            <a href="order-tracking.html">Order Tracking</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-focus-3-line"></i>
                                        <span>Localization</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="translation.html">Translation</a>
                                        </li>

                                        <li>
                                            <a href="currency-rates.html">Currency Rates</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-price-tag-3-line"></i>
                                        <span>Coupons</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="coupon-list.html">Coupon List</a>
                                        </li>

                                        <li>
                                            <a href="create-coupon.html">Create Coupon</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="taxes.html">
                                        <i class="ri-price-tag-3-line"></i>
                                        <span>Tax</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="product-review.html">
                                        <i class="ri-star-line"></i>
                                        <span>Product Review</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="support-ticket.html">
                                        <i class="ri-phone-line"></i>
                                        <span>Support Ticket</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-settings-line"></i>
                                        <span>Settings</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="profile-setting.html">Profile Setting</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="reports.html">
                                        <i class="ri-file-chart-line"></i>
                                        <span>Reports</span>
                                    </a>
                                </li>

                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="list-page.html">
                                        <i class="ri-list-check"></i>
                                        <span>List Page</span>
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="right-arrow" id="right-arrow">
                            <i data-feather="arrow-right"></i>
                        </div>
                    </nav>
                </div>
            </div>
            -->


	<!-- New Product Add Start -->
	<c:choose>
		<c:when test="${requestScope.inquiry != null }">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-sm-8 m-auto">
								<form action="/cs/updateInquiry" id="updateInquiry"
									method="POST" enctype="multipart/form-data">
									<input type="hidden" name="postNo" id="postNo" value="" />
									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>1:1 문의 상세</h5>
											</div>


											<div class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">제목</label>
													<div class="col-sm-9">
														<input class="form-control" id="inquiryTitle" type="text"
															name="title" placeholder="제목"
															value="${requestScope.inquiry.title }" readonly>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">문의 유형</label>
													<div class="col-sm-9">
														<!--  <input class="form-control" id="inquiryType" type="text" name="inquiryType"
													 readonly value="${requestScope.inquiry.inquiryType }">-->
														<select class="js-example-basic-single w-100"
															id="selectState" name="inquiryType">
															<!-- <option disabled>Static Menu</option> -->
															<option>문의 유형을 선택해주세요.</option>
															<option>주문/결제</option>
															<option>반품/교환/환불</option>
															<option>시스템불편사항</option>
														</select>
													</div>
												</div>

												<!-- <div class="mb-4 row align-items-center">
											<label class="col-sm-3 col-form-label form-label-title">문의유형</label>
											<div class="col-sm-9">
												<select class="js-example-basic-single w-100" id="selectState" name="inquiryType">
													<!-- <option disabled>Static Menu</option> 
													<option>문의 유형을 선택해주세요.</option>
													<option>주문/결제</option>
													<option>반품/교환/환불</option>
													<option>시스템불편사항</option>
												</select>
											</div>
										</div>-->

												<!-- <div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Category</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option disabled>Category Menu</option>
															<option>Electronics</option>
															<option>TV & Appliances</option>
															<option>Home & Furniture</option>
															<option>Another</option>
															<option>Baby & Kids</option>
															<option>Health, Beauty & Perfumes</option>
															<option>Uncategorized</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Subcategory</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option disabled>Subcategory Menu</option>
															<option>Ethnic Wear</option>
															<option>Ethnic Bottoms</option>
															<option>Women Western Wear</option>
															<option>Sandels</option>
															<option>Shoes</option>
															<option>Beauty & Grooming</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Brand</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100">
															<option disabled>Brand Menu</option>
															<option value="puma">Puma</option>
															<option value="hrx">HRX</option>
															<option value="roadster">Roadster</option>
															<option value="zara">Zara</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Unit</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100">
															<option disabled>Unit Menu</option>
															<option>Kilogram</option>
															<option>Pieces</option>
														</select>
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Tags</label>
													<div class="col-sm-9">
														<div class="bs-example">
															<input type="text" class="form-control"
																placeholder="Type tag & hit enter" id="#inputTag"
																data-role="tagsinput">
														</div>
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Exchangeable</label>
													<div class="col-sm-9">
														<label class="switch"> <input type="checkbox"><span
															class="switch-state"></span>
														</label>
													</div>
												</div>
												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Refundable</label>
													<div class="col-sm-9">
														<label class="switch"> <input type="checkbox"
															checked=""><span class="switch-state"></span>
														</label>
													</div>
												</div>
												 -->
											</div>

										</div>
									</div>

									<div class="theme-form theme-form-2 mega-form">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>내용</h5>
												</div>


												<div class="row">
													<div class="col-12">
														<div class="row">
															<label class="form-label-title col-sm-3 mb-0">상세
																내용</label>
															<div class="col-sm-9 inquiryTextArea">
																<textarea maxlength="500"
																	style="height: 246px; width: 100%;" name="content"
																	id="inquiryContent" readonly></textarea>
															</div>
														</div>
													</div>
												</div>

											</div>
										</div>
									</div>

									<div class="theme-form theme-form-2 mega-form"
										id="updateUpfileArea" style="display: none">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>사진 첨부</h5>
												</div>


												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Images</label>
													<div class="col-sm-9">
														<div>첨부한 이미지 파일</div>
														<div class="upFileArea">
															<div class="uploadFiles">
																<c:forEach var="image"
																	items="${requestScope.uploadFiles }" varStatus="status">
																	<div id="${image.thumbnailFileName }" class="imgList">
																		<img style="pointer-events: none"
																			src='../resources/inquiryUploads${image.thumbnailFileName }' />
																		<button style="display: none"
																			id='${image.thumbnailFileName }${status.index}'
																			class="removeImgBtn" type="button"
																			onclick="removeSpecificImg(this.id,'\${update}');">
																			<img width="16" height="16"
																				src="https://img.icons8.com/tiny-glyph/16/cancel.png"
																				alt="cancel" />
																		</button>
																	</div>
																</c:forEach>
																<div class="insertFiles"></div>
															</div>
														</div>
													</div>

													<!-- <div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Thumbnail
														Image</label>
													<div class="col-sm-9">
														<input class="form-control form-choose" type="file"
															id="formFileMultiple1" multiple>
													</div>
												</div> -->

												</div>
											</div>
										</div>
									</div>

									<div class="theme-form theme-form-2 mega-form"
										id="detailUpfile" style="display:">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>사진 첨부</h5>
												</div>


												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Images</label>
													<div class="col-sm-9">
														<div>첨부한 이미지 파일</div>
														<div class="detailUpFileArea">
															<div class="uploadFiles">
																<c:forEach var="image"
																	items="${requestScope.uploadFiles }" varStatus="status">
																	<div id="${image.thumbnailFileName }" class="imgList">
																		<img
																			src='../resources/inquiryUploads${image.thumbnailFileName }'
																			onclick="enlargeImg(${status.index});" />
																		<button style="display: none"
																			id='${image.thumbnailFileName }${status.index}'
																			class="removeImgBtn" type="button"
																			onclick="removeSpecificImg(this.id);">
																			<img width="16" height="16"
																				src="https://img.icons8.com/tiny-glyph/16/cancel.png"
																				alt="cancel" />
																		</button>
																	</div>
																</c:forEach>
																<div class="insertFiles"></div>
															</div>
														</div>
													</div>

													<!-- <div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Thumbnail
														Image</label>
													<div class="col-sm-9">
														<input class="form-control form-choose" type="file"
															id="formFileMultiple1" multiple>
													</div>
												</div> -->

												</div>
											</div>
										</div>
									</div>
									<!-- The Modal -->
									<div class="modal" id="imgModal">
										<div class="modal-dialog">

											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title">이미지 상세보기</h4>
													<button type="button" style="border:none" onclick="closeBigImgModal()">X</button>
												</div>
												<div class="modal-body">
													<!-- Carousel -->
													<div id="demo" class="carousel"
														data-bs-ride="carousel">

														<!-- Indicators/dots -->
														<div class="carousel-indicators">
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="0" class="active"></button>
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="1"></button>
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="2"></button>
														</div>

														<!-- The slideshow/carousel -->
														<div class="carousel-inner">

															<!--  <div class="item active">
												<img src="la.jpg" alt="Los Angeles">
											</div>

											<div class="item">
												<img src="chicago.jpg" alt="Chicago">
											</div>-->
															<c:forEach var="file"
																items="${requestScope.uploadFiles }" varStatus="status">
																<div class="carousel-item">
																	<img
																		src="../resources/inquiryUploads${file.newFileName }"
																		id="newFile${status.index }" class="d-block"
																		style="width: 512px; height: 512px;">
																</div>
															</c:forEach>

														</div>

														<!-- Left and right controls/icons -->
														<button class="carousel-control-prev" type="button"
															data-bs-target="#demo" data-bs-slide="prev">
															<span class="carousel-control-prev-icon"></span>
														</button>
														<button class="carousel-control-next" type="button"
															data-bs-target="#demo" data-bs-slide="next">
															<span class="carousel-control-next-icon"></span>
														</button>
													</div>

													<div class="container-fluid mt-3">
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															onclick="closeBigImgModal()"data-dismiss="modal">Close</button>
													</div>
												</div>

											</div>
										</div>
									</div>




									<!-- 									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Videos</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Video
														Provider</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Vimeo</option>
															<option>Youtube</option>
															<option>Dailymotion</option>
															<option>Vimeo</option>
														</select>
													</div>
												</div>

												<div class="row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Video
														Link</label>
													<div class="col-sm-9">
														<input class="form-control" type="text"
															placeholder="Video Link">
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product variations</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Option
														Name</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Color</option>
															<option>Size</option>
															<option>Material</option>
															<option>Style</option>
														</select>
													</div>
												</div>

												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Option
														Value</label>
													<div class="col-sm-9">
														<div class="bs-example">
															<input type="text" class="form-control"
																placeholder="Type tag & hit enter" id="#inputTag"
																data-role="tagsinput">
														</div>
													</div>
												</div>
											</form>

											<a href="#" class="add-option"><i
												class="ri-add-line me-2"></i> Add Another Option</a>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Shipping</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Weight
														(kg)</label>
													<div class="col-sm-9">
														<input class="form-control" type="number"
															placeholder="Weight">
													</div>
												</div>

												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Dimensions
														(cm)</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Length</option>
															<option>Width</option>
															<option>Height</option>
														</select>
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Price</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">price</label>
													<div class="col-sm-9">
														<input class="form-control" type="number" placeholder="0">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">Compare at
														price</label>
													<div class="col-sm-9">
														<input class="form-control" type="number" placeholder="0">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">Cost per
														item</label>
													<div class="col-sm-5">
														<input class="form-control" type="number" placeholder="0">
													</div>
													<div class="col-sm-2">
														<label>Margin:</label> <span>25%</span>
													</div>
													<div class="col-sm-2">
														<label>Profit:</label> <span>$5</span>
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Inventory</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">SKU</label>
													<div class="col-sm-9">
														<input class="form-control" type="text">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Stock
														Status</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>In Stock</option>
															<option>Out Of Stock</option>
															<option>On Backorder</option>
														</select>
													</div>
												</div>
											</form>
											<table class="table variation-table table-responsive-sm">
												<thead>
													<tr>
														<th scope="col">Variant</th>
														<th scope="col">Price</th>
														<th scope="col">SKU</th>
														<th scope="col">Quantity</th>
														<th scope="col"></th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Red</td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td>
															<ul class="order-option">
																<li><a href="javascript:void(0)"
																	data-toggle="modal" data-target="#deleteModal"><i
																		class="ri-delete-bin-line"></i></a></li>
															</ul>
														</td>
													</tr>
													<tr>
														<td>Blue</td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td>
															<ul class="order-option">
																<li><a href="javascript:void(0)"
																	data-toggle="modal" data-target="#deleteModal"><i
																		class="ri-delete-bin-line"></i></a></li>
															</ul>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Link Products</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Upsells</label>
													<div class="col-sm-9">
														<input class="form-control" type="search">
													</div>
												</div>

												<div class="row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Cross-Sells</label>
													<div class="col-sm-9">
														<input class="form-control" type="search">
													</div>
												</div>
											</form>
										</div>
									</div> -->
									<div class="theme-form theme-form-2 mega-form">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>문의에 대한 답변 등록 시 알림받을 번호</h5>
												</div>




												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">휴대폰번호
													</label>
													<div class="col-sm-9">
														<input class="form-control" type="text" id="phoneNumber"
															placeholder="미요청" name="phoneNumber"
															value="${requestScope.inquiry.phoneNumber }" readonly>
													</div>
												</div>
												<div>
													<input type="checkbox" disabled /> 답변 알림 문자 요청
												</div>

												<!--  <div class="mb-4 row">
													<label class="form-label-title col-sm-3 mb-0">Meta
														description</label>
													<div class="col-sm-9">
														<textarea class="form-control" rows="3"></textarea>
													</div>
												</div>

												<div class="row">
													<label class="form-label-title col-sm-3 mb-0">URL
														handle</label>
													<div class="col-sm-9">
														<input class="form-control" type="search"
															placeholder="https://fastkart.com/fresh-veggies">
													</div>
												</div>
												-->

											</div>
										</div>
									</div>
								</form>
							</div>

						</div>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-sm-8 m-auto">
								<form action="/cs/saveInquiry" id="saveInquiry" method="POST"
									enctype="multipart/form-data">
									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>1:1 문의 접수</h5>
											</div>


											<div class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">제목</label>
													<div class="col-sm-9">
														<input class="form-control" id="inquiryTitle" type="text"
															name="title" placeholder="제목">
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">문의유형</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100"
															id="selectState" name="inquiryType">
															<!-- <option disabled>Static Menu</option> -->
															<option>문의 유형을 선택해주세요.</option>
															<option>주문/결제</option>
															<option>반품/교환/환불</option>
															<option>시스템불편사항</option>
														</select>
													</div>
												</div>

												<!-- <div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Category</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option disabled>Category Menu</option>
															<option>Electronics</option>
															<option>TV & Appliances</option>
															<option>Home & Furniture</option>
															<option>Another</option>
															<option>Baby & Kids</option>
															<option>Health, Beauty & Perfumes</option>
															<option>Uncategorized</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Subcategory</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option disabled>Subcategory Menu</option>
															<option>Ethnic Wear</option>
															<option>Ethnic Bottoms</option>
															<option>Women Western Wear</option>
															<option>Sandels</option>
															<option>Shoes</option>
															<option>Beauty & Grooming</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Brand</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100">
															<option disabled>Brand Menu</option>
															<option value="puma">Puma</option>
															<option value="hrx">HRX</option>
															<option value="roadster">Roadster</option>
															<option value="zara">Zara</option>
														</select>
													</div>
												</div>

												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Unit</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100">
															<option disabled>Unit Menu</option>
															<option>Kilogram</option>
															<option>Pieces</option>
														</select>
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Tags</label>
													<div class="col-sm-9">
														<div class="bs-example">
															<input type="text" class="form-control"
																placeholder="Type tag & hit enter" id="#inputTag"
																data-role="tagsinput">
														</div>
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Exchangeable</label>
													<div class="col-sm-9">
														<label class="switch"> <input type="checkbox"><span
															class="switch-state"></span>
														</label>
													</div>
												</div>
												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Refundable</label>
													<div class="col-sm-9">
														<label class="switch"> <input type="checkbox"
															checked=""><span class="switch-state"></span>
														</label>
													</div>
												</div>
												 -->
											</div>

										</div>
									</div>

									<div class="theme-form theme-form-2 mega-form">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>내용</h5>
												</div>


												<div class="row">
													<div class="col-12">
														<div class="row">
															<label class="form-label-title col-sm-3 mb-0">상세
																내용</label>
															<div class="col-sm-9 inquiryTextArea">
																<textarea maxlength="500"
																	style="height: 246px; width: 100%;" name="content"
																	id="inquiryContent"></textarea>
															</div>
														</div>
													</div>
												</div>

											</div>
										</div>
									</div>
									<div class="theme-form theme-form-2 mega-form">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>사진 첨부</h5>
												</div>


												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Images</label>
													<div class="col-sm-9">
														<div>빠른 답변을 위해 이미지를 첨부해 주세요.</div>
														<div class="upFileArea">
															<div class="uploadFiles">
															<div class="insertFiles"></div>
															</div>
															
														</div>
														<div>* JPG, PNG, GIF 파일만 최대 3장 업로드 가능합니다.</div>
													</div>

													<!-- <div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Thumbnail
														Image</label>
													<div class="col-sm-9">
														<input class="form-control form-choose" type="file"
															id="formFileMultiple1" multiple>
													</div>
												</div> -->

												</div>
											</div>
										</div>
									</div>

									<!-- 									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Videos</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Video
														Provider</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Vimeo</option>
															<option>Youtube</option>
															<option>Dailymotion</option>
															<option>Vimeo</option>
														</select>
													</div>
												</div>

												<div class="row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Video
														Link</label>
													<div class="col-sm-9">
														<input class="form-control" type="text"
															placeholder="Video Link">
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product variations</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Option
														Name</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Color</option>
															<option>Size</option>
															<option>Material</option>
															<option>Style</option>
														</select>
													</div>
												</div>

												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Option
														Value</label>
													<div class="col-sm-9">
														<div class="bs-example">
															<input type="text" class="form-control"
																placeholder="Type tag & hit enter" id="#inputTag"
																data-role="tagsinput">
														</div>
													</div>
												</div>
											</form>

											<a href="#" class="add-option"><i
												class="ri-add-line me-2"></i> Add Another Option</a>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Shipping</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Weight
														(kg)</label>
													<div class="col-sm-9">
														<input class="form-control" type="number"
															placeholder="Weight">
													</div>
												</div>

												<div class="row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Dimensions
														(cm)</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>Length</option>
															<option>Width</option>
															<option>Height</option>
														</select>
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Price</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">price</label>
													<div class="col-sm-9">
														<input class="form-control" type="number" placeholder="0">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">Compare at
														price</label>
													<div class="col-sm-9">
														<input class="form-control" type="number" placeholder="0">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 form-label-title">Cost per
														item</label>
													<div class="col-sm-5">
														<input class="form-control" type="number" placeholder="0">
													</div>
													<div class="col-sm-2">
														<label>Margin:</label> <span>25%</span>
													</div>
													<div class="col-sm-2">
														<label>Profit:</label> <span>$5</span>
													</div>
												</div>
											</form>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Product Inventory</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">SKU</label>
													<div class="col-sm-9">
														<input class="form-control" type="text">
													</div>
												</div>
												<div class="mb-4 row align-items-center">
													<label class="col-sm-3 col-form-label form-label-title">Stock
														Status</label>
													<div class="col-sm-9">
														<select class="js-example-basic-single w-100" name="state">
															<option>In Stock</option>
															<option>Out Of Stock</option>
															<option>On Backorder</option>
														</select>
													</div>
												</div>
											</form>
											<table class="table variation-table table-responsive-sm">
												<thead>
													<tr>
														<th scope="col">Variant</th>
														<th scope="col">Price</th>
														<th scope="col">SKU</th>
														<th scope="col">Quantity</th>
														<th scope="col"></th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Red</td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td>
															<ul class="order-option">
																<li><a href="javascript:void(0)"
																	data-toggle="modal" data-target="#deleteModal"><i
																		class="ri-delete-bin-line"></i></a></li>
															</ul>
														</td>
													</tr>
													<tr>
														<td>Blue</td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td><input class="form-control" type="number"
															placeholder="0"></td>
														<td>
															<ul class="order-option">
																<li><a href="javascript:void(0)"
																	data-toggle="modal" data-target="#deleteModal"><i
																		class="ri-delete-bin-line"></i></a></li>
															</ul>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>

									<div class="card">
										<div class="card-body">
											<div class="card-header-2">
												<h5>Link Products</h5>
											</div>

											<form class="theme-form theme-form-2 mega-form">
												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Upsells</label>
													<div class="col-sm-9">
														<input class="form-control" type="search">
													</div>
												</div>

												<div class="row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">Cross-Sells</label>
													<div class="col-sm-9">
														<input class="form-control" type="search">
													</div>
												</div>
											</form>
										</div>
									</div> -->
									<div class="theme-form theme-form-2 mega-form">
										<div class="card">
											<div class="card-body">
												<div class="card-header-2">
													<h5>문의에 대한 답변 등록 시 알려드립니다.</h5>
												</div>




												<div class="mb-4 row align-items-center">
													<label class="form-label-title col-sm-3 mb-0">휴대폰번호
													</label>
													<div class="col-sm-9">
														<input class="form-control" type="search"
															placeholder="Fresh Fruits" name="phoneNumber">
													</div>
												</div>
												<div>
													<input type="checkbox" /> 답변 알림 문자 요청
												</div>

												<!--  <div class="mb-4 row">
													<label class="form-label-title col-sm-3 mb-0">Meta
														description</label>
													<div class="col-sm-9">
														<textarea class="form-control" rows="3"></textarea>
													</div>
												</div>

												<div class="row">
													<label class="form-label-title col-sm-3 mb-0">URL
														handle</label>
													<div class="col-sm-9">
														<input class="form-control" type="search"
															placeholder="https://fastkart.com/fresh-veggies">
													</div>
												</div>
												-->

											</div>
										</div>
									</div>
								</form>
							</div>

						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<!-- New Product Add End -->









	<!-- latest js -->
	<!-- <script src="/resources/boardAssets/js/jquery-3.6.0.min.js"></script>

	Bootstrap js
	<script
		src="/resources/boardAssets/js/bootstrap/bootstrap.bundle.min.js"></script>

	feather icon js
	<script
		src="/resources/boardAssets/js/icons/feather-icon/feather.min.js"></script>
	<script
		src="/resources/boardAssets/js/icons/feather-icon/feather-icon.js"></script>

	scrollbar simplebar js
	<script src="/resources/boardAssets/js/scrollbar/simplebar.js"></script>
	<script src="/resources/boardAssets/js/scrollbar/custom.js"></script>

	Sidebar js
	<script src="/resources/boardAssets/js/config.js"></script>

	bootstrap tag-input js
	<script src="/resources/boardAssets/js/bootstrap-tagsinput.min.js"></script>
	<script src="/resources/boardAssets/js/sidebar-menu.js"></script>

	customizer js
	<script src="/resources/boardAssets/js/customizer.js"></script>

	Dropzon js
	<script src="/resources/boardAssets/js/dropzone/dropzone.js"></script>
	<script src="/resources/boardAssets/js/dropzone/dropzone-script.js"></script>

	Plugins js
	<script src="/resources/boardAssets/js/notify/bootstrap-notify.min.js"></script>
	<script src="/resources/boardAssets/js/notify/index.js"></script>

	ck editor js
	<script src="/resources/boardAssets/js/ckeditor.js"></script>
	<script src="/resources/boardAssets/js/ckeditor-custom.js"></script>

	select2 js
	<script src="/resources/boardAssets/js/select2.min.js"></script>
	<script src="/resources/boardAssets/js/select2-custom.js"></script>

	sidebar effect
	<script src="/resources/boardAssets/js/sidebareffect.js"></script>

	Theme js
	<script src="/resources/boardAssets/js/script.js"></script>
 -->
</body>

</html>