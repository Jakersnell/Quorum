<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-3">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row text-center">
					<h2 class="group-name">${group.name}</h2>
				</div>
				<div class="row">
					<p class="group-description">${group.name}</p>
				</div>
			</div>
			<div class="col-1"></div>
			<div class="col-2">
				<c:if test="${userHasEditAuth}">
					<a href="editGroup.do?groupID=${group.id}"
						class="btn btn-secondary form-control">edit</a>
				</c:if>
			</div>
			<div class="col-1"></div>
		</div>
		<div class="spacer"></div>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-3">
				<div class="container row">
					<h2 class="content-header">Members</h2>
				</div>
				<div class="scroll-container">
					<c:forEach var="member" items="${members}">
						<a href="userProfile.do?userID=${member.id}">
							<div class="row container">
								<h3 class="card-title">${member.username}</h3>
							</div>
						</a>
						<hr>
						<div class="xs-spacer"></div>
					</c:forEach>
				</div>
			</div>
			<div class="col-6">
				<div class="row text-center container">
					<h2 class="content-header">Make A Post</h2>
				</div>
				<div class="make-post-form shadow p-1 mb-5 rounded">
					<form action="createPost.do" method="post">

						<div class="title-input">
							<input class="form-control" type="text" name="title"
								id="Your posts title" placeholder="Whats on your mind?" required /><br />
						</div>
						<div class="group-selector">
							<select class="form-select" aria-label="Group Selector"
								name="groupId">
								<option selected>What group is this for?</option>
								<c:forEach var="group" items="${loggedUser.groups}">
									<option value="${group.id}">${group.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="post-content-input">
							<textarea class="form-control" id="postContents" rows="2"
								name="contents"></textarea>
						</div>
						<button class="btn post-btn" type="submit">Post</button>
					</form>
				</div>
				<div class="row text-center container">
					<h2 class="content-header">posts in ${group.name}</h2>
				</div>
				<hr>
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
	<jsp:include page="footer.jsp" />
</body>

</html>