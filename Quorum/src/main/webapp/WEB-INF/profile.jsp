<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="spacer"></div>
	<div class="container user-profile mt-5">
		<div class="row align-items-start">
			<div class="col-6 text-left">

				<div class="row">
					<div class="col-4"></div>
					<div class="col-4"></div>
					<div class="col-4"></div>
				</div>
			</div>
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-2">
				<c:if test="${!userEditAuth}">
					<c:choose>
						<c:when test="${userIsFollowingUser}">
							<form action="removeFollowing.do" method="post">
								<input type="hidden" name="userID" id="userID"
									value="${loggedUser.id}" /> <input type="hidden"
									name="removeID" id="removeID" value="${user.id}" /> <input
									type="hidden" name="fromProfile" id="fromProfile" value="true" />
								<button type="submit" class="btn btn-secondary">Unfollow</button>
							</form>
						</c:when>
						<c:otherwise>
							<form action="addFollowing.do" method="post">
								<input type="hidden" name="userID" id="userID"
									value="${loggedUser.id}" /> <input type="hidden"
									name="followID" id="followID" value="${user.id}" />


								<button type="submit" class="btn btn-secondary">Follow</button>
							</form>
						</c:otherwise>
					</c:choose>
				</c:if>
				<h3>
					<c:out value="${user.firstName} ${user.lastName}"></c:out>
				</h3>
			</div>
			<div class="col-4">
				<a class="nav-link btn btn-secondary form-control"
					href="getFollow.do?userID=${user.id}">followers</a>
			</div>
			<div class="col-2">
				<c:choose>
					<c:when test="${userEditAuth}">
						<a class="btn btn-info" role="button"
							href="editProfile.do?userID=${user.id}">Edit Profile</a>
						<br>
						<c:if test="${user.enabled == true }">
							<a class="btn btn-danger" role="button"
								href="delete.do?userID=${user.id}">Delete Account</a>
						</c:if>
						<c:if test="${user.enabled == false }">
							<a class="btn btn-success" role="button"
								href="activate.do?userID=${user.id}">Activate Account</a>
						</c:if>
					</c:when>
					<c:otherwise>
						<a class="btn btn-info" role="button"
							href="editProfile.do?userID=${user.id}">Edit Profile</a>
						<br>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-4">
				<h4>Bio</h4>
				<p>
					<em>"<c:out value="${user.biography}"></c:out>"
					</em>
				</p>
			</div>
			<div class="col-4"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-4">
				<h4>School</h4>
				<a href="school.do?schoolID=${user.school.id}"><c:out
						value="${user.school.name}"></c:out></a> <br>
			</div>
			<div class="col-4"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-2">
				<c:if test="${not empty loggedUser}">
					<a class="btn btn-info" role="button"
						href="message.do?userID=${user.id}">Message</a>
				</c:if>
			</div>
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<!-- example spacing -->
			<div class="col-2">
				<!-- column 1 -->
			</div>
			<div class="col-2">
				<!-- column 2 -->
			</div>
			<div class="col-2">
				<!-- column 3 -->
			</div>
			<div class="col-2">
				<!-- column 4 -->
			</div>
			<div class="col-2">
				<!-- column 5 -->
			</div>
			<div class="col-2">
				<!-- column 6 -->

			</div>
		</div>

		<div class="spacer"></div>
		<div class="container row">
			<div class="col-3"></div>
			<div class="col-6 profile-posts-scroll">
				<c:if test="${loggedUser == user}">
					<jsp:include page="makePostForm.jsp"></jsp:include></c:if>
				<jsp:include page="_feed.jsp" />
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>
