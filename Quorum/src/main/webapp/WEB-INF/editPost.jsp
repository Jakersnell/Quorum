<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="md-spacer"></div>
	<div class="container wrapper vert-container">
		<div class="row vert-middle">
			<div class="col-2"></div>
			<div
				class="col-8 post-update-form post-detail-container make-post-form pt-2"
				align="center">
				<div class="row text-center form-header">
					<h2>Edit Your Post</h2>
				</div>
				<div class="row" id="postEditHeaderRow">
					<div class="col-6 ml-1">
						<h3 id="postEditHeader">Posted in ${post.socialGroup.name}</h3>
					</div>
					<div class="col-3"></div>
					<div class="col-3">
					
						<c:if test="${post.enabled}">
							<form action="deletePost.do" method="post">
								<input class="form-control" type="hidden" class="id"
									name="postID" id="postIdInput" value="${post.id}" />
								<button id="postDeleteBtn" type="submit"
									class="btn btn-danger form-control post-delete-btn">Delete</button>
							</form>
						</c:if>
						<c:if test="${!post.enabled && loggedUser.isAdmin()}">
							<form action="reActivatePost.do" method="post">
								<input class="form-control" type="hidden" class="id"
									name="postID" id="postIdInput" value="${post.id}" />
								<button id="postDeleteBtn" type="submit"
									class="btn btn-danger form-control post-delete-btn">ReActivate</button>
							</form>
						</c:if>
					</div>
				</div>
				<div class="row form-body">
					<form action="editPost.do" method="post">
						<c:if test="${not empty fromUrl}">
							<input class="form-control" type="hidden" class="fromUrl"
								name="fromUrl" id="fromUrl" value="${fromUrl}" />
						</c:if>
						<input class="form-control" type="hidden" class="id" name="id"
							id="postIdInput" value="${post.id}" />
						<div class="title-input">
							<label for="postTitle" id="postTitleLabel">Title</label> <input
								class="form-control" type="text" name="title" id="postTitle"
								placeholder="Title" value="${post.title}" required /><br />
						</div>
						<div class="post-content-input mt-3">
							<label for="postContents" id="postContentsLabel">Post
								Contents</label>
							<textarea class="form-control" id="postContents" rows="2"
								placeholder="Post Contents" name="contents">${post.contents}</textarea>
						</div>
						<div class="row mb-3 post-update-field">
							<div class="col-4"></div>
							<div class="col-4">
								<button class="btn post-btn form-control">Save</button>
							</div>
							<div class="col-4"></div>

						</div>
					</form>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	<div class="md-spacer"></div>
	<jsp:include page="footer.jsp" />
</body>

</html>