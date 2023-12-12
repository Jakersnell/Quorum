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
					<c:out value="${loggedUser.firstName} ${loggedUser.lastName}"></c:out>
				</h3>
				<hr>
				<c:out value="${loggedUser}"></c:out>
				<hr>
				<h3>Following</h3>
				<c:forEach var="follower" items="${loggedUser.following}">
					<h2>${follower.firstName}&nbsp;${follower.lastName}</h2>
					<hr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<h4>User Not Found!</h4>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>