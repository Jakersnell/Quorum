<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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

						<div class="row">
							<div class="col-4"></div>
							<div class="col-4">
								<a class="nav-link btn btn-secondary form-control"
									href="getFollow.do?userID=${user.id}">followers</a>
							</div>
							<div class="col-4"></div>
						</div>
					</div>
					<div class="col-2"></div>
					<div class="col-2">
						<c:if test="${userEditAuth}">
							<a class="btn btn-info" role="button" href="editProfile.do?userID=${user.id}">Edit
								Profile</a>
						</c:if>
					</div>
					<div class="col-2"></div>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</body>

		</html>