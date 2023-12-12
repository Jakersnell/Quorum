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
			<div class="col-2"></div>
			<div class="col-4">
				<div class="row">
					<div class="col-10">
						<h2 class="table-title">Followers</h2>
					</div>
					<div class="col-2"></div>
				</div>
				<hr>
				<div class="row scroll-container">
					<c:forEach var="follower" items="${user.followers}">
						<div class="follow-item row">
							<div class="col-10">
								<h3>${follower.firstName}&nbsp;${follower.lastName}</h3>
							</div>
							<div class="col-2">
								<c:if test="${userEditAuth}">
									<button
										class="form-control btn btn-secondary remove-follow-btn">X</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-4">
				<div class="row">
					<div class="col-10">
						<h2 class="table-title">Following</h2>
					</div>
					<div class="col-2"></div>
				</div>
				<hr>
				<div class="row scroll-container">
					<c:forEach var="follow" items="${user.following}">
						<div class="follow-item row">
							<div class="col-10">
								<h3>${follow.firstName}&nbsp;${follow.lastName}</h3>
							</div>
							<div class="col-2">
								<c:if test="${userEditAuth}">
									<button
										class="form-control btn btn-secondary remove-follow-btn">X</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>