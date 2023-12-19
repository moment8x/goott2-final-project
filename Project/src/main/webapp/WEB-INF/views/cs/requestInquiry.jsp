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
<script>

</script>
</head>

<body>

	<!-- tap on top start -->
	<div class="tap-top">
		<span class="lnr lnr-chevron-up"></span>
	</div>
	<!-- tap on tap end -->

	<!-- page-wrapper start -->

	<!-- Page Sidebar Start-->
	


	<!-- New Product Add Start -->
	<c:choose>
		<c:when test="${inquiry != null && inquiry.author != 'qwer123' }">
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
												<h5 id="inquiryStatus">1:1 문의 상세</h5>
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
														<c:forEach items="${requestScope.uploadFiles }" varStatus="status" >
															<c:choose>
															<c:when test="${status.index == 0 }">
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="${status.index }" class="active"></button>
															</c:when>
															<c:otherwise>
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="${status.index }" ></button>
															</c:otherwise>
															</c:choose>
															  <!--<button type="button" data-bs-target="#demo"
																data-bs-slide-to="${status.index }"></button>
															<button type="button" data-bs-target="#demo"
																data-bs-slide-to="2"></button>-->
														</c:forEach>
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
																		style="width:512px; height:512px;">
																</div>
															</c:forEach>

														</div>

														<!-- Left and right controls/icons 
														<button class="carousel-control-prev" type="button"
															data-bs-target="#demo" data-bs-slide="prev">
															<span class="carousel-control-prev-icon"></span>
														</button>
														<button class="carousel-control-next" type="button"
															data-bs-target="#demo" data-bs-slide="next">
															<span class="carousel-control-next-icon"></span>
														</button>-->
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
													<input type="checkbox" name="inquirySms" id="inquirySms" onclick="checkSms()" disabled /> 답변 알림 문자 요청
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
		<c:when test="${inquiry != null && inquiry.author eq 'qwer123' }">
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

									

									
									<!-- The Modal -->
									
									
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
															placeholder="-빼고 입력해주세요" id="phoneNumber"name="phoneNumber">
													</div>
												</div>
												<div>
													<input type="checkbox" id="inquirySms" onclick="checkSms()" name="inquirySms"/> 답변 알림 문자 요청
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