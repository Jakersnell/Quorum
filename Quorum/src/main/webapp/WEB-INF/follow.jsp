<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />

	<div class="container follow-container mt-4">
		<div class="row">
			<div class="row-6 text-center">
				<h3>Following</h3>
			</div>
			<div class="row-6 text-center">
				<h3>Followers</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-6 scroll-container">
				<c:forEach var="follower" items="${followers}">
					<div class="container follow-item row">
						<div class="col-10 text-center">
							<h3>${follower.firstName}&nbsp;${follower.lastName}</h3>
						</div>
						<div class="col-2">
							<c:if test="${editUserAuth}">
								<button class="form-control btn btn-secondary">remove</button>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="col-6 scroll-container">
				<c:forEach var="follow" items="${following}">
					<div class="container follow-item row">
						<div class="col-10 text-center">
							<h3>${follow.firstName}&nbsp;${follow.lastName}</h3>
						</div>
						<div class="col-2">
							<c:if test="${editUserAuth}">
								<button class="form-control btn btn-secondary">remove</button>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>