<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6" align="center">
				<c:choose>
					<c:when test="${empty loggedUser}">
						<div class="xl-spacer"></div>
						<h1 class="welcome-header">Welcome To Quorum!</h1>
						<div class="xl-spacer"></div>
					</c:when>
					<c:otherwise>
						<div class="sm-spacer"></div>
						<h1>
							Hello, <strong><c:out value="${loggedUser.firstName}">!</c:out></strong>
						</h1>
						<div class="make-post-form">
							<form action="create-post.do" method="post">
								<div class="title-input">
									<input class="form-control" type="text" name="title"
										id="Your posts title" placeholder="Whats on your mind?"
										required /><br />
								</div>
								<div class="post-content-input">
									<textarea class="form-control" id="postCodeSnippetInput"
										rows="2" name="codeSnippet" required>${post.codeSnippet}</textarea>
								</div>
								<button class="btn post-btn" type="submit">Post</button>
							</form>
						</div>
						<div class="spacer"></div>
						<c:choose>
							<c:when test="${empty feed}">
								<h3>Your feed is empty!</h3>
							</c:when>
							<c:otherwise>
								<c:forEach var="post" items="${feed}" varStatus="status">
									<div class="shadow-sm p-3 mb-5 bg-body rounded container home-post-color-${status.index % 4}">
										<div class="row">
											<div class="col-6">
												<h6>
													<a class="post-link"
														href="userProfile.do?userID=${post.user.id}">@${post.user.username}</a>
												</h6>
											</div>
											<div class="col-6">
												<h6>
													<a class="post-link"
														href="socialGroup.do?groupID=${post.socialGroup.id}">${post.socialGroup.name}</a>
												</h6>
											</div>
										</div>
										<div class="row">
											<h5 class="card-title">${post.title}</h3>
										</div>
										<div class="row">
											<p>${post.contents}</p>
										</div>
									</div>
									<c:if test="${!status.last}">
										<div class="xs-spacer"></div>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<div class="sm-spacer"></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-3"></div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

</body>
</html>