<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="container">
		<h1>CommonError.jsp</h1>
		
		<div>${requestScope.errorMsg }</div>
		<ul>
			<c:forEach var="product" items="${requestScope.productInfos }">
				<c:if test="${product.adequacy == 'N' }">
					<li><h2>구매하려는 수량과 재고 불일치</h2></li>
				</c:if>
			</c:forEach>
			<c:forEach var="err" items="${requestScope.errorStack }">
			<li>${err }</li>
			</c:forEach>
		</ul>
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>