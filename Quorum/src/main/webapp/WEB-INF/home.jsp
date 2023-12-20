<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<c:if test="${empty loggedUser}">
	<style>
body {
	background-image: linear-gradient(90deg, rgba(242, 229, 246, 1) 0%,
		rgba(248, 236, 238, 1) 38%, rgba(243, 244, 238, 1) 69%,
		rgba(216, 254, 252, 1) 100%);
}

#navbar-logo-img {
	display: none;
}
</style>
</c:if>

<body id="homeBody">
	<jsp:include page="navbar.jsp" />

	<div class="container wrapper">
		<c:choose>
			<c:when test="${not empty loggedUser}">
				<div class="sm-spacer"></div>
				<div class="row">
					<div class="col-3 home-side">
						<div class="side-banner">
							<img class="side-banner-image" alt="side banner image"
								src="img/background-image-1.png">
						</div>
					</div>
					<div class="col-6 home-center" align="center">
						<c:choose>
							<c:when test="${loggedUser.isAdmin()}">
								<h1 id="administrator>">Welcom Quorum Admin</h1>
							</c:when>
							<c:otherwise>

								<div class="profile-container">
									<h1>
										Hello, <strong><c:out value="${loggedUser.firstName}">!</c:out></strong>
									</h1>
									<div class="scroll-home-feed stylized-scroll">

										<c:if
											test="${loggedUser.groups != null && !loggedUser.groups.isEmpty()}">
											<div class="make-post-form shadow pt-3 pb-3 mb-5 rounded"
												align="center">

												<div class="row text-center container">
													<h6 class="content-header">Make A Post</h6>
												</div>
												<form action="createPost.do" method="post">

													<div class="title-input">
														<input class="form-control" type="text" name="title"
															id="Your posts title" placeholder="Title" required /><br />
													</div>
													<div class="post-content-input">
														<textarea class="form-control" id="postContents" rows="2"
															name="contents" placeholder="Whats on your mind?"></textarea>
													</div>

													<c:if test="${not empty fromUrl}">
														<input class="form-control" type="hidden" name="fromUrl"
															value="${fromUrl}" />
													</c:if>

													<div class="group-selector">
														<select class="form-select" aria-label="Group Selector"
															name="groupId">
															<option selected>What group is this for?</option>
															<c:forEach var="group" items="${loggedUser.groups}">
																<option value="${group.id}">${group.name}</option>
															</c:forEach>
														</select>
													</div>
													<button class="btn rounded-pill my-2" id="loginbtn"
														type="submit">Post</button>
												</form>
											</div>
										</c:if>

										<c:choose>
											<c:when test="${empty feed}">
												<h3>Your feed is empty!</h3>
												<h5>Try following some Users or Joining some groups!</h5>
											</c:when>
											<c:otherwise>
												<jsp:include page="_feed.jsp" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-3 home-side">
						<div class="side-banner">
							<img class="side-banner-image" alt="side banner image"
								src="img/background-image-1.png">
						</div>
					</div>
				</div>
				<div class="sm-spacer"></div>
			</c:when>
			<c:otherwise>
				<div class="row" id="homeRow">
					<div class="col-6 vert-container">
						<div class="xl-spacer"></div>
						<div class="header-div vert-middle" align="center">
							<div class="logo-div">
								<img alt="website logo" src="img/logo.png">
							</div>
							<div class="welcome-header text-center">
								<h1 class="welcome-header">Quorum</h1>
								<h4 class="welcome-subheader">Explore. Connect. Grow.</h4>
							</div>
						</div>
						<div class="xl-spacer"></div>
					</div>
					<div class="col-6" align="center">
						<div class="home-image" align="center">
							<img alt="3d graphic of people playing with school items"
								src="img/background-image-1.png">
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>