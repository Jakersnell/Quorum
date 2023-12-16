<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body id="homeBody">
	<jsp:include page="navbar.jsp" />
	<div class="container wrapper">
		<div class="row">
			<div class="col-3">
				<c:if test="${not empty loggedUser}">
					<div class="side-banner">
						<img class="side-banner-image" alt="side banner image"
							src="img/background-image-1.png">
					</div>
				</c:if>
			</div>
			<div class="col-6" align="center">
				<c:choose>
					<c:when test="${empty loggedUser}">
						<div class="xl-spacer"></div>
						<h1 class="welcome-header">Welcome To Quorum!</h1>
						<div class="xl-spacer"></div>
					</c:when>
					<c:when test="${loggedUser.role == 'admin'}">
						<h1 id="administrator>">01000001 01000100 01001101 01001001
							01001110</h1>
					</c:when>
					<c:otherwise>

						<div class="sm-spacer"></div>
						<h1>
							Hello, <strong><c:out value="${loggedUser.firstName}">!</c:out></strong>
						</h1>
						<div class="scroll-feed">
							<jsp:include page="makePostForm.jsp"></jsp:include>
							<c:choose>
								<c:when test="${empty feed}">
									<h3>Your feed is empty!</h3>
								</c:when>

								<c:otherwise>

									<jsp:include page="_feed.jsp" />

								</c:otherwise>
							</c:choose>
						</div>
						<div class="sm-spacer"></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-3">
				<c:if test="${not empty loggedUser}">
					<div class="side-banner">
						<img class="side-banner-image" alt="side banner image"
							src="img/background-image-1.png">
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

</body>
</html>