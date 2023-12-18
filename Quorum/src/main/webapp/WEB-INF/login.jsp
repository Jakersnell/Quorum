<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container wrapper vert-container">

		<div class="row vert-middle">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="card shadow p-3 mb-5 rounded" id="logincard">
					<div class="card-body" id="logincard">
						<form action="login.do" method="post">
							<div class="row mb-3">

								<input class="form-control login-form rounded bg-white"
									type="text" name="username" placeholder="username" required>
							</div>
							<div class="row  mb-3">
								<input class="form-control login-form rounded bg-white"
									type="password" name="password" placeholder="password" />
							</div>
							<div class="row  mb-3">
								<button class="btn form-control login-form rounded-pill"
									id="loginbtn" type="submit">Log In</button>
							</div>
						</form>
						<div class="text-center">
							Don't have an account? <a href="signup.do" id="signuplink">Sign
								Up</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>