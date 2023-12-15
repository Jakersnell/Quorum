<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
		<div class="spacer"></div>
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 post-detail-container">
				<div class="row">
					<div class="col-4"></div>
					<div class="col-4"></div>
					<div class="col-1"></div>
					<div class="col-3">
						<c:if test="${userEditAuth}">
							<a href="editPost.do?postID=${post.id}" class="btn btn-secondary">Edit
								Post</a>
						</c:if>
					</div>
				</div>
				<div class="row">
					<div class="col-6">
						<a href="userProfile.do?userID=${post.user.id}">
							<h4 class="post-author">@${post.user.username}</h4>
						</a>
						<h6 class="post-date">${post.createdOn}</h6>
					</div>
					<div class="col-6">
						<a href="group.do?groupID=${post.socialGroup.id}"><h6>Posted
								in ${post.socialGroup.name}</h6></a>
					</div>
				</div>
				<div class="md-spacer"></div>
				<div class="row post-title">
					<h3>${post.title}</h3>
				</div>
				<div class="row post-title">
					<p>${post.contents}</p>
				</div>
				<div class="row">
					<h6>Last updated on ${post.lastUpdate}</h6>
				</div>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	<div class="xl-spacer"></div>
	<jsp:include page="footer.jsp" />
</body>

</html>