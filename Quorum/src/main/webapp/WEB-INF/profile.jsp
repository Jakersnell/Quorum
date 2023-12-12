 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />

	<div class="container user-profile mt-5">
		<div class="row">
			<div class="col-6 text-center">
				<h3>
					<c:out value="${user.firstName} ${user.lastName}"></c:out>
				</h3>
				
				<a class="nav-link" href="getFollow.do?userID=${user.id}">followers</a>
				
			</div>
			<div class="col-2"></div>
			<div class="col-2">
				<c:if test="${userEditAuth}">
					<button class="form-control btn btn-info">Edit Profile</button>
				</c:if>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>