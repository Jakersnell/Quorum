<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />

	<h5>${professor.firstName} ${professor.lastName}</h5>
	<h1>Average Rating ${professor.averageRating}</h1>

	<c:forEach var="rating" items="${ratings}">
		<h5>${rating.content}</h5>
		<p>Rating: ${rating.rating}</p>
	</c:forEach>


	<jsp:include page="footer.jsp" />
</body>

</html>