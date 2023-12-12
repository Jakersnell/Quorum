<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container text-center">
		<c:choose>
			<c:when test="${not empty loggedUser}">
				<h2>MyAccount</h2>
				<hr>
				<h3>
					<c:out value="${loggedUser.firstName}&nbsp;${loggedUser.lastName}"></c:out>
				</h3>
				<hr>
				<c:out value="${loggedUser}"></c:out>
				<hr>
				<c:forEach var="follower" items="${loggedUser.following}">
					<h2>${follower.firstName}&nbsp;${follower.lastName}</h2>
					<hr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<h3>User Not Found!</h3>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>