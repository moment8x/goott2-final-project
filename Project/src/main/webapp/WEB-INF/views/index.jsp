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
	<jsp:include page="./header.jsp"></jsp:include>


	<div class="container">
		
	</div>
	
	<div>
		<p>Principal : <sec:authentication property="principal"/></p>
	</div>

	<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>