<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<nav class="navbar navbar-expand-lg bg-light">
	<div class="container-fluid nav-container row">
		<div class="col-5 text-center">
			<a class="navbar-brand" href="home.do">Quorum</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
		<div class="col-2 d-flex justify-content-center">
			<a class="nav-link" aria-current="page" href="home.do"><img
				id="navbar-logo-img" alt="logo image" src="img/logo.png"></a>
		</div>
		<div class="col-2">
			<c:if test="${not empty loggedUser}">
				<c:choose>
					<c:when test="${loggedUser.role == 'admin'}">
						<div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
							<ul class="navbar-nav">
								<li class="nav-item dropdown">
									<button class="btn btn-light nav-link dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false">Pages</button>
									<ul class="dropdown-menu dropdown-menu-light">
										<li><a class="dropdown-item nav-link" href="account.do">Account</a></li>
										<li><a class="dropdown-item nav-link" href="messages.do">Messages</a></li>
										<li><a class="dropdown-item nav-link" href="logout.do">Logout</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
							<ul class="navbar-nav">
								<li class="nav-item dropdown">
									<button class="btn btn-light nav-link dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false">Pages</button>
									<ul class="dropdown-menu dropdown-menu-light">
										<li><a class="dropdown-item nav-link"
											href="userProfile.do?userID=${loggedUser.id}">Profile</a></li>
										<li><a class="dropdown-item nav-link" href="account.do">Account</a></li>
										<li><a class="dropdown-item nav-link" href="messages.do">Messages</a></li>
										<li><a class="dropdown-item nav-link" href="createGroup.do">Create A Group</a></li>
										<li><a class="dropdown-item nav-link" href="logout.do">Logout</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
		<div class="col-3">
			<c:choose>
				<c:when test="${not empty loggedUser}">
					<form class="d-flex" action="search.do" method="GET">
						<input class="form-control me-2 searchbar" type="text"
							name="query" placeholder="Search for..." aria-label="Search"
							required>
						<button class="btn btn-info search-btn" type="submit">Search</button>
					</form>
				</c:when>
				<c:otherwise>
					<ul class="navbar-nav">
						<li><a class="dropdown-item nav-link" href="login.do">Login</a></li>
						<li><a class="dropdown-item nav-link"> </a></li>
						<li><a class="dropdown-item nav-link" href="signup.do">Sign
								Up</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>
<jsp:include page="_alert.jsp" />