<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Dear Books</title>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>


	<div class="container">
		<a href="http://localhost:8081/detail/S000208719388">결제 테스트용 링크</a>
	</div>
	<div>
		<sec:authentication property="principal" />
	</div>
	<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>