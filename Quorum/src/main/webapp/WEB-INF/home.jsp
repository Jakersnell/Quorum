<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<c:if test="${empty loggedUser}">
	<style>
#navbar-logo-img {
	display: none;
}

body {
	background-image: linear-gradient(to right, #eadcff, #c6faf5);
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
										<jsp:include page="makePostForm.jsp"></jsp:include>
										<jsp:include page="_feed.jsp" />
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