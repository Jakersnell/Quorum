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
			<div class="col-4">
				<h3>
					<c:out value="${user.firstName} ${user.lastName}"></c:out>
				</h3>
			</div>
			<div class="col-4">
				<a class="nav-link btn btn-secondary form-control"
					href="getFollow.do?userID=${user.id}">followers</a>

			</div>
			<div class="col-2">
				<c:if test="${userEditAuth}">
					<a class="btn btn-info" role="button"
						href="editProfile.do?userID=${user.id}">Edit Profile</a>
				</c:if>
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
			<div class="col-2"></div>
			<div class="col-8 profile-posts-scroll">
				<c:forEach var="post" items="${feed}" varStatus="status">
					<div
						class="shadow p-1 mb-5 rounded container post-list home-post-color-${status.index % 4}">
						<div class="row">
							<div class="col-6">
								<h6>
									<a class="post-link"
										href="userProfile.do?userID=${post.user.id}">@${post.user.username}</a>
								</h6>
							</div>
							<div class="col-3">
								<h6>
									<a class="post-link"
										href="socialGroup.do?groupID=${post.socialGroup.id}">${post.socialGroup.name}</a>
								</h6>
							</div>
							<div class="col-3">
								<c:if test="${loggedUser.id == post.user.id}">
									<a class="btn post-edit-btn"
										href="editPost.do?postID=${post.id}">Edit</a>
								</c:if>
							</div>
						</div>
						<div class="row">
							<h3 class="card-title">${post.title}</h3>
						</div>
						<div class="row">
							<p>${post.contents}</p>
						</div>
					</div>
					<c:if test="${!status.last}">
						<div class="xs-spacer"></div>
					</c:if>
				</c:forEach>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>
