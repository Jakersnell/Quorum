<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<nav class="navbar navbar-expand-lg bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="home.do">Quorum</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavDropdown">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="home.do">Home</a></li>
				<c:choose>
					<c:when test="${not empty loggedUser}">
						<li class="nav-item"><a class="nav-link" href="account.do">Account</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="login.do">Login</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="signup.do">Sign
								Up</a></li>
					</c:otherwise>
				</c:choose>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Dropdown link
				</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
						<li><a class="dropdown-item" href="#">Something else here</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>