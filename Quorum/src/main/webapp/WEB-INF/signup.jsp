<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
<jsp:include page="navbar.jsp" />
    <main>
    <div class="container wrapper">

		<div class="row">
			<div class="col-4"></div>
			<div class="col-4 ">
				<div class="spacer"></div>
				<div class="card shadow p-3 mb-5 rounded" id="logincard">
					<div class="card-header text-center">
					    <strong>Sign Up</strong>
				  	</div>
					<div class="card-body" id="logincard">
						<form action="signup.do" method="POST">
							<div class="row mb-3">
								<input class="form-control login-form rounded bg-white" type="text" name="username"
									placeholder="username" required>
					            <label for="username">Username</label>
							</div>
							<div class="row mb-3">
								<input class="form-control login-form rounded bg-white" type="password"
									name="password" placeholder="password" />
					            <label for="password">Password</label>
							</div>
							<div class="row mb-3">
								<input class="form-control login-form rounded bg-white" type="email"
									name="email" placeholder="email" />
					            <label for="email">email</label>
							</div>
							<div class="row mb-3">
								<input class="form-control login-form rounded bg-white" type="text" name="firstName"
									placeholder="First Name" required>
					            <label for="firstName">First Name</label>
							</div>
							<div class="row mb-3">
								<input class="form-control login-form rounded bg-white" type="text"
									name="lastName" placeholder="Last Name" />
					            <label for="lastName">lastName</label>
							</div>
							<div class="row mb-3">
					            <select name="schoolID" id="schoolID" class="form-select" aria-label="School" required>
					                <c:forEach items="${school}" var = "s">
					                    <option value="${s.id}">${s.name}</option>
					                </c:forEach>
					            </select>
					            <label for="school">School</label>
							</div>
							<div class="row mb-3">
								<button class="btn form-control login-form rounded-pill" id="loginbtn"
									type="submit">Submit</button>
							</div>
						</form>
						<div class="text-center">
						Have an account? <a href="login.do" id="signuplink">Log in</a>						
						</div>
					</div>
				</div>
				<div class="spacer"></div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<div class="spacer"></div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
