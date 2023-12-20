<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />

	<div class="container follow-container mt-4 wrapper">
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
				<c:choose>
					<c:when test="${!user.followers.isEmpty()}">
						<div class="row scroll-container">
							<c:forEach var="follower" items="${user.followers}">
								<div class="follow-item row">
									<div class="col-10">
										<h3>${follower.username}</h3>
										<h5>${follower.firstName}&nbsp;${follower.lastName}</h5>
									</div>
									<div class="col-2">
										<c:if test="${loggedUser.equals(user) || user.isAdmin()}">
											<form action="removeFollower.do" method="post">
												<input type="hidden" id="removeFollowerID" name="removeID"
													value="${follower.id}" /> <input type="hidden"
													id="removeFollowerID" name="userID" value="${user.id}" />
												<button type="submit"
													class="form-control btn btn-secondary remove-follow-btn">X</button>
											</form>
										</c:if>
									</div>
								</div>
								<hr>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div class="text-center">
							<h3>None</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-4">
				<div class="row">
					<div class="col-10">
						<h2 class="table-title">Following</h2>
					</div>
					<div class="col-2"></div>
				</div>
				<hr>
				<c:choose>
					<c:when test="${!user.following.isEmpty()}">
						<div class="row scroll-container">
							<c:forEach var="follow" items="${user.following}">
								<div class="follow-item row">
									<div class="col-10">
										<h3>${follow.username}</h3>
										<h5>${follow.firstName}&nbsp;${follow.lastName}</h5>
									</div>
									<div class="col-2">
										<c:if test="${loggedUser.equals(user) || user.isAdmin()}">
											<form action="removeFollowing.do" method="post">
												<input type="hidden" id="removeFollowID" name="removeID"
													value="${follow.id}" /> <input type="hidden"
													id="removeFollowID" name="userID" value="${user.id}" />
												<button type="submit"
													class="form-control btn btn-secondary remove-follow-btn">X</button>
											</form>
										</c:if>
									</div>
								</div>
								<hr>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div class="text-center">
							<h3>None</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>