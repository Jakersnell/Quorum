<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6" align="center">
				<div class="xl-spacer"></div>
				<c:if test="${empty loggedUser}">
					<h1 class="welcome-header">Welcome To Quorum!</h1>
				</c:if>
				<br>
				<c:if test="${not empty loggedUser}">
					<h1>
						Hello, <strong><c:out value="${loggedUser.firstName}">!</c:out></strong>
					</h1>
				</c:if>
			</div>
			<div class="col-3"></div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>