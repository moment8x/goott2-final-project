<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="pagination justify-content-center">

		<c:if test="${page.pageNo > 1 }">
			<li class="page-item disabled"><a class="page-link"
				href="myPage" tabindex="-1" aria-disabled="true"> <i
					class="fa-solid fa-angles-left"></i>
			</a></li>
		</c:if>

		<c:forEach var="i" begin="${page.startNumOfCurrentPagingBlock }"
			end="${pgae.endNumOfCurrentPagingBlock }">
			<li class="page-item active"><a class="page-link" href="myPage">${i }</a></li>
		</c:forEach>

		<c:if test="${param.pageNo < page.totalPageCnt }">
			<li class="page-item"><a class="page-link" href="myPage"> <i
					class="fa-solid fa-angles-right"></i>
			</a></li>
		</c:if>

	</ul>
</body>
</html>