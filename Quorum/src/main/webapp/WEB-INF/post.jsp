<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="xs-spacer"></div>
	<div class="container wrapper">
		<div class="row">
			<div class="col-3 post-side"></div>
			<div class="col-6 post-center">
				<div class="post-detail-card text-center align-middle">
					<div class="row">
						<div class="col-6">
							<a href="userProfile.do?userID=${post.user.id}">
								<div class="post-author">
									<div class="post-author-full-name">
										<h4>${post.user.firstName}&nbsp;${post.user.lastName}</h4>
									</div>
									<div class="post-author-username">
										<small>@${post.user.username}</small>
									</div>
								</div>
							</a>
						</div>
						<div class="col-6">
							<a href="group.do?groupID=${post.socialGroup.id}">
								<div class="post-author">
									<div class="post-group">
										<span><h5>
												<small class="embedded-small">Posted in </small>${post.socialGroup.name}</h5></span>
									</div>
								</div> <c:if
									test="${not empty loggedUser && post.user.equals(loggedUser)}">
									<div class="row">
										<div class="col-3"></div>
										<div class="col-6">
											<div class="post-edit-btn-div">

												<a href="editPost.do?postID=${post.id}"
													class="btn post-btn-secondary form-control">Edit</a>

											</div>
										</div>
										<div class="col-3"></div>
									</div>
								</c:if>
							</a>
						</div>
					</div>
					<hr>
					<div class="post-title">
						<h3>${post.title}</h3>
					</div>
					<div class="post-contents">
						<p>${post.contents}</p>
					</div>
					<br>
					<div class="post-metadata">
						<div class="post-date">
							<p>Posted on ${post.createdOn}</p>
							<p>Last updated on ${post.createdOn}</p>
						</div>
					</div>
				</div>
				<div id="comments" class="comments mt-3">
					<div class="comments-header">
						<c:if test="${userIsInGroup}">
							<div class="row">
								<div class="col-2"></div>
								<div class="col-8">
									<button type="button" class="btn form-control" id="editbtn"
										data-bs-toggle="modal" data-bs-target="#editGroupModal">
										Make A Comment</button>
								</div>
								<div class="col-2"></div>
							</div>
							<div class="modal fade" id="editGroupModal" tabindex="-1"
								aria-labelledby="editGroupModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<form action="comment.do" method="post">
											<div class="modal-body">
												<input id="groupNameInput"
													class="form-control login-form rounded bg-white"
													type="hidden" name="postID" value="${post.id}" required>
												<div class="row mb-3">
													<label for="commentContentsInput">Contents</label>
													<textarea id="commentContentsInput"
														class="form-control login-form rounded bg-white"
														id="groupDescription" rows="2" name="contents"></textarea>
												</div>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>
												<button type="submit" class="btn btn-primary">Save
													changes</button>
											</div>
										</form>
									</div>
								</div>
							</div>
							<br>
						</c:if>

					</div>
					<c:choose>
						<c:when
							test="${post.comments != null && !post.comments.isEmpty()}">
							<div class="comments-header ml-4">
								<h3>Comments</h3>
							</div>

							<c:forEach var="comment" items="${post.comments}">
								<c:if test="${comment.enabled || loggedUser.isAdmin()}">
									<div class="comment">
										<div class="comment-header row">
											<div class="col-6">
												<h5>
													<strong>@${comment.user.username}</strong>
												</h5>
											</div>
											<div class="col-4"></div>
											<div class="col-2">
												<c:if
													test="${loggedUser.equals(comment.user) || loggedUser.isAdmin()}">
													<form action="setCommentStatus.do" method="POST">
														<input type="hidden" name="commentID"
															value="${comment.id}"> <input type="hidden"
															name="status" value="false">
														<button type="submit"
															class="btn btn-danger delete-comment-btn">delete</button>
													</form>
												</c:if>
												<c:if test="${!comment.enabled && loggedUser.isAdmin()}">
													<form action="setCommentStatus.do" method="POST">
														<input type="hidden" name="commentID"
															value="${comment.id}"> <input type="hidden"
															name="status" value="true">
														<button type="submit"
															class="btn btn-danger delete-comment-btn">re-enable</button>
													</form>
												</c:if>
											</div>
										</div>
										<hr class="mt-0 mb-1">
										<div class="comment-body">
											<p>${comment.contents}</p>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="comments-header ml-4">
								<h3>This post has no comments.</h3>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="col-3 post-side"></div>
		</div>
	</div>
	<div class="xs-spacer"></div>
	<jsp:include page="footer.jsp" />
</body>

</html>