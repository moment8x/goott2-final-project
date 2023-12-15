<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>


	<div class="container">
		<div>${requestScope.orderItem }</div>
		<a href="http://localhost:8081/detail/S000208719388?nonOrder=true">비회원주문</a>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>