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
				<div class="card">
					<div class="card-body center">
						<form action="update.do">
							<div class="row mb-3">
							
								<div class="col-sm-3">
									<label for="firstName" class="form-label"><strong>First Name</strong></label>
								</div>
								<div class="col-9">
									<input class="form-control" type="text" name="firstName" value="${user.firstName }" required />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<label for="lastName" class="form-label"><strong>Last Name</strong></label>
								</div>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="lastName" value="${user.lastName }" required />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<label for="username" class="form-label"><strong>Username</strong></label>
								</div>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="username" value="${user.username }" required />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<label for="password" class="form-label"><strong>Password</strong></label>
								</div>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="password" value="${user.password }" required />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<label for="email" class="form-label"><strong>Email</strong></label>
								</div>
								<div class="col-sm-9">
									<input class="form-control" type="email" name="email" value="${user.email }" required />
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-sm-3">
									<label for="biography" class="form-label"><strong>Bio</strong></label>
								</div>
								<div class="col-sm-9">
									<input class="form-control" type="text" name="biography" value="${user.biography }" />
								</div>
							</div>
							<div class="row mb-3">
								<input type="hidden" class="id" name="id" value="${user.id}" />
								<input type="hidden" name="profileImageUrl" value="${user.profileImageUrl}" />
								<input type="hidden" id="dateOfBirth" value="${user.dateOfBirth}"/>
							</div>
							<div class="row mb-3">
								<div class="col-4"></div>
								<div class="col-4">
									<button type="submit" class="btn btn-info form-control">Save
										Changes</button>
								</div>
								<div class="col-4"></div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	<div class="spacer"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>
