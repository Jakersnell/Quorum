<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" />
<body>
	<jsp:include page="navbar.jsp" />
	<div class="spacer"></div>
	<div class="container wrapper">
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
						<label for="firstName">First Name:</label> <input id="firstName"
							class="form-control" type="text" class="firstName"
							name="firstName" id="firstName" value="${user.firstName }"
							required /><br />
					</div>
					<div class="row mb-3">
						<label for="lastName">Last Name:</label> <input
							class="form-control" type="text" class="lastName" name="lastName"
							id="lastName" value="${user.lastName }" required /><br />
					</div>
					<div class="row mb-3">
						<label for="dateOfBirth">Date of birth:</label> <input
							class="form-control" type="text" id="dateOfBirth"
							value="${user.dateOfBirth}" aria-label="Disabled input example"
							disabled />
					</div>
					<div class="row mb-3">
						<label for="username">Username:</label> <input
							class="form-control" type="text" class="username" name="username"
							id="username" value="${user.username }" required /><br />
					</div>
					<div class="row mb-3">
						<label for="password">Password:</label> <input
							class="form-control" type="text" class="password" name="password"
							id="password" value="${user.password }" required /><br />
					</div>
					<div class="row mb-3">
						<label for="email">Email:</label> <input class="form-control"
							type="email" class="email" name="email" id="email"
							value="${user.email }" required /><br />
					</div>
					<div class="row mb-3">
						<label for="bio">Bio:</label> <input class="form-control"
							type="text" class="bio" name="biography" id="bio"
							value="${user.biography }" /><br />
					</div>
					<div class="row mb-3">
						<input type="hidden" class="id" name="id" id="id"
							value="${user.id}" /><br /> <input type="hidden"
							class="profileImageUrl" name="profileImageUrl"
							id="profileImageUrl" value="${user.profileImageUrl}" /><br />
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
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>
