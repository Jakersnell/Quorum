<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />
	<div class="spacer"></div>
	<div class="container wrapper">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 post-update-form post-detail-container">
				<div class="row">
					<div class="col-6">
						<h3>posted in ${post.socialGroup.name}</h3>
					</div>
					<div class="col-3"></div>
					<div class="col-3">
						<form action="deletePost.do" method="post">
							<input class="form-control" type="hidden" class="id" name="postID"
								id="postIdInput" value="${post.id}" />
							<button type="submit"
								class="btn btn-danger form-control post-delete-btn">Delete</button>
						</form>
					</div>
				</div>
				<div class="row make-post-form">
					<form action="editPost.do" method="post">
						<div class="row mb-3 title-input">
							<input class="form-control" type="hidden" class="id" name="id"
								id="postIdInput" value="${post.id}" />
						</div>
						<div class="row mb-3 post-update-field">
							<label class="form-label" for="postTitle">title</label> <input
								class="form-control" type="text" class="update-post-input"
								name="title" id="postTitle" value="${post.title}" required />
						</div>
						<div class="post-content-input">
							<textarea class="form-control" id="postContents" rows="2"
								name="contents">${post.contents}</textarea>
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
	<jsp:include page="footer.jsp" />
</body>

</html>