<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />

<body>
	<jsp:include page="navbar.jsp" />

	<div class="container">

		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 ">
				<div class="xl-spacer"></div>
				<form action="login.do" method="post">
					<div class="row mb-3">

						<input class="form-control login-form" type="text" name="username"
							placeholder="username" required>
					</div>
					<div class="row  mb-3">
						<input class="form-control login-form" type="password"
							name="password" placeholder="password" />
					</div>
					<div class="row  mb-3">
						<button class="btn btn-primary form-control login-form"
							type="submit">Log In</button>
					</div>
				</form>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>


</html>