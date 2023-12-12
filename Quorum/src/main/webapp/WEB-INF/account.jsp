<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<c:choose>
		<c:when test="${not empty loggedUser}">
			<c:out value="${loggedUser}"></c:out>
		</c:when>
		<c:otherwise>
			<h3>User Not Found!</h3>
		</c:otherwise>
	</c:choose>
	<jsp:include page="footer.jsp" />
</body>
</html>