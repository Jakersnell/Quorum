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
				<c:choose>
				<c:when test="${empty loggedUser}">
					<h1 class="welcome-header">Welcome To Quorum!</h1>
				</c:when>
				<c:when test="${not empty loggedUser}">
					<c:choose>
						<c:when test="${loggedUser.role == 'admin'}">
							<h1 id="administrator>">
								01000001 01000100 01001101 01001001 01001110 			
							</h1>
						</c:when>
						<c:otherwise>
							<h1>
								Hello, <strong><c:out value="${loggedUser.firstName}">!</c:out></strong>
							</h1>
						</c:otherwise>
					</c:choose>
				</c:when>
				</c:choose>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	<div class="xl-spacer"></div>

	<jsp:include page="footer.jsp" />
</body>
</html>