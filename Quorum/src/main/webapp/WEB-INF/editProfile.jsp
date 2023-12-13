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
			<div class="col-6">
				<div class="sm-spacer"></div>
				<form action="update.do">
					<div class="row mb-3">
						<label for="firstName" class="form-label"><strong>Update
								Profile</strong></label>
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text" class="firstName"
							name="firstName" id="firstName" value="${user.firstName }"
							required /><br />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text" class="lastName"
							name="lastName" id="lastName" value="${user.lastName }" required /><br />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text"
							value="${user.dateOfBirth}" aria-label="Disabled input example"
							disabled />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text" class="username"
							name="username" id="username" value="${user.username }" required /><br />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text" class="password"
							name="password" id="password" value="${user.password }" required /><br />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="email" class="email"
							name="email" id="email" value="${user.email }" required /><br />
					</div>
					<div class="row mb-3">
						<input class="form-control" type="text" class="bio"
							name="biography" id="bio" value="${user.biography }" required /><br />
					</div>
					<div class="row mb-3">
						<input type="hidden" class="id" name="id" id="id"
							value="${user.id}" /><br />
					</div>
					<div>
						<button type="submit" class="btn btn-info form-control">Save
							Changes</button>
					</div>
				</form>
			</div>
			<div class="col-3"></div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>
