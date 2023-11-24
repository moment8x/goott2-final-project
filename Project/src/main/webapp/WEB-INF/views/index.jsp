<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Dear Books</title>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>


	<div class="container">
	
	</div>
	<div>
		<sec:authentication property="principal"/>
	</div>
	<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>