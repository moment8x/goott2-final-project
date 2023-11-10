<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dear Books</title>
<style type="text/css">
.info {

	text-align: center;
	height: 500px;
}
.moveBtn{
	display: flex;
	justify-content: center;
	gap : 10px;
}
.msg{
	margin-top: 170px;
	margin-bottom: 100px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div class="info">
		<h2 class="msg">정보 수정이 완료 되었습니다.</h2>
		<div class="moveBtn">
			<button class="btn theme-bg-color btn-md text-white" type="button" onclick="location.href='/user/myPage';">마이페이지로
				이동</button>
			<button class="btn theme-bg-color btn-md text-white" type="button" onclick="location.href='/';">메인페이지로
				이동</button>
		</div>
	</div>


	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>